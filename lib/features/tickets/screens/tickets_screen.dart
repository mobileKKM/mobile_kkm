import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/app_snack_bar.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/empty_state_card.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';
import 'package:mobile_kkm/features/purchase/widgets/purchase_notices.dart';
import 'package:mobile_kkm/features/tickets/models/stored_ticket.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/mkkm_ticket_card.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_skeletons.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The user's mobile tickets and, in a second list, the purchase history.
class TicketsScreen extends ConsumerStatefulWidget {
  const TicketsScreen({super.key});

  @override
  ConsumerState<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends ConsumerState<TicketsScreen> {
  bool _past = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Without tickets the way to buy one is in the list's place, not over it.
    final hasTickets = ref.watch(mkkmTicketsProvider.select((tickets) => tickets.value?.isNotEmpty ?? false));
    // A messenger of its own: this screen's snackbars then belong to its
    // scaffold, which lifts the floating button over them, and not to the
    // shell's, which would draw them across it.
    return ScaffoldMessenger(
      child: PurchaseNotices(
        child: Scaffold(
          appBar: AppBar(
            // Its "scrolled under" tint only follows scrolling, and each list starts at the top: start over with the list.
            key: ValueKey(_past),
            title: Text(l10n.navTickets),
            // Part of the bar, so that it takes the bar's tint when a list scrolls under it.
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                // Material's own button: 40 high in a touch target of 48.
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: SegmentedButton<bool>(
                  expandedInsets: EdgeInsets.zero,
                  selectedIcon: const Icon(Symbols.check_rounded, size: 18),
                  segments: [
                    ButtonSegment(value: false, label: Text(l10n.ticketsActive)),
                    ButtonSegment(value: true, label: Text(l10n.ticketsHistory)),
                  ],
                  selected: {_past},
                  onSelectionChanged: (selection) => setState(() => _past = selection.first),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _past || hasTickets
              ? FloatingActionButton.extended(
                  heroTag: 'buy-ticket',
                  onPressed: () => context.push(Routes.buy),
                  icon: const Icon(Symbols.add_shopping_cart_rounded),
                  label: Text(l10n.navBuy),
                )
              : null,
          body: _past ? const _TicketHistory() : const _ActiveTickets(),
        ),
      ),
    );
  }
}

/// A list with the offline strip held over it: the list scrolls under the
/// strip, and both are inside the refresh indicator, which so comes down
/// from the app bar and not from under the strip.
class _UnderStatus extends StatelessWidget {
  const _UnderStatus({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const AppStatusBanner(padding: EdgeInsets.fromLTRB(16, 4, 16, 8)),
      Expanded(child: child),
    ],
  );
}

// The bottom leaves room for the floating button.
const _listPadding = EdgeInsets.fromLTRB(16, 4, 16, 96);

/// Something other than tickets in a list's place. Scrollable, so that
/// pulling to refresh works on it too.
class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.child, this.fill = false});

  final Widget child;

  /// Across the list's width, for a card; otherwise centred further down.
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: fill ? const EdgeInsets.fromLTRB(16, 28, 16, 24) : const EdgeInsets.fromLTRB(24, 96, 24, 24),
      children: [fill ? child : Center(child: child)],
    );
  }
}

/// The shapes of a list that is loading for the first time, where the list
/// will be, so that nothing jumps when it arrives.
class _Loading extends StatelessWidget {
  const _Loading({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: _listPadding,
      children: [SkeletonPulse(label: AppLocalizations.of(context).ticketsLoading, child: child)],
    );
  }
}

class _ActiveTickets extends ConsumerWidget {
  const _ActiveTickets();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tickets = ref.watch(sortedTicketsProvider);
    final sync = ref.watch(ticketSyncProvider);
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));
    void retry() => unawaited(ref.read(ticketSyncProvider.notifier).refresh());

    Widget failed(String message) => _Placeholder(
      fill: true,
      child: EmptyStateCard(
        icon: Symbols.cloud_off_rounded,
        title: message,
        actionIcon: Symbols.refresh_rounded,
        actionLabel: l10n.retry,
        onAction: retry,
        tonal: true,
      ),
    );

    final Widget content;
    if (tickets != null && tickets.isNotEmpty) {
      content = ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: _listPadding,
        itemCount: tickets.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _ActiveTicketCard(tickets[index]),
      );
    } else if (sync.status == TicketSyncStatus.failed) {
      content = failed(sync.error == null ? l10n.ticketsLoadError : describeError(l10n, sync.error!));
    } else if (!online) {
      // No list is asked for while the service is away; the banner says why.
      content = failed(l10n.ticketsLoadError);
    } else if (tickets == null || sync.lastSyncedAt == null) {
      // Nothing stored and the first sync has not come back yet.
      content = const _Loading(child: Column(spacing: 12, children: [TicketCardSkeleton(), TicketCardSkeleton()]));
    } else {
      content = _Placeholder(
        fill: true,
        child: EmptyStateCard(
          icon: Symbols.confirmation_number_rounded,
          title: l10n.ticketsEmptyActive,
          body: l10n.ticketsEmptyBody,
          actionIcon: Symbols.add_shopping_cart_rounded,
          actionLabel: l10n.navBuy,
          onAction: () => context.push(Routes.buy),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: ref.read(ticketSyncProvider.notifier).refresh,
      child: _UnderStatus(child: content),
    );
  }
}

class _ActiveTicketCard extends StatelessWidget {
  const _ActiveTicketCard(this.stored);

