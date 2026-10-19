import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/purchase/services/payments_dao.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _guid = networkGuid;
const _list = '/mkkm/tickets/list';
final _success = Uri.parse('https://ekp.mpk.krakow.pl/payment/success?id=$_guid&type=2');
final _rejected = Uri.parse('https://ekp.mpk.krakow.pl/payment/rejected?id=$_guid&type=2');

Map<String, dynamic> _pending() => {
  ...ticketJson(
    status: 'pending',
    start: DateTime.now().add(const Duration(days: 1)),
    end: DateTime.now().add(const Duration(days: 31)),
  ),
};

Map<String, dynamic> _active() => {..._pending(), 'status': 'active'};

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', _list, 200, ticketsReply([_pending()]))
  ..reply('GET', '/payments/banks', 200, apiFixture('banks'))
  ..reply('POST', '/tickets/pay', 200, apiFixture('pay_response'))
  ..reply('POST', '/payments/result', 200)
  ..reply('POST', '/payments/check', 400, {'code': 2, 'message': 'Brak zaksięgowanej płatności.'});

/// Signed in, on Pay for ticket with BLIK chosen, and tPay opened.
Future<App> _paying(WidgetTester tester, FakeAdapter adapter, {FakePaymentBrowser? browser}) async {
  final app = await pumpApp(
    tester,
    adapter,
    session: signedInSession,
    linkSettings: FakeLinkSettings(enabled: true),
    lastPaymentMethod: InMemoryLastPaymentMethodStore('150'),
    paymentBrowser: browser,
    tall: true,
  );
  unawaited(app.router.push(Routes.ticketPay(transactionCode)));
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, 'Pay 99,00 zł'));
  await tester.pumpAndSettle();
  expect(app.paymentBrowser.opened, hasLength(1));
  return app;
}

/// The app goes to the background for the browser and comes back.
Future<void> _leaveAndReturn(WidgetTester tester) async {
  for (final state in [
    AppLifecycleState.inactive,
    AppLifecycleState.hidden,
    AppLifecycleState.paused,
    AppLifecycleState.hidden,
    AppLifecycleState.inactive,
    AppLifecycleState.resumed,
  ]) {
    tester.binding.handleAppLifecycleStateChanged(state);
  }
  await tester.pump();
}

Future<List<String>> _marks(App app) async => [
  for (final row in await app.database.select(app.database.payments).get()) row.ticketGuid,
];

/// Drops the marks a test left, which stops the watcher's polling.
Future<void> _clearMarks(WidgetTester tester, App app) async {
  await PaymentsDao(app.database).clear();
  await tester.pumpAndSettle();
}

Map<String, dynamic> _resultBody(FakeAdapter adapter) =>
    adapter.requestsTo('/payments/result').last.data as Map<String, dynamic>;

