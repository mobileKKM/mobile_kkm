import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
import 'package:mobile_kkm/features/purchase/screens/payment_screen.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _guid = 'feedfacefeedfacefeedfacefeedface';

final _choice = TicketChoice(
  validFrom: DateTime(2025, 10, 28),
  ticketNumberOfLineCode: 3,
  ticketKindCode: 2,
  ticketPeriodCode: 1,
  lines: const [],
  specialTransportLine: '1001',
);

CheckoutEntry _entry({bool similar = false}) => CheckoutEntry.buy(
  _choice,
  TicketCalculation.fromJson({...apiFixture('tickets_calculate'), 'hasSimilarTicket': similar}),
);

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', '/tickets/ticket-sales-configuration/100001', 200, apiFixture('sales_config_privileged'))
  ..reply('GET', '/payments/banks', 200, apiFixture('banks'))
  ..reply('GET', '/dictionary/ticket-kind-list', 200, {
    'kinds': [
      {'code': 21, 'description': 'Normalny'},
    ],
  })
  ..reply('GET', '/dictionary/ticket-period-list', 200, ticketPeriodsJson)
  ..reply('GET', '/dictionary/ticket-number-of-line-list', 200, lineScopesJson)
  ..reply('POST', '/tickets/buy', 200, apiFixture('buy_response'))
  ..reply('POST', '/tickets/pay', 200, apiFixture('pay_response'))
  ..reply('POST', '/payments/result', 200);

final _rejected = Uri.parse('https://ekp.mpk.krakow.pl/payment/rejected?id=$_guid&type=2');

Future<App> _open(
  WidgetTester tester,
  FakeAdapter adapter, {
  CheckoutEntry? entry,
  FakeLinkSettings? links,
  String? lastMethod,
}) async {
  final app = await pumpApp(
    tester,
    adapter,
    session: signedInSession,
    linkSettings: links ?? FakeLinkSettings(enabled: true),
    lastPaymentMethod: InMemoryLastPaymentMethodStore(lastMethod),
    tall: true,
  );
  unawaited(app.router.push(Routes.buyPay, extra: entry ?? _entry()));
  await tester.pumpAndSettle();
  return app;
}

/// What Continue payment hands over for the pending ticket.
TicketDetailResponse _details() =>
    TicketDetailResponse.fromJson(ticketDetailJson({...validTicket(), 'status': 'pending'}, paid: false));

Finder get _payButton => find.widgetWithText(FilledButton, 'Pay 99,00 zł');

/// Taps Pay; the Payment screen it opens has a spinner up.
Future<void> _tapPay(WidgetTester tester) async {
  await tester.ensureVisible(_payButton);
  await tester.pumpAndSettle();
  await tester.tap(_payButton);
  await pumpWithSpinner(tester);
}

Map<String, dynamic> _body(FakeAdapter adapter, String path) =>
    adapter.requestsTo(path).last.data as Map<String, dynamic>;

