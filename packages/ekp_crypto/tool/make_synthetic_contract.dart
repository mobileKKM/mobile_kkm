// Generates the SYNTHETIC contract-e fixture used by ekp_api's tests.
//
// The original fixture was a real captured (encrypted) contract blob; real
// capture data was removed from the repository before publishing. This tool
// rebuilds a byte-shape-identical synthetic replacement:
//
//   dart run tool/make_synthetic_contract.dart
//
// It prints (1) the planted 512-char uppercase-hex AZTEC token and (2) the
// JSON body to write to ekp_api's test/fixtures/contract_e_response.json.
// The token must be planted as the expected value in ekp_api's
// tickets_encrypted_test.dart.
//
// The IV is fixed (0..15) — this is test data, not a secret; the official
// scheme's security is unaffected by a published test vector.

// A command-line tool: stdout is its output.
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:ekp_crypto/ekp_crypto.dart';
import 'package:pointycastle/export.dart';

void main() {
  // Deterministic 512-char uppercase-hex token (the AZTEC plaintext shape).
  final token = List<String>.generate(512, (i) => '0123456789ABCDEF'[(i * 7) % 16]).join();

  final iv = List<int>.generate(16, (i) => i);
  final aes = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
    ..init(
      true,
      PaddedBlockCipherParameters(
        ParametersWithIV(
          KeyParameter(utf8.encode(EkpCryptoEnvironment.production.aesKeyOf(cppSecret))),
          Uint8List.fromList(iv),
        ),
        null,
      ),
    );
  final ciphertext = aes.process(utf8.encode(token));

  final blob = base64Encode([...iv, ...ciphertext]);
  const encoder = JsonEncoder.withIndent('  ');
  print('planted token:');
  print(token);
  print('');
  print('fixture body (test/fixtures/contract_e_response.json):');
  print(encoder.convert({'contract': blob, 'code': null, 'message': null}));
}