void main() {
  testWidgets('Android success: reported, marked, processing until booked, then ready', (tester) async {
    final adapter = _adapter();
    final app = await _paying(tester, adapter);

    app.paymentBrowser.returnTo(_success);
    await tester.pumpAndSettle();

    expect(_resultBody(adapter), {'id': _guid, 'type': '2', 'result': 'Success'});
    expect(app.location, Routes.tickets);
    expect(find.text('Payment made.'), findsOneWidget);
    expect(await _marks(app), contains(_guid));
    expect(find.text('Processing payment'), findsOneWidget);
    expect(find.text('Continue payment'), findsNothing);

    // Polled every 10 s until the server lists it as paid.
    final before = adapter.requestsTo(_list).length;
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
    expect(adapter.requestsTo(_list).length, before + 1);
    expect(find.text('Processing payment'), findsOneWidget);

    adapter.reply('GET', _list, 200, ticketsReply([_active()]));
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
    expect(await _marks(app), isEmpty);
    expect(find.text('Your ticket is ready.'), findsOneWidget);
    expect(find.text('Processing payment'), findsNothing);
  });

  testWidgets('rejected: reported, back on Check and pay with the notice', (tester) async {
    final adapter = _adapter();
    final app = await _paying(tester, adapter);

    app.paymentBrowser.returnTo(_rejected);
    await tester.pumpAndSettle();

    expect(_resultBody(adapter)['result'], 'Error');
    expect(app.location, Routes.ticketPay(transactionCode));
    expect(find.text('The payment didn’t go through. Choose a method and try again.'), findsOneWidget);
    expect(await _marks(app), isEmpty);
  });

  testWidgets('closed without a link: three checks, Not yet, then Check again finds it', (tester) async {
    final adapter = _adapter();
    final app = await _paying(tester, adapter);

    await _leaveAndReturn(tester);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(app.location, Routes.payment);
    expect(find.text('Checking your payment…'), findsOneWidget);
    expect(adapter.requestsTo('/payments/check'), hasLength(1));

    await tester.pump(const Duration(seconds: 5));
    await tester.pump();
    expect(adapter.requestsTo('/payments/check'), hasLength(2));
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(adapter.requestsTo('/payments/check'), hasLength(3));
    expect(find.text('We can’t see your payment yet'), findsOneWidget);
    expect(find.text('Brak zaksięgowanej płatności.'), findsOneWidget);

    adapter
      ..reply('POST', '/payments/check', 200)
      ..reply('GET', _list, 200, ticketsReply([_active()]));
    await tester.tap(find.text('Check again'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.tickets);
    expect(find.textContaining('Payment confirmed'), findsOneWidget);
  });

  testWidgets('Not yet: Pay again goes back to Check and pay', (tester) async {
    final adapter = _adapter();
    final app = await _paying(tester, adapter);

    await _leaveAndReturn(tester);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 5));
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('We can’t see your payment yet'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Pay again'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.ticketPay(transactionCode));
  });

  testWidgets('a return link right after the app is back: no checks', (tester) async {
    final adapter = _adapter();
    final app = await _paying(tester, adapter);

    await _leaveAndReturn(tester);
    app.paymentBrowser.returnTo(_success);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(adapter.requestsTo('/payments/check'), isEmpty);
    expect(app.location, Routes.tickets);
    await _clearMarks(tester, app);
  });

  testWidgets('iOS: Done asks the server, and a paid answer ends on Tickets', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final adapter = _adapter()..reply('POST', '/payments/check', 200);
    final app = await _paying(tester, adapter);

    adapter.reply('GET', _list, 200, ticketsReply([_active()]));
    app.paymentBrowser.closeByUser();
    await tester.pumpAndSettle();

    expect(adapter.requestsTo('/payments/check'), hasLength(1));
    expect(app.location, Routes.tickets);
    expect(find.textContaining('Payment confirmed'), findsOneWidget);
    expect(find.text('Processing payment'), findsNothing);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('a cold start with a return link still reports and marks it', (tester) async {
    final adapter = _adapter();
    final app = await pumpApp(
      tester,
      adapter,
      session: signedInSession,
      paymentBrowser: FakePaymentBrowser(initial: _success),
    );
    await tester.pumpAndSettle();

    expect(_resultBody(adapter)['result'], 'Success');
    expect(await _marks(app), contains(_guid));
    expect(app.location, Routes.tickets);
    expect(find.text('Payment made.'), findsOneWidget);
    await _clearMarks(tester, app);
  });

  group('marks', () {
    testWidgets('one older than an hour is dropped', (tester) async {
      final adapter = _adapter();
      final app = await pumpApp(tester, adapter, session: signedInSession);
      await PaymentsDao(app.database).markMade(_guid, DateTime.now().subtract(const Duration(hours: 2)));
      await tester.pump(const Duration(seconds: 10));
      await tester.pumpAndSettle();
      expect(await _marks(app), isEmpty);
    });

    testWidgets('one whose ticket is gone after a sync is dropped', (tester) async {
      final adapter = _adapter()..reply('GET', _list, 200, ticketsReply([]));
      final app = await pumpApp(tester, adapter, session: signedInSession);
      await PaymentsDao(app.database).markMade(_guid, DateTime.now().subtract(const Duration(minutes: 1)));
      await tester.pump(const Duration(seconds: 10));
      await tester.pumpAndSettle();
      expect(await _marks(app), isEmpty);
    });
  });
}
