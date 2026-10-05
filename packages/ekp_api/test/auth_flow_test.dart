import 'package:dio/dio.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:test/test.dart';

import 'fixtures.dart';
import 'mock_adapter.dart';

const baseUrl = 'https://api.ekp.mpk.krakow.pl';

const tokenA = 'aaa.payload-a.sig-a-1234567890abcdef12345678';
const tokenB = 'bbb.payload-b.sig-b-1234567890abcdef12345678';

final sessionA = AuthSession(token: tokenA, refresh: 'refresh-a', expires: DateTime.utc(2030, 1, 1));

/// A successful recover rotation to [tokenB].
const recoverSuccessReplies = [
  (200, {'token': tokenB, 'refresh': 'refresh-b', 'expires': '2030-01-02T00:00:00Z'}),
];

void main() {
  late Dio dio;
  late MockAdapter adapter;
  late InMemoryTokenStore store;
  late EkpClient client;
  late List<EkpSessionEvent> events;

  setUp(() {
    store = InMemoryTokenStore();
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    adapter = MockAdapter();
    dio.httpClientAdapter = adapter;

    client = EkpClient(
      device: const EkpDeviceIdentity(deviceId: 'deadbeefdeadbeef', platform: 'android 34', deviceName: 'test device'),
      tokenStore: store,
      dio: dio,
    );
    events = [];
    client.session.events.listen(events.add);
  });

  tearDown(() async {
    await client.dispose();
  });

  Map<String, String?> headersOf(RequestOptions options) =>
      options.headers.map((k, v) => MapEntry(k.toLowerCase(), v?.toString()));

  Iterable<RequestOptions> requestsTo(String fragment) => adapter.requestsTo(fragment);

  group('login', () {
    test('stores session and emits authenticated event', () async {
      adapter.onPost('/auth/login', [(200, fixture('login_response'))]);
      final session = await client.auth.login('test@example.com', 'pw');
      expect(session.token, 'aaa.bbb.ccc');
      final stored = await store.read();
      expect(stored!.token, 'aaa.bbb.ccc');
      expect(events, contains(isA<EkpSessionAuthenticated>()));
    });

    test('sends device identity in body and headers, no Bearer', () async {
      adapter.onPost('/auth/login', [(200, fixture('login_response'))]);
      await client.auth.login('test@example.com', 'pw');

      final req = requestsTo('/auth/login').single;
      expect((req.data as Map<String, dynamic>)['deviceId'], 'deadbeefdeadbeef');
      expect((req.data as Map<String, dynamic>)['deviceName'], 'test device');
      final headers = headersOf(req);
      expect(headers['x-device-id'], 'deadbeefdeadbeef');
      expect(headers['x-platform'], 'android 34');
      expect(headers['x-client-version'], '1.6.10');
      expect(headers['accept'], 'application/json');
      expect(headers['user-agent'], 'okhttp/4.12.0', reason: 'dart:io would advertise Dart/x.y — instant fingerprint');
      expect(headers.containsKey('authorization'), isFalse, reason: 'anonymous endpoint must not carry a Bearer token');
    });

    test('wrong credentials map to EkpUnauthorizedException', () async {
      adapter.onPost('/auth/login', [
        (401, ''), // the server sends an empty body
      ]);
      await expectLater(
        client.auth.login('x@y.z', 'bad'),
        throwsA(isA<EkpUnauthorizedException>().having((e) => e.message, 'message', 'Nieprawidłowy e-mail lub hasło.')),
      );
      expect(await store.read(), isNull);
    });

    test('inactive account: login 400 surfaces as EkpHttpException', () async {
      adapter.onPost('/auth/login', [
        (400, {'message': 'Konto jest nieaktywne', 'exceptionCode': 259, 'code': 1}),
      ]);
      await expectLater(
        client.auth.login('x@y.z', 'never-activated'),
        throwsA(
          isA<EkpHttpException>()
              .having((e) => e.statusCode, 'statusCode', 400)
              .having((e) => e.message, 'message', 'Konto jest nieaktywne')
              // `code` (1) shadows `exceptionCode` (259) in the pick order.
              .having((e) => e.codeAsInt, 'codeAsInt', 1),
        ),
      );
      expect(await store.read(), isNull);
    });

    test('register with birthDate sends date and no pesel', () async {
      adapter.onPost('/auth/register', [
        (200, {'code': null, 'message': null}),
      ]);
      await client.auth.register(
        firstName: 'Jan',
        lastName: 'Testowy',
        email: 'test@example.com',
        password: 'Sup3rSecret!',
        birthDate: DateTime(1983, 9, 28),
      );
      final body = requestsTo('/auth/register').single.data as Map<String, dynamic>;
      expect(body.containsKey('pesel'), isFalse);
      expect(body['birthDate'], matches(RegExp(r'^1983-09-28T00:00:00[+-]\d{2}:\d{2}$')));
      expect(body['repeat_email'], body['email']);
    });

    test('register with pesel sends pesel AND the derived birthDate', () async {
      adapter.onPost('/auth/register', [
        (200, {'code': null, 'message': null}),
      ]);
      await client.auth.register(
        firstName: 'Jan',
        lastName: 'Testowy',
        email: 'test@example.com',
        password: 'Sup3rSecret!',
        pesel: '90010112345',
        // Derived client-side by the host app (captured 2026-10-01: the
        // official app prefills birthDate from the PESEL and sends both).
        birthDate: DateTime(1990, 1, 1),
      );
      final body = requestsTo('/auth/register').single.data as Map<String, dynamic>;
      expect(body['pesel'], '90010112345');
      expect((body['birthDate'] as String).startsWith('1990-01-01T00:00:00'), isTrue);
    });

    test('register always sends a birthDate', () async {
      adapter.onPost('/auth/register', [
        (200, {'code': null, 'message': null}),
      ]);
      await client.auth.register(
        firstName: 'a',
        lastName: 'b',
        email: 'c@d.e',
        password: 'x',
        birthDate: DateTime(1983, 9, 28),
      );
      final body = requestsTo('/auth/register').single.data as Map<String, dynamic>;
      expect(body['pesel'], isNull);
      expect(body['birthDate'], startsWith('1983-09-28T00:00:00'));
    });
  });

  group('device headers on authenticated calls', () {
    test('Bearer attached for non-auth endpoints when session exists', () async {
      await store.write(sessionA);
      adapter.onGet('/account/user-data', [(200, fixture('user_data'))]);
      await client.account.userData();
      final req = requestsTo('/account/user-data').single;
      final headers = headersOf(req);
      expect(headers['authorization'], 'Bearer $tokenA');
      expect(headers['x-device-name'], 'test device');
      expect(headers['x-platform'], 'android 34');
      expect(headers['user-agent'], 'okhttp/4.12.0');
      expect(headers['content-type'], 'application/json', reason: 'okhttp sends content-type even on bodyless GETs');
    });

    test('token/recover travels the normal pipeline: x-headers, no Bearer', () async {
      await store.write(sessionA);
      adapter.onPost('/auth/token/recover', [(200, fixture('token_recover_response'))]);
      final ok = await client.session.recover();
      expect(ok, isTrue);

      final req = requestsTo('/auth/token/recover').single;
      final body = req.data as Map<String, dynamic>;
      expect(body['token'], 'refresh-a');
      expect(body['deviceId'], 'deadbeefdeadbeef');
      expect(body['deviceName'], 'test device');
      final headers = headersOf(req);
      expect(headers['x-device-id'], 'deadbeefdeadbeef');
      expect(headers['x-client-version'], '1.6.10');
      expect(headers['authorization'], isNull, reason: 'token endpoints are exempt from Bearer injection');
    });
  });

  group('token transport', () {
    test('logout sends Bearer + device id, clears store and emits logged out', () async {
      await store.write(sessionA);
      adapter.onPost('/auth/logout', [(200, '"Successfully logged out."')]);
      await client.auth.logout();

      expect(await store.read(), isNull);
      expect(events.whereType<EkpSessionLoggedOut>(), isNotEmpty);
      final req = requestsTo('/auth/logout').single;
      expect(req.queryParameters['id'], 'deadbeefdeadbeef');
      expect(
        headersOf(req)['authorization'],
        'Bearer $tokenA',
        reason: 'Bearer is the primary credential; cookies are not needed',
      );
    });

    test('recover rotates the session and emits updated', () async {
      await store.write(sessionA);
      adapter.onPost('/auth/token/recover', recoverSuccessReplies);
      final ok = await client.session.recover();
      expect(ok, isTrue);
      expect((await store.read())!.token, tokenB);
      expect(events.whereType<EkpSessionUpdated>(), isNotEmpty);
    });
  });

  test('recover keeps the session when the server is unreachable', () async {
    await store.write(sessionA);
    // No route registered: the request fails without an HTTP response.
    final ok = await client.session.recover();
    expect(ok, isFalse);
    expect((await store.read())!.token, tokenA);
    expect(events.whereType<EkpSessionExpired>(), isEmpty);
  });

  group('automatic 401 recovery', () {
    test('recovers once, retries the request with the fresh token', () async {
      await store.write(sessionA);

      adapter.onPost('/auth/token/recover', recoverSuccessReplies);
      adapter.onGet('/mkkm/tickets/list', [
        (401, ''), // original request fails
        (200, fixture('mkkm_tickets')), // retry succeeds
      ]);

      final tickets = await client.tickets.mkkmTickets();
      expect(tickets.tickets, hasLength(1));
      expect(requestsTo('/auth/token/recover'), hasLength(1));
      expect(requestsTo('mkkm/tickets'), hasLength(2), reason: 'original request + exactly one retry');
      expect((await store.read())!.token, tokenB);
      expect(
        headersOf(requestsTo('mkkm/tickets').last)['authorization'],
        'Bearer $tokenB',
        reason: 'retry uses the recovered token',
      );
    });

    test('concurrent 401s share a single recovery (single flight)', () async {
      await store.write(sessionA);

      adapter.onPost('/auth/token/recover', recoverSuccessReplies);
      adapter.onGet('/service-status', [
        (401, ''), // both parallel originals fail
        (401, ''),
        (200, fixture('service_status')), // both retries succeed
        (200, fixture('service_status')),
      ]);

      final results = await Future.wait(List.generate(2, (_) => client.misc.serviceStatus()));
      expect(results.map((r) => r.isAvailable), everyElement(isTrue));
      expect(requestsTo('/auth/token/recover'), hasLength(1), reason: 'one recovery shared by both failures');
      expect(requestsTo('service-status'), hasLength(4), reason: '2 original + 2 retried requests');
    });

    test('unrecoverable session surfaces as EkpSessionExpiredException', () async {
      await store.write(sessionA);

      adapter.onPost('/auth/token/recover', [(401, '')]);
      adapter.onGet('/invoices', [(401, '')]);

      await expectLater(client.invoices.list(), throwsA(isA<EkpSessionExpiredException>()));
      expect(await store.read(), isNull);
      expect(events.whereType<EkpSessionExpired>(), isNotEmpty);
    });

    test('401 on auth endpoints never triggers recovery', () async {
      adapter.onPost('/auth/change-password', [(401, '')]);
      await expectLater(
        client.auth.changePassword(previousPassword: 'a', newPassword: 'b', repeatPassword: 'b'),
        throwsA(isA<EkpUnauthorizedException>()),
      );
      expect(requestsTo('token/recover'), isEmpty, reason: 'no recovery attempt for /auth/* paths');
    });
  });

  group('cookie jar (standard jar honoring Set-Cookie)', () {
    /// The login/recover Set-Cookie trio, byte-shaped like the real server's
    /// (values matching tokenA/sessionA).
    final loginSetCookies = <String, List<String>>{
      'set-cookie': [
        'access-token=aaa.payload-a; Path=/; Secure',
        'access-signature=sig-a-1234567890abcdef12345678; Path=/; Secure',
        'access-remember=refresh-a; Path=/; Secure',
      ],
    };

    /// The logout response overwrites the trio with blank values — that is
    /// where the official app's post-logout "empty cookies" come from.
    final logoutSetCookies = <String, List<String>>{
      'set-cookie': [
        'access-token=; Path=/; Secure',
        'access-signature=; Path=/; Secure',
        'access-remember=; Path=/; Secure',
      ],
    };

    test('fresh jar sends no cookies; login stores the trio and replays it', () async {
      adapter.onPost('/auth/login', [(200, fixture('login_response'))], responseHeaders: loginSetCookies);
      adapter.onGet('/service-status', [(200, fixture('service_status')), (200, fixture('service_status'))]);

      await client.misc.serviceStatus();
      expect(
        headersOf(requestsTo('service-status').first)['cookie'],
        isNull,
        reason: 'fresh jar → no cookie header (null-valued, dropped on wire)',
      );

      await client.auth.login('test@example.com', 'pw');
      await client.misc.serviceStatus();
      expect(
        headersOf(requestsTo('service-status').last)['cookie'],
        'access-token=aaa.payload-a; '
        'access-signature=sig-a-1234567890abcdef12345678; '
        'access-remember=refresh-a',
        reason: 'Set-Cookie from the login response is replayed verbatim',
      );
    });

    test('recover rotates the stored cookies via its Set-Cookie', () async {
      await store.write(sessionA);
      adapter.onPost(
        '/auth/token/recover',
        [(200, fixture('login_response'))],
        responseHeaders: {
          'set-cookie': [
            'access-token=aaa.bbb; Path=/; Secure',
            'access-signature=ccc; Path=/; Secure',
            'access-remember=feedfacefeedfacefeedfacefeedface; Path=/; Secure',
          ],
        },
      );
      await client.session.recover();
      expect(
        requestsTo('/auth/token/recover').single.headers['cookie'],
        isNull,
        reason: 'jar was empty before the recover response arrived',
      );
    });

    test('logout blanks are stored and replayed, like the official client', () async {
      adapter.onPost('/auth/login', [(200, fixture('login_response'))], responseHeaders: loginSetCookies);
      adapter.onPost('/auth/logout', [(200, '"Successfully logged out."')], responseHeaders: logoutSetCookies);
      adapter.onGet('/auth/password-policy', [(200, fixture('password_policy'))]);

      await client.auth.login('test@example.com', 'pw');

      // The logout request itself still carries the live cookies.
      await client.auth.logout();
      expect(
        headersOf(requestsTo('/auth/logout').single)['cookie'],
        'access-token=aaa.payload-a; '
        'access-signature=sig-a-1234567890abcdef12345678; '
        'access-remember=refresh-a',
      );

      // Afterwards the jar replays the blank values the server set.
      await client.auth.passwordPolicy();
      expect(
        headersOf(requestsTo('/auth/password-policy').single)['cookie'],
        'access-token=; access-signature=; access-remember=',
      );
    });
  });

  group('PaymentsApi.check', () {
    test('HTTP 400 with code 2 maps to pending', () async {
      adapter.onPost('/payments/check', [(400, fixture('payments_check_pending'))]);
      final result = await client.payments.check('guid');
      expect(result.status, PaymentCheckStatus.pending);
      expect(result.message, contains('Brak zaksięgowanej płatności'));
    });

    test('HTTP 200 maps to confirmed', () async {
      adapter.onPost('/payments/check', [
        (200, {'code': null, 'message': null}),
      ]);
      final result = await client.payments.check('guid');
      expect(result.status, PaymentCheckStatus.confirmed);
    });

    test('other 400s are raised as EkpHttpException', () async {
      adapter.onPost('/payments/check', [
        (400, {'code': 9, 'message': 'boom'}),
      ]);
      await expectLater(
        client.payments.check('guid'),
        throwsA(isA<EkpHttpException>().having((e) => e.codeAsInt, 'code', 9)),
      );
    });
  });

  group('PaymentsApi.result', () {
    test('reports webview outcome with string-typed body, empty 200', () async {
      adapter.onPost('/payments/result', [
        (200, null), // the real endpoint answers 200 with an empty body
      ]);
      await client.payments.result(id: '0123456789abcdef0123456789abcdef', type: '2');

      final req = requestsTo('/payments/result').single;
      final body = req.data as Map<String, dynamic>;
      expect(body, {'id': '0123456789abcdef0123456789abcdef', 'type': '2', 'result': 'Success'});
      expect(
        body.values.every((v) => v is String),
        isTrue,
        reason: 'every payments/result field is a string on the wire',
      );
    });

    test('reports the rejected-payment outcome with result: Error', () async {
      adapter.onPost('/payments/result', [(200, null)]);
      await client.payments.result(id: 'fedcba9876543210fedcba9876543210', type: '2', result: 'Error');

      final body = requestsTo('/payments/result').single.data as Map<String, dynamic>;
      expect(body['result'], 'Error');
      expect(
        body['id'],
        'fedcba9876543210fedcba9876543210',
        reason: 'id comes from the /payment/rejected redirect query',
      );
    });
  });

  group('TicketsApi.returnTicket', () {
    test('executes the return with a UTC-instant returnDate', () async {
      adapter.onPost('/ticket-returns', [(200, fixture('ticket_return'))]);
      final res = await client.tickets.returnTicket(transactionId: 400004, returnDate: DateTime.utc(2025, 6, 15));
      expect(res.success, isTrue);

      final body = requestsTo('/ticket-returns').single.data as Map<String, dynamic>;
      expect(body['transactionId'], 400004);
      expect(
        body['returnDate'],
        '2025-06-15T00:00:00.000Z',
        reason:
            'returnDate must serialize as a true-UTC instant '
            '(YYYY-MM-DDTHH:mm:ss.sssZ)',
      );
    });
  });

  group('AccountApi.anonymise', () {
    test('sends PUT with password confirmation and parses the envelope', () async {
      await store.write(sessionA);
      adapter.onPut('/account/anonymise', [(200, fixture('anonymise_response'))]);
      final res = await client.account.anonymise(password: 'Sup3rSecret!');
      expect(res.code, isNull);
      expect(res.message, contains('usunięte'));

      final req = requestsTo('/account/anonymise').single;
      expect(req.method, 'PUT');
      expect((req.data as Map<String, dynamic>)['password'], 'Sup3rSecret!');
      expect(headersOf(req)['authorization'], 'Bearer $tokenA', reason: 'anonymise is an authenticated call');
    });
  });
}
