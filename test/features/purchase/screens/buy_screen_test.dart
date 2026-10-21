import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _config = '/tickets/ticket-sales-configuration/100001';
const _calculate = '/tickets/calculate';

FakeAdapter _adapter({String config = 'sales_config_privileged'}) => FakeAdapter()
  ..reply('GET', _config, 200, apiFixture(config))
  ..reply('POST', _calculate, 200, apiFixture('tickets_calculate'))
  ..reply('GET', '/dictionary/transport-line', 200, {
    'lines': [
      {'line': 52, 'second_zone': false, 'is_tram': true, 'is_bus': false},
    ],
  });

Future<App> _open(WidgetTester tester, FakeAdapter adapter, {String route = Routes.buy}) async {
  final app = await pumpApp(tester, adapter, session: signedInSession);
  unawaited(app.router.push(route));
  await tester.pumpAndSettle();
  return app;
}

/// Lets the 300 ms price debounce run and the answer arrive.
Future<void> _priced(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 350));
  await tester.pumpAndSettle();
}

FilledButton _continue(WidgetTester tester) => tester.widget(find.widgetWithText(FilledButton, 'Continue'));

FilterChip _chip(WidgetTester tester, String label) => tester.widget(find.widgetWithText(FilterChip, label));

/// The privileged configuration plus a made-up "2 linie - Strefa I"
/// (code 2, sold where 1 line is), as the design's 25a/L1–L6 show it.
Map<String, dynamic> _twoLineConfig() {
  final config = apiFixture('sales_config_privileged');
  final options = (config['ticketNumberOfLines'] as List).cast<Map<String, dynamic>>();
  final prices = (config['priceListConfigurations'] as List).cast<Map<String, dynamic>>();
  return {
    ...config,
    'ticketNumberOfLines': [
      ...options,
      {
        ...options.firstWhere((option) => option['code'] == 1),
        'code': 2,
        'description': '2 linie - Strefa I',
        'urbanLineQty': 2,
        'sumLinesToSelection': 2,
      },
    ],
    'priceListConfigurations': [
      ...prices,
      for (final price in prices)
        if (price['ticketNumberOfLineCode'] == 1) {...price, 'ticketNumberOfLineCode': 2},
    ],
  };
}

/// Ticks [line] in the line search and closes it with Done.
Future<void> _pickLine(WidgetTester tester, String line) async {
  await tapVisible(tester, find.text('Add line'));
  await tester.enterText(find.byType(TextField), line);
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
  await tester.tap(find.text(line).last);
  await tester.pump();
  await tester.tap(find.text('Done'));
  await tester.pumpAndSettle();
}

final _form = find.byType(SingleChildScrollView);

ScrollPosition _list(WidgetTester tester) =>
    tester.state<ScrollableState>(find.descendant(of: _form, matching: find.byType(Scrollable)).last).position;

