import 'package:drift/native.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/features/tickets/services/tickets_dao.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _list = '/mkkm/tickets/list';
const _history = '/api/v1/tickets';

FakeAdapter _adapter(List<Map<String, dynamic>> tickets) => FakeAdapter()
  ..reply('GET', _list, 200, ticketsReply(tickets))
  ..reply('GET', '/account/user-data', 200, userDataJson());

/// A database that already holds [tickets], as after an earlier run.
Future<AppDatabase> _seeded(List<Map<String, dynamic>> tickets) async {
  final db = AppDatabase(NativeDatabase.memory());
  addTearDown(db.close);
  await TicketsDao(db).replaceWith([for (final ticket in tickets) MkkmTicket.fromJson(ticket)]);
  return db;
}

void main() {
  testWidgets('the active list shows the mobile tickets with their state', (tester) async {
    final adapter = _adapter([
      validTicket(),
      upcomingTicket(),
      ticketJson(
        guid: 'pending',
        status: 'pending',
        start: DateTime.now().add(const Duration(days: 40)),
        end: DateTime.now().add(const Duration(days: 70)),
        lines: [4, 52],
        price: 54.5,
      ),
    ]);
    await pumpApp(tester, adapter, session: signedInSession);
    await openTab(tester, 'Tickets');

    expect(find.byType(TicketCard), findsNWidgets(3));
    expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    expect(find.widgetWithText(TicketCard, 'Valid'), findsOneWidget);
    expect(find.widgetWithText(TicketCard, 'Metropolitan ticket'), findsOneWidget);
    expect(find.textContaining('Valid from '), findsOneWidget);
    expect(find.widgetWithText(TicketCard, 'Lines 4, 52'), findsOneWidget);
    expect(find.widgetWithText(TicketCard, 'Awaiting payment'), findsOneWidget);
    expect(find.textContaining('54.50'), findsOneWidget);
  });

  testWidgets('without tickets the list says so', (tester) async {
    await pumpApp(tester, _adapter([]), session: signedInSession);
    await openTab(tester, 'Tickets');

    expect(find.text('You have no tickets yet.'), findsOneWidget);
  });

  testWidgets('a failed load can be retried', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _list, 500, {'message': 'Błąd serwera.'});
    await pumpApp(tester, adapter, session: signedInSession);
    await openTab(tester, 'Tickets');
    expect(find.text('Błąd serwera.'), findsOneWidget);

    adapter.reply('GET', _list, 200, ticketsReply([validTicket()]));
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    expect(find.text('Błąd serwera.'), findsNothing);
  });

  testWidgets('stored tickets are shown while offline', (tester) async {
    final adapter = FakeAdapter()
      ..fail('GET', '/service-status')
      ..fail('GET', _list);
    await pumpApp(tester, adapter, session: signedInSession, database: await _seeded([validTicket()]));
    await openTab(tester, 'Tickets');

    expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    expect(find.text("You're offline. Showing saved data."), findsOneWidget);
  });

  testWidgets('a ticket the server no longer returns disappears', (tester) async {
    final db = await _seeded([validTicket(), upcomingTicket()]);
    await pumpApp(tester, _adapter([validTicket()]), session: signedInSession, database: db);
    await openTab(tester, 'Tickets');

    expect(find.byType(TicketCard), findsOneWidget);
    expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
  });

  testWidgets('pulling to refresh fetches the list again', (tester) async {
    final adapter = _adapter([]);
    await pumpApp(tester, adapter, session: signedInSession);
    await openTab(tester, 'Tickets');

    adapter.reply('GET', _list, 200, ticketsReply([validTicket()]));
    await pullToRefresh(tester);

    expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    expect(adapter.requestsTo(_list), hasLength(2));
  });

  testWidgets('coming back to the foreground right after a sync does not sync again', (tester) async {
    final adapter = _adapter([validTicket()]);
    await pumpApp(tester, adapter, session: signedInSession);

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
    await tester.pumpAndSettle();

    expect(adapter.requestsTo(_list), hasLength(1));
  });

  group('the list is asked for', () {
    testWidgets('only after the service has reported itself available', (tester) async {
      final adapter = _adapter([validTicket()])..reply('GET', '/service-status', 200, {'isAvailable': true});
      final release = adapter.hold('GET', '/service-status');
      await pumpApp(tester, adapter, session: signedInSession, settle: false);

      await tester.pump(const Duration(seconds: 1));
      expect(adapter.requestsTo(_list), isEmpty);

      release();
      await tester.pumpAndSettle();
      expect(adapter.requestsTo(_list), hasLength(1));
    });

    testWidgets('without waiting for the user data', (tester) async {
      final adapter = _adapter([validTicket()]);
      adapter.hold('GET', '/account/user-data');
      await pumpApp(tester, adapter, session: signedInSession, settle: false);

      // Through the start-up check, up to the held request.
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }
      expect(adapter.requestsTo('/account/user-data'), hasLength(1));
      expect(adapter.requestsTo(_list), hasLength(1));
      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    });

    testWidgets('also when the user data could not be loaded', (tester) async {
      final adapter = FakeAdapter()
        ..reply('GET', _list, 200, ticketsReply([validTicket()]))
        ..reply('GET', '/account/user-data', 500);
      await pumpApp(tester, adapter, session: signedInSession);

      expect(adapter.requestsTo(_list), hasLength(1));
    });

    testWidgets('not while the server is unreachable, then once it is back', (tester) async {
      final adapter = _adapter([validTicket()])..fail('GET', '/service-status');
      await pumpApp(tester, adapter, session: signedInSession);
      expect(adapter.requestsTo(_list), isEmpty);
      expect(find.text('Your tickets could not be loaded.'), findsOneWidget);

      adapter.reply('GET', '/service-status', 200, {'isAvailable': true});
      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(adapter.requestsTo(_list), hasLength(1));
      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    });

    testWidgets('not while the service is switched off', (tester) async {
      final adapter = _adapter([validTicket()])..reply('GET', '/service-status', 200, {'isAvailable': false});
      await pumpApp(tester, adapter, session: signedInSession);
      await openTab(tester, 'Tickets');
      await pullToRefresh(tester);

      expect(adapter.requestsTo(_list), isEmpty);
    });

    testWidgets('not before signing in, and right after it', (tester) async {
      final adapter = _adapter([validTicket()])
        ..reply('POST', '/auth/login', 200, {
          'token': 'aaa.bbb.ccc',
          'refresh': 'feedfacefeedfacefeedfacefeedface',
          'expires': '2100-01-01T00:00:00Z',
        });
      await pumpApp(tester, adapter);
      expect(adapter.requestsTo(_list), isEmpty);

      await tester.enterText(field('E-mail'), 'user@example.com');
      await tester.enterText(field('Password'), 'Secret123');
      await tapVisible(tester, find.widgetWithText(FilledButton, 'Sign in'));

      expect(adapter.requestsTo(_list), hasLength(1));
    });
  });

  testWidgets('buying a ticket starts from a button on both lists', (tester) async {
    final app = await pumpApp(tester, _adapter([validTicket()]), session: signedInSession);
    await openTab(tester, 'Tickets');
    await tester.tap(find.text('Past'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FloatingActionButton, 'Buy ticket'));
    await tester.pumpAndSettle();
    expect(app.location, '/buy');
    expect(find.text('Coming soon'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(app.location, '/tickets');
    await tester.tap(find.text('Active'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FloatingActionButton, 'Buy ticket'), findsOneWidget);
  });

  testWidgets('signing out empties the ticket store', (tester) async {
    final adapter = _adapter([validTicket()])..reply('POST', '/auth/logout', 200);
    final app = await pumpApp(tester, adapter, session: signedInSession);
    expect(await app.database.select(app.database.tickets).get(), hasLength(1));

    await signOut(tester);

    expect(await app.database.select(app.database.tickets).get(), isEmpty);
  });

  group('the past list', () {
    testWidgets('asks for the history of the customer and shows it', (tester) async {
      final adapter = _adapter([])..reply('GET', _history, 200, historyJson);
      await pumpApp(tester, adapter, session: signedInSession);
      await openTab(tester, 'Tickets');
      expect(adapter.requestsTo(_history), isEmpty);

      await tester.tap(find.text('Past'));
      await tester.pumpAndSettle();

      expect(adapter.requestTo(_history).queryParameters, {'customerCode': '100001', 'validity': 'Past'});
      expect(find.widgetWithText(TicketCard, 'Bilet norm. 1-mies. sieciowy'), findsOneWidget);
      expect(find.text('Transakcja zakończona pomyślnie'), findsOneWidget);
    });

    testWidgets('says when there is none', (tester) async {
      final adapter = _adapter([])..reply('GET', _history, 200, const <Object>[]);
      await pumpApp(tester, adapter, session: signedInSession);
      await openTab(tester, 'Tickets');
      await tester.tap(find.text('Past'));
      await tester.pumpAndSettle();

      expect(find.text('No past tickets.'), findsOneWidget);
    });

    testWidgets('a failed load can be retried', (tester) async {
      final adapter = _adapter([])..fail('GET', _history);
      await pumpApp(tester, adapter, session: signedInSession);
      await openTab(tester, 'Tickets');
      await tester.tap(find.text('Past'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Could not reach the server'), findsOneWidget);

      adapter.reply('GET', _history, 200, historyJson);
      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TicketCard, 'Bilet norm. 1-mies. sieciowy'), findsOneWidget);
    });
  });
}
