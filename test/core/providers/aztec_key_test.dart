import 'dart:convert';
import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:ekp_crypto/ekp_crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/crypto/aztec_key.dart';
import 'package:mobile_kkm/core/crypto/aztec_key_relay.dart';
import 'package:mobile_kkm/core/providers/aztec_key_provider.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';

import '../../support/fake_adapter.dart';
import '../../support/harness.dart';
import '../../support/sample_data.dart';

// Relative to the relay's base URL, so without a leading slash.
const _key = 'aztec-key';
const _refresh = 'aztec-key/refresh';
const _contract = '/mkkm/tickets/contract-e';
const _assign = '/mkkm/tickets/assign-e';
const _refusal = {'code': 4, 'message': 'Bilet nie jest powiązany.'};

final _contractJson = jsonDecode(
  File('packages/ekp_api/test/fixtures/contract_e_response.json').readAsStringSync(),
) as Map<String, dynamic>;

FakeAdapter _relay({String pem = rotatedAztecKeyPem, int version = 2}) =>
    FakeAdapter()..reply('GET', _key, 200, relayKeyJson(pem, version: version));

FakeAdapter _adapter({bool assigned = true}) => FakeAdapter()
  ..reply(
    'GET',
    '/mkkm/tickets/list',
    200,
    ticketsReply([assigned ? validTicket(assigned: true) : validTicket(canAssign: true)]),
  )
  ..reply('GET', '/account/user-data', 200, userDataJson());

AztecKey _keyOf(App app) => app.container.read(aztecKeyProvider);

Future<void> _openControl(WidgetTester tester) async {
  await openTab(tester, 'Tickets');
  await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
  await tester.pumpAndSettle();
}

