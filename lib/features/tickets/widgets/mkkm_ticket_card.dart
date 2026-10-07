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
    this.pinned = false,
    this.trailing,
    this.onTap,
    this.showActions = true,
  });

  final MkkmTicket ticket;
  final bool pinned;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showActions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // The zone's name comes from a dictionary; the card does without it
    // until that is there.
    final zone = ticketZone(ticket.ticketNumberOfLineCode, ref.watch(ticketLineScopesProvider).value);
    final phase = phaseOf(ticket, DateTime.now());
    final name = ticket.productName;
    return TicketCard(
      title: ticketScope(l10n, ticket, zone: zone),
      subtitle: name == null || name.isEmpty ? null : name,
      icon: isTramTicket(ticket) ? Symbols.tram_rounded : Symbols.directions_bus_rounded,
      start: ticket.startDate,
      end: ticket.endDate,
      price: ticket.price,
      statusLabel: phaseLabel(l10n, phase, ticket),
      tone: toneOf(phase),
      note: actionOf(ticket) == TicketAction.assignedElsewhere ? l10n.ticketStatusAssignedElsewhere : null,
      pinned: pinned,
      trailing: trailing,
      actions: showActions && TicketActions.appliesTo(ticket) ? TicketActions(ticket) : null,
      onTap: onTap,
    );
  }
}