  final StoredTicket stored;

  @override
  Widget build(BuildContext context) {
    final ticket = stored.ticket;
    final code = ticket.transactionCode;
    final guid = ticket.ticketGuid;
    // Only a running or coming ticket that this phone can show, or could
    // once assigned, has a place on the home screen: not one that is unpaid,
    // over, or held by other devices.
    final now = DateTime.now();
    final phase = phaseOf(ticket, now);
    final canPin =
        guid != null &&
        (phase == TicketPhase.valid || phase == TicketPhase.upcoming) &&
        toneOf(ticket, now) != TicketTone.over;
    return MkkmTicketCard(
      ticket,
      pinned: stored.pinned,
      onTap: code == null ? null : () => context.push(Routes.ticket(code)),
      trailing: canPin ? _PinToggle(guid: guid, pinned: stored.pinned) : null,
    );
  }
}

/// Puts a ticket on the home screen, in place of any other, or takes it off.
class _PinToggle extends ConsumerWidget {
  const _PinToggle({required this.guid, required this.pinned});

  final String guid;
  final bool pinned;

  Future<void> _toggle(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await ref.read(ticketsDaoProvider).setPinned(pinned ? null : guid);
    showAppSnackBar(messenger, pinned ? l10n.ticketUnpinDone : l10n.ticketPinDone);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = TicketCardColors.of(context);
    return IconButton(
      tooltip: pinned ? l10n.ticketUnpin : l10n.ticketPin,
      isSelected: pinned,
      color: palette.medium,
      icon: const Icon(Symbols.keep_rounded),
      selectedIcon: Icon(Symbols.keep_rounded, fill: 1, color: palette.high),
      onPressed: () => unawaited(_toggle(context, ref)),
    );
  }
}

class _TicketHistory extends ConsumerWidget {
  const _TicketHistory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(ticketHistoryProvider);

    final Widget content = switch (history) {
      AsyncValue(value: final entries?) when entries.isNotEmpty => _HistoryList(entries),
      AsyncValue(hasValue: true) => _Placeholder(child: Text(l10n.ticketsEmptyHistory)),
      AsyncError(:final error) => _Placeholder(
        fill: true,
        child: EmptyStateCard(
          icon: Symbols.cloud_off_rounded,
          title: describeError(l10n, error),
          actionIcon: Symbols.refresh_rounded,
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(ticketHistoryProvider),
          tonal: true,
        ),
      ),
      _ => const _Loading(child: TicketHistorySkeleton()),
    };
    return RefreshIndicator(
      // A failure shows in the list's place, not here.
      onRefresh: () => ref.refresh(ticketHistoryProvider.future).then<void>((_) {}, onError: (_) {}),
      child: _UnderStatus(child: content),
    );
  }
}

/// The purchases by the month their ticket started in. These are receipts,
/// not tickets to show, so they get rows rather than cards.
class _HistoryList extends StatelessWidget {
  const _HistoryList(this.entries);

  final List<TicketHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = AppLocalizations.of(context).localeName;
    final month = DateFormat.yMMMM(locale);

    // The server's order is kept, between the months and inside them.
    final groups = <(String, List<TicketHistoryEntry>)>[];
    for (final entry in entries) {
      final start = entry.ticketStartDate ?? entry.transactionDate;
      final title = start == null ? '' : month.format(start.toLocal());
      if (groups.isEmpty || groups.last.$1 != title) {
        groups.add((title, []));
      }
      groups.last.$2.add(entry);
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: _listPadding,
      itemCount: groups.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final (title, rows) = groups[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 6, 4, 8),
                child: Semantics(
                  header: true,
                  child: Text(
                    title,
                    style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ),
            RowGroup(children: [for (final entry in rows) _HistoryRow(entry)]),
          ],
        );
      },
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow(this.entry);

  final TicketHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = l10n.localeName;
    final name = entry.productName;
    final code = entry.transactionCode;
    final start = entry.ticketStartDate;
    final end = entry.ticketExpiryDate;
    final price = entry.price;
    // What became of the purchase, in a word. The server's own description
    // is a sentence; it stands in only for a state this app has no word for.
    final purchase = purchaseStateOf(entry);
    final state = switch (purchase) {
      PurchaseState.completed => l10n.ticketHistoryStateCompleted,
      PurchaseState.cancelled => l10n.ticketHistoryStateCancelled,
      PurchaseState.other => entry.transactionStateDescription,
    };
    final range = [
      if (start != null) DateFormat.MMMd(locale).format(start.toLocal()),
      if (end != null) formatDate(locale, end),
    ].join(' – ');
    final quiet = theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant);

    return GroupRow(
      leading: IconTile(
        switch (purchase) {
          PurchaseState.cancelled => Symbols.block_rounded,
          PurchaseState.completed || PurchaseState.other => Symbols.confirmation_number_rounded,
        },
        size: 40,
        foreground: scheme.onSurfaceVariant,
      ),
      label: name == null || name.isEmpty ? l10n.ticketTitleGeneric : name,
      subtitle: range.isEmpty ? null : range,
      smallLabel: true,
      showChevron: false,
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 128),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 2,
          children: [
            if (price != null)
              Text(
                formatPrice(price),
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 15,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            if (state != null && state.isNotEmpty)
              Text(state, textAlign: TextAlign.end, maxLines: 2, overflow: TextOverflow.ellipsis, style: quiet),
          ],
        ),
      ),
      onTap: code == null ? null : () => context.push(Routes.ticket(code)),
    );
  }
}