void main() {
  testWidgets('with the status: the discount, one line, a duration, priced', (tester) async {
    final adapter = _adapter();
    final app = await _open(tester, adapter);
    expect(find.text('Ticket type'), findsOneWidget);
    expect(find.text('Fare'), findsNothing);
    expect(find.text('Choose a ticket type'), findsOneWidget);
    expect(_continue(tester).onPressed, isNull);

    await tester.tap(find.text('Bilet ze zniżką Karty Krakowskiej'));
    await tester.pumpAndSettle();
    expect(find.text('Fare'), findsOneWidget);
    expect(find.text('Choose a fare'), findsOneWidget);

    await tester.tap(find.text('Normalny'));
    await tester.pumpAndSettle();
    expect(find.text('The Karta Krakowska discount is for Strefa I only.'), findsOneWidget);
    expect(find.text('Choose the lines'), findsOneWidget);

    await tapVisible(tester, find.widgetWithText(FilterChip, '1 line'));
    expect(find.text('Choose 1 line'), findsOneWidget);
    expect(find.text('Choose 1 more line'), findsOneWidget);

    await tapVisible(tester, find.text('Add line'));
    await tester.enterText(find.byType(TextField), '52');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.text('1 of 1 chosen'), findsOneWidget);
    expect(find.text('Add line'), findsNothing);
    expect(find.text('Choose how long'), findsOneWidget);
    // 6 months and Studencki Roczny are sold with all lines only.
    expect(_chip(tester, '6 months').onSelected, isNull);
    expect(_chip(tester, 'Studencki Roczny').onSelected, isNull);
    expect(_chip(tester, '3 months').onSelected, isNotNull);

    await tapVisible(tester, find.widgetWithText(FilterChip, '3 months'));
    await _priced(tester);
    expect(find.text('Starts'), findsOneWidget);
    final body = adapter.requestTo(_calculate).data as Map<String, dynamic>;
    expect(body['ticketNumberOfLineCode'], 1);
    expect(body['ticketPeriodCode'], 3);
    expect(body['lines'], [
      {'line': 52, 'second_zone': false, 'is_tram': true, 'is_bus': false, 'has_second_zone': null},
    ]);
    expect(find.text('99,00 zł'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.buyPay);
    expect(app.router.state.extra, isA<CheckoutEntry>());
  });

  testWidgets('without the status: no Type section, the zone notes', (tester) async {
    await _open(tester, _adapter(config: 'sales_config'));
    expect(find.text('Ticket type'), findsNothing);
    expect(find.text('Fare'), findsOneWidget);

    await tester.tap(find.text('Normalny'));
    await tester.pumpAndSettle();
    expect(find.text('Choose every zone you need'), findsOneWidget);
    await tester.tap(find.text('Strefa I'));
    await tester.tap(find.text('Strefa III'));
    await tester.pumpAndSettle();
    expect(find.text('Strefa I and III aren’t sold together. Add Strefa II to travel in both.'), findsOneWidget);
    expect(find.text('Choose where you travel'), findsOneWidget);

    await tester.tap(find.text('Strefa III'));
    await tester.tap(find.text('Strefa I'));
    await tester.tap(find.text('Aktywizujący'));
    await tester.tap(find.text('Strefa II'));
    await tester.pumpAndSettle();
    expect(find.text('Aktywizujący is sold for Strefa I, I+II and I+II+III.'), findsOneWidget);
  });

  testWidgets('the price is asked once after quick changes; a refusal shows above the bar', (tester) async {
    final adapter = _adapter(config: 'sales_config')
      ..reply('POST', _calculate, 400, {'message': 'Można posiadać tylko 2 aktywne bilety w tym samym czasie.'});
    await _open(tester, adapter);
    await tester.tap(find.text('Normalny'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Strefa I'));
    await tester.pumpAndSettle();
    // Taps within the debounce: a settle would let it run out in between.
    await tester.ensureVisible(find.widgetWithText(FilterChip, '3 months'));
    await tester.pumpAndSettle();
    for (final label in ['1 month', '2 months', '3 months']) {
      await tester.tap(find.widgetWithText(FilterChip, label));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await _priced(tester);

    expect(adapter.requestsTo(_calculate), hasLength(1));
    expect(find.text('Można posiadać tylko 2 aktywne bilety w tym samym czasie.'), findsOneWidget);
    expect(_continue(tester).onPressed, isNull);
  });

  testWidgets('field errors have their own text', (tester) async {
    final adapter = _adapter(config: 'sales_config')
      ..reply('POST', _calculate, 400, {
        'message': 'x',
        'fields': {'ticketKindCode': 'x'},
      });
    await _open(tester, adapter);
    await tester.tap(find.text('Normalny'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Strefa I'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.widgetWithText(FilterChip, '1 month'));
    await _priced(tester);
    expect(find.text('Please choose the fare and type correctly.'), findsOneWidget);
  });

  testWidgets('the sales announcement is on top while it is due', (tester) async {
    final adapter = _adapter()
      ..reply('GET', '/client/mobile-app/config', 200, {
        ...appConfigJson,
        'salesViewAnnouncement': {
          'text': 'Od 1 listopada nowe ceny biletów.',
          'startDate': '2020-01-01T00:00:00Z',
          'endDate': '2100-01-01T00:00:00Z',
        },
      });
    await _open(tester, adapter);
    expect(find.text('Od 1 listopada nowe ceny biletów.'), findsOneWidget);
  });

  testWidgets('offline: nothing can be bought', (tester) async {
    final adapter = FakeAdapter()..fail('GET', _config);
    await _open(tester, adapter);
    expect(find.text('Buying a ticket needs a connection.'), findsOneWidget);
    expect(find.text('Continue'), findsNothing);
  });

  testWidgets('a failed load says so and can be retried', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _config, 500);
    await _open(tester, adapter);
    expect(find.text('The ticket options could not be loaded.'), findsOneWidget);
    expect(find.text('Continue'), findsNothing);

    adapter.reply('GET', _config, 200, apiFixture('sales_config'));
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Fare'), findsOneWidget);
    expect(adapter.requestsTo(_config), hasLength(2));
  });

  testWidgets('extend: filled in from the ticket, starting the day after it ends', (tester) async {
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
    await _open(tester, adapter, route: Routes.buyExtend(transactionCode));

    expect(find.text('Extend ticket'), findsOneWidget);
    expect(find.text('Filled in from your ticket. The new one starts the day after it ends.'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Starts'), 200);
    expect(find.textContaining('the day after your ticket ends'), findsOneWidget);
    await _priced(tester);
    expect(adapter.requestsTo(_calculate), hasLength(1));
    final dayAfter = DateTime(end.year, end.month, end.day + 1);
    expect(
      (adapter.requestTo(_calculate).data as Map<String, dynamic>)['validFrom'],
      dayAfter.toUtc().toIso8601String(),
    );
  });

  testWidgets('Extend in the details opens the filled-in form', (tester) async {
    final ticket = {...validTicket(), 'specialTransportLine': '1001', 'ticketKindCode': 21, 'ticketPeriodCode': 1};
    final adapter = _adapter()
      ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([ticket]))
      ..reply('GET', '/tickets/$transactionCode', 200, ticketDetailJson(ticket, canBuyTheSame: true));
    final app = await _open(tester, adapter, route: Routes.ticket(transactionCode));

    await tapVisible(tester, find.text('Extend ticket'));
    await tester.pumpAndSettle();
    expect(app.router.state.uri.toString(), Routes.buyExtend(transactionCode));
  });

  testWidgets('two lines: chosen one by one; Duration once both are there (25a/L2, L5, L6)', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', _config, 200, _twoLineConfig())
      ..reply('POST', _calculate, 200, apiFixture('tickets_calculate'))
      ..reply('GET', '/dictionary/transport-line', 200, {
        'lines': [
          {'line': 5, 'second_zone': false, 'is_tram': true, 'is_bus': false},
          {'line': 52, 'second_zone': false, 'is_tram': true, 'is_bus': false},
        ],
      });
    await _open(tester, adapter);
    await tester.tap(find.text('Bilet ze zniżką Karty Krakowskiej'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Normalny'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilterChip, '1 line'), findsOneWidget);

    await tapVisible(tester, find.widgetWithText(FilterChip, '2 lines'));
    expect(find.text('Choose 2 lines'), findsOneWidget);
    expect(find.text('Choose 2 more lines'), findsOneWidget);

    await _pickLine(tester, '5');
    expect(find.text('1 of 2 chosen'), findsOneWidget);
    expect(find.text('Choose 1 more line'), findsOneWidget);
    expect(find.text('Add line'), findsOneWidget);
    expect(find.text('Duration'), findsNothing);

    await _pickLine(tester, '52');
    expect(find.text('2 of 2 chosen'), findsOneWidget);
    expect(find.text('Add line'), findsNothing);
    expect(find.text('Choose how long'), findsOneWidget);

    // Down to one line: the first one stays.
    await tapVisible(tester, find.widgetWithText(FilterChip, '1 line'));
    expect(find.text('1 of 1 chosen'), findsOneWidget);
    expect(find.byTooltip('Remove line 5'), findsOneWidget);
    expect(find.byTooltip('Remove line 52'), findsNothing);
  });

  group('a new section scrolls into view', () {
    testWidgets('whole, down to its last row, when hidden', (tester) async {
      final app = await _open(tester, _adapter());
      tester.view.physicalSize = const Size(1080, 1260);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bilet ze zniżką Karty Krakowskiej'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Normalny'));
      await tester.pumpAndSettle();
      expect(app.location, Routes.buy);

      final before = _list(tester).pixels;
      await tapVisible(tester, find.widgetWithText(FilterChip, 'All lines'));
      expect(_list(tester).pixels, greaterThan(before));
      // The Duration section's last chip is above the bar, its heading still in view.
      final list = tester.getRect(_form.last);
      expect(tester.getRect(find.byType(FilterChip).last).bottom, lessThanOrEqualTo(list.bottom));
      expect(tester.getRect(find.text('Duration')).top, greaterThanOrEqualTo(list.top));

      // The start date's help text, the end of the form, clears the bar too.
      await tapVisible(tester, find.widgetWithText(FilterChip, '1 month'));
      await _priced(tester);
      final listNow = tester.getRect(_form.last);
      expect(tester.getRect(find.textContaining('Any day from')).bottom, lessThanOrEqualTo(listNow.bottom));
      expect(_list(tester).pixels, _list(tester).maxScrollExtent);
    });

    testWidgets('not at all when it is already in view', (tester) async {
      await _open(tester, _adapter());
      await tester.tap(find.text('Bilet ze zniżką Karty Krakowskiej'));
      await tester.pumpAndSettle();
      expect(_list(tester).pixels, 0);
    });

    testWidgets('stops as soon as the user takes hold of the list', (tester) async {
      await _open(tester, _adapter());
      tester.view.physicalSize = const Size(1080, 1260);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bilet ze zniżką Karty Krakowskiej'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Normalny'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.widgetWithText(FilterChip, 'All lines'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'All lines'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      final hold = await tester.startGesture(tester.getCenter(find.text('Lines')), kind: PointerDeviceKind.touch);
      final held = _list(tester).pixels;
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));
      expect(_list(tester).pixels, held);
      await hold.up();
      await tester.pumpAndSettle();
    });
  });
}
