import 'dart:convert';
import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_area.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_ring.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_state.dart';

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
  await pumpWithCode(tester);
  return app;
}

/// What the code area is showing.
CodeState _state(WidgetTester tester) => tester.widget<CodeArea>(find.byType(CodeArea)).state;

/// The time the code on the screen has left, as `m:ss`.
String _time(WidgetTester tester) => (_state(tester) as CodeRunning).time;

void main() {
  testWidgets('shows whose ticket it is, what kind, and its code', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    expect(app.location, Routes.ticketControl(networkGuid));
    expect(adapter.requestTo(_contract).data, contains('message'));
    expect(tester.widget<BarcodeWidget>(find.byType(BarcodeWidget)).data, utf8.encode(_token));
    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(find.text('100001'), findsOneWidget);
    expect(find.text('Ticket'), findsOneWidget);
    expect(find.text('Network ticket'), findsOneWidget);
    expect(find.text('Valid until'), findsOneWidget);
    expect(find.text('Tap the code to enlarge it'), findsOneWidget);
    expect(_time(tester), '1:30');

    await tester.pump(const Duration(seconds: 60));
    expect(_time(tester), '0:30');
    expect(adapter.requestsTo(_contract), hasLength(1));
  });

  testWidgets('a screen reader gets the code as one button that says how long it is good for', (tester) async {
    final semantics = tester.ensureSemantics();
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);

    expect(find.bySemanticsLabel('Ticket code, valid for 1:30. Double tap to enlarge.'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('the fare and the zone come from the dictionaries', (tester) async {
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

    expect(find.text('Network ticket · Strefa I'), findsOneWidget);
    expect(find.text('Fare'), findsOneWidget);
    expect(find.text('Normalny'), findsOneWidget);
    // Not the period: the date the ticket runs until says more.
    expect(find.text('Jeden miesiąc'), findsNothing);
    expect(find.textContaining('Bilet norm.'), findsNothing);
  });

  testWidgets('without the dictionaries the ticket is named by what is stored alone', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);

    expect(find.text('Network ticket'), findsOneWidget);
    expect(find.text('Fare'), findsNothing);
    expect(find.text('Valid until'), findsOneWidget);
  });

  testWidgets('on a small phone the photo keeps its size and the code gives way', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);
    final large = tester.getSize(find.byType(BarcodeWidget));
    expect(tester.getSize(find.byKey(const Key('code-photo'))), const Size(128, 128));

    tester.view.physicalSize = const Size(1080, 1920);
    await tester.pump();

    expect(tester.getSize(find.byKey(const Key('code-photo'))), const Size(128, 128));
    expect(tester.getSize(find.byType(BarcodeWidget)).width, lessThan(large.width));
    // The smallest it gets; from there on the screen scrolls.
    expect(tester.getSize(find.byType(CodeRing)).width, greaterThanOrEqualTo(CodeArea.minSide));
    expect(tester.takeException(), isNull);
  });

  testWidgets('a tap enlarges the code, and any tap closes it again', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);
    final small = tester.getSize(find.byType(BarcodeWidget));

    await tester.tap(find.byType(BarcodeWidget));
    await pumpWithCode(tester);
    expect(find.text('Tap anywhere to close'), findsOneWidget);
    expect(find.text('Customer number 100001'), findsOneWidget);
    expect(tester.getSize(find.byType(BarcodeWidget).last).width, greaterThan(small.width));
    // Still protected, still bright: the screen under it is open.
    expect(app.screen.secure, isTrue);
    expect(app.scanDisplay.active, isTrue);

    // The same code with the same timer.
    await tester.pump(const Duration(seconds: 30));
    final under = tester.widget<CodeArea>(find.byType(CodeArea, skipOffstage: false)).state as CodeRunning;
    expect(under.left, lessThan(0.76));
    expect(tester.widget<CodeRing>(find.byType(CodeRing)).left, under.left);

    await tester.tap(find.text('Jan Testowy').last);
    await pumpWithCode(tester);
    expect(find.text('Tap anywhere to close'), findsNothing);
    expect(app.location, Routes.ticketControl(networkGuid));
    expect(adapter.requestsTo(_contract), hasLength(1));
  });

  testWidgets('the enlarged code closes when there is no code left to show', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);
    adapter.reply('POST', _contract, 200, {'code': 4, 'message': 'Bilet nie jest powiązany.'});
    await tester.tap(find.byType(BarcodeWidget));
    await pumpWithCode(tester);
    expect(find.text('Tap anywhere to close'), findsOneWidget);

    await tester.pump(const Duration(seconds: 90));
    await pumpWithCode(tester);

    expect(find.text('Tap anywhere to close'), findsNothing);
    expect(find.text('Bilet nie jest powiązany.'), findsOneWidget);
    expect(app.location, Routes.ticketControl(networkGuid));
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

  testWidgets('stays open: the next code is fetched ahead and takes over with its whole time', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    await tester.pump(const Duration(seconds: 79));
    expect(adapter.requestsTo(_contract), hasLength(1));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(adapter.requestsTo(_contract), hasLength(2));
    // The old code stays until its time is up.
    expect(_time(tester), '0:09');
    expect(find.byType(BarcodeWidget), findsOneWidget);

    await tester.pump(const Duration(seconds: 9));
    await tester.pump();

    expect(app.location, Routes.ticketControl(networkGuid));
    expect(find.byType(BarcodeWidget), findsOneWidget);
    // Counted from when it is shown, not from when it was fetched.
    expect(_time(tester), '1:30');
    // The ring is full again at once, not on its way there.
    expect(tester.widget<CodeRing>(find.byType(CodeRing)).left, 1);
    expect(adapter.requestsTo(_contract), hasLength(2));
  });

  testWidgets('the ring is the timer, and a warning in the last seconds', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);
    final scheme = Theme.of(tester.element(find.byType(CodeArea))).colorScheme;
    CodeRing ring() => tester.widget<CodeRing>(find.byType(CodeRing));
    expect(ring().left, 1);
    expect(ring().color, scheme.primary);

    await tester.pump(const Duration(seconds: 74));
    expect(ring().left, closeTo(16 / 90, 0.001));
    expect(ring().color, scheme.primary);

    await tester.pump(const Duration(seconds: 1));
    expect(ring().color, scheme.error);

    // In its last second the ring is on its way to empty, so that it gets
    // there when the time does and not a second late.
    await tester.pump(const Duration(seconds: 14));
    expect(ring().left, closeTo(1 / 90, 0.001));
    expect(ring().leftNext, 0);
  });

  testWidgets('a slow next code is waited for, without the old one', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    await _open(tester, adapter);
    final release = adapter.hold('POST', _contract);

    await tester.pump(const Duration(seconds: 90));
    await tester.pump();
    expect(find.byType(BarcodeWidget), findsNothing);
    expect(find.text('Getting your code…'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    release();
    await pumpWithCode(tester);
    expect(find.byType(BarcodeWidget), findsOneWidget);
    expect(find.text('Getting your code…'), findsNothing);
    expect(find.text('Tap the code to enlarge it'), findsOneWidget);
  });

  testWidgets('without a next code the old one is dropped when its time is up', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);
    adapter.reply('POST', _contract, 200, {'code': 4, 'message': 'Bilet nie jest powiązany.'});

    await tester.pump(const Duration(seconds: 86));
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
    await pumpWithCode(tester);
    expect(find.byType(BarcodeWidget), findsOneWidget);
  });

  testWidgets('the screen is kept out of screenshots while it is open', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await pumpApp(tester, adapter, session: signedInSession);
    await openTab(tester, 'Tickets');
    expect(app.screen.changes, isEmpty);

    await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
    await pumpWithCode(tester);
    expect(app.screen.secure, isTrue);

    await tester.tap(find.byTooltip('Close'));
    await pumpWithCode(tester);
    expect(app.screen.changes, [true, false]);
  });

  testWidgets('the display is bright and stays awake while the screen is open', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await pumpApp(tester, adapter, session: signedInSession);
    await openTab(tester, 'Tickets');
    expect(app.scanDisplay.changes, isEmpty);

    await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
    await pumpWithCode(tester);
    expect(app.scanDisplay.active, isTrue);

    await tester.tap(find.byTooltip('Close'));
    await pumpWithCode(tester);
    expect(app.scanDisplay.changes, [true, false]);
  });

  testWidgets('the code is hidden while the screen is being recorded', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    app.screen.capture(true);
    await tester.pump();
    await tester.pump();
    expect(find.byType(BarcodeWidget), findsNothing);
    expect(find.text('The code is hidden while the screen is recorded or shared.'), findsOneWidget);
    // Nothing to enlarge, but the time goes on.
    expect(find.text('Tap the code to enlarge it'), findsNothing);
    expect(_state(tester), isA<CodeHidden>());

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
    // Neither ring nor hint: there is nothing to count down.
    expect(find.byType(CodeRing), findsNothing);
    expect(find.text('Tap the code to enlarge it'), findsNothing);
  });

  testWidgets('without an answer it is the app that says so', (tester) async {
    final adapter = _adapter()..fail('POST', _contract);
    await _open(tester, adapter);

    expect(find.text('The code could not be loaded. Check your connection and try again.'), findsOneWidget);
  });

  testWidgets('a code that cannot be read can be asked for again', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, {'contract': 'AAAA'});
    await _open(tester, adapter);
    expect(find.text('The code could not be loaded. Check your connection and try again.'), findsOneWidget);

    adapter.reply('POST', _contract, 200, _contractJson);
    await tester.tap(find.text('Try again'));
    await pumpWithCode(tester);

    expect(find.byType(BarcodeWidget), findsOneWidget);
    // Leave before the test ends: the countdown is still running.
    await tester.tap(find.byTooltip('Close'));
    await pumpWithCode(tester);
  });
}
