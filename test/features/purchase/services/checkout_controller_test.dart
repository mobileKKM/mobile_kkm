import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _guid = 'feedfacefeedfacefeedfacefeedface';

final _choice = TicketChoice(
  validFrom: DateTime(2025, 10, 6),
  ticketNumberOfLineCode: 63,
  ticketKindCode: 2,
  ticketPeriodCode: 3,
  lines: const [],
  specialTransportLine: '1003',
);
final _entry = CheckoutEntry.buy(_choice, TicketCalculation.fromJson(apiFixture('tickets_calculate')));

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', '/payments/banks', 200, apiFixture('banks'))
  ..reply('POST', '/tickets/buy', 200, apiFixture('buy_response'))
  ..reply('POST', '/tickets/pay', 200, apiFixture('pay_response'));

Future<CheckoutController> _checkout(WidgetTester tester, App app, [CheckoutEntry? entry]) async {
  final provider = checkoutProvider(entry ?? _entry);
  addTearDown(app.container.listen(provider, (_, _) {}).close);
  await tester.pump(const Duration(milliseconds: 10));
  return app.container.read(provider.notifier);
}

CheckoutState _state(App app, [CheckoutEntry? entry]) => app.container.read(checkoutProvider(entry ?? _entry));

Future<CheckoutOutcome?> _pay(WidgetTester tester, CheckoutController checkout, {bool ignoreWarnings = false}) async {
  CheckoutOutcome? outcome;
  checkout.pay(ignoreWarnings: ignoreWarnings).then((o) => outcome = o).ignore();
  await tester.pump(const Duration(milliseconds: 10));
  await tester.pump(const Duration(milliseconds: 10));
  return outcome;
}

Map<String, dynamic> _body(FakeAdapter adapter, String path) =>
    adapter.requestsTo(path).last.data as Map<String, dynamic>;

void main() {
  testWidgets('nothing is chosen the first time', (tester) async {
    final app = await pumpApp(tester, _adapter(), session: signedInSession);
    await _checkout(tester, app);

    final state = _state(app);
    expect(state.methods.value?.tiles.map((b) => b.id), ['150', '166', '103', '171']);
    expect(state.selected, isNull);
    expect(state.lastUsed, isNull);
  });

  testWidgets('the method used last is chosen when the list still has it', (tester) async {
    final app = await pumpApp(
      tester,
      _adapter(),
      session: signedInSession,
      lastPaymentMethod: InMemoryLastPaymentMethodStore('160'),
    );
    await _checkout(tester, app);

    expect(_state(app).selected, '160');
    expect(_state(app).lastUsed, '160');
  });

  testWidgets('a method the list no longer has is not chosen', (tester) async {
    final app = await pumpApp(
      tester,
      _adapter(),
      session: signedInSession,
      lastPaymentMethod: InMemoryLastPaymentMethodStore('999'),
    );
    await _checkout(tester, app);

    expect(_state(app).selected, isNull);
  });

  testWidgets('buy once, then pay; the method is remembered', (tester) async {
    final adapter = _adapter();
    final store = InMemoryLastPaymentMethodStore();
    final app = await pumpApp(tester, adapter, session: signedInSession, lastPaymentMethod: store);
    final checkout = await _checkout(tester, app);
    checkout.select('150');

    final first = await _pay(tester, checkout);
    expect(first, isA<CheckoutOpen>());
    expect((first! as CheckoutOpen).paymentUrl, startsWith('https://secure.tpay.com/'));
    expect(_body(adapter, '/tickets/buy'), {
      'tPayPaymentGroupId': '150',
      'validFrom': DateTime(2025, 10, 6).toUtc().toIso8601String(),
      'ticketNumberOfLineCode': 63,
      'lines': <Object>[],
      'specialTransportLine': '1003',
      'customerCode': '100001',
      'ticketKindCode': 2,
      'ticketPeriodCode': 3,
    });
    expect(_state(app).ticketGuid, _guid);
    expect(store.groupId, '150');

    checkout.select('103');
    final second = await _pay(tester, checkout);
    expect(second, isA<CheckoutOpen>());
    expect(adapter.requestsTo('/tickets/buy'), hasLength(1));
    expect(_body(adapter, '/tickets/pay'), {'id': _guid, 'ignoreWarnings': false, 'tPayPaymentGroupId': '103'});
    expect(store.groupId, '103');
  });

  testWidgets('code 5 asks first, then pays with ignoreWarnings', (tester) async {
    final adapter = _adapter()
      ..reply('POST', '/tickets/pay', 400, {'code': 5, 'message': 'System oczekuje na potwierdzenie'});
    final app = await pumpApp(tester, adapter, session: signedInSession);
    const entry = CheckoutEntry.pay(_guid);
    final checkout = await _checkout(tester, app, entry);
    checkout.select('150');

    expect(await _pay(tester, checkout), isA<CheckoutConfirmRepeat>());

    adapter.reply('POST', '/tickets/pay', 200, apiFixture('pay_response'));
    expect(await _pay(tester, checkout, ignoreWarnings: true), isA<CheckoutOpen>());
    expect(_body(adapter, '/tickets/pay')['ignoreWarnings'], isTrue);
    expect(adapter.requestsTo('/tickets/buy'), isEmpty);
  });

  testWidgets('already paid reloads the tickets', (tester) async {
    final adapter = _adapter()..reply('POST', '/tickets/pay', 200, {'code': 'AlreadyPaid', 'message': 'Opłacony'});
    final app = await pumpApp(tester, adapter, session: signedInSession);
    const entry = CheckoutEntry.pay(_guid);
    final checkout = await _checkout(tester, app, entry);
    checkout.select('150');
    final listed = adapter.requestsTo('/mkkm/tickets/list').length;

    expect(await _pay(tester, checkout), isA<CheckoutAlreadyPaid>());
    expect(adapter.requestsTo('/mkkm/tickets/list').length, listed + 1);
  });

  testWidgets('a refused buy creates nothing and keeps the message', (tester) async {
    final adapter = _adapter()
      ..reply('POST', '/tickets/buy', 400, {'code': 2, 'message': 'Można posiadać tylko 2 aktywne bilety'});
    final app = await pumpApp(tester, adapter, session: signedInSession);
    final checkout = await _checkout(tester, app);
    checkout.select('150');

    expect(await _pay(tester, checkout), isA<CheckoutFailed>());
    final state = _state(app);
    expect(state.ticketGuid, isNull);
    expect(state.busy, isFalse);
    expect((state.failure! as EkpApiException).message, 'Można posiadać tylko 2 aktywne bilety');
  });

  testWidgets('failed methods load again on retry', (tester) async {
    final adapter = _adapter()..reply('GET', '/payments/banks', 500);
    final app = await pumpApp(tester, adapter, session: signedInSession);
    final checkout = await _checkout(tester, app);
    expect(_state(app).methods.hasError, isTrue);

    adapter.reply('GET', '/payments/banks', 200, apiFixture('banks'));
    checkout.retryMethods();
    expect(_state(app).methods.isLoading, isTrue);
    await tester.pump(const Duration(milliseconds: 10));
    expect(_state(app).methods.value, isNotNull);
  });
}
