import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/export.dart'
    show
        AESEngine,
        CBCBlockCipher,
        KeyParameter,
        ParametersWithIV,
        PaddedBlockCipherImpl,
        PaddedBlockCipherParameters,
        PKCS1Encoding,
        PKCS7Padding,
        PublicKeyParameter,
        RSAEngine,
        RSAPublicKey;

import 'android_base64.dart';
import 'keys.dart';

/// Failure while building an encrypted request payload (unparseable key,
/// payload too large for a single RSA block, …). Contract *decryption*
/// failures are not signalled this way — [EkpAztecCrypto.decryptContract]
/// mirrors the official client's behavior and returns `null` instead.
class EkpCryptoException implements Exception {
  const EkpCryptoException(this.message);

  final String message;

  @override
  String toString() => 'EkpCryptoException: $message';
}

/// The mKKM "aztec" crypto scheme (reverse-engineered, see README):
///
/// * **Requests** — the JSON payload is serialized exactly like the official
///   client's `JSON.stringify` (compact, insertion-ordered), UTF-8 encoded
///   and encrypted with RSA-2048 PKCS#1 v1.5 (randomized type-2 padding,
///   single 256-byte block). The ciphertext is wrapped with Android's
///   `Base64.DEFAULT` (76-char `\n` lines + trailing `\n`) and sent as the
///   `{"message": …}` body of `assign-e` / `contract-e`.
/// * **Contracts** — the response `contract` field is base64; the decoded
///   blob is `IV (16 bytes) ‖ AES-128-CBC ciphertext` (crypto-js defaults,
///   PKCS#7). The key is the first/second 16 UTF-8 chars of [cppSecret]
///   depending on [environment]. The plaintext is a 512-char hex token that
///   the official app renders directly as an AZTEC barcode (~119 s validity).
class EkpAztecCrypto {
  const EkpAztecCrypto({
    this.publicKeyPem = aztecKeyPem,
    this.secret = cppSecret,
    this.environment = EkpCryptoEnvironment.production,
  });

  /// RSA public key (PKCS#1 PEM) — override after key rotation.
  final String publicKeyPem;

  /// The native module's 32-char secret — override after an app update
  /// changes `HybridCppModule::getString()`.
  final String secret;

  /// Production uses secret chars 0–16 as the AES key, development 16–32.
  final EkpCryptoEnvironment environment;

  /// Serializes [payload] to the wire JSON, encrypts it and returns the
  /// Android-`Base64.DEFAULT` wrapped ciphertext for the `message` field.
  ///
  /// Throws [EkpCryptoException] on failure (the official app surfaces
  /// encryption errors as generic failures; callers here get a typed error).
  String encryptJson(Map<String, dynamic> payload) {
    try {
      final plaintext = utf8.encode(jsonEncode(payload));
      final key = parseRsaPublicKey(publicKeyPem);
      // PKCS#1 v1.5 with randomized type-2 padding: init() without an
      // explicit SecureRandom auto-seeds pointycastle's FortunaRandom.
      final rsa = PKCS1Encoding(RSAEngine())
        ..init(true, PublicKeyParameter<RSAPublicKey>(key));
      final block = rsa.process(Uint8List.fromList(plaintext));
      return encodeAndroidDefault(block);
    } on Object catch (e) {
      throw EkpCryptoException('request encryption failed: $e');
    }
  }

  /// Decrypts a `contract-e` response blob back into the AZTEC hex token.
  ///
  /// Returns `null` on any failure — malformed base64, wrong length, bad
  /// PKCS#7 padding or invalid UTF-8 — mirroring the official client's
  /// `catch → null` handling (it then shows a generic error).
  String? decryptContract(String contractBase64) {
    try {
      final blob = base64Decode(contractBase64.replaceAll(RegExp(r'\s'), ''));
      // 16 bytes IV + at least one AES block, block-aligned remainder.
      if (blob.length < 32 || (blob.length - 16) % 16 != 0) return null;
      // AES-128-CBC + PKCS#7 — the crypto-js defaults the official client
      // relies on (PaddedBlockCipherImpl(PKCS7, CBC(AES)) == 'AES/CBC/PKCS7').
      final aes = PaddedBlockCipherImpl(
        PKCS7Padding(),
        CBCBlockCipher(AESEngine()),
      )..init(
          false,
          PaddedBlockCipherParameters(
            ParametersWithIV(
              KeyParameter(utf8.encode(environment.aesKeyOf(secret))),
              blob.sublist(0, 16),
            ),
            null,
          ),
        );
      final plaintext = aes.process(blob.sublist(16));
      // utf8-decode with allowMalformed — like crypto-js
      // `.toString(CryptoJS.enc.Utf8)`, which never throws either.
      return utf8.decode(plaintext, allowMalformed: true);
    } on Object {
      return null;
    }
  }
}

/// Parses an RSA public key from a PEM envelope.
///
/// Supports the two public-key shapes the mKKM key material can take:
/// PKCS#1 (`-----BEGIN RSA PUBLIC KEY-----`, the captured `aztecKey`
/// format) and SubjectPublicKeyInfo (`-----BEGIN PUBLIC KEY-----`).
/// Anything else throws — [EkpAztecCrypto.encryptJson] wraps that into an
/// [EkpCryptoException].
RSAPublicKey parseRsaPublicKey(String pem) {
  final rows = pem.split(RegExp(r'\r\n?|\n'));
  final header = rows.first;

  ASN1Sequence sequence;
  if (header == '-----BEGIN RSA PUBLIC KEY-----') {
    sequence = _parseAsn1Sequence(rows);
  } else if (header == '-----BEGIN PUBLIC KEY-----') {
    // SPKI: SEQUENCE { AlgorithmIdentifier, BIT STRING { SEQUENCE { n, e } } }
    final spki = _parseAsn1Sequence(rows);
    final bitString = spki.elements[1];
    sequence = ASN1Parser(
      Uint8List.fromList(bitString.valueBytes().sublist(1)),
    ).nextObject() as ASN1Sequence;
  } else {
    throw FormatException('Unable to parse key, invalid format.', header);
  }

  final modulus = (sequence.elements[0] as ASN1Integer).valueAsBigInteger;
  final exponent = (sequence.elements[1] as ASN1Integer).valueAsBigInteger;
  return RSAPublicKey(modulus, exponent);
}

/// Base64-decodes the PEM body (rows between the BEGIN/END markers) and
/// parses its top-level ASN.1 object.
ASN1Sequence _parseAsn1Sequence(List<String> rows) {
  final keyText = rows
      .skipWhile((row) => row.startsWith('-----BEGIN'))
      .takeWhile((row) => !row.startsWith('-----END'))
      .map((row) => row.trim())
      .join('');
  final keyBytes = Uint8List.fromList(base64.decode(keyText));
  return ASN1Parser(keyBytes).nextObject() as ASN1Sequence;
}
