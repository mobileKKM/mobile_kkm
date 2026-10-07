import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

void main() {
  final now = DateTime.utc(2026, 6, 15, 12);
  MkkmTicket ticket(String status, int startDay, int endDay, {String? guid}) => MkkmTicket(
    ticketGuid: guid,
    status: status,
    startDate: DateTime.utc(2026, 6, startDay),
    endDate: DateTime.utc(2026, 6, endDay, 23, 59, 59),
  );

  test('phaseOf follows the status, then the validity window', () {
    expect(phaseOf(ticket('pending', 1, 30), now), TicketPhase.pending);
    expect(phaseOf(ticket('returned', 1, 30), now), TicketPhase.returned);
    expect(phaseOf(ticket('weird', 1, 30), now), TicketPhase.unknown);
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

    test('ignores unpaid, returned and expired tickets', () {
      expect(
        currentOrUpcoming([ticket('pending', 1, 30), ticket('returned', 1, 30), ticket('active', 1, 10)], now),
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
}
