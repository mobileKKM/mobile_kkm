import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/pointycastle.dart' show RSAPublicKey;

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
      final key = encrypt.RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
      final rsa = encrypt.RSA(
        publicKey: key,
        encoding: encrypt.RSAEncoding.PKCS1,
      );
      final block = rsa.encrypt(Uint8List.fromList(plaintext)).bytes;
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
      final aes = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key.fromUtf8(environment.aesKeyOf(secret)),
          mode: encrypt.AESMode.cbc,
          padding: 'PKCS7',
        ),
      );
      // decrypt() utf8-decodes with allowMalformed — like crypto-js
      // `.toString(CryptoJS.enc.Utf8)`, which never throws either.
      return aes.decrypt(
        encrypt.Encrypted(Uint8List.fromList(blob.sublist(16))),
        iv: encrypt.IV(Uint8List.fromList(blob.sublist(0, 16))),
      );
    } on Object {
      return null;
    }
  }
}
