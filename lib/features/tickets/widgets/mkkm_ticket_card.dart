import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_actions.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// A mobile ticket as a [TicketCard], with its state and its buttons.
class MkkmTicketCard extends ConsumerWidget {
  const MkkmTicketCard(
    this.ticket, {
    super.key,
    this.calm = true,
    this.cancelled = false,
    this.pinned = false,
    this.trailing,
    this.onTap,
    this.showActions = true,
  });

  final MkkmTicket ticket;

  /// A neutral card; see [TicketCard.calm].
  final bool calm;

  /// The purchase was cancelled for want of a payment. The ticket itself
  /// cannot say so (the mobile list drops such a ticket), only the details
  /// of its purchase.
  final bool cancelled;

  /// Marks the ticket the user pinned to the home screen, unless [trailing]
  /// says so itself.
  final bool pinned;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showActions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = l10n.localeName;
    // The zone's name comes from a dictionary; the card does without it
    // until that is there.
    final zone = ticketZone(ticket.ticketNumberOfLineCode, ref.watch(ticketLineScopesProvider).value);
    final now = DateTime.now();
    final phase = cancelled ? TicketPhase.cancelled : phaseOf(ticket, now);
    final tone = cancelled ? TicketTone.over : toneOf(ticket, now);
    final countdown = cancelled ? null : countdownOf(ticket, now);
    // Likewise the product: its fare and its period.
    final kinds = ref.watch(ticketKindsProvider);
    final periods = ref.watch(ticketPeriodsProvider);
    final product = ticketProduct(ticket, kinds: kinds.value, periods: periods.value);
    // Only a first start waits for the dictionaries, and then for both, so
    // that the line comes whole. One that could not be loaded leaves its
    // part out.
    final productLoading =
        !kinds.hasError &&
        !periods.hasError &&
        ((kinds.isLoading && !kinds.hasValue) || (periods.isLoading && !periods.hasValue));
    final price = ticket.price;

    final TicketHero? hero;
    if (countdown == null) {
      hero = null;
    } else if (countdown.isToday) {
      final time = formatTime(locale, countdown.moment);
      hero = TicketHero(
        big: l10n.ticketToday,
        unit: countdown.upcoming ? l10n.ticketStartsAt(time) : l10n.ticketEndsAt(time),
      );
    } else {
      final moment = formatDateTime(locale, countdown.moment);
      hero = TicketHero(
        big: '${countdown.days}',
        unit: countdown.upcoming ? l10n.ticketDaysUntilStart(countdown.days) : l10n.ticketDaysLeft(countdown.days),
        sub: countdown.upcoming ? l10n.ticketFrom(moment) : l10n.ticketUntil(moment),
      );
    }

    return TicketCard(
      title: ticketScope(l10n, ticket, zone: zone),
      subtitle: productLoading ? null : product,
      subtitleLoading: productLoading,
      icon: isTramTicket(ticket) ? Symbols.tram_rounded : Symbols.directions_bus_rounded,
      tone: tone,
      calm: calm,
      pill: TicketPill(phaseLabel(l10n, phase, ticket), _pillIcon(phase), switch (phase) {
        TicketPhase.valid => tone == TicketTone.valid ? TicketPillKind.validOnTone : TicketPillKind.valid,
        TicketPhase.pending => TicketPillKind.emphasis,
        _ => TicketPillKind.plain,
      }),
      hero: hero,
      range: hero == null ? formatValidity(locale, ticket.startDate, ticket.endDate) : null,
      left: cancelled ? null : validityLeft(ticket, now),
      meta: hero == null ? null : formatShortRange(locale, ticket.startDate, ticket.endDate),
      price: price == null ? null : formatPrice(price),
      trailing: trailing ?? (pinned ? const PinnedMark() : null),
      stub: cancelled
          ? TicketNote(Symbols.block_rounded, l10n.ticketCancelledNote)
          : showActions && TicketActions.appliesTo(ticket)
          ? TicketActions(ticket)
          : null,
      onTap: onTap,
    );
  }

  static IconData _pillIcon(TicketPhase phase) => switch (phase) {
    TicketPhase.valid => Symbols.check_circle_rounded,
    TicketPhase.upcoming => Symbols.event_upcoming_rounded,
    TicketPhase.pending => Symbols.payments_rounded,
    TicketPhase.processing => Symbols.hourglass_top_rounded,
    TicketPhase.returned => Symbols.undo_rounded,
    TicketPhase.cancelled => Symbols.block_rounded,
    TicketPhase.expired => Symbols.event_busy_rounded,
    TicketPhase.unknown => Symbols.info_rounded,
  };
}

/// Says that a card's ticket is the one on the home screen, where that
/// cannot be changed.
class PinnedMark extends StatelessWidget {
  const PinnedMark({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 32,
    height: 48,
    child: Icon(
      Symbols.keep_rounded,
      size: 20,
      fill: 1,
      color: TicketCardColors.of(context).high,
      semanticLabel: AppLocalizations.of(context).ticketPinned,
    ),
  );
}
