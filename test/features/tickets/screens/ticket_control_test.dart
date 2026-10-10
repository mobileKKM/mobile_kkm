import 'dart:convert';
import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _contract = '/mkkm/tickets/contract-e';

/// The synthetic contract of `ekp_api`'s tests and the token planted in it.
final _contractJson = jsonDecode(
  File('packages/ekp_api/test/fixtures/contract_e_response.json').readAsStringSync(),
) as Map<String, dynamic>;
final _token = '07E5C3A18F6D4B29' * 32;

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([validTicket(assigned: true)]))
  ..reply('GET', '/account/user-data', 200, userDataJson());

Future<App> _open(WidgetTester tester, FakeAdapter adapter) async {
  final app = await pumpApp(tester, adapter, session: signedInSession);
  await openTab(tester, 'Tickets');
  await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
  await tester.pumpAndSettle();
  return app;
}

void main() {
  testWidgets('shows whose ticket it is, what kind, and its code', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    expect(app.location, Routes.ticketControl(networkGuid));
    expect(adapter.requestTo(_contract).data, contains('message'));
    expect(tester.widget<BarcodeWidget>(find.byType(BarcodeWidget)).data, utf8.encode(_token));
    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(find.text('100001'), findsOneWidget);
    expect(find.text('Network ticket'), findsOneWidget);
    expect(find.textContaining('Valid until '), findsOneWidget);
    expect(find.text('1:59'), findsOneWidget);

    await tester.pump(const Duration(seconds: 60));
    expect(find.text('0:59'), findsOneWidget);
    expect(adapter.requestsTo(_contract), hasLength(1));
  });

  testWidgets('the fare, the period and the zone come from the dictionaries', (tester) async {
    final ticket = {
      ...validTicket(assigned: true),
      ...productCodes,
      'ticketNumberOfLineCode': 3,
      // Not what is shown: the list would not have it.
      'productName': 'Bilet norm. 1-mies. sieciowy',
    };
    final adapter = _adapter()
      ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([ticket]))
      ..reply('GET', '/dictionary/ticket-kind-list', 200, ticketKindsJson)
      ..reply('GET', '/dictionary/ticket-period-list', 200, ticketPeriodsJson)
      ..reply('GET', '/dictionary/ticket-number-of-line-list', 200, lineScopesJson)
      ..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);

    expect(find.text('Network ticket'), findsOneWidget);
    expect(find.text('Zones'), findsOneWidget);
    expect(find.text('Strefa I'), findsOneWidget);
    expect(find.text('Fare'), findsOneWidget);
    expect(find.text('Normalny'), findsOneWidget);
    expect(find.text('Period'), findsOneWidget);
    expect(find.text('Jeden miesiąc'), findsOneWidget);
    expect(find.textContaining('Bilet norm.'), findsNothing);
  });

  testWidgets('without the dictionaries the ticket is named by what is stored alone', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);

    expect(find.text('Network ticket'), findsOneWidget);
    expect(find.text('Fare'), findsNothing);
    expect(find.textContaining('Valid until '), findsOneWidget);
  });

  testWidgets('a long name is shown in full', (tester) async {
    final user = userDataJson();
    (user['userData'] as Map<String, dynamic>)
      ..['firstName'] = 'Aleksandra Katarzyna'
      ..['lastName'] = 'Szczepańska-Wojciechowska';
    final adapter = _adapter()
      ..reply('GET', '/account/user-data', 200, user)
      ..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);

    final name = tester.widget<Text>(find.text('Aleksandra Katarzyna Szczepańska-Wojciechowska'));
    expect(name.overflow, isNull);
    // In smaller letters than a short one.
    expect(name.style?.fontSize, 20);
  });

  testWidgets('stays open: the next code is fetched ahead and takes over', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    await tester.pump(const Duration(seconds: 108));
    expect(adapter.requestsTo(_contract), hasLength(1));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(adapter.requestsTo(_contract), hasLength(2));
    // The old code is good until its time is up.
    expect(find.text('0:09'), findsOneWidget);
    expect(find.byType(BarcodeWidget), findsOneWidget);

    await tester.pump(const Duration(seconds: 9));
    await tester.pump();

    expect(app.location, Routes.ticketControl(networkGuid));
    expect(find.byType(BarcodeWidget), findsOneWidget);
    expect(find.text('1:59'), findsOneWidget);
    expect(adapter.requestsTo(_contract), hasLength(2));
  });

  testWidgets('the last seconds are marked by more than the colour', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);
    Icon timer() => tester.widget<Icon>(find.byIcon(Symbols.timer_rounded));
    expect(timer().fill, 0);

    await tester.pump(const Duration(seconds: 105));
    await tester.pump(const Duration(milliseconds: 500));
    expect(timer().fill, 1);
  });

  testWidgets('a slow next code is waited for, without the old one', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);
    final release = adapter.hold('POST', _contract);

    await tester.pump(const Duration(seconds: 119));
    await tester.pump();
    expect(find.byType(BarcodeWidget), findsNothing);
    expect(find.text('Getting your code…'), findsOneWidget);

    release();
    await tester.pumpAndSettle();
    expect(find.byType(BarcodeWidget), findsOneWidget);
    expect(find.text('Getting your code…'), findsNothing);
    expect(find.byIcon(Symbols.timer_rounded), findsOneWidget);
  });

  testWidgets('without a next code the old one is dropped when its time is up', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);
    adapter.reply('POST', _contract, 200, {'code': 4, 'message': 'Bilet nie jest powiązany.'});

    await tester.pump(const Duration(seconds: 115));
    await tester.pump();
    // Refused already, but there is still a code to scan.
    expect(adapter.requestsTo(_contract), hasLength(2));
    expect(find.byType(BarcodeWidget), findsOneWidget);
    expect(find.text('Bilet nie jest powiązany.'), findsNothing);

    await tester.pump(const Duration(seconds: 4));
    await tester.pump();
    expect(find.byType(BarcodeWidget), findsNothing);
    expect(find.text('Bilet nie jest powiązany.'), findsOneWidget);
    expect(app.location, Routes.ticketControl(networkGuid));
    // It does not keep asking by itself.
    await tester.pump(const Duration(seconds: 30));
    expect(adapter.requestsTo(_contract), hasLength(2));

    adapter.reply('POST', _contract, 200, _contractJson);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.byType(BarcodeWidget), findsOneWidget);
  });

  testWidgets('the screen is kept out of screenshots while it is open', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await pumpApp(tester, adapter, session: signedInSession);
    await openTab(tester, 'Tickets');
    expect(app.screen.changes, isEmpty);

    await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
    await tester.pumpAndSettle();
    expect(app.screen.secure, isTrue);

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(app.screen.changes, [true, false]);
  });

  testWidgets('the code is hidden while the screen is being recorded', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    app.screen.capture(true);
    await tester.pump();
    await tester.pump();
    expect(find.byType(BarcodeWidget), findsNothing);
    expect(find.text('The code is hidden while the screen is being recorded.'), findsOneWidget);

    app.screen.capture(false);
    await tester.pump();
    await tester.pump();
    expect(find.byType(BarcodeWidget), findsOneWidget);
  });

  testWidgets('the server says why there is no code', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, {'code': 4, 'message': 'Bilet nie jest powiązany.'});
    await _open(tester, adapter);

    expect(find.text('Bilet nie jest powiązany.'), findsOneWidget);
    expect(find.byType(BarcodeWidget), findsNothing);
  });

  testWidgets('a code that cannot be read can be asked for again', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, {'contract': 'AAAA'});
    await _open(tester, adapter);
    expect(find.text('The code could not be loaded. Check your connection and try again.'), findsOneWidget);

    adapter.reply('POST', _contract, 200, _contractJson);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.byType(BarcodeWidget), findsOneWidget);
    // Leave before the test ends: the countdown is still running.
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
  });
}
