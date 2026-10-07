import 'package:ekp_api/ekp_api.dart';
import 'package:intl/intl.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Where a mobile ticket stands at a given moment.
enum TicketPhase { pending, processing, returned, upcoming, valid, expired, unknown }

TicketPhase phaseOf(MkkmTicket ticket, DateTime now) {
  switch (ticket.statusEnum) {
    case MkkmTicketStatus.pending:
      return TicketPhase.pending;
    case MkkmTicketStatus.processing:
      return TicketPhase.processing;
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
      case TicketPhase.pending ||
          TicketPhase.processing ||
          TicketPhase.returned ||
          TicketPhase.expired ||
          TicketPhase.unknown:
        break;
    }
  }
  return upcoming;
}

/// What the user can do with a mobile ticket next.
enum TicketAction {
  /// Assigned to this device: its code can be shown to an inspector.
  control,

  /// A payment is being booked; nothing to do but wait.
  processing,

  /// Unpaid: pay, or ask whether a payment has arrived.
  payment,

  /// Paid and not yet assigned to this device.
  assign,

  /// Paid, but every device slot is taken by another device.
  assignedElsewhere,
  none,
}

/// The first match decides, in the official client's order.
TicketAction actionOf(MkkmTicket ticket) {
  if (ticket.assigned ?? false) {
    return TicketAction.control;
  }
  return switch (ticket.statusEnum) {
    MkkmTicketStatus.processing => TicketAction.processing,
    MkkmTicketStatus.pending => TicketAction.payment,
    _ when ticket.canAssign ?? false => TicketAction.assign,
    MkkmTicketStatus.active => TicketAction.assignedElsewhere,
    MkkmTicketStatus.returned || MkkmTicketStatus.unknown => TicketAction.none,
  };
}

/// The code can only be shown once the ticket has started.
bool canControl(MkkmTicket ticket, DateTime now) {
  final start = ticket.startDate;
  return (ticket.assigned ?? false) && (start == null || !now.isBefore(start));
}

/// `Strefa I` out of the dictionary's `Wszystkie linie - Strefa I` for the
/// ticket's line scope. Null until the dictionary is there.
String? ticketZone(int? lineScopeCode, TicketNumberOfLineListResponse? scopes) {
  if (lineScopeCode == null || scopes == null) {
    return null;
  }
  for (final scope in scopes.list) {
    if (scope.code == lineScopeCode) {
      final parts = (scope.description ?? '').split(' - ');
      return parts.length < 2 ? null : parts.last.trim();
    }
  }
  return null;
}

/// What the ticket covers: its lines or its network, and the zone when
/// [zone] is known.
String ticketScope(AppLocalizations l10n, MkkmTicket ticket, {String? zone}) {
  final lines = [for (final line in ticket.lines) ?line.line];
  final String scope;
  if (ticket.isMetropolitan ?? false) {
    scope = l10n.ticketTitleMetropolitan;
  } else if (lines.isNotEmpty) {
    scope = l10n.ticketTitleLines(lines.length, lines.join(', '));
  } else if (ticket.isNetwork ?? false) {
    scope = l10n.ticketTitleNetwork;
  } else {
    scope = l10n.ticketTitleGeneric;
  }
  return zone == null || zone.isEmpty ? scope : '$scope · $zone';
}

/// A ticket for tram lines only gets the tram.
bool isTramTicket(MkkmTicket ticket) => ticket.lines.isNotEmpty && ticket.lines.every((line) => line.isTram ?? false);

String phaseLabel(AppLocalizations l10n, TicketPhase phase, MkkmTicket ticket) {
  final start = ticket.startDate;
  return switch (phase) {
    TicketPhase.pending => l10n.ticketStatusPending,
    TicketPhase.processing => l10n.ticketStatusProcessing,
    TicketPhase.returned => l10n.ticketStatusReturned,
    TicketPhase.upcoming when start != null => l10n.ticketStatusValidFrom(formatDate(l10n.localeName, start)),
    TicketPhase.upcoming => l10n.ticketStatusUpcoming,
    TicketPhase.valid => l10n.ticketStatusValid,
    TicketPhase.expired => l10n.ticketStatusExpired,
    TicketPhase.unknown => ticket.status ?? '',
  };
}

String formatDate(String locale, DateTime date) => DateFormat.yMMMd(locale).format(date.toLocal());

String formatDateTime(String locale, DateTime date) => DateFormat.yMMMd(locale).add_Hm().format(date.toLocal());

/// `1 Sep 2025, 00:00 – 30 Sep 2025, 23:59`, or whichever end is known.
String formatValidity(String locale, DateTime? start, DateTime? end) =>
    [if (start != null) formatDateTime(locale, start), if (end != null) formatDateTime(locale, end)].join(' – ');

String formatPrice(String locale, double price) => NumberFormat.currency(locale: locale, symbol: 'zł').format(price);
