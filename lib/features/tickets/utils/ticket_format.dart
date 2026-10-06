import 'package:ekp_api/ekp_api.dart';
import 'package:intl/intl.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Where a mobile ticket stands at a given moment.
enum TicketPhase { pending, returned, upcoming, valid, expired, unknown }

TicketPhase phaseOf(MkkmTicket ticket, DateTime now) {
  switch (ticket.statusEnum) {
    case MkkmTicketStatus.pending:
      return TicketPhase.pending;
    case MkkmTicketStatus.returned:
      return TicketPhase.returned;
    case MkkmTicketStatus.unknown:
      return TicketPhase.unknown;
    case MkkmTicketStatus.active:
      final start = ticket.startDate;
      final end = ticket.endDate;
      if (end != null && now.isAfter(end)) {
        return TicketPhase.expired;
      }
      if (start != null && now.isBefore(start)) {
        return TicketPhase.upcoming;
      }
      return TicketPhase.valid;
  }
}

/// The ticket the home screen shows unless the user pinned another: the one
/// valid now, otherwise the next one to start.
MkkmTicket? currentOrUpcoming(Iterable<MkkmTicket> tickets, DateTime now) {
  MkkmTicket? upcoming;
  for (final ticket in tickets) {
    switch (phaseOf(ticket, now)) {
      case TicketPhase.valid:
        return ticket;
      case TicketPhase.upcoming:
        final start = ticket.startDate;
        final best = upcoming?.startDate;
        if (upcoming == null || (start != null && best != null && start.isBefore(best))) {
          upcoming = ticket;
        }
      case TicketPhase.pending || TicketPhase.returned || TicketPhase.expired || TicketPhase.unknown:
        break;
    }
  }
  return upcoming;
}

/// The list response carries no product name, so the title says what the
/// ticket covers.
String ticketTitle(AppLocalizations l10n, MkkmTicket ticket) {
  final name = ticket.productName;
  if (name != null && name.isNotEmpty) {
    return name;
  }
  if (ticket.isMetropolitan ?? false) {
    return l10n.ticketTitleMetropolitan;
  }
  final lines = [for (final line in ticket.lines) ?line.line];
  if (lines.isNotEmpty) {
    return l10n.ticketTitleLines(lines.length, lines.join(', '));
  }
  if (ticket.isNetwork ?? false) {
    return l10n.ticketTitleNetwork;
  }
  return l10n.ticketTitleGeneric;
}

String phaseLabel(AppLocalizations l10n, TicketPhase phase, MkkmTicket ticket) {
  final start = ticket.startDate;
  return switch (phase) {
    TicketPhase.pending => l10n.ticketStatusPending,
    TicketPhase.returned => l10n.ticketStatusReturned,
    TicketPhase.upcoming when start != null => l10n.ticketStatusValidFrom(formatDate(l10n.localeName, start)),
    TicketPhase.upcoming => l10n.ticketStatusUpcoming,
    TicketPhase.valid => l10n.ticketStatusValid,
    TicketPhase.expired => l10n.ticketStatusExpired,
    TicketPhase.unknown => ticket.status ?? '',
  };
}

String formatDate(String locale, DateTime date) => DateFormat.yMMMd(locale).format(date.toLocal());

/// `1 Sep 2025 – 30 Sep 2025`, or whichever end is known.
String formatDateRange(String locale, DateTime? start, DateTime? end) =>
    [if (start != null) formatDate(locale, start), if (end != null) formatDate(locale, end)].join(' – ');

String formatPrice(String locale, double price) => NumberFormat.currency(locale: locale, symbol: 'zł').format(price);
