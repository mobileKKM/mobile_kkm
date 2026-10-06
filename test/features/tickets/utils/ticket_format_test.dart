import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';

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
}
