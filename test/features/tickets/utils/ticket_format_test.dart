import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

void main() {
  setUpAll(initializeDateFormatting);

  final now = DateTime.utc(2026, 6, 15, 12);
  MkkmTicket ticket(String status, int startDay, int endDay, {String? guid}) => MkkmTicket(
    ticketGuid: guid,
    status: status,
    startDate: DateTime.utc(2026, 6, startDay),
    endDate: DateTime.utc(2026, 6, endDay, 23, 59, 59),
  );

  test('a purchase in the history went through or was cancelled, by its transaction state', () {
    PurchaseState of(int? state) => purchaseStateOf(TicketHistoryEntry(transactionStateId: state));
    expect(of(9), PurchaseState.completed);
    expect(of(5), PurchaseState.cancelled);
    expect(of(2), PurchaseState.other);
    expect(of(null), PurchaseState.other);
  });

  test('phaseOf follows the status, then the validity window', () {
    expect(phaseOf(ticket('pending', 1, 30), now), TicketPhase.pending);
    // A returned ticket runs until the end the return left it with.
    expect(phaseOf(ticket('returned', 1, 30), now), TicketPhase.valid);
    expect(phaseOf(ticket('returned', 20, 30), now), TicketPhase.upcoming);
    expect(phaseOf(ticket('returned', 1, 10), now), TicketPhase.returned);
    expect(phaseOf(const MkkmTicket(status: 'returned'), now), TicketPhase.returned);
    // Given back whole: nothing between its ends.
    expect(
      phaseOf(
        MkkmTicket(status: 'returned', startDate: DateTime.utc(2026, 6, 20), endDate: DateTime.utc(2026, 6, 20)),
        now,
      ),
      TicketPhase.returned,
    );
    expect(phaseOf(ticket('weird', 1, 30), now), TicketPhase.unknown);
    // The list has no status for a cancelled purchase: it drops the ticket.
    expect(phaseOf(ticket('cancelled', 1, 30), now), TicketPhase.unknown);
    expect(phaseOf(ticket('active', 1, 30), now), TicketPhase.valid);
    expect(phaseOf(ticket('active', 20, 30), now), TicketPhase.upcoming);
    expect(phaseOf(ticket('active', 1, 10), now), TicketPhase.expired);
    expect(phaseOf(const MkkmTicket(status: 'active'), now), TicketPhase.valid);
  });

  group('currentOrUpcoming', () {
    test('prefers the ticket valid now', () {
      final picked = currentOrUpcoming([
        ticket('active', 20, 30, guid: 'next'),
        ticket('active', 1, 30, guid: 'now'),
      ], now);
      expect(picked?.ticketGuid, 'now');
    });

    test('otherwise takes the next one to start', () {
      final picked = currentOrUpcoming([
        ticket('active', 25, 30, guid: 'later'),
        ticket('active', 20, 30, guid: 'next'),
        ticket('active', 1, 10, guid: 'gone'),
      ], now);
      expect(picked?.ticketGuid, 'next');
    });

    test('takes a returned ticket for as long as it still runs', () {
      expect(currentOrUpcoming([ticket('returned', 1, 30, guid: 'kept')], now)?.ticketGuid, 'kept');
    });

    test('ignores unpaid, returned and expired tickets', () {
      expect(
        currentOrUpcoming([ticket('pending', 1, 30), ticket('returned', 1, 10), ticket('active', 1, 10)], now),
        isNull,
      );
    });
  });

  test('actionOf follows the official client, first match first', () {
    expect(actionOf(const MkkmTicket(status: 'pending', assigned: true)), TicketAction.control);
    expect(actionOf(const MkkmTicket(status: 'processing', canAssign: true)), TicketAction.processing);
    expect(actionOf(const MkkmTicket(status: 'pending', canAssign: true)), TicketAction.payment);
    expect(actionOf(const MkkmTicket(status: 'active', canAssign: true)), TicketAction.assign);
    expect(actionOf(const MkkmTicket(status: 'active', canAssign: false)), TicketAction.assignedElsewhere);
    expect(actionOf(const MkkmTicket(status: 'returned')), TicketAction.none);
    expect(actionOf(const MkkmTicket(status: 'weird')), TicketAction.none);
  });

  test('the code can be shown once an assigned ticket has started', () {
    MkkmTicket assigned(int startDay) =>
        MkkmTicket(status: 'active', assigned: true, startDate: DateTime.utc(2026, 6, startDay));
    expect(canControl(assigned(1), now), isTrue);
    expect(canControl(assigned(20), now), isFalse);
    expect(canControl(ticket('active', 1, 30), now), isFalse);
  });

  test('ticketZone takes the zone out of the line scope\'s description', () {
    const scopes = TicketNumberOfLineListResponse(
      list: [
        TicketNumberOfLine(code: 3, description: 'Wszystkie linie - Strefa I'),
        TicketNumberOfLine(code: 9, description: 'Bez strefy'),
      ],
    );
    expect(ticketZone(3, scopes), 'Strefa I');
    expect(ticketZone(9, scopes), isNull);
    expect(ticketZone(4, scopes), isNull);
    expect(ticketZone(3, null), isNull);
    expect(ticketZone(null, scopes), isNull);
  });

  test('ticketScope names the lines or the network, then the zone', () {
    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(ticketScope(l10n, const MkkmTicket(isNetwork: true)), 'Network ticket');
    expect(
      ticketScope(l10n, const MkkmTicket(isMetropolitan: true), zone: 'Strefa I'),
      'Metropolitan ticket · Strefa I',
    );
    expect(
      ticketScope(l10n, const MkkmTicket(lines: [TransportLine(line: 4), TransportLine(line: 52)])),
      'Lines 4, 52',
    );
  });

  group('what a card says', () {
    // Local times: the counts go by the days of the user's calendar.
    final noon = DateTime(2026, 10, 8, 12);
    MkkmTicket running({bool? assigned, bool? canAssign, String status = 'active'}) => MkkmTicket(
      status: status,
      assigned: assigned,
      canAssign: canAssign,
      startDate: DateTime(2026, 10),
      endDate: DateTime(2026, 10, 31, 23, 59, 59),
    );
    MkkmTicket starting(DateTime start, {bool? assigned, bool? canAssign}) => MkkmTicket(
      status: 'active',
      assigned: assigned,
      canAssign: canAssign,
      startDate: start,
      endDate: start.add(const Duration(days: 30)),
    );

    test('its colour is what can be done with the ticket here', () {
      expect(toneOf(running(assigned: true), noon), TicketTone.valid);
      // Assigning is one step, not a problem.
      expect(toneOf(running(canAssign: true), noon), TicketTone.valid);
      expect(toneOf(running(canAssign: false), noon), TicketTone.over);
      expect(toneOf(starting(DateTime(2026, 10, 17), assigned: true), noon), TicketTone.wait);
      expect(toneOf(starting(DateTime(2026, 10, 17), canAssign: false), noon), TicketTone.over);
      expect(toneOf(running(status: 'processing'), noon), TicketTone.wait);
      // The one colour for payments.
      expect(toneOf(running(status: 'pending'), noon), TicketTone.action);
      // Returned, but its last days are still to come.
      expect(toneOf(running(status: 'returned', assigned: true), noon), TicketTone.valid);
      expect(toneOf(running(status: 'returned', assigned: true), DateTime(2026, 11, 2)), TicketTone.over);
      // Running, yet neither on this phone nor to be put on it.
      expect(toneOf(running(status: 'returned'), noon), TicketTone.over);
      expect(toneOf(running(assigned: true), DateTime(2026, 11, 2)), TicketTone.over);
    });

    test('a running ticket counts its days, today included', () {
      final left = countdownOf(running(assigned: true), noon)!;
      expect(left.days, 24);
      expect(left.upcoming, isFalse);
      expect(left.isToday, isFalse);
      expect(left.moment, DateTime(2026, 10, 31, 23, 59, 59));
    });

    test('its last day is said as today', () {
      final left = countdownOf(running(assigned: true), DateTime(2026, 10, 31, 8))!;
      expect(left.days, 1);
      expect(left.isToday, isTrue);
    });

    test('one still to start counts the days until then', () {
      final ahead = countdownOf(starting(DateTime(2026, 10, 17)), noon)!;
      expect(ahead.days, 9);
      expect(ahead.upcoming, isTrue);
      expect(ahead.isToday, isFalse);
      expect(countdownOf(starting(DateTime(2026, 10, 8, 18)), noon)!.isToday, isTrue);
    });

    test('nothing is counted for a ticket that is neither', () {
      expect(countdownOf(running(status: 'pending'), noon), isNull);
      expect(countdownOf(running(status: 'returned'), DateTime(2026, 11, 2)), isNull);
      expect(countdownOf(running(status: 'returned'), noon)?.days, 24);
      expect(countdownOf(running(assigned: true), DateTime(2026, 11, 2)), isNull);
      expect(countdownOf(const MkkmTicket(status: 'active'), noon), isNull);
    });

    test('the bar is the share of the time still ahead', () {
      final ticket = MkkmTicket(status: 'active', startDate: DateTime(2026, 10), endDate: DateTime(2026, 10, 11));
      expect(validityLeft(ticket, DateTime(2026, 10, 6)), closeTo(0.5, 0.01));
      expect(validityLeft(ticket, DateTime(2026, 10, 1, 0, 0, 1)), closeTo(1, 0.01));
      // Only while it runs.
      expect(validityLeft(ticket, DateTime(2026, 9, 30)), isNull);
      expect(validityLeft(ticket, DateTime(2026, 10, 12)), isNull);
      expect(validityLeft(running(status: 'pending'), noon), isNull);
    });

    test('the list puts first what can be shown, last what cannot be used here', () {
      final ranks = [
        listRankOf(running(assigned: true), noon),
        listRankOf(running(status: 'pending'), noon),
        listRankOf(starting(DateTime(2026, 10, 17), assigned: true), noon),
        listRankOf(running(canAssign: true), noon),
        listRankOf(starting(DateTime(2026, 10, 17), canAssign: true), noon),
        listRankOf(running(canAssign: false), noon),
        listRankOf(running(status: 'returned'), DateTime(2026, 11, 2)),
      ];
      expect(ranks, [0, 1, 2, 4, 4, 5, 6]);
    });
  });

  test('the product is the fare and the period from the dictionaries, never the server\'s name', () {
    const kinds = TicketKindListResponse(kinds: [TicketKind(code: 2, description: 'Normalny')]);
    const periods = TicketPeriodListResponse(list: [TicketPeriod(code: 1, description: 'Jeden miesiąc')]);
    const listed = MkkmTicket(ticketKindCode: 2, ticketPeriodCode: 1);

    expect(ticketProduct(listed, kinds: kinds, periods: periods), 'Normalny · Jeden miesiąc');
    expect(ticketProduct(listed, kinds: kinds), 'Normalny');
    expect(ticketProduct(listed), isNull);
    expect(ticketProduct(const MkkmTicket(ticketKindCode: 9), kinds: kinds, periods: periods), isNull);
    // The same in the list and in the details, which alone come with a name.
    final named = listed.copyWith(productName: 'Bilet norm. 1-mies. sieciowy');
    expect(ticketProduct(named, kinds: kinds, periods: periods), 'Normalny · Jeden miesiąc');
    expect(ticketProduct(named), isNull);
    expect(ticketFare(listed, kinds), 'Normalny');
    expect(ticketPeriod(listed, periods), 'Jeden miesiąc');
  });

  test('a price is written the Polish way in every language', () {
    expect(formatPrice(99), '99,00\u00a0zł');
    expect(formatPrice(49.5), '49,50\u00a0zł');
  });

  test('the short range is the two days alone', () {
    final start = DateTime(2026, 10);
    final end = DateTime(2026, 10, 31, 23, 59);
    expect(formatShortRange('en', start, end), 'Oct 1 – Oct 31');
    expect(formatShortRange('en', null, end), 'Oct 31');
    expect(formatShortRange('en', null, null), isEmpty);
  });
}
