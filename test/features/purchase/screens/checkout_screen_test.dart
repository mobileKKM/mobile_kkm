import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
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
  ..reply('POST', '/tickets/buy', 200, apiFixture('buy_response'))
  ..reply('POST', '/tickets/pay', 200, apiFixture('pay_response'));

Future<App> _open(
  WidgetTester tester,
  FakeAdapter adapter, {
  CheckoutEntry? entry,
  List<Uri>? opened,
  FakeLinkSettings? links,
  String? lastMethod,
}) async {
  final app = await pumpApp(
    tester,
    adapter,
    session: signedInSession,
    openedUrls: opened,
    linkSettings: links ?? FakeLinkSettings(enabled: true),
    lastPaymentMethod: InMemoryLastPaymentMethodStore(lastMethod),
    tall: true,
  );
  unawaited(app.router.push(Routes.buyPay, extra: entry ?? _entry()));
  await tester.pumpAndSettle();
  return app;
}

Finder get _payButton => find.widgetWithText(FilledButton, 'Pay 99,00 zł');

Map<String, dynamic> _body(FakeAdapter adapter, String path) =>
    adapter.requestsTo(path).last.data as Map<String, dynamic>;

void main() {
  testWidgets('the summary, nothing chosen, then BLIK: buy and open tPay', (tester) async {
    final adapter = _adapter();
    final opened = <Uri>[];
    final app = await _open(tester, adapter, opened: opened);

    expect(find.text('Check and pay'), findsOneWidget);
    expect(find.text('All lines · Strefa I'), findsOneWidget);
    expect(find.text('Bilet norm. mieszk. 1-mies. sieciowy st. I'), findsOneWidget);
    expect(find.text('Every day'), findsOneWidget);
    expect(
      find.text('You pay on tPay’s secure page in your browser. mobileKKM opens again when you’re done.'),
      findsOneWidget,
    );
    expect(tester.widget<FilledButton>(_payButton).onPressed, isNull);

    await tester.tap(find.text('BLIK'));
    await tester.pump();
    await tapVisible(tester, _payButton);

    expect(_body(adapter, '/tickets/buy')['tPayPaymentGroupId'], '150');
    expect(opened.single.host, 'secure.tpay.com');

    // Bought: from now on Pay pays, and leaving goes to the tickets.
    await tapVisible(tester, _payButton);
    expect(adapter.requestsTo('/tickets/buy'), hasLength(1));
    expect(_body(adapter, '/tickets/pay'), {'id': _guid, 'ignoreWarnings': false, 'tPayPaymentGroupId': '150'});

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(app.location, Routes.tickets);
  });

  testWidgets('the method used last is chosen and says so', (tester) async {
    await _open(tester, _adapter(), lastMethod: '103');
    expect(find.text('Last used'), findsOneWidget);
    expect(tester.widget<FilledButton>(_payButton).onPressed, isNotNull);
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
    await tapVisible(tester, _payButton);
    expect(_body(adapter, '/tickets/buy')['tPayPaymentGroupId'], '160');
  });

  testWidgets('a refused buy shows the message and creates nothing', (tester) async {
    final adapter = _adapter()
      ..reply('POST', '/tickets/buy', 400, {'message': 'Można posiadać tylko 2 aktywne bilety w tym samym czasie.'});
    final app = await _open(tester, adapter, lastMethod: '150');

    await tapVisible(tester, _payButton);
    expect(find.text('Można posiadać tylko 2 aktywne bilety w tym samym czasie.'), findsOneWidget);
    // Nothing was bought: back goes where it came from, not to the tickets.
    await tester.pageBack();
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

      await tapVisible(tester, _payButton);
      expect(fake.requestsTo('/tickets/buy'), isEmpty);
      expect(_body(fake, '/tickets/pay')['ignoreWarnings'], isFalse);
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
      unawaited(app.router.push(Routes.ticketPay(transactionCode)));
      await tester.pumpAndSettle();

      await tapVisible(tester, _payButton);
      expect(find.text('Pay again?'), findsOneWidget);
      fake.reply('POST', '/tickets/pay', 200, apiFixture('pay_response'));
      await tester.tap(find.widgetWithText(FilledButton, 'Pay again'));
      await tester.pumpAndSettle();
      expect(_body(fake, '/tickets/pay')['ignoreWarnings'], isTrue);
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
      unawaited(app.router.push(Routes.ticketPay(transactionCode)));
      await tester.pumpAndSettle();

      await tapVisible(tester, _payButton);
      expect(app.location, Routes.tickets);
      expect(find.text('This ticket is already paid.'), findsOneWidget);
    });
  });
}
