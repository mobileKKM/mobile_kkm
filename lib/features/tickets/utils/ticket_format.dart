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
      // A return is dated: the ticket runs on until then, with its end moved
      // there, and is only over after that. One given back whole has no
      // time left between its ends.
      final start = ticket.startDate;
      final end = ticket.endDate;
      if (end == null || now.isAfter(end) || (start != null && !end.isAfter(start))) {
        return TicketPhase.returned;
      }
      return start != null && now.isBefore(start) ? TicketPhase.upcoming : TicketPhase.valid;
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

/// The fare a ticket was sold at, e.g. `Normalny`, from the ticket kind
/// dictionary (Polish only). Null until that is there.
String? ticketFare(MkkmTicket ticket, TicketKindListResponse? kinds) {
  for (final kind in kinds?.kinds ?? const <TicketKind>[]) {
    if (kind.code == ticket.ticketKindCode) {
      final description = kind.description;
      return description == null || description.isEmpty ? null : description;
    }
  }
  return null;
}

/// How long a ticket was sold for, e.g. `Jeden miesiąc`, from the period
/// dictionary (Polish only). Null until that is there.
String? ticketPeriod(MkkmTicket ticket, TicketPeriodListResponse? periods) {
  for (final period in periods?.list ?? const <TicketPeriod>[]) {
    if (period.code == ticket.ticketPeriodCode) {
      final description = period.description;
      return description == null || description.isEmpty ? null : description;
    }
  }
  return null;
}

/// The product behind a ticket, e.g. `Normalny · Jeden miesiąc`: its fare
/// and its period, both from their dictionaries. The server's `productName`
/// is not used: it only comes with a ticket's details, so a ticket would
/// read differently there than in the list. Null until a dictionary is there.
String? ticketProduct(MkkmTicket ticket, {TicketKindListResponse? kinds, TicketPeriodListResponse? periods}) {
  final parts = [?ticketFare(ticket, kinds), ?ticketPeriod(ticket, periods)];
  return parts.isEmpty ? null : parts.join(' · ');
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

String formatTime(String locale, DateTime date) => DateFormat.Hm(locale).format(date.toLocal());

/// `1 Sep 2025, 00:00 – 30 Sep 2025, 23:59`, or whichever end is known.
String formatValidity(String locale, DateTime? start, DateTime? end) =>
    [if (start != null) formatDateTime(locale, start), if (end != null) formatDateTime(locale, end)].join(' – ');

/// `Sep 1 – Sep 30`: the days only, for a line that has the rest elsewhere.
String formatShortRange(String locale, DateTime? start, DateTime? end) {
  final day = DateFormat.MMMd(locale);
  return [if (start != null) day.format(start.toLocal()), if (end != null) day.format(end.toLocal())].join(' – ');
}

/// `99.00 zł`: the amount first in every language, as the złoty is written.
String formatPrice(String locale, double price) =>
    '${NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 2).format(price)}\u00a0zł';

/// What a ticket's card says with its colour: what can be done with the
/// ticket on this phone. Its label says which phase it is in.
enum TicketTone {
  /// Can be shown on this phone now, or after one step.
  valid,

  /// Waiting on time or on the server.
  wait,

  /// A payment needs finishing.
  action,

  /// Not usable here: over, or held by other devices.
  over,
}

TicketTone toneOf(MkkmTicket ticket, DateTime now) {
  // Held by other devices, or not to be had on this one at all.
  final action = actionOf(ticket);
  final elsewhere = action == TicketAction.assignedElsewhere || action == TicketAction.none;
  return switch (phaseOf(ticket, now)) {
    TicketPhase.pending => TicketTone.action,
    TicketPhase.processing => TicketTone.wait,
    TicketPhase.upcoming => elsewhere ? TicketTone.over : TicketTone.wait,
    TicketPhase.valid => elsewhere ? TicketTone.over : TicketTone.valid,
    TicketPhase.returned || TicketPhase.expired || TicketPhase.unknown => TicketTone.over,
  };
}

/// How long a ticket still runs, or how long until it starts.
class TicketCountdown {
  const TicketCountdown({required this.days, required this.moment, required this.upcoming});

  /// Whole calendar days: for a running ticket today counts, so its last
  /// day is 1; for one that has not started, 0 means later today.
  final int days;

  /// The end of a running ticket, the start of an upcoming one.
  final DateTime moment;
  final bool upcoming;

  /// The day itself has come: said as "Today", not as a number.
  bool get isToday => upcoming ? days <= 0 : days <= 1;
}

/// Null for a ticket that is neither running nor about to, or whose dates
/// the server left out.
TicketCountdown? countdownOf(MkkmTicket ticket, DateTime now) {
  int daysBetween(DateTime from, DateTime to) {
    final a = from.toLocal();
    final b = to.toLocal();
    // By date, not by 24 hours: a day with a clock change is still one day.
    return DateTime.utc(b.year, b.month, b.day).difference(DateTime.utc(a.year, a.month, a.day)).inDays;
  }

  switch (phaseOf(ticket, now)) {
    case TicketPhase.valid:
      final end = ticket.endDate;
      return end == null ? null : TicketCountdown(days: daysBetween(now, end) + 1, moment: end, upcoming: false);
    case TicketPhase.upcoming:
      final start = ticket.startDate;
      return start == null ? null : TicketCountdown(days: daysBetween(now, start), moment: start, upcoming: true);
    case TicketPhase.pending ||
        TicketPhase.processing ||
        TicketPhase.returned ||
        TicketPhase.expired ||
        TicketPhase.unknown:
      return null;
  }
}

/// The share of a running ticket's time that is still ahead, 0 to 1. Null
/// unless it is running and both ends are known.
double? validityLeft(MkkmTicket ticket, DateTime now) {
  final start = ticket.startDate;
  final end = ticket.endDate;
  if (start == null || end == null || phaseOf(ticket, now) != TicketPhase.valid) {
    return null;
  }
  final whole = end.difference(start).inSeconds;
  return whole <= 0 ? 0 : (end.difference(now).inSeconds / whole).clamp(0, 1).toDouble();
}

/// The order of the Tickets list: what can be shown now, then what needs
/// paying, then what is waiting, then tickets not on this phone, and last
/// those that cannot be used here.
int listRankOf(MkkmTicket ticket, DateTime now) {
  final action = actionOf(ticket);
  if (action == TicketAction.assignedElsewhere) {
    return 5;
  }
  if (action == TicketAction.assign) {
    return 4;
  }
  return switch (phaseOf(ticket, now)) {
    TicketPhase.valid => 0,
    TicketPhase.pending => 1,
    TicketPhase.upcoming || TicketPhase.processing => 2,
    TicketPhase.returned || TicketPhase.expired || TicketPhase.unknown => 6,
  };
}
