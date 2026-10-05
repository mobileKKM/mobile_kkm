import 'package:dio/dio.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:test/test.dart';

import 'fixtures.dart';
import 'mock_adapter.dart';

/// Wire-format tests for every API layer: path, method, query parameters,
/// request body and Bearer/header behavior, each against the captured
/// fixtures. (Auth/session flows have their dedicated suite in
/// auth_flow_test.dart; models are pinned in models_test.dart.)
const baseUrl = 'https://api.ekp.mpk.krakow.pl';

/// A session seeded into the store so requests carry a Bearer token.
final seededSession = AuthSession(
  token: 'aaa.payload-a.sig-a-1234567890abcdef12345678',
  refresh: 'refresh-a',
  expires: DateTime.utc(2030, 1, 1),
);

void main() {
  late Dio dio;
  late MockAdapter adapter;
  late InMemoryTokenStore store;
  late EkpClient client;

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
    store.write(seededSession);
  });

  tearDown(() => client.dispose());

  Map<String, String?> headersOf(RequestOptions options) =>
      options.headers.map((k, v) => MapEntry(k.toLowerCase(), v?.toString()));

  Map<String, dynamic> bodyOf(RequestOptions options) => options.data as Map<String, dynamic>;

  Iterable<RequestOptions> requestsTo(String fragment) => adapter.requestsTo(fragment);

  /// Asserts the recorded request carried the seeded Bearer token.
  void expectBearer(RequestOptions options) {
    expect(headersOf(options)['authorization'], 'Bearer ${seededSession.token}');
  }

  group('AuthApi (registration & password family)', () {
    test('register sends PESEL variant with repeated email/password', () async {
      adapter.onPost('/auth/register', [
        (200, {'code': null, 'message': 'ok'}),
      ]);
      await client.auth.register(
        firstName: 'Jan',
        lastName: 'Testowy',
        email: 'test@example.com',
        password: 'secret123',
        // The official app derives the birth date from the PESEL
        // client-side and sends BOTH (captured 2026-10-01).
        pesel: '90010112345',
        birthDate: DateTime(1990, 1, 1),
      );

      final body = bodyOf(requestsTo('/auth/register').single);
      expect(body['pesel'], '90010112345');
      expect(
        (body['birthDate'] as String).startsWith('1990-01-01T00:00:00'),
        isTrue,
        reason: 'got ${body['birthDate']}',
      );
      expect(body['repeat_email'], 'test@example.com');
      expect(body['repeat_password'], 'secret123');
      expect(body['marketingConsents'], isEmpty);
      expect(
        headersOf(requestsTo('/auth/register').single)['authorization'],
        isNull,
        reason: 'register is anonymous — must not carry a Bearer token',
      );
    });

    test('register formats birthDate as local-calendar ISO offset', () async {
      adapter.onPost('/auth/register', [
        (200, {'code': null, 'message': 'ok'}),
      ]);
      await client.auth.register(
        firstName: 'Jan',
        lastName: 'Testowy',
        email: 'test@example.com',
        password: 'secret123',
        birthDate: DateTime(1983, 9, 28),
      );

      final body = bodyOf(requestsTo('/auth/register').single);
      expect(body['pesel'], isNull);
      // Official format: local midnight with the local UTC offset.
      expect(
        (body['birthDate'] as String).startsWith('1983-09-28T00:00:00'),
        isTrue,
        reason: 'got ${body['birthDate']}',
      );
      expect(body['birthDate'], contains(RegExp(r'[+-]\d{2}:\d{2}$')));
    });

    test('activate posts the e-mail token', () async {
      adapter.onPost('/auth/activate', [
        (200, {'code': null, 'message': 'ok'}),
      ]);
      final res = await client.auth.activate('token-from-email');
      expect(res.message, 'ok');
      expect(bodyOf(requestsTo('/auth/activate').single)['token'], 'token-from-email');
    });

    test('changePassword posts triple and surfaces code-as-string', () async {
      adapter.onPost('/auth/change-password', [(200, fixture('change_password_error'))]);
      final res = await client.auth.changePassword(previousPassword: 'old', newPassword: 'new', repeatPassword: 'new');
      expect(res.codeAsString, 'PasswordInHistory');
      final body = bodyOf(requestsTo('/auth/change-password').single);
      expect(body['previousPassword'], 'old');
      expect(body['newPassword'], 'new');
      expect(body['repeatPassword'], 'new');
    });

    test('requestPasswordReset posts just the e-mail', () async {
      adapter.onPost('/auth/reset-password-link-request', [
        (200, {'code': null, 'message': 'sent'}),
      ]);
      await client.auth.requestPasswordReset('test@example.com');
      expect(bodyOf(requestsTo('/auth/reset-password-link-request').single), {'email': 'test@example.com'});
    });

    test('resetPassword posts token + newPassword', () async {
      adapter.onPost('/auth/reset-password', [
        (200, {'code': null, 'message': 'ok'}),
      ]);
      await client.auth.resetPassword(token: 't', newPassword: 'n');
      expect(bodyOf(requestsTo('/auth/reset-password').single), {'token': 't', 'newPassword': 'n'});
    });

    test('passwordPolicy GETs the policy', () async {
      adapter.onGet('/auth/password-policy', [(200, fixture('password_policy'))]);
      final policy = await client.auth.passwordPolicy();
      expect(policy.minLength, 8);
    });

    test('marketingConsents GETs the consent list', () async {
      adapter.onGet('/auth/marketing-consents', [(200, fixture('auth_consents'))]);
      final res = await client.auth.marketingConsents();
      expect(res.marketingConsents, hasLength(1));
    });

    test('logout swallows server failure and still logs out locally', () async {
      adapter.onPost('/auth/logout', [(500, '')]);
      await expectLater(client.auth.logout(), completes);
      expect(await client.session.currentSession(), isNull);
    });
  });

  group('AccountApi', () {
    test('userData GETs and parses, with Bearer', () async {
      adapter.onGet('/account/user-data', [(200, fixture('user_data'))]);
      final res = await client.account.userData();
      expect(res.userData!.firstName, 'Jan');
      expectBearer(requestsTo('/account/user-data').single);
    });

    test('updateUserData sends only provided fields', () async {
      adapter.onPost('/account/user-data', [(204, '')]);
      await client.account.updateUserData(phoneNumber: '600100200');
      expect(bodyOf(requestsTo('/account/user-data').single), {'phoneNumber': '600100200'});
    });

    test('inhabitantStatus GETs', () async {
      adapter.onGet('/account/inhabitant-status', [(200, fixture('inhabitant_status'))]);
      final res = await client.account.inhabitantStatus();
      expect(res.isActive, isTrue);
    });

    test('inhabitantContract GETs the epoch/PNG contract', () async {
      adapter.onGet('/account/inhabitant-contract', [(200, fixture('inhabitant_contract'))]);
      final res = await client.account.inhabitantContract();
      expect(res.expirationDate, isNotNull);
    });

    test('streetAutocomplete builds the city/query path', () async {
      adapter.onGet('/account/street-autocomplete', [(200, fixture('street_autocomplete'))]);
      final res = await client.account.streetAutocomplete(15, 'Test');
      expect(res.streets, contains('TESTOWA'));
      expect(requestsTo('/account/street-autocomplete').single.path, contains('/account/street-autocomplete/15/Test'));
    });

    test('uploadPhotoBytes posts multipart under the photo field', () async {
      adapter.onPost('/account/photo', [(200, '')]);
      await client.account.uploadPhotoBytes([1, 2, 3, 4]);
      final req = requestsTo('/account/photo').single;
      expect(req.data, isA<FormData>());
      expect((req.data as FormData).files.single.key, 'photo');
    });

    test('updateUserData serializes a full registered address', () async {
      adapter.onPost('/account/user-data', [(204, '')]);
      final user = UserDataResponse.fromJson(fixture('user_data'));
      final address = user.userData!.registeredAddress!;
      await client.account.updateUserData(registeredAddress: address);
      expect(bodyOf(requestsTo('/account/user-data').single)['registeredAddress'], address.toJson());
    });
  });

  group('StorageMediumApi', () {
    test('list GETs the media', () async {
      adapter.onGet('/storage-medium/list', [(200, fixture('storage_medium_list'))]);
      final res = await client.storageMediums.list();
      expect(res.items, isNotEmpty);
    });

    test('createMkkm POSTs the address, expecting plain response', () async {
      adapter.onPost('/storage-medium/create-mkkm', [(200, '')]);
      final user = UserDataResponse.fromJson(fixture('user_data'));
      final address = user.userData!.registeredAddress!;
      await client.storageMediums.createMkkm(address);
      final req = requestsTo('/storage-medium/create-mkkm').single;
      expect(bodyOf(req), address.toJson());
    });
  });

  group('DictionaryApi', () {
    test('ticketKindList GETs', () async {
      adapter.onGet('/dictionary/ticket-kind-list', [(200, fixture('ticket_kind_list'))]);
      final res = await client.dictionaries.ticketKindList();
      expect(res.kinds, isNotEmpty);
    });

    test('ticketNumberOfLineList GETs', () async {
      adapter.onGet('/dictionary/ticket-number-of-line-list', [(200, fixture('ticket_number_of_line_list'))]);
      final res = await client.dictionaries.ticketNumberOfLineList();
      expect(res.list, isNotEmpty);
    });

    test('ticketPeriodList GETs', () async {
      adapter.onGet('/dictionary/ticket-period-list', [(200, fixture('ticket_period_list'))]);
      final res = await client.dictionaries.ticketPeriodList();
      expect(res.list, isNotEmpty);
    });

    test('transportLines passes number as query and parses typed lines', () async {
      adapter.onGet('/dictionary/transport-line', [(200, fixture('transport_line'))]);
      final res = await client.dictionaries.transportLines('1');
      expect(res.lines, hasLength(90));
      expect(requestsTo('/dictionary/transport-line').single.queryParameters, containsPair('number', '1'));
    });

    test('cityCardTypes GETs and resolves names', () async {
      adapter.onGet('/dictionary/city-card-types', [(200, fixture('city_card_types'))]);
      final res = await client.dictionaries.cityCardTypes();
      expect(res.nameForCode(8), isNotNull);
    });
  });

  group('MiscApi', () {
    test('serviceStatus GETs', () async {
      adapter.onGet('/service-status', [(200, fixture('service_status'))]);
      final res = await client.misc.serviceStatus();
      expect(res.isAvailable, isTrue);
    });

    test('mobileAppConfig GETs', () async {
      adapter.onGet('/client/mobile-app/config', [(200, fixture('app_config'))]);
      final res = await client.misc.mobileAppConfig();
      expect(res.minAppVersion, '1.6.10');
    });
  });

  group('InvoicesApi', () {
    test('list sends request.-prefixed pager queries', () async {
      adapter.onGet('/invoices', [(200, fixture('invoices'))]);
      final res = await client.invoices.list();
      expect(res.rowCount, 0);
      expect(
        requestsTo('/invoices').single.queryParameters,
        allOf(
          containsPair('request.pageIndex', 1),
          containsPair('request.pageSize', 15),
          containsPair('request.orderBy', 'createDatetime'),
          containsPair('request.sortDirection', 'DESC'),
        ),
      );
    });
  });

  group('SubscriptionsApi', () {
    test('details GETs', () async {
      adapter.onGet('/subscriptions/details', [(200, fixture('subscriptions_details'))]);
      final res = await client.subscriptions.details();
      expect(res.isSubscriptionSignedIn, isFalse);
    });

    test('availableActions GETs the action flags', () async {
      adapter.onGet('/subscriptions/available-actions', [(200, fixture('subscriptions_actions'))]);
      final res = await client.subscriptions.availableActions();
      expect(res.buyTicket, isFalse);
    });

    test('marketingConsents GETs', () async {
      adapter.onGet('/subscriptions/marketing-consents', [(200, fixture('subscriptions_consents'))]);
      final res = await client.subscriptions.marketingConsents();
      expect(res.marketingConsents, isNotNull);
    });

    test('signIn posts customer data, consents with content', () async {
      adapter.onPost('/subscriptions/sign-in', [(200, '')]);
      await client.subscriptions.signIn(
        firstName: 'JAN',
        lastName: 'TESTOWY',
        email: 'test@example.com',
        pesel: '90010112345',
        ccCustomerId: 200001,
        marketingConsents: const [MarketingConsent(id: 5, content: 'AKCEPTUJĘ REGULAMIN BILETU 5+1', isChecked: true)],
      );
      final req = requestsTo('/subscriptions/sign-in').single;
      expectBearer(req);
      expect(bodyOf(req), {
        'firstName': 'JAN',
        'lastName': 'TESTOWY',
        'email': 'test@example.com',
        'pesel': '90010112345',
        'ccCustomerId': 200001,
        'marketingConsents': [
          {'id': 5, 'content': 'AKCEPTUJĘ REGULAMIN BILETU 5+1', 'isChecked': true},
        ],
        'isCycleRefreshEnabled': false,
      });
    });

    test('cancel posts the literal null body', () async {
      adapter.onPost('/subscriptions/cancel', [(200, '')]);
      await client.subscriptions.cancel();
      final req = requestsTo('/subscriptions/cancel').single;
      expectBearer(req);
      expect(req.data, 'null');
    });
  });

  group('TicketsApi', () {
    test('mkkmTickets GETs the list', () async {
      adapter.onGet('/mkkm/tickets/list', [(200, fixture('mkkm_tickets'))]);
      final res = await client.tickets.mkkmTickets();
      expect(res.tickets, isNotEmpty);
      expect(res.tickets.first.status, 'active');
    });

    test('history sends customerCode + validity and parses the bare array', () async {
      adapter.onGet('/tickets', [(200, fixtureList('tickets_current'))]);
      final res = await client.tickets.history('100001');
      expect(res, hasLength(1));
      expect(res.first.transactionId, 400001);
      expect(requestsTo('/tickets').single.queryParameters, containsPair('validity', 'Current'));
    });

    test('detail GETs by transaction code', () async {
      adapter.onGet('/tickets/NDAwMDAxIzE', [(200, fixture('ticket_detail_active'))]);
      final res = await client.tickets.detail('NDAwMDAxIzE');
      expect(res.ticket, isNotNull);
      expect(requestsTo('/tickets/NDAwMDAxIzE').single.path, contains('/tickets/NDAwMDAxIzE'));
    });

    test('salesConfiguration GETs by customer code', () async {
      adapter.onGet('/tickets/ticket-sales-configuration', [(200, fixture('sales_config'))]);
      final res = await client.tickets.salesConfiguration('100001');
      expect(res.specialTransportLines, isNotNull);
    });

    test('calculate posts the selection body (UTC validFrom)', () async {
      adapter.onPost('/tickets/calculate', [(200, fixture('tickets_calculate'))]);
      final res = await client.tickets.calculate(
        validFrom: DateTime.utc(2025, 10, 1),
        ticketNumberOfLineCode: 3,
        customerCode: '100001',
        ticketKindCode: 2,
        ticketPeriodCode: 1,
        specialTransportLine: '1001',
      );
      expect(res.price, isNotNull);
      final body = bodyOf(requestsTo('/tickets/calculate').single);
      expect(body['validFrom'], '2025-10-01T00:00:00.000Z');
      expect(body['customerCode'], '100001');
      expect(body['ticketKindCode'], 2);
      expect(body['ticketPeriodCode'], 1);
      expect(body['ticketNumberOfLineCode'], 3);
      expect(body['specialTransportLine'], '1001');
      expect(body['lines'], isEmpty);
    });

    test('buy prepends tPayPaymentGroupId to the selection', () async {
      adapter.onPost('/tickets/buy', [(200, fixture('buy_response'))]);
      final res = await client.tickets.buy(
        tPayPaymentGroupId: '160',
        validFrom: DateTime.utc(2025, 10, 1),
        ticketNumberOfLineCode: 3,
        customerCode: '100001',
        ticketKindCode: 2,
        ticketPeriodCode: 1,
      );
      expect(res.ticket!.status, 'pending');
      final body = bodyOf(requestsTo('/tickets/buy').single);
      expect(body['tPayPaymentGroupId'], '160');
      expect(body.keys.first, 'tPayPaymentGroupId', reason: 'official body order: group id first');
      expect(res.urls, isNotNull);
    });

    test('pay posts id + ignoreWarnings + group id', () async {
      adapter.onPost('/tickets/pay', [(200, fixture('pay_response'))]);
      final res = await client.tickets.pay(ticketGuid: 'feedfacefeedfacefeedfacefeedface', tPayPaymentGroupId: '160');
      expect(res.ticket, isNotNull);
      expect(bodyOf(requestsTo('/tickets/pay').single), {
        'id': 'feedfacefeedfacefeedfacefeedface',
        'ignoreWarnings': true,
        'tPayPaymentGroupId': '160',
      });
    });

    test('calculateReturn posts transactionId + UTC returnDate', () async {
      adapter.onPost('/ticket-returns/calculate', [(200, fixture('ticket_returns_calculate'))]);
      final res = await client.tickets.calculateReturn(transactionId: 400004, returnDate: DateTime.utc(2025, 6, 15));
      expect(res.returnPrice, 92.4);
      expect(bodyOf(requestsTo('/ticket-returns/calculate').single), {
        'transactionId': 400004,
        'returnDate': '2025-06-15T00:00:00.000Z',
      });
    });
  });

  group('PaymentsApi', () {
    test('banks GETs the tpay bank list', () async {
      adapter.onGet('/payments/banks', [(200, fixture('banks'))]);
      final res = await client.payments.banks();
      expect(res.list, isNotEmpty);
    });

    test('changePaymentCard posts literal null, parses redirect', () async {
      adapter.onPost('/payments/change-payment-card', [(200, fixture('change_payment_card'))]);
      final res = await client.payments.changePaymentCard();
      expect(res.tPayRedirectUrl, 'https://secure.tpay.com/cards/?sale_auth=deadbeef');
      final req = requestsTo('/payments/change-payment-card').single;
      expectBearer(req);
      expect(req.data, 'null');
    });

    test('check returns confirmed on HTTP 200', () async {
      adapter.onPost('/payments/check', [(200, '')]);
      final res = await client.payments.check('feedfacefeedfacefeedfacefeedface');
      expect(res.status, PaymentCheckStatus.confirmed);
      expect(bodyOf(requestsTo('/payments/check').single), {'id': 'feedfacefeedfacefeedfacefeedface'});
    });

    test('check maps 400 code 2 to pending with the server message', () async {
      adapter.onPost('/payments/check', [(400, fixture('payments_check_pending'))]);
      final res = await client.payments.check('feedfacefeedfacefeedfacefeedface');
      expect(res.status, PaymentCheckStatus.pending);
      expect(res.message, contains('Brak zaksięgowanej płatności'));
      expect(res.code, 2);
    });

    test('check rethrows other 400s as EkpApiException', () async {
      adapter.onPost('/payments/check', [
        (400, {'code': 5, 'message': 'inne'}),
      ]);
      await expectLater(client.payments.check('feedfacefeedfacefeedfacefeedface'), throwsA(isA<EkpApiException>()));
    });

    test('result posts all-string body, default Success', () async {
      adapter.onPost('/payments/result', [(200, '')]);
      await client.payments.result(id: 'abc123', type: '2');
      expect(bodyOf(requestsTo('/payments/result').single), {'id': 'abc123', 'type': '2', 'result': 'Success'});
    });

    test('result forwards the Error outcome', () async {
      adapter.onPost('/payments/result', [(200, '')]);
      await client.payments.result(id: 'abc123', type: '2', result: 'Error');
      expect(bodyOf(requestsTo('/payments/result').single)['result'], 'Error');
    });
  });

  group('EkpClient defaults', () {
    test('constructing without a Dio uses the official base URL', () {
      final defaults = EkpClient();
      addTearDown(defaults.dispose);
      expect(defaults.dio.options.baseUrl, EkpDefaults.baseUrl);
      expect(defaults.dio.options.headers[Headers.acceptHeader], 'application/json');
    });
  });
}
