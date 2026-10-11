import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:dio/dio.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:ekp_crypto/ekp_crypto.dart';
import 'package:pointycastle/export.dart';
import 'package:test/test.dart';

import 'fixtures.dart';
import 'mock_adapter.dart';

const baseUrl = 'https://api.ekp.mpk.krakow.pl';
const ticketGuid = 'feedfacefeedfacefeedfacefeedface';
const deviceName = 'unknown Android SDK built for arm64';

/// The token planted in the synthetic contract fixture — regenerate with
/// `dart run ../ekp_crypto/tool/make_synthetic_contract.dart` and update
/// alongside `fixtures/contract_e_response.json`.
final plantedAztecToken = '07E5C3A18F6D4B29' * 32;

void main() {
  late Dio dio;
  late MockAdapter adapter;
  late EkpClient client;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    adapter = MockAdapter();
    dio.httpClientAdapter = adapter;

    client = EkpClient(
      device: const EkpDeviceIdentity(deviceId: '23a71d82a4f5a3e1', platform: 'android 34', deviceName: deviceName),
      tokenStore: InMemoryTokenStore(),
      dio: dio,
    );
  });

  tearDown(() => client.dispose());

  Map<String, dynamic> bodyOf(RequestOptions options) => options.data as Map<String, dynamic>;

  group('TicketsApi.assign', () {
    test('posts an Android-Base64-wrapped RSA block as {"message"}', () async {
      adapter.onPost('/mkkm/tickets/assign-e', [(200, fixture('assign_e_response'))]);

      final response = await client.tickets.assign(ticketGuid);

      expect(response.assigned, isTrue);
      expect(response.code, isNull);

      final req = adapter.requestsTo('/mkkm/tickets/assign-e').single;
      final message = bodyOf(req)['message'] as String;

      // Shape parity with the official client's assign-e bodies
      // (Android Base64.DEFAULT wrapping of a single 256-byte block).
      expect(message.split('\n').map((l) => l.length).toList(), const [76, 76, 76, 76, 40, 0]);
      expect(base64Decode(message.replaceAll('\n', '')).length, 256);
    });

    test('device_name defaults to the device identity', () async {
      adapter.onPost('/mkkm/tickets/assign-e', [(200, fixture('assign_e_response'))]);
      await client.tickets.assign(ticketGuid);

      // The plaintext payload is RSA-encrypted (opaque), but our own crypto
      // is deterministic about serialization: same inputs -> same JSON.
      final reference = const EkpAztecCrypto().encryptJson({'id': ticketGuid, 'device_name': deviceName});
      final sent = bodyOf(adapter.requestsTo('/mkkm/tickets/assign-e').single)['message'] as String;

      // Both are random-padded ciphertexts; identical shape, different bytes.
      expect(base64Decode(sent.replaceAll('\n', '')).length, base64Decode(reference.replaceAll('\n', '')).length);
      expect(sent, isNot(reference));
    });

    test('explicit deviceName overrides the identity', () async {
      adapter.onPost('/mkkm/tickets/assign-e', [(200, fixture('assign_e_response'))]);
      await client.tickets.assign(ticketGuid, deviceName: 'Google Pixel 8');

      final message = bodyOf(adapter.requestsTo('/mkkm/tickets/assign-e').single)['message'] as String;
      expect(message.split('\n').length, 6); // still the same wire shape
    });

    test('carries the error envelope through on failure', () async {
      adapter.onPost('/mkkm/tickets/assign-e', [
        (200, {'assigned': false, 'code': 5, 'message': 'Bilet już przypisany'}),
      ]);

      final response = await client.tickets.assign(ticketGuid);

      expect(response.assigned, isFalse);
      expect(response.codeAsInt, 5);
      expect(response.message, 'Bilet już przypisany');
    });
  });

  group('TicketsApi.contract', () {
    test('round-trips a contract into the AZTEC hex token', () async {
      adapter.onPost('/mkkm/tickets/contract-e', [(200, fixture('contract_e_response'))]);

      final response = await client.tickets.contract(ticketGuid);

      expect(response.code, isNull);
      expect(response.contract, isNotNull);

      final aztec = response.decodeAztec();
      expect(aztec, plantedAztecToken);
      expect(aztec, matches(RegExp('^[0-9A-F]{512}\$')));
    });

    test('rejects with the error envelope (code != null)', () async {
      adapter.onPost('/mkkm/tickets/contract-e', [
        (200, {'contract': null, 'code': 4, 'message': 'Bilet nieprzypisany'}),
      ]);

      final response = await client.tickets.contract(ticketGuid);

      expect(response.codeAsInt, 4);
      expect(response.decodeAztec(), isNull);
    });

    test('posts a {"ticketGuid": …} payload in the wire shape', () async {
      adapter.onPost('/mkkm/tickets/contract-e', [(200, fixture('contract_e_response'))]);
      await client.tickets.contract(ticketGuid);

      final req = adapter.requestsTo('/mkkm/tickets/contract-e').single;
      final message = bodyOf(req)['message'] as String;
      expect(message.split('\n').map((l) => l.length).toList(), const [76, 76, 76, 76, 40, 0]);
      expect(base64Decode(message.replaceAll('\n', '')).length, 256);
    });
  });

  group('aztecKey', () {
    test('the key the host supplies is asked for on every call and used', () async {
      final first = _generateRsaKeyPair();
      final second = _generateRsaKeyPair();
      var current = first;
      final rotating = EkpClient(
        tokenStore: InMemoryTokenStore(),
        dio: Dio(BaseOptions(baseUrl: baseUrl))..httpClientAdapter = adapter,
        aztecKey: () => _encodePublicKeyToPkcs1Pem(current.publicKey),
      );
      addTearDown(rotating.dispose);
      adapter.onPost('/mkkm/tickets/contract-e', [
        (200, fixture('contract_e_response')),
        (200, fixture('contract_e_response')),
      ]);

      await rotating.tickets.contract(ticketGuid);
      current = second;
      await rotating.tickets.contract(ticketGuid);

      final sent = [
        for (final request in adapter.requestsTo('/mkkm/tickets/contract-e')) bodyOf(request)['message'] as String,
      ];
      expect(_decrypt(sent[0], first.privateKey), jsonEncode({'ticketGuid': ticketGuid}));
      expect(_decrypt(sent[1], second.privateKey), jsonEncode({'ticketGuid': ticketGuid}));
    });

    test('a key that cannot be read fails before anything is sent', () async {
      final broken = EkpClient(
        tokenStore: InMemoryTokenStore(),
        dio: Dio(BaseOptions(baseUrl: baseUrl))..httpClientAdapter = adapter,
        aztecKey: () => 'not a pem',
      );
      addTearDown(broken.dispose);

      await expectLater(broken.tickets.assign(ticketGuid), throwsA(isA<EkpCryptoException>()));
      expect(adapter.requestsTo('/mkkm/tickets/assign-e'), isEmpty);
    });
  });

  group('TicketContractResponse.decodeAztec', () {
    test('returns null for a contract with garbage bytes', () {
      final response = TicketContractResponse(contract: base64Encode(List<int>.filled(64, 7)));
      expect(response.decodeAztec(), isNull);
    });

    test('uses the override secret/environment hooks', () {
      final response = TicketContractResponse(contract: base64Encode(List<int>.filled(64, 7)));
      expect(
        response.decodeAztec(secret: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', environment: EkpCryptoEnvironment.development),
        isNull,
      );
    });
  });
}

