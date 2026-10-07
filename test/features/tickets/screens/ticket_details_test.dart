import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _detail = '/tickets/$transactionCode';

FakeAdapter _adapter(Map<String, dynamic> ticket, {bool canReturn = false, bool canBuyTheSame = false}) => FakeAdapter()
  ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([ticket]))
  ..reply('GET', '/account/user-data', 200, userDataJson())
  ..reply('GET', _detail, 200, ticketDetailJson(ticket, canReturn: canReturn, canBuyTheSame: canBuyTheSame));

Future<App> _open(WidgetTester tester, FakeAdapter adapter) async {
  final app = await pumpApp(tester, adapter, session: signedInSession);
  await openTab(tester, 'Tickets');
  await tester.tap(find.byType(TicketCard));
  await tester.pumpAndSettle();
  return app;
}

void main() {
  testWidgets('shows the purchase and what happened to it', (tester) async {
    await _open(tester, _adapter(validTicket(assigned: true)));

    expect(find.widgetWithText(TicketCard, 'Bilet norm. 1-mies. sieciowy'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Ticket control'), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Yes'), findsOneWidget);
    expect(find.text('ePłatność - przelew elektroniczny'), findsOneWidget);
    expect(find.text('Płatność potwierdzona i zakończona'), findsOneWidget);
    // No promotion.
    expect(find.text('–'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Payment history'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('Transaction history'), findsOneWidget);
    expect(find.text('Transakcja dodana'), findsOneWidget);
    expect(find.text('Płatność rozpoczęta'), findsOneWidget);
    // Nothing was refunded.
    expect(find.text('Refund history'), findsNothing);
  });

  testWidgets('offers neither a return nor another purchase unless the server allows them', (tester) async {
    await _open(tester, _adapter(validTicket()));

    expect(find.text('Return ticket'), findsNothing);
    expect(find.text('Extend ticket'), findsNothing);
    expect(find.text('Buy similar'), findsNothing);
  });

  testWidgets('a running ticket can be extended, an expired one bought again', (tester) async {
    final app = await _open(tester, _adapter(validTicket(), canBuyTheSame: true));
    expect(find.text('Buy similar'), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Extend ticket'));
    await tester.pumpAndSettle();
    // Not built yet.
    expect(app.location, '/buy');
  });

  testWidgets('an expired ticket can be bought again', (tester) async {
    await _open(tester, _adapter(expiredTicket(), canBuyTheSame: true));

    expect(find.widgetWithText(TextButton, 'Buy similar'), findsOneWidget);
    expect(find.text('Extend ticket'), findsNothing);
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
    expect(find.text('Refund history'), findsOneWidget);
    expect(find.text('Zwrot rozpoczęty'), findsOneWidget);
    expect(find.text('Days returned'), findsOneWidget);
    expect(find.text('28'), findsOneWidget);
    expect(find.textContaining('92.40'), findsOneWidget);
    expect(find.text('Zwrot przelewu elektronicznego za pośrednictwem TPay'), findsOneWidget);
    // Neither a button nor the two-devices notice on a returned ticket.
    expect(find.byType(FilledButton), findsNothing);
    expect(find.textContaining('already assigned to two'), findsNothing);
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

    await tester.tap(find.widgetWithText(OutlinedButton, 'Return ticket'));
    await tester.pumpAndSettle();

    expect(app.location, Routes.ticketReturn(transactionCode));
  });
}
