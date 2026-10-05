import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:ekp_crypto/ekp_crypto.dart';
import 'package:pointycastle/export.dart';
import 'package:test/test.dart';

// Synthetic payload identities. The capture-derived golden vectors this
// suite originally pinned (real contract-e request/response pairs and
// phone-scanned tokens) were removed before publishing; the tests below
// pin the same wire-format and crypto facts with synthetic data. See the
// README ("Testing") for details.
const ticketGuid = '0123456789abcdef0123456789abcdef';
const deviceName = 'unknown Android SDK built for arm64';

/// Deterministic 512-char uppercase-hex token — the AZTEC plaintext shape
/// the official scheme produces.
final String syntheticToken = List<String>.generate(512, (i) => '0123456789ABCDEF'[(i * 7) % 16]).join();

/// Builds a contract-e style blob — base64(IV ‖ AES-128-CBC/PKCS7(token)) —
/// the exact inverse of [EkpAztecCrypto.decryptContract].
String buildContractBlob(
  String token, {
  String secret = cppSecret,
  EkpCryptoEnvironment environment = EkpCryptoEnvironment.production,
}) {
  // Fixed IV: synthetic test data, not a secret.
  final iv = List<int>.generate(16, (i) => i);
  final aes = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
    ..init(
      true,
      PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(utf8.encode(environment.aesKeyOf(secret))), Uint8List.fromList(iv)),
        null,
      ),
    );
  final ciphertext = aes.process(utf8.encode(token));
  return base64Encode([...iv, ...ciphertext]);
}