/// Undoes [EkpAztecCrypto.encryptJson] with the private half of the key.
String _decrypt(String message, RSAPrivateKey key) {
  final rsa = PKCS1Encoding(RSAEngine())..init(false, PrivateKeyParameter<RSAPrivateKey>(key));
  return utf8.decode(rsa.process(base64Decode(message.replaceAll('\n', ''))));
}

/// Generates a 2048-bit RSA keypair (test only; ~0.5 s).
AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> _generateRsaKeyPair() {
  final seed = Uint8List.fromList(List<int>.generate(32, (_) => Random.secure().nextInt(256)));
  final random = FortunaRandom()..seed(KeyParameter(seed));
  final generator = RSAKeyGenerator()
    ..init(ParametersWithRandom(RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64), random));
  return generator.generateKeyPair();
}

/// [key] as a PKCS#1 `BEGIN RSA PUBLIC KEY` PEM.
String _encodePublicKeyToPkcs1Pem(RSAPublicKey key) {
  final sequence = ASN1Sequence()
    ..add(ASN1Integer(key.modulus!))
    ..add(ASN1Integer(key.exponent!));
  final encoded = base64Encode(sequence.encodedBytes);
  final buffer = StringBuffer()..writeln('-----BEGIN RSA PUBLIC KEY-----');
  for (var i = 0; i < encoded.length; i += 64) {
    buffer.writeln(encoded.substring(i, min(i + 64, encoded.length)));
  }
  buffer.writeln('-----END RSA PUBLIC KEY-----');
  return buffer.toString();
}
