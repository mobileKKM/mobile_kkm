import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/features/tickets/screens/ticket_change_line_screen.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _edit = '/tickets/line-change/edit';

Map<String, dynamic> _line(int number, {bool tram = false}) => {
  'line': number,
  'second_zone': false,
  'has_second_zone': false,
  'is_tram': tram,
  'is_bus': !tram,
};

/// A running ticket for [lines], and a search that finds 13 and 139.
FakeAdapter _adapter(List<int> lines) {
  final ticket = ticketJson(
    start: DateTime.now().subtract(const Duration(days: 3)),
    end: DateTime.now().add(const Duration(days: 27)),
    lines: lines,
    assigned: true,
  );
  return FakeAdapter()
    ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([ticket]))
    ..reply('GET', '/account/user-data', 200, userDataJson())
    ..reply('GET', '/tickets/$transactionCode', 200, ticketDetailJson(ticket, canChangeLine: true))
    ..reply('GET', '/dictionary/transport-line', 200, {
      'lines': [_line(13, tram: true), _line(139)],
      'code': null,
      'message': null,
    })
    ..reply('POST', _edit, 200, 3170);
}

Future<App> _open(WidgetTester tester, FakeAdapter adapter) async {
  final app = await pumpApp(tester, adapter, session: signedInSession, tall: true);
  await openTab(tester, 'Tickets');
  await tester.tap(find.byType(TicketCard));
  await tester.pumpAndSettle();
  await tapVisible(tester, find.widgetWithText(GroupRow, 'Change line'));
  return app;
}

/// A line among the search's results, not the number in its field.
Finder _result(String number) => find.descendant(of: find.byType(ListView), matching: find.text(number));

/// Taps the ticket's line [from] and types [query] into the search.
Future<void> _search(WidgetTester tester, String from, String query) async {
  await tester.tap(find.text(from));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField), query);
  // The search waits for the typing to pause.
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
}

final _save = find.widgetWithText(FilledButton, 'Save');

void main() {
  test('only the places that were given another line change', () {
    const lines = [TransportLine(line: 52), TransportLine(line: 139)];

    expect(linesAfter(lines, const {}), lines);
    expect(linesAfter(lines, const {1: TransportLine(line: 13)}).map((line) => line.line), [52, 13]);
  });

  testWidgets('nothing can be saved before a line was picked', (tester) async {
    final adapter = _adapter([52]);
    await _open(tester, adapter);

    expect(find.text('Your line'), findsOneWidget);
    expect(tester.widget<FilledButton>(_save).onPressed, isNull);
    expect(adapter.requestsTo(_edit), isEmpty);
  });

  testWidgets('a picked line takes the place of the ticket\'s, and saving sends it', (tester) async {
    final adapter = _adapter([52]);
    final app = await _open(tester, adapter);

    await _search(tester, '52', '13');
    expect(find.text('Replacing line 52'), findsOneWidget);
    expect(adapter.requestTo('/dictionary/transport-line').queryParameters, {'number': '13'});
    await tester.tap(_result('13'));
    await tester.pumpAndSettle();

    expect(find.text('Tram · replaces 52'), findsOneWidget);
    expect(find.text('After saving, this ticket is valid on line 13.'), findsOneWidget);

    await tester.tap(_save);
    await tester.pumpAndSettle();

    expect(adapter.requestTo(_edit).data, {
      'ccTransaction': 400001,
      'lines': [
        {'number': 13, 'secondZone': false},
      ],
    });
    expect(app.location, Routes.ticket(transactionCode));
    expect(find.text('Line changed.'), findsOneWidget);
    // The details are asked for again: the ticket is another now.
    expect(adapter.requestsTo('/tickets/$transactionCode').length, 2);
  });

  testWidgets('with two lines only the tapped one changes, and both are sent', (tester) async {
    final adapter = _adapter([52, 139]);
    await _open(tester, adapter);
    expect(find.text('Which line do you want to change?'), findsOneWidget);

    await _search(tester, '52', '13');
    // The ticket's other line cannot be had twice.
    expect(find.text('On your ticket'), findsOneWidget);
    await tester.tap(_result('139'));
    await tester.pumpAndSettle();
    expect(find.text('Replacing line 52'), findsOneWidget);

    await tester.tap(_result('13'));
    await tester.pumpAndSettle();
    expect(find.text('After saving, this ticket is valid on lines 13 and 139.'), findsOneWidget);

    await tester.tap(_save);
    await tester.pumpAndSettle();

    final sent = (adapter.requestTo(_edit).data as Map<String, dynamic>)['lines'] as List<dynamic>;
    expect(sent.map((line) => (line as Map<String, dynamic>)['number']), [13, 139]);
  });

  testWidgets('picking the ticket\'s own line again takes the change back', (tester) async {
    final adapter = _adapter([52])
      ..reply('GET', '/dictionary/transport-line', 200, {
        'lines': [_line(13, tram: true), _line(52, tram: true)],
      });
    await _open(tester, adapter);

    await _search(tester, '52', '13');
    await tester.tap(_result('13'));
    await tester.pumpAndSettle();
    await _search(tester, '13', '5');
    await tester.tap(_result('52'));
    await tester.pumpAndSettle();

    expect(find.textContaining('replaces'), findsNothing);
    expect(tester.widget<FilledButton>(_save).onPressed, isNull);
  });

  testWidgets('a change the server refuses leaves the screen open, with its reason', (tester) async {
    const reason = 'Zmiana linii dla tego biletu nie jest już możliwa.';
    final adapter = _adapter([52])..reply('POST', _edit, 400, {'code': 'error', 'message': reason});
    final app = await _open(tester, adapter);

    await _search(tester, '52', '13');
    await tester.tap(_result('13'));
    await tester.pumpAndSettle();
    await tester.tap(_save);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MessageBanner, reason), findsOneWidget);
    expect(app.location, Routes.ticketChangeLine(transactionCode));
    expect(tester.widget<FilledButton>(_save).onPressed, isNotNull);
  });

  testWidgets('a number no line starts with says so', (tester) async {
    final adapter = _adapter([52])..reply('GET', '/dictionary/transport-line', 200, {'lines': <Object>[]});
    await _open(tester, adapter);

    await _search(tester, '52', '99');

    expect(find.text('No line starts with 99.'), findsOneWidget);
  });
}
