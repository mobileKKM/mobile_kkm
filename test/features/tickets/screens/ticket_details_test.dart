import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/features/tickets/screens/ticket_details_screen.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _detail = '/tickets/$transactionCode';

FakeAdapter _adapter(Map<String, dynamic> ticket, {bool canReturn = false, bool canBuyTheSame = false}) => FakeAdapter()
  ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([ticket]))
  ..reply('GET', '/account/user-data', 200, userDataJson())
  ..reply('GET', _detail, 200, ticketDetailJson(ticket, canReturn: canReturn, canBuyTheSame: canBuyTheSame));

Future<App> _open(WidgetTester tester, FakeAdapter adapter) async {
  // Tall: the screen is one lazily built list, and the tests look at all of it.
  final app = await pumpApp(tester, adapter, session: signedInSession, tall: true);
  await openTab(tester, 'Tickets');
  await tester.tap(find.byType(TicketCard));
  await tester.pumpAndSettle();
  return app;
}

void main() {
  testWidgets('shows the purchase and what happened to it', (tester) async {
    final adapter = _adapter({...validTicket(assigned: true), ...productCodes})
      ..reply('GET', '/dictionary/ticket-kind-list', 200, ticketKindsJson)
      ..reply('GET', '/dictionary/ticket-period-list', 200, ticketPeriodsJson);
    await _open(tester, adapter);

    // The card names the product as the list does; the name only the details
    // carry is a field of the purchase.
    expect(find.widgetWithText(TicketCard, 'Normalny · Jeden miesiąc'), findsOneWidget);
    expect(find.widgetWithText(TicketCard, 'Bilet norm. 1-mies. sieciowy'), findsNothing);
    expect(find.text('Product'), findsOneWidget);
    expect(find.text('Bilet norm. 1-mies. sieciowy'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Ticket control'), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Yes'), findsOneWidget);
    expect(find.text('ePłatność - przelew elektroniczny'), findsOneWidget);
    expect(find.text('Płatność potwierdzona i zakończona'), findsOneWidget);
    // No promotion.
    expect(find.text('–'), findsOneWidget);

    // One history out of the server's three lists, each entry saying which.
    await tester.scrollUntilVisible(find.text('Płatność rozpoczęta'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Transakcja dodana'), findsOneWidget);
    expect(find.textContaining(' · Transaction'), findsNWidgets(2));
    expect(find.textContaining(' · Payment'), findsOneWidget);
    // Nothing was refunded.
    expect(find.textContaining(' · Refund'), findsNothing);
  });

  test('the history is one list, newest first, in the server\'s order where the time is the same', () {
    final l10n = lookupAppLocalizations(const Locale('en'));
    TicketStateChange at(int minute, String state) =>
        TicketStateChange(createDate: DateTime.utc(2025, 3, 1, 10, minute), stateDescription: state);
    final timeline = timelineOf(
      l10n,
      TicketDetailResponse(
        transactionStateList: [at(16, 'paid'), at(15, 'added')],
        paymentStateList: [
          at(15, 'started'),
          const TicketStateChange(stateDescription: 'undated'),
        ],
        refundStateList: [at(40, 'refunded')],
      ),
    );

    expect(
      [for (final entry in timeline) '${entry.change.stateDescription} (${entry.kind})'],
      ['refunded (Refund)', 'paid (Transaction)', 'added (Transaction)', 'started (Payment)', 'undated (Payment)'],
    );
  });

  group('a line can be changed', () {
    MkkmTicket ticket({List<int> lines = const [], bool network = false}) => MkkmTicket(
      isNetwork: network,
      lines: [for (final line in lines) TransportLine(line: line)],
    );

    test('on a ticket for lines, when the server allows it', () {
      expect(canChangeLineOf(TicketDetailResponse(canChangeLine: true, ticketEkp: ticket(lines: [52]))), isTrue);
      expect(canChangeLineOf(TicketDetailResponse(canChangeLine: false, ticketEkp: ticket(lines: [52]))), isFalse);
      expect(canChangeLineOf(TicketDetailResponse(ticketEkp: ticket(lines: [52]))), isFalse);
    });

    test('never on a ticket for all lines, whatever the server says', () {
      expect(canChangeLineOf(TicketDetailResponse(canChangeLine: true, ticketEkp: ticket(network: true))), isFalse);
      expect(canChangeLineOf(TicketDetailResponse(canChangeLine: true, ticketEkp: ticket(lines: [1000]))), isFalse);
      expect(canChangeLineOf(const TicketDetailResponse(canChangeLine: true)), isFalse);
    });

    testWidgets('from a row that leads to the screen for it', (tester) async {
      final lines = ticketJson(
        start: DateTime.now().subtract(const Duration(days: 3)),
        end: DateTime.now().add(const Duration(days: 27)),
        lines: [52],
        assigned: true,
      );
      final adapter = FakeAdapter()
        ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([lines]))
        ..reply('GET', '/account/user-data', 200, userDataJson())
        ..reply('GET', _detail, 200, ticketDetailJson(lines, canChangeLine: true));
      final app = await _open(tester, adapter);

      await tapVisible(tester, find.widgetWithText(GroupRow, 'Change line'));

      // Not built yet.
      expect(app.location, Routes.ticketChangeLine(transactionCode));
      expect(find.text('Coming soon'), findsOneWidget);
    });
  });

  testWidgets('offers neither a return nor another purchase unless the server allows them', (tester) async {
    await _open(tester, _adapter(validTicket()));

    expect(find.text('Return ticket'), findsNothing);
    expect(find.text('Extend ticket'), findsNothing);
    expect(find.text('Buy similar'), findsNothing);
    expect(find.text('Change line'), findsNothing);
    // With nothing to offer there is no heading for it either.
    expect(find.text('Manage'), findsNothing);
  });

  testWidgets('a running ticket can be extended, an expired one bought again', (tester) async {
    final app = await _open(tester, _adapter(validTicket(), canBuyTheSame: true));
    expect(find.text('Buy similar'), findsNothing);

    expect(find.text('Manage'), findsOneWidget);
    await tapVisible(tester, find.widgetWithText(GroupRow, 'Extend ticket'));
    // Not built yet.
    expect(app.location, '/buy');
  });

  testWidgets('an expired ticket can be bought again', (tester) async {
    await _open(tester, _adapter(expiredTicket(), canBuyTheSame: true));

    expect(find.widgetWithText(GroupRow, 'Buy similar'), findsOneWidget);
    expect(find.text('Extend ticket'), findsNothing);
  });

  testWidgets('a purchase cancelled for want of a payment can only be bought again', (tester) async {
    final ticket = validTicket(assigned: true);
    final detail = ticketDetailJson(ticket, canReturn: true, canBuyTheSame: true, canChangeLine: true, paid: false);
    (detail['ticket'] as Map<String, dynamic>)['transactionStateId'] = 5;
    final adapter = FakeAdapter()
      ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([ticket]))
      ..reply('GET', '/account/user-data', 200, userDataJson())
      ..reply('GET', _detail, 200, detail);
    await _open(tester, adapter);

    expect(find.widgetWithText(TicketCard, 'Cancelled'), findsOneWidget);
    expect(find.text('The payment wasn’t finished in time, so this purchase was cancelled.'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Ticket control'), findsNothing);
    expect(find.widgetWithText(GroupRow, 'Buy again'), findsOneWidget);
    expect(find.widgetWithText(GroupRow, 'Return ticket'), findsNothing);
    expect(find.widgetWithText(GroupRow, 'Extend ticket'), findsNothing);
  });

  testWidgets('says why a ticket held by other devices cannot be assigned', (tester) async {
    await _open(tester, _adapter(validTicket(assigned: false, canAssign: false)));

    expect(find.textContaining('already assigned to two browsers or devices'), findsOneWidget);
  });

  testWidgets('shows the return of a returned ticket', (tester) async {
    final ticket = {...validTicket(), 'status': 'returned'};
    final adapter = _adapter(ticket)
      ..reply(
        'GET',
        _detail,
        200,
        ticketDetailJson(
          ticket,
          returns: [
            {
              'returnDate': '2025-03-10T09:00:00Z',
              'returnQty': 28,
              'unitPriceReturn': 92.4,
              'paymentTypeDescription': 'Zwrot przelewu elektronicznego za pośrednictwem TPay',
            },
          ],
        ),
      );
    await _open(tester, adapter);

    await tester.scrollUntilVisible(find.text('Refund method'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('Days returned'), findsOneWidget);
    expect(find.text('28'), findsOneWidget);
    expect(find.textContaining('92,40'), findsOneWidget);
    expect(find.text('Zwrot przelewu elektronicznego za pośrednictwem TPay'), findsOneWidget);
    // Neither a button nor the two-devices notice on a returned ticket.
    expect(find.byType(FilledButton), findsNothing);
    expect(find.textContaining('already assigned to two'), findsNothing);

    await tester.scrollUntilVisible(find.text('Zwrot rozpoczęty'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.textContaining(' · Refund'), findsOneWidget);
  });

  testWidgets('a failed load can be retried', (tester) async {
    final ticket = validTicket();
    final adapter = _adapter(ticket)..reply('GET', _detail, 500, {'message': 'Błąd serwera.'});
    await _open(tester, adapter);
    expect(find.text('Błąd serwera.'), findsOneWidget);

    adapter.reply('GET', _detail, 200, ticketDetailJson(ticket));
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.text('Paid'), findsOneWidget);
  });

  testWidgets('the return starts from here', (tester) async {
    final app = await _open(tester, _adapter(validTicket(), canReturn: true));

    await tapVisible(tester, find.widgetWithText(GroupRow, 'Return ticket'));

    expect(app.location, Routes.ticketReturn(transactionCode));
  });
}
