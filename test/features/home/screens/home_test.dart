import 'package:drift/native.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/features/tickets/services/tickets_dao.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _subscription = '5+1 half-year ticket';

FakeAdapter _adapter(List<Map<String, dynamic>> tickets, {bool? resident = true, bool? activeSubscription}) =>
    FakeAdapter()
      ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply(tickets))
      ..reply(
        'GET',
        '/account/user-data',
        200,
        userDataJson(resident: resident, activeSubscription: activeSubscription),
      );

void main() {
  testWidgets('greets the user by first name', (tester) async {
    await pumpApp(tester, _adapter([]), session: signedInSession);
    expect(find.text('Hello, Jan!'), findsOneWidget);
  });

  group('the ticket', () {
    testWidgets('is the one valid now', (tester) async {
      await pumpApp(tester, _adapter([upcomingTicket(), validTicket()]), session: signedInSession);

      expect(find.byType(TicketCard), findsOneWidget);
      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
      expect(find.widgetWithText(TicketCard, 'Valid'), findsOneWidget);
    });

    testWidgets('is the next one when none is valid yet', (tester) async {
      await pumpApp(tester, _adapter([expiredTicket(guid: 'old'), upcomingTicket()]), session: signedInSession);

      expect(find.widgetWithText(TicketCard, 'Metropolitan ticket'), findsOneWidget);
      expect(find.textContaining('Valid from '), findsOneWidget);
    });

    testWidgets('opens the ticket list', (tester) async {
      final app = await pumpApp(tester, _adapter([validTicket()]), session: signedInSession);

      await tester.tap(find.byType(TicketCard));
      await tester.pumpAndSettle();

      expect(app.location, '/tickets');
    });

    testWidgets('without any, the user is invited to buy one', (tester) async {
      final app = await pumpApp(tester, _adapter([expiredTicket()]), session: signedInSession);
      expect(find.byType(TicketCard), findsNothing);
      expect(find.text('No active ticket'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Buy ticket'));
      await tester.pumpAndSettle();

      expect(app.location, '/buy');
      expect(find.text('Coming soon'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('a failed first load can be retried in its place', (tester) async {
      final adapter = FakeAdapter()..fail('GET', '/mkkm/tickets/list');
      await pumpApp(tester, adapter, session: signedInSession);
      expect(find.textContaining('Could not reach the server'), findsOneWidget);

      adapter.reply('GET', '/mkkm/tickets/list', 200, ticketsReply([validTicket()]));
      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    });
  });

  group('a pinned ticket', () {
    testWidgets('replaces the automatic choice and is kept for the next start', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final tickets = [validTicket(), upcomingTicket()];
      await pumpApp(tester, _adapter(tickets), session: signedInSession, database: db);
      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);

      await openTab(tester, 'Tickets');
      await tester.tap(
        find.descendant(
          of: find.widgetWithText(TicketCard, 'Metropolitan ticket'),
          matching: find.byTooltip('Ticket options'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pin to Home'));
      await tester.pumpAndSettle();
      await openTab(tester, 'Home');

      expect(find.widgetWithText(TicketCard, 'Metropolitan ticket'), findsOneWidget);
      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsNothing);
      expect(find.byIcon(Symbols.push_pin_rounded), findsOneWidget);

      // A fresh start of the app on the same database.
      await pumpApp(tester, _adapter(tickets), session: signedInSession, database: db);
      expect(find.widgetWithText(TicketCard, 'Metropolitan ticket'), findsOneWidget);
      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsNothing);
    });

    testWidgets('can be unpinned again', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final tickets = [validTicket(), upcomingTicket()];
      await TicketsDao(db).replaceWith([for (final ticket in tickets) MkkmTicket.fromJson(ticket)]);
      await TicketsDao(db).setPinned(metropolitanGuid);
      await pumpApp(tester, _adapter(tickets), session: signedInSession, database: db);
      expect(find.widgetWithText(TicketCard, 'Metropolitan ticket'), findsOneWidget);

      await openTab(tester, 'Tickets');
      await tester.tap(
        find.descendant(
          of: find.widgetWithText(TicketCard, 'Metropolitan ticket'),
          matching: find.byTooltip('Ticket options'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Unpin'));
      await tester.pumpAndSettle();
      await openTab(tester, 'Home');

      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
    });

    testWidgets('that has expired gives way to the automatic choice', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final tickets = [validTicket(), expiredTicket()];
      await TicketsDao(db).replaceWith([for (final ticket in tickets) MkkmTicket.fromJson(ticket)]);
      await TicketsDao(db).setPinned(metropolitanGuid);
      await pumpApp(tester, _adapter(tickets), session: signedInSession, database: db);

      expect(find.widgetWithText(TicketCard, 'Network ticket'), findsOneWidget);
      expect(find.widgetWithText(TicketCard, 'Metropolitan ticket'), findsNothing);
    });
  });

  group('quick actions', () {
    for (final (label, location, lands) in [
      ('Tickets', '/tickets', 'Active'),
      ('Buy ticket', '/buy', 'Coming soon'),
      ('Karta Krakowska', '/karta-krakowska', 'Coming soon'),
      ('Departures', '/map', 'Search for a stop'),
    ]) {
      testWidgets('$label opens $location', (tester) async {
        final app = await pumpApp(tester, _adapter([validTicket()]), session: signedInSession);

        await tester.tap(find.descendant(of: find.byType(InkWell), matching: find.text(label)).last);
        await tester.pumpAndSettle();

        expect(app.location, location);
        expect(find.text(lands), findsOneWidget);
      });
    }
  });

  group('the 5+1 row', () {
    testWidgets('is offered to Karta Krakowska holders and opens the programme', (tester) async {
      final app = await pumpApp(tester, _adapter([]), session: signedInSession);

      await tapVisible(tester, find.text(_subscription));

      expect(app.location, '/subscription');
    });

    testWidgets('is not shown without the inhabitant privilege', (tester) async {
      await pumpApp(tester, _adapter([], resident: false), session: signedInSession);
      expect(find.text(_subscription), findsNothing);
    });

    testWidgets('is offered to a subscriber without the inhabitant privilege', (tester) async {
      await pumpApp(tester, _adapter([], resident: false, activeSubscription: true), session: signedInSession);
      expect(find.text(_subscription), findsOneWidget);
    });

    testWidgets('is not shown while the privilege is unknown', (tester) async {
      await pumpApp(tester, _adapter([], resident: null), session: signedInSession);
      expect(find.text(_subscription), findsNothing);
    });
  });
}