void main() {
  testWidgets('the summary, nothing chosen, then BLIK: buy, and Payment opens tPay', (tester) async {
    final adapter = _adapter();
    final app = await _open(tester, adapter);

    expect(find.text('Check and pay'), findsOneWidget);
    expect(app.paymentLogos.requested, contains('https://secure.tpay.com/_/g/150.png'));
    expect(find.text('Network ticket · Strefa I'), findsOneWidget);
    expect(find.text('Normalny · Jeden miesiąc'), findsOneWidget);
    expect(find.text('Bilet norm. mieszk. 1-mies. sieciowy st. I'), findsOneWidget);
    expect(find.text('Every day'), findsOneWidget);
    expect(
      find.text('You pay on tPay’s secure page in your browser. mobileKKM opens again when you’re done.'),
      findsOneWidget,
    );
    expect(tester.widget<FilledButton>(_payButton).onPressed, isNull);

    await tester.tap(find.text('BLIK'));
    await tester.pump();
    await _tapPay(tester);

    expect(_body(adapter, '/tickets/buy')['tPayPaymentGroupId'], '150');
    expect(app.location, Routes.payment);
    expect(find.text('Opening tPay…'), findsOneWidget);
    expect(find.text('When you finish paying, mobileKKM brings you back here by itself.'), findsOneWidget);
    expect(app.paymentBrowser.opened.single.host, 'secure.tpay.com');
    // Nothing to go back to while tPay opens.
    expect(find.descendant(of: find.byType(PaymentScreen), matching: find.byTooltip('Back')), findsNothing);
    await tester.binding.handlePopRoute();
    await pumpWithSpinner(tester);
    expect(app.location, Routes.payment);

    // Rejected: back on Check and pay, the same method chosen.
    app.paymentBrowser.returnTo(_rejected);
    await tester.pumpAndSettle();
    expect(find.text('The payment didn’t go through'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Try again'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.buyPay);

    // Bought: from now on Pay pays, and leaving goes to the tickets.
    await _tapPay(tester);
    expect(adapter.requestsTo('/tickets/buy'), hasLength(1));
    expect(_body(adapter, '/tickets/pay'), {'id': _guid, 'ignoreWarnings': false, 'tPayPaymentGroupId': '150'});
    expect(app.paymentBrowser.opened, hasLength(2));

    app.paymentBrowser.returnTo(_rejected);
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(PaymentScreen), matching: find.byTooltip('Back')));
    await tester.pumpAndSettle();
    expect(app.location, Routes.buyPay);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.tickets);
  });

  testWidgets('while the order goes out the screen is locked and Back is ignored', (tester) async {
    final adapter = _adapter();
    final release = adapter.hold('POST', '/tickets/buy');
    final app = await _open(tester, adapter, lastMethod: '150');

    await tester.ensureVisible(_payButton);
    await tester.pumpAndSettle();
    await tester.tap(_payButton);
    await tester.pump();
    expect(find.text('Opening payment…'), findsOneWidget);
    await tester.tap(find.text('Google Pay'), warnIfMissed: false);
    expect(tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.arrow_back)).onPressed, isNull);
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(app.location, Routes.buyPay);

    release();
    await pumpWithSpinner(tester);
    expect(_body(adapter, '/tickets/buy')['tPayPaymentGroupId'], '150');
    expect(app.location, Routes.payment);
  });

  testWidgets('links not allowed: Payment says to close the page', (tester) async {
    final app = await _open(tester, _adapter(), links: FakeLinkSettings(), lastMethod: '150');
    await _tapPay(tester);
    expect(app.location, Routes.payment);
    expect(find.text('When you finish paying, close the payment page to come back here.'), findsOneWidget);
  });

  testWidgets('the method used last is chosen and says so', (tester) async {
    await _open(tester, _adapter(), lastMethod: '103');
    expect(find.text('Last used'), findsOneWidget);
    expect(tester.widget<FilledButton>(_payButton).onPressed, isNotNull);
  });

  testWidgets('a bank used last is chosen in the bank row and says so', (tester) async {
    final adapter = _adapter();
    await _open(tester, adapter, lastMethod: '160');
    expect(find.text('mBank'), findsOneWidget);
    expect(find.text('Change'), findsOneWidget);
    expect(find.text('Last used'), findsOneWidget);
    // No tile is chosen.
    expect(find.byIcon(Symbols.check_circle_rounded), findsNothing);
    await _tapPay(tester);
    expect(_body(adapter, '/tickets/buy')['tPayPaymentGroupId'], '160');
  });

  testWidgets('a bank from the sheet', (tester) async {
    final adapter = _adapter();
    await _open(tester, adapter);
    expect(find.text('Choose your bank'), findsOneWidget);

    await tapVisible(tester, find.text('Bank transfer'));
    expect(find.text('Online transfer through tPay'), findsOneWidget);
    await tester.tap(find.text('mBank'));
    await tester.pumpAndSettle();

    expect(find.text('mBank'), findsOneWidget);
    expect(find.text('Change'), findsOneWidget);
    await _tapPay(tester);
    expect(_body(adapter, '/tickets/buy')['tPayPaymentGroupId'], '160');
  });

  testWidgets('a refused buy shows the message and creates nothing', (tester) async {
    final adapter = _adapter()
      ..reply('POST', '/tickets/buy', 400, {'message': 'Można posiadać tylko 2 aktywne bilety w tym samym czasie.'});
    final app = await _open(tester, adapter, lastMethod: '150');

    await tapVisible(tester, _payButton);
    expect(find.text('Można posiadać tylko 2 aktywne bilety w tym samym czasie.'), findsOneWidget);
    // Nothing was bought: back goes where it came from, not to the tickets.
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(app.location, Routes.home);
  });

  testWidgets('a similar ticket is a warning, not a block', (tester) async {
    await _open(tester, _adapter(), entry: _entry(similar: true), lastMethod: '150');
    expect(find.text('You already have a similar ticket that is valid for part of this period.'), findsOneWidget);
    expect(tester.widget<FilledButton>(_payButton).onPressed, isNotNull);
  });

  testWidgets('failed methods: a panel, Pay off, and a retry', (tester) async {
    final adapter = _adapter()..reply('GET', '/payments/banks', 500);
    await _open(tester, adapter);
    expect(find.text('Payment methods could not be loaded.'), findsOneWidget);
    expect(tester.widget<FilledButton>(_payButton).onPressed, isNull);

    adapter.reply('GET', '/payments/banks', 200, apiFixture('banks'));
    await tapVisible(tester, find.text('Try again'));
    expect(find.text('BLIK'), findsOneWidget);
  });

  testWidgets('the link hint when return links are not allowed', (tester) async {
    final links = FakeLinkSettings();
    await _open(tester, _adapter(), links: links);
    expect(
      find.text('To come back here by itself after paying, allow mobileKKM to open ekp.mpk.krakow.pl links.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Open link settings'));
    expect(links.openedSettings, 1);
  });

  testWidgets('no link hint when they are', (tester) async {
    await _open(tester, _adapter());
    expect(find.textContaining('allow mobileKKM to open'), findsNothing);
  });

  testWidgets('iOS: Apple Pay instead of Google Pay, and Safari', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    await _open(tester, _adapter());
    expect(find.text('Apple Pay'), findsOneWidget);
    expect(find.text('Google Pay'), findsNothing);
    expect(find.textContaining('in Safari'), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  group('pay for a ticket', () {
    FakeAdapter adapter() => _adapter()
      ..reply(
        'GET',
        '/mkkm/tickets/list',
        200,
        ticketsReply([
          {...validTicket(), 'status': 'pending', 'price': 99.0},
        ]),
      )
      ..reply(
        'GET',
        '/tickets/$transactionCode',
        200,
        ticketDetailJson({...validTicket(), 'status': 'pending'}, paid: false),
      );

    testWidgets('Continue payment opens it and pays, never buys', (tester) async {
      final fake = adapter();
      final app = await pumpApp(
        tester,
        fake,
        session: signedInSession,
        linkSettings: FakeLinkSettings(enabled: true),
        lastPaymentMethod: InMemoryLastPaymentMethodStore('150'),
      );
      await openTab(tester, 'Tickets');
      await tapVisible(tester, find.text('Continue payment'));
      expect(app.location, Routes.ticketPay(transactionCode));
      expect(find.text('Pay for ticket'), findsOneWidget);

      await _tapPay(tester);
      expect(fake.requestsTo('/tickets/buy'), isEmpty);
      expect(_body(fake, '/tickets/pay')['ignoreWarnings'], isFalse);
    });

    testWidgets('Continue payment waits for the details, busy, and opens complete', (tester) async {
      final fake = adapter();
      final release = fake.hold('GET', '/tickets/$transactionCode');
      final app = await pumpApp(
        tester,
        fake,
        session: signedInSession,
        linkSettings: FakeLinkSettings(enabled: true),
        lastPaymentMethod: InMemoryLastPaymentMethodStore('150'),
      );
      await openTab(tester, 'Tickets');
      await tester.ensureVisible(find.text('Continue payment'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue payment'));
      await tester.pump();
      expect(app.location, Routes.tickets);
      final pay = find.ancestor(of: find.text('Continue payment'), matching: find.byType(FilledButton));
      expect(find.descendant(of: pay, matching: find.byType(CircularProgressIndicator)), findsOneWidget);
      final check = find.ancestor(of: find.text('Check payment'), matching: find.byType(OutlinedButton));
      expect(tester.widget<OutlinedButton>(check).onPressed, isNull);

      release();
      await tester.pumpAndSettle();
      expect(app.location, Routes.ticketPay(transactionCode));
      expect(find.text('Product'), findsOneWidget);
    });

    testWidgets('Continue payment stays put when the details fail, and says why', (tester) async {
      final fake = adapter()..reply('GET', '/tickets/$transactionCode', 400, {'message': 'Nie znaleziono biletu'});
      final app = await pumpApp(
        tester,
        fake,
        session: signedInSession,
        linkSettings: FakeLinkSettings(enabled: true),
        lastPaymentMethod: InMemoryLastPaymentMethodStore('150'),
      );
      await openTab(tester, 'Tickets');
      await tapVisible(tester, find.text('Continue payment'));
      expect(app.location, Routes.tickets);
      expect(find.text('Nie znaleziono biletu'), findsOneWidget);
      final pay = find.ancestor(of: find.text('Continue payment'), matching: find.byType(FilledButton));
      expect(find.descendant(of: pay, matching: find.byType(CircularProgressIndicator)), findsNothing);
    });

    testWidgets('without the details it is the ticket details screen', (tester) async {
      final app = await pumpApp(tester, adapter(), session: signedInSession);
      unawaited(app.router.push(Routes.ticketPay(transactionCode)));
      await tester.pumpAndSettle();
      expect(app.location, Routes.ticket(transactionCode));
      expect(find.text('Pay for ticket'), findsNothing);
    });

    testWidgets('code 5 asks, then pays with ignoreWarnings', (tester) async {
      final fake = adapter()
        ..reply('POST', '/tickets/pay', 400, {'code': 5, 'message': 'System oczekuje na potwierdzenie'});
      final app = await pumpApp(
        tester,
        fake,
        session: signedInSession,
        linkSettings: FakeLinkSettings(enabled: true),
        lastPaymentMethod: InMemoryLastPaymentMethodStore('150'),
      );
      unawaited(app.router.push(Routes.ticketPay(transactionCode), extra: _details()));
      await tester.pumpAndSettle();

      await tapVisible(tester, _payButton);
      expect(find.text('Pay again?'), findsOneWidget);
      fake.reply('POST', '/tickets/pay', 200, apiFixture('pay_response'));
      await tester.tap(find.widgetWithText(FilledButton, 'Pay again'));
      await pumpWithSpinner(tester);
      expect(_body(fake, '/tickets/pay')['ignoreWarnings'], isTrue);
      expect(app.location, Routes.payment);
    });

    testWidgets('already paid: Tickets says so', (tester) async {
      final fake = adapter()..reply('POST', '/tickets/pay', 200, {'code': 'AlreadyPaid', 'message': 'Opłacony'});
      final app = await pumpApp(
        tester,
        fake,
        session: signedInSession,
        linkSettings: FakeLinkSettings(enabled: true),
        lastPaymentMethod: InMemoryLastPaymentMethodStore('150'),
      );
      unawaited(app.router.push(Routes.ticketPay(transactionCode), extra: _details()));
      await tester.pumpAndSettle();

      await tapVisible(tester, _payButton);
      expect(app.location, Routes.tickets);
      expect(find.text('This ticket is already paid.'), findsOneWidget);
    });
  });
}
