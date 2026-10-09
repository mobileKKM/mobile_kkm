import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/empty_state_card.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/mkkm_ticket_card.dart';
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
      final action = actionOf(stored.ticket);
      return MkkmTicketCard(
        stored.ticket,
        // In full colour only while it can be shown: this is the one place
        // where the ticket is the screen's subject.
        calm: toneOf(stored.ticket, DateTime.now()) != TicketTone.valid,
        pinned: stored.pinned,
        // Here only the way to the code; the rest is on the Tickets screen.
        showActions: action == TicketAction.control || action == TicketAction.assignedElsewhere,
        onTap: () => context.go(Routes.tickets),
      );
    }

    final tickets = ref.watch(mkkmTicketsProvider).value;
    final sync = ref.watch(ticketSyncProvider);
    final nothingStored = tickets == null || tickets.isEmpty;
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));
    void retry() => unawaited(ref.read(ticketSyncProvider.notifier).refresh());

    if (nothingStored && sync.status == TicketSyncStatus.failed) {
      return _Failed(
        message: sync.error == null ? l10n.ticketsLoadError : describeError(l10n, sync.error!),
        onRetry: retry,
      );
    }
    if (nothingStored && !online) {
      // No list is asked for while the service is away; the banner says why.
      return _Failed(message: l10n.ticketsLoadError, onRetry: retry);
    }
    if (nothingStored && sync.lastSyncedAt == null) {
      // Nothing stored and the first sync has not come back yet.
      return const _Loading();
    }
    return EmptyStateCard(
      icon: Symbols.confirmation_number_rounded,
      title: l10n.homeNoTicketTitle,
      body: l10n.homeNoTicketBody,
      actionIcon: Symbols.add_shopping_cart_rounded,
      actionLabel: l10n.navBuy,
      onAction: () => context.push(Routes.buy),
    );
  }
}

class _Failed extends StatelessWidget {
  const _Failed({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => EmptyStateCard(
    icon: Symbols.cloud_off_rounded,
    title: message,
    actionIcon: Symbols.refresh_rounded,
    actionLabel: AppLocalizations.of(context).retry,
    onAction: onRetry,
    tonal: true,
  );
}

/// The outline of a ticket card while the first list is on its way.
class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: MaterialLocalizations.of(context).refreshIndicatorSemanticLabel,
      child: Material(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 340,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(minHeight: 4, backgroundColor: Colors.transparent, color: scheme.primary),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SkeletonBox(width: 44, height: 44, radius: 16),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [SkeletonBox(width: 180, height: 14), SkeletonBox(width: 130, height: 12)],
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      SkeletonBox(width: 90, height: 32, radius: 10),
                      SizedBox(height: 14),
                      SkeletonBox(width: 200, height: 52, radius: 14),
                      SizedBox(height: 14),
                      SkeletonBox(height: 10),
                      Spacer(),
                      SkeletonBox(height: 56),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
