import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_providers.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _config = '/tickets/ticket-sales-configuration/100001';
const _calculate = '/tickets/calculate';
const _fresh = PurchaseEntry.fresh();

FakeAdapter _adapter({String config = 'sales_config_privileged'}) =>
    FakeAdapter()..reply('GET', _config, 200, apiFixture(config));

/// Waits for [future] while pumping, as the fake clock needs.
Future<T> _await<T>(WidgetTester tester, Future<T> future) async {
  late T value;
  var done = false;
  future
      .then(
        (v) {
          value = v;
          done = true;
        },
        onError: (Object _) {
          done = true;
        },
      )
      .ignore();
  for (var i = 0; i < 20 && !done; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
  return value;
}

/// Keeps [provider] alive for the rest of the test.
void _keep(App app, ProviderListenable<Object?> provider) =>
    addTearDown(app.container.listen(provider, (_, _) {}).close);

Future<PurchaseFormController> _form(WidgetTester tester, App app, [PurchaseEntry entry = _fresh]) async {
  _keep(app, purchaseFormProvider(entry));
  await _await(tester, app.container.read(purchaseFormProvider(entry).future));
  return app.container.read(purchaseFormProvider(entry).notifier);
}

PurchaseForm _formOf(App app, [PurchaseEntry entry = _fresh]) => app.container.read(purchaseFormProvider(entry)).value!;

/// Chooses the metropolitan Normalny ticket in all three zones.
void _chooseMetropolitan(PurchaseFormController form) {
  form
    ..setType('1003')
    ..setKind(2)
    ..toggleZone(0)
    ..toggleZone(1)
    ..toggleZone(2);
}

void main() {
  group('sales configuration', () {
    testWidgets('is asked for the customer and reused for five minutes', (tester) async {
      final adapter = _adapter();
      final app = await pumpApp(tester, adapter, session: signedInSession);

      final first = app.container.listen(salesConfigurationProvider, (_, _) {});
      final rules = await _await(tester, app.container.read(salesConfigurationProvider.future));
      expect(rules.showsTypes, isTrue);
      expect(adapter.requestsTo(_config), hasLength(1));

      first.close();
      await tester.pump(const Duration(minutes: 4));
      final second = app.container.listen(salesConfigurationProvider, (_, _) {});
      await _await(tester, app.container.read(salesConfigurationProvider.future));
      expect(adapter.requestsTo(_config), hasLength(1));

      second.close();
      await tester.pump(salesConfigurationLifetime);
      _keep(app, salesConfigurationProvider);
      await _await(tester, app.container.read(salesConfigurationProvider.future));
      expect(adapter.requestsTo(_config), hasLength(2));
    });

    testWidgets('an unanswered request marks the app offline', (tester) async {
      final adapter = FakeAdapter()..fail('GET', _config);
      final app = await pumpApp(tester, adapter, session: signedInSession);

      _keep(app, salesConfigurationProvider);
      await tester.pump(const Duration(milliseconds: 100));

      expect(app.container.read(salesConfigurationProvider).error, isA<EkpNetworkException>());
      expect(app.container.read(appStatusProvider).mode, AppMode.offline);
    });
  });

  group('form', () {
    testWidgets('starts empty, tomorrow within the configuration', (tester) async {
      final app = await pumpApp(tester, _adapter(), session: signedInSession);
      await _form(tester, app);

      final form = _formOf(app);
      expect(form.prefilled, isFalse);
      expect(form.selection.type, isNull);
      expect(form.selection.startDate, form.bounds.initial);
      expect(form.nextMissing, PurchaseSection.type);
    });

    testWidgets('without the status the only type is chosen', (tester) async {
      final app = await pumpApp(tester, _adapter(config: 'sales_config'), session: signedInSession);
      await _form(tester, app);

      expect(_formOf(app).selection.type, '1003');
      expect(_formOf(app).visibleSections, [PurchaseSection.fare]);
    });

    testWidgets('extend fills it in from the ticket, inhabitant fare included', (tester) async {
      final end = DateTime.now().add(const Duration(days: 10));
      final ticket = {
        ...ticketJson(start: end.subtract(const Duration(days: 30)), end: end, lineScope: 3),
        'specialTransportLine': '1001',
        'ticketKindCode': 21,
        'ticketPeriodCode': 1,
      };
      final adapter = _adapter()
        ..reply('GET', '/tickets/$transactionCode', 200, ticketDetailJson(ticket))
        ..reply('GET', '/dictionary/ticket-kind-list', 200, apiFixture('ticket_kind_list'));
      final app = await pumpApp(tester, adapter, session: signedInSession);
      const entry = PurchaseEntry.extend(transactionCode);
      await _form(tester, app, entry);

      final form = _formOf(app, entry);
      expect(form.prefilled, isTrue);
      expect(form.selection.kind, 2);
      expect(form.selection.type, '1001');
      expect(form.nextMissing, isNull);
      final dayAfter = DateTime(end.year, end.month, end.day + 1);
      expect(form.bounds.first, dayAfter);
      expect(form.selection.startDate, dayAfter);
    });

    testWidgets('a start outside the range is moved into it', (tester) async {
      final app = await pumpApp(tester, _adapter(), session: signedInSession);
      final form = await _form(tester, app);

      form.setStart(DateTime(2020));
      expect(_formOf(app).selection.startDate, _formOf(app).bounds.first);
    });
  });

  group('price', () {
    testWidgets('is asked for 300 ms after the last change, once', (tester) async {
      final adapter = _adapter()..reply('POST', _calculate, 200, apiFixture('tickets_calculate'));
      final app = await pumpApp(tester, adapter, session: signedInSession);
      final form = await _form(tester, app);
      _keep(app, priceProvider(_fresh));
      expect(app.container.read(priceProvider(_fresh)), isA<PriceIdle>());

      _chooseMetropolitan(form);
      form.setPeriod(1);
      await tester.pump(const Duration(milliseconds: 200));
      form.setPeriod(3);
      expect(app.container.read(priceProvider(_fresh)), isA<PriceCalculating>());
      await tester.pump(const Duration(milliseconds: 200));
      expect(adapter.requestsTo(_calculate), isEmpty);

      await tester.pump(const Duration(milliseconds: 150));
      await tester.pump();
      expect(adapter.requestsTo(_calculate), hasLength(1));
      final body = adapter.requestTo(_calculate).data as Map<String, dynamic>;
      expect(body['ticketNumberOfLineCode'], 63);
      expect(body['ticketPeriodCode'], 3);
      expect(body['specialTransportLine'], '1003');
      expect(body['customerCode'], '100001');

      final price = app.container.read(priceProvider(_fresh));
      expect(price, isA<PricePriced>());
      expect((price as PricePriced).calculation.price, 99);
    });

    testWidgets('an answer to an older choice is dropped', (tester) async {
      final adapter = _adapter()..reply('POST', _calculate, 200, apiFixture('tickets_calculate'));
      final release = adapter.hold('POST', _calculate);
      final app = await pumpApp(tester, adapter, session: signedInSession);
      final form = await _form(tester, app);
      _keep(app, priceProvider(_fresh));

      _chooseMetropolitan(form);
      form.setPeriod(1);
      await tester.pump(const Duration(milliseconds: 350));
      form.setPeriod(2);
      await tester.pump(const Duration(milliseconds: 350));
      expect(adapter.requestsTo(_calculate), hasLength(2));

      release();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 10));
      final price = app.container.read(priceProvider(_fresh));
      expect(price, isA<PricePriced>(), reason: '$price');
      price as PricePriced;
      expect(price.choice.ticketPeriodCode, 2);
    });

    testWidgets('a refusal on HTTP 200: field errors, else the message', (tester) async {
      final adapter = _adapter()
        ..reply('POST', _calculate, 200, {
          'code': 'PurchaseImpossible',
          'message': 'Zakup niemożliwy',
          'fields': {'ticketKindCode': 'x'},
        });
      final app = await pumpApp(tester, adapter, session: signedInSession);
      final form = await _form(tester, app);
      _keep(app, priceProvider(_fresh));

      _chooseMetropolitan(form);
      form.setPeriod(1);
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();
      final refused = app.container.read(priceProvider(_fresh)) as PriceRefused;
      expect(refused.fieldErrors, isTrue);
      expect(refused.message, 'Zakup niemożliwy');
    });

    testWidgets('an HTTP refusal keeps the server message', (tester) async {
      final adapter = _adapter()
        ..reply('POST', _calculate, 400, {'code': 2, 'message': 'Można posiadać tylko 2 aktywne bilety'});
      final app = await pumpApp(tester, adapter, session: signedInSession);
      final form = await _form(tester, app);
      _keep(app, priceProvider(_fresh));

      _chooseMetropolitan(form);
      form.setPeriod(1);
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();
      final refused = app.container.read(priceProvider(_fresh)) as PriceRefused;
      expect(refused.fieldErrors, isFalse);
      expect(refused.message, 'Można posiadać tylko 2 aktywne bilety');

      form.setPeriod(2);
      expect(app.container.read(priceProvider(_fresh)), isA<PriceCalculating>());
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();
    });
  });
}
