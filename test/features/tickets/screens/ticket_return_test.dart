import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/tickets/screens/ticket_return_screen.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _list = '/mkkm/tickets/list';
const _calculate = '/ticket-returns/calculate';
const _return = '/ticket-returns';

final _preview = {
  'returnPrice': 92.4,
  'ticketStartDate': '2025-10-27T22:59:59Z',
  'newTicketExpiryDate': '2025-09-29T21:59:59Z',
  'code': null,
  'message': null,
};

FakeAdapter _adapter() {
  final ticket = validTicket(assigned: true);
  return FakeAdapter()
    ..reply('GET', _list, 200, ticketsReply([ticket]))
    ..reply('GET', '/account/user-data', 200, userDataJson())
    ..reply('GET', '/tickets/$transactionCode', 200, ticketDetailJson(ticket, canReturn: true));
}

Future<App> _open(WidgetTester tester, FakeAdapter adapter) async {
  final app = await pumpApp(tester, adapter, session: signedInSession);
  await openTab(tester, 'Tickets');
  await tester.tap(find.byType(TicketCard));
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(OutlinedButton, 'Return ticket'));
  await tester.pumpAndSettle();
  return app;
}

/// Opens the date picker and takes the day it starts on, the first allowed.
Future<void> _pickFirstDay(WidgetTester tester) async {
  await tester.tap(find.text('Choose'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

void main() {
  test('a return is dated from today, or from the first day of a ticket still to start', () {
    final now = DateTime(2026, 6, 15, 12);
    TicketDetailResponse detail(DateTime start, {DateTime? limit}) => TicketDetailResponse(
      ticket: TicketHistoryEntry(ticketStartDate: start, ticketExpiryDate: DateTime(2026, 7, 20, 23, 59)),
      minExpireReturnDate: limit,
    );

    expect(returnDateBounds(detail(DateTime(2026, 6, 1)), now), (DateTime(2026, 6, 15), DateTime(2026, 7, 20)));
    expect(returnDateBounds(detail(DateTime(2026, 6, 20, 8)), now).$1, DateTime(2026, 6, 20));
    expect(returnDateBounds(detail(DateTime(2026, 6, 1), limit: DateTime(2026, 7, 1, 10)), now).$2, DateTime(2026, 7));
    // Never an empty range.
    expect(returnDateBounds(detail(DateTime(2026, 6, 1), limit: DateTime(2026, 6, 1)), now).$2, DateTime(2026, 6, 15));
  });

  testWidgets('nothing can be returned before the server has priced a date', (tester) async {
    await _open(tester, _adapter());

    expect(find.textContaining('stays valid until the end of the day before'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Return ticket')).onPressed, isNull);
  });

  testWidgets('picking a date asks for the refund, confirming returns the ticket', (tester) async {
    final adapter = _adapter()
      ..reply('POST', _calculate, 200, _preview)
      ..reply('POST', _return, 200, {'createdCorrectionInvoice': false, 'success': true});
    final app = await _open(tester, adapter);

    await _pickFirstDay(tester);
    final today = DateTime.now();
    final sent = adapter.requestTo(_calculate).data as Map<String, dynamic>;
    expect(sent['transactionId'], 400001);
    expect(DateTime.parse(sent['returnDate'] as String).toLocal(), DateTime(today.year, today.month, today.day));
    expect(find.textContaining('92.40'), findsOneWidget);
    expect(find.text('New end of validity'), findsOneWidget);
    expect(adapter.requestsTo(_return), isEmpty);

    await tester.tap(find.widgetWithText(FilledButton, 'Return ticket'));
    await tester.pumpAndSettle();
    expect(find.text('Return this ticket?'), findsOneWidget);
    expect(adapter.requestsTo(_return), isEmpty);
    await tester.tap(find.widgetWithText(TextButton, 'Return ticket'));
    await tester.pumpAndSettle();

    expect(adapter.requestTo(_return).data, sent);
    expect(app.location, Routes.ticket(transactionCode));
    expect(find.text('The ticket was returned.'), findsOneWidget);
    // The list and the details were fetched again.
    expect(adapter.requestsTo(_list), hasLength(2));
    expect(adapter.requestsTo('/tickets/$transactionCode'), hasLength(2));
  });

  testWidgets('cancelling the confirmation returns nothing', (tester) async {
    final adapter = _adapter()..reply('POST', _calculate, 200, _preview);
    final app = await _open(tester, adapter);
    await _pickFirstDay(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Return ticket'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(adapter.requestsTo(_return), isEmpty);
    expect(app.location, Routes.ticketReturn(transactionCode));
  });

  testWidgets('the server says why a date cannot be priced', (tester) async {
    final adapter = _adapter()..reply('POST', _calculate, 200, {'code': 7, 'message': 'Nie można zwrócić biletu.'});
    await _open(tester, adapter);
    await _pickFirstDay(tester);

    expect(find.text('Nie można zwrócić biletu.'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Return ticket')).onPressed, isNull);
  });

  testWidgets('a return the server refuses leaves the screen open', (tester) async {
    final adapter = _adapter()
      ..reply('POST', _calculate, 200, _preview)
      ..reply('POST', _return, 400, {'message': 'Zwrot niemożliwy.'});
    final app = await _open(tester, adapter);
    await _pickFirstDay(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Return ticket'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Return ticket'));
    await tester.pumpAndSettle();

    expect(find.text('Zwrot niemożliwy.'), findsOneWidget);
    expect(app.location, Routes.ticketReturn(transactionCode));
  });
}
