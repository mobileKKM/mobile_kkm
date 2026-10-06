import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The home screen's ticket: the one the user pinned, or else the current
/// or next one. Without any, an invitation to buy.
class PinnedTicketCard extends ConsumerWidget {
  const PinnedTicketCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stored = ref.watch(homeTicketProvider);
    if (stored != null) {
      final ticket = stored.ticket;
      final phase = phaseOf(ticket, DateTime.now());
      return TicketCard(
        title: ticketTitle(l10n, ticket),
        start: ticket.startDate,
        end: ticket.endDate,
        price: ticket.price,
        statusLabel: phaseLabel(l10n, phase, ticket),
        tone: toneOf(phase),
        pinned: stored.pinned,
        onTap: () => context.go(Routes.tickets),
      );
    }

    final tickets = ref.watch(mkkmTicketsProvider).value;
    final sync = ref.watch(ticketSyncProvider);
    final nothingStored = tickets == null || tickets.isEmpty;
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));

    final Widget content;
    if (nothingStored && sync.status == TicketSyncStatus.failed) {
      content = LoadProblem(
        message: sync.error == null ? l10n.ticketsLoadError : describeError(l10n, sync.error!),
        onRetry: () => unawaited(ref.read(ticketSyncProvider.notifier).refresh()),
      );
    } else if (nothingStored && !online) {
      // No list is asked for while the service is away; the banner says why.
      content = LoadProblem(
        message: l10n.ticketsLoadError,
        onRetry: () => unawaited(ref.read(ticketSyncProvider.notifier).refresh()),
      );
    } else if (nothingStored && sync.lastSyncedAt == null) {
      // Nothing stored and the first sync has not come back yet.
      content = const Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator());
    } else {
      content = const _NoTicket();
    }
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: content),
      ),
    );
  }
}

class _NoTicket extends StatelessWidget {
  const _NoTicket();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Symbols.confirmation_number_rounded, size: 40, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(height: 12),
        Text(l10n.homeNoTicketTitle, textAlign: TextAlign.center, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          l10n.homeNoTicketBody,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        FilledButton.tonal(onPressed: () => context.push(Routes.buy), child: Text(l10n.navBuy)),
      ],
    );
  }
}
