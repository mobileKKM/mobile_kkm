import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
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
  // Tall: the screen is one lazily built list, and the tests look at all of it.
  final app = await pumpApp(tester, adapter, session: signedInSession, tall: true);
  await openTab(tester, 'Tickets');
  await tester.tap(find.byType(TicketCard));
  await tester.pumpAndSettle();
  await tapVisible(tester, find.widgetWithText(GroupRow, 'Return ticket'));
  return app;
}

/// The button of the confirmation, not the one under it that opened it.
final _confirm = find.descendant(
  of: find.byType(AlertDialog),
  matching: find.widgetWithText(FilledButton, 'Return ticket'),
);

/// Opens the date picker and takes the day it starts on, the first allowed.
Future<void> _pickFirstDay(WidgetTester tester) async {
  await tester.tap(find.text('Choose a date'));
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

  group('the days a return gives back', () {
    final start = DateTime(2026, 10, 9, 1, 15);
    final end = DateTime(2026, 11, 8, 23, 59, 59);

    test('do not include today once the ticket has started: it stays valid through it', () {
      final now = DateTime(2026, 10, 9, 12);
      expect(returnedDays(returnFrom: DateTime(2026, 10, 9), start: start, end: end, now: now), 30);
      expect(returnedDays(returnFrom: DateTime(2026, 10, 10), start: start, end: end, now: now), 30);
      expect(returnedDays(returnFrom: DateTime(2026, 10, 11), start: start, end: end, now: now), 29);
    });

    test('are all of them for a ticket still to start', () {
      final now = DateTime(2026, 10, 1, 12);
      expect(returnedDays(returnFrom: DateTime(2026, 10, 9), start: start, end: end, now: now), 31);
    });

    test('follow the server once it has said until when the ticket is kept', () {
      expect(
        returnedDays(
          returnFrom: DateTime(2026, 10, 9),
          start: start,
          end: end,
          now: DateTime(2026, 10, 9, 12),
          keptUntil: DateTime(2026, 10, 20, 23, 59, 59),
        ),
        19,
      );
    });
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
    // What is kept and what goes back, under the bar that shows it.
    expect(find.textContaining('Still valid until '), findsOneWidget);
    expect(find.textContaining(' days returned'), findsOneWidget);
    expect(find.text('You get back'), findsOneWidget);
    expect(adapter.requestsTo(_return), isEmpty);

    await tester.tap(find.widgetWithText(FilledButton, 'Return ticket'));
    await tester.pumpAndSettle();
    expect(find.text('Return this ticket?'), findsOneWidget);
    // With what it comes to, and until when the ticket still runs.
    expect(find.textContaining('will be refunded. The ticket stays valid until '), findsOneWidget);
    expect(adapter.requestsTo(_return), isEmpty);
    await tester.tap(_confirm);
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
    await tester.tap(_confirm);
    await tester.pumpAndSettle();

    expect(find.text('Zwrot niemożliwy.'), findsOneWidget);
    expect(app.location, Routes.ticketReturn(transactionCode));
  });
}