void main() {
  group('at start', () {
    testWidgets('the relay is asked once, and its key is used and stored', (tester) async {
      final store = InMemoryAztecKeyStore();
      final app = await pumpApp(tester, _adapter(), session: signedInSession, relay: _relay(), aztecKeyStore: store);

      expect(app.relay.requests, hasLength(1));
      expect(_keyOf(app).pem, rotatedAztecKeyPem);
      expect(_keyOf(app).version, 2);
      expect(app.client.aztecKey!(), rotatedAztecKeyPem);
      expect((await store.read())?.pem, rotatedAztecKeyPem);
    });

    testWidgets('the relay is told which app is asking, and nothing of the device or the session', (tester) async {
      final app = await pumpApp(tester, _adapter(), session: signedInSession, relay: _relay());

      final request = app.relay.requests.single;
      expect(request.headers['User-Agent'], 'mobileKKM/1.2.3');
      final headers = request.headers.keys.map((name) => name.toLowerCase());
      expect(headers, isNot(contains('authorization')));
      expect(headers.where((name) => name.startsWith('x-')), isEmpty);
    });

    test('the relay is the project\'s own unless the build names another', () {
      expect(AztecKeyRelay.apiUrl(AztecKeyRelay.address), 'https://relay.mobilekkm.app/api/v1/');
      expect(AztecKeyRelay.apiUrl('https://relay.example.org/'), 'https://relay.example.org/api/v1/');
      expect(AztecKeyRelay.apiUrl('https://example.org/relay'), 'https://example.org/relay/api/v1/');
    });

    test('a relay that asks for a token gets it with every request', () async {
      final adapter = _relay()..reply('POST', _refresh, 429);
      final relay = AztecKeyRelay(
        Dio(BaseOptions(baseUrl: 'https://relay.test/api/v1/'))..httpClientAdapter = adapter,
        userAgent: 'mobileKKM/1.2.3',
        token: 'synthetic-token',
      );

      await relay.refresh();

      expect(adapter.requests, hasLength(2));
      expect(
        adapter.requests.map((request) => request.headers['Authorization']),
        everyElement('Bearer synthetic-token'),
      );
      expect(adapter.requests.map((request) => request.headers['User-Agent']), everyElement('mobileKKM/1.2.3'));
    });

    testWidgets('not while signed out, and right after signing in', (tester) async {
      final adapter = _adapter()
        ..reply('POST', '/auth/login', 200, {
          'token': 'aaa.bbb.ccc',
          'refresh': 'feedfacefeedfacefeedfacefeedface',
          'expires': '2100-01-01T00:00:00Z',
        });
      final app = await pumpApp(tester, adapter, relay: _relay());

      expect(app.relay.requests, isEmpty);
      expect(_keyOf(app).isBundled, isTrue);

      await tester.enterText(field('E-mail'), 'user@example.com');
      await tester.enterText(field('Password'), 'Secret123');
      await tapVisible(tester, find.widgetWithText(FilledButton, 'Sign in'));

      expect(app.relay.requests, hasLength(1));
      expect(_keyOf(app).pem, rotatedAztecKeyPem);
    });

    testWidgets('not behind the splash', (tester) async {
      final adapter = _adapter()..reply('GET', '/service-status', 200, {'isAvailable': true});
      final release = adapter.hold('GET', '/service-status');
      final app = await pumpApp(tester, adapter, session: signedInSession, relay: _relay(), settle: false);

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SplashScreen), findsOneWidget);
      expect(app.relay.requests, isEmpty);

      release();
      await tester.pumpAndSettle();
      expect(app.relay.requests, hasLength(1));
    });

    testWidgets('without the relay the key of the last run is used', (tester) async {
      final stored = AztecKey.fromJson(relayKeyJson(rotatedAztecKeyPem, version: 3));
      final store = InMemoryAztecKeyStore(stored);
      final app = await pumpApp(tester, _adapter(), session: signedInSession, aztecKeyStore: store);

      expect(_keyOf(app).pem, rotatedAztecKeyPem);
      expect(_keyOf(app).version, 3);
      expect(store.writes, 0);
    });

    testWidgets('without either, the key the app was built with', (tester) async {
      final app = await pumpApp(tester, _adapter(), session: signedInSession);

      expect(app.relay.requests, hasLength(1));
      expect(_keyOf(app).pem, aztecKeyPem);
      expect(app.client.aztecKey!(), aztecKeyPem);
    });

    testWidgets('a key that is not one is turned down', (tester) async {
      final store = InMemoryAztecKeyStore();
      final relay = _relay(pem: '-----BEGIN RSA PUBLIC KEY-----\nAAAA\n-----END RSA PUBLIC KEY-----\n');
      final app = await pumpApp(tester, _adapter(), session: signedInSession, relay: relay, aztecKeyStore: store);

      expect(_keyOf(app).isBundled, isTrue);
      expect(store.writes, 0);
    });

    testWidgets('the same key again is not written a second time', (tester) async {
      final store = InMemoryAztecKeyStore(AztecKey.fromJson(relayKeyJson(rotatedAztecKeyPem, version: 2)));
      await pumpApp(tester, _adapter(), session: signedInSession, relay: _relay(), aztecKeyStore: store);

      expect(store.writes, 0);
    });
  });

  group('a refused request', () {
    testWidgets('is sent again when the relay has another key by then', (tester) async {
      final adapter = _adapter()..reply('POST', _contract, 200, _refusal);
      final relay = FakeAdapter()..reply('POST', _refresh, 200, relayKeyJson(rotatedAztecKeyPem, version: 2));
      final release = relay.hold('POST', _refresh);
      final app = await pumpApp(tester, adapter, session: signedInSession, relay: relay);

      await openTab(tester, 'Tickets');
      await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
      // Not settled: the screen waits for the relay, with a spinner.
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(adapter.requestsTo(_contract), hasLength(1));
      expect(relay.requestsTo(_refresh), hasLength(1));

      // Under the new key the server answers.
      adapter.reply('POST', _contract, 200, _contractJson);
      release();
      await tester.pumpAndSettle();

      expect(adapter.requestsTo(_contract), hasLength(2));
      expect(_keyOf(app).pem, rotatedAztecKeyPem);
      expect(find.byType(BarcodeWidget), findsOneWidget);
      expect(find.text('Bilet nie jest powiązany.'), findsNothing);
    });

    testWidgets('is not sent again while the key is the same, and the relay is left alone for a while', (tester) async {
      final adapter = _adapter()..reply('POST', _contract, 200, _refusal);
      final relay = FakeAdapter()..reply('POST', _refresh, 200, relayKeyJson(aztecKeyPem));
      final app = await pumpApp(tester, adapter, session: signedInSession, relay: relay);
      await _openControl(tester);

      expect(adapter.requestsTo(_contract), hasLength(1));
      expect(relay.requestsTo(_refresh), hasLength(1));
      expect(find.text('Bilet nie jest powiązany.'), findsOneWidget);

      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();
      expect(adapter.requestsTo(_contract), hasLength(2));
      expect(relay.requestsTo(_refresh), hasLength(1));
      expect(_keyOf(app).sameKeyAs(AztecKey.bundled), isTrue);
    });

    testWidgets('gets the key the relay holds when the relay may not look again', (tester) async {
      final adapter = _adapter()..reply('POST', _contract, 200, _refusal);
      final relay = FakeAdapter()..reply('POST', _refresh, 429, {'detail': 'refresh rate limited'});
      final app = await pumpApp(tester, adapter, session: signedInSession, relay: relay);
      relay.reply('GET', _key, 200, relayKeyJson(rotatedAztecKeyPem, version: 2));
      await _openControl(tester);

      expect(_keyOf(app).pem, rotatedAztecKeyPem);
      expect(adapter.requestsTo(_contract), hasLength(2));
    });

    testWidgets('to assign a ticket is repeated the same way', (tester) async {
      final adapter = _adapter(assigned: false)
        ..reply('POST', _assign, 200, {'code': 3, 'message': 'Bilet jest już powiązany.'});
      final relay = FakeAdapter()..reply('POST', _refresh, 200, relayKeyJson(rotatedAztecKeyPem, version: 2));
      await pumpApp(tester, adapter, session: signedInSession, relay: relay);
      await openTab(tester, 'Tickets');

      await tester.tap(find.widgetWithText(FilledButton, 'Assign to device'));
      await tester.pumpAndSettle();

      expect(adapter.requestsTo(_assign), hasLength(2));
      expect(find.text('Bilet jest już powiązany.'), findsOneWidget);
    });

    testWidgets('for want of a connection asks nothing of the relay', (tester) async {
      final adapter = _adapter()..fail('POST', _contract);
      final app = await pumpApp(tester, adapter, session: signedInSession);
      final before = app.relay.requests.length;
      await _openControl(tester);

      expect(app.relay.requests, hasLength(before));
    });
  });
}