void main() {
  group('encodeAndroidDefault', () {
    test('wraps a 256-byte RSA block like Android Base64.DEFAULT', () {
      // 256 arbitrary bytes -> 344 base64 chars -> [76, 76, 76, 76, 40] + \n.
      final bytes = List<int>.generate(256, (i) => (i * 7 + 3) % 256);
      final wrapped = encodeAndroidDefault(bytes);

      final lines = wrapped.split('\n');
      expect(
        lines.map((l) => l.length).toList(),
        const [76, 76, 76, 76, 40, 0], // trailing '' = final newline
        reason: 'must match the captured bodies byte-for-byte',
      );
      expect(wrapped.endsWith('\n'), isTrue);
      expect(base64Decode(wrapped.replaceAll('\n', '')), bytes);
    });

    test('empty input yields an empty string', () {
      expect(encodeAndroidDefault([]), '');
    });

    test('short input stays on a single line', () {
      final short = encodeAndroidDefault([1, 2, 3, 4, 5]);
      expect(short, '${base64Encode([1, 2, 3, 4, 5])}\n');
    });

    test('exactly 76 base64 chars form one full line', () {
      // 57 bytes = 19 x 3 -> 76 b64 chars, no '=' padding.
      final bytes = List<int>.generate(57, (i) => i);
      expect(encodeAndroidDefault(bytes).split('\n').map((l) => l.length), const [76, 0]);
    });

    test('padding survives the wrap (58 bytes -> [76, 4])', () {
      // 58 = 19 x 3 + 1 byte: the final group encodes to 4 chars ending
      // in '==' — the wrap must not split or strip the padding.
      final bytes = List<int>.generate(58, (i) => (i * 3) % 256);
      final wrapped = encodeAndroidDefault(bytes);
      expect(wrapped.split('\n').map((l) => l.length).toList(), const [76, 4, 0]);
      expect(wrapped.endsWith('==\n'), isTrue);
      expect(base64Decode(wrapped.replaceAll('\n', '')), bytes);
    });
  });

  group('aztecKeyPem', () {
    test('parses as PKCS#1 RSA-2048 with e = 65537', () {
      final key = parseRsaPublicKey(aztecKeyPem);
      expect(key.modulus!.bitLength, 2048);
      expect(key.exponent, BigInt.from(65537));
    });

    test('parses the same key from an SPKI envelope', () {
      // Same aztecKey in SubjectPublicKeyInfo form (what openssl/pub
      // tooling calls "public key") — parseRsaPublicKey must accept it
      // and yield the identical key.
      const spki = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4NgeDRNowqtK1GC3UgDk
TquMtb2P0SFNsi54OWcvYtihKuOsr+YeK9UmDmfK5xCRzBmwJ3uMrjVFnqNTW2eF
IxB0rqS2qo0p7XrRJLQ7By96L7fYJn4gj4/IUER4vu/wLYzQMlCKD2mTtM6M2AaJ
A/otrbwPIintebttEfZ3oEvTmeifTYNPMI648Zte140yVa0sipEr4Tjb26+lFn6h
BT5pK+g7tuRBToiWPD1db+ysOcQx0PwLWAO5E/7EfJM0kveA8t+SxXPiA6JR95sm
5l8NE2mdjP/cRCw4qIiz7AKJqUMduKDwgwLOkQXwSjXHNDR0q/N4dvfb97/hyea8
ZwIDAQAB
-----END PUBLIC KEY-----
''';
      final fromPkcs1 = parseRsaPublicKey(aztecKeyPem);
      final fromSpki = parseRsaPublicKey(spki);
      expect(fromSpki.modulus, fromPkcs1.modulus);
      expect(fromSpki.exponent, fromPkcs1.exponent);
    });
  });

  group('EkpCryptoEnvironment key slicing', () {
    test('production uses chars 0-16, development chars 16-32', () {
      expect(EkpCryptoEnvironment.production.aesKeyOf(cppSecret), 'VoEVG4Yv/u1IFP6S');
      expect(EkpCryptoEnvironment.development.aesKeyOf(cppSecret), 'PnsVGi1SWPnrwQfJ');
      expect(cppSecret.length, 32);
    });
  });

  group('encryptJson', () {
    final crypto = const EkpAztecCrypto();

    test('produces the server-expected wire shape', () {
      final message = crypto.encryptJson({'id': ticketGuid, 'device_name': deviceName});

      // Byte-for-byte shape of every captured request body.
      expect(message.split('\n').map((l) => l.length).toList(), const [76, 76, 76, 76, 40, 0]);
      expect(base64Decode(message.replaceAll('\n', '')).length, 256);
    });

    test('serializes the payload exactly like JSON.stringify', () {
      final payload = {'id': ticketGuid, 'device_name': deviceName};
      expect(jsonEncode(payload), '{"id":"$ticketGuid","device_name":"$deviceName"}');
    });

    test('randomizes PKCS#1 padding (two calls differ)', () {
      final a = crypto.encryptJson({'ticketGuid': ticketGuid});
      final b = crypto.encryptJson({'ticketGuid': ticketGuid});
      expect(a, isNot(b));
    });

    test('round-trips through a locally generated keypair', () {
      final keyPair = _generateRsaKeyPair();
      final pem = _encodePublicKeyToPkcs1Pem(keyPair.publicKey);

      final local = EkpAztecCrypto(publicKeyPem: pem);
      final payload = {'id': ticketGuid, 'device_name': deviceName};
      final message = local.encryptJson(payload);

      // Unwrap our own Android-style base64, then RSA-decrypt.
      final block = base64Decode(message.replaceAll('\n', ''));
      final rsa = PKCS1Encoding(RSAEngine())..init(false, PrivateKeyParameter<RSAPrivateKey>(keyPair.privateKey));
      final decrypted = rsa.process(Uint8List.fromList(block));
      expect(utf8.decode(decrypted), jsonEncode(payload));
    });
    test('round-trips non-ASCII payloads (UTF-8 symmetry)', () {
      // Dart's jsonEncode emits non-ASCII characters raw (no \u escapes),
      // so a Polish device name exercises the multi-byte UTF-8 path end
      // to end.
      final keyPair = _generateRsaKeyPair();
      final pem = _encodePublicKeyToPkcs1Pem(keyPair.publicKey);
      final local = EkpAztecCrypto(publicKeyPem: pem);
      final payload = {'id': ticketGuid, 'device_name': 'Urządzenie ćwierćważne numer 12'};
      final message = local.encryptJson(payload);

      final block = base64Decode(message.replaceAll('\n', ''));
      final rsa = PKCS1Encoding(RSAEngine())..init(false, PrivateKeyParameter<RSAPrivateKey>(keyPair.privateKey));
      final decrypted = rsa.process(Uint8List.fromList(block));
      expect(utf8.decode(decrypted), jsonEncode(payload));
    });
    test('throws EkpCryptoException on garbage key material', () {
      const broken = EkpAztecCrypto(publicKeyPem: 'not a pem');
      expect(() => broken.encryptJson({'a': 1}), throwsA(isA<EkpCryptoException>()));
    });

    test('throws EkpCryptoException when payload exceeds one RSA block', () {
      // RSA-2048 PKCS#1 v1.5 carries at most 256 - 11 = 245 plaintext bytes.
      final oversized = {'pad': 'x' * 300}; // ~309 bytes of JSON
      expect(() => crypto.encryptJson(oversized), throwsA(isA<EkpCryptoException>()));
    });
  });

  group('decryptContract (synthetic vectors)', () {
    final crypto = const EkpAztecCrypto();

    test('decrypts a contract blob back into the AZTEC hex token', () {
      final hex = crypto.decryptContract(buildContractBlob(syntheticToken));
      expect(hex, syntheticToken);
      expect(hex, matches(RegExp('^[0-9A-F]{512}\$')), reason: 'plaintext must be 512 uppercase hex chars');
    });

    test('returns null when the blob was encrypted with a different key', () {
      final wrongKeyBlob = buildContractBlob(syntheticToken, secret: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      expect(crypto.decryptContract(wrongKeyBlob), isNull);
    });

    test('returns null on malformed input', () {
      expect(crypto.decryptContract('!!!not-base64!!!'), isNull);
      expect(crypto.decryptContract(base64Encode(List.filled(10, 1))), isNull);
      expect(
        crypto.decryptContract(base64Encode(List.filled(48, 2))),
        isNull, // valid shape, garbage content -> bad padding/UTF-8
      );
    });

    test('returns null on empty input', () {
      expect(crypto.decryptContract(''), isNull);
    });

    test('returns null on the 32-byte boundary with garbage', () {
      // 32 bytes = IV + exactly one AES block: passes both shape checks
      // (>= 32 and block-aligned); garbage content -> bad padding.
      expect(crypto.decryptContract(base64Encode(List.filled(32, 5))), isNull);
    });

    test('returns null on a non-block-aligned blob', () {
      // 33 bytes: passes the >= 32 check but (33 - 16) % 16 != 0.
      expect(crypto.decryptContract(base64Encode(List.filled(33, 3))), isNull);
    });

    test('decrypts with the development key slice', () {
      final devBlob = buildContractBlob(syntheticToken, environment: EkpCryptoEnvironment.development);
      const devCrypto = EkpAztecCrypto(environment: EkpCryptoEnvironment.development);
      expect(devCrypto.decryptContract(devBlob), syntheticToken);
      // …and the production key must NOT open a development blob.
      expect(crypto.decryptContract(devBlob), isNull);
    });

    test('strips embedded whitespace before decoding', () {
      // The wire format is single-line, but decryptContract defensively
      // removes \s — pin that polluted whitespace of every kind (leading,
      // interior, trailing; space, tab, CR, LF) still decrypts.
      final blob = buildContractBlob(syntheticToken);
      final polluted = ' \t${blob.substring(0, 100)}\r\n ${blob.substring(100)}\n';
      expect(crypto.decryptContract(polluted), syntheticToken);
    });
  });

  group('EkpCryptoException', () {
    test('carries the message and formats toString', () {
      const e = EkpCryptoException('boom');
      expect(e.message, 'boom');
      expect(e.toString(), 'EkpCryptoException: boom');
    });
  });
}

/// Generates a 2048-bit RSA keypair (test only; ~0.5 s).
AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> _generateRsaKeyPair() {
  final seed = Uint8List.fromList(List<int>.generate(32, (_) => Random.secure().nextInt(256)));
  final random = FortunaRandom()..seed(KeyParameter(seed));
  final generator = RSAKeyGenerator()
    ..init(ParametersWithRandom(RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64), random));
  // pointycastle 4: generateKeyPair is generic — RSAKeyGenerator yields
  // AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> directly, no casts.
  return generator.generateKeyPair();
}

/// DER-encodes [key] as PKCS#1 `RSAPublicKey` and wraps it in the
/// `BEGIN RSA PUBLIC KEY` PEM envelope.
String _encodePublicKeyToPkcs1Pem(RSAPublicKey key) {
  final seq = ASN1Sequence()
    ..add(ASN1Integer(key.modulus!))
    ..add(ASN1Integer(key.exponent!));
  final b64 = base64Encode(seq.encodedBytes);
  final buffer = StringBuffer();
  buffer.writeln('-----BEGIN RSA PUBLIC KEY-----');
  for (var i = 0; i < b64.length; i += 64) {
    buffer.writeln(b64.substring(i, i + 64 < b64.length ? i + 64 : b64.length));
  }
  buffer.writeln('-----END RSA PUBLIC KEY-----');
  return buffer.toString();
}
