import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/features/tickets/models/stored_ticket.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/widgets/mkkm_ticket_card.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The user's mobile tickets and, in a second list, the purchase history.
class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  // Keeps the buttons' state (and their animation) when the app bar starts over.
  final _segmentsKey = GlobalKey();
  bool _past = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        // Its "scrolled under" tint only follows scrolling, and each list starts at the top: start over with the list.
        key: ValueKey(_past),
        title: Text(l10n.navTickets),
        // Part of the bar, so that it takes the bar's tint when a list scrolls under it.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<bool>(
                key: _segmentsKey,
                segments: [
                  ButtonSegment(value: false, label: Text(l10n.ticketsActive)),
                  ButtonSegment(value: true, label: Text(l10n.ticketsHistory)),
                ],
                selected: {_past},
                onSelectionChanged: (selection) => setState(() => _past = selection.single),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'buy-ticket',
        // A pill, like the app's other buttons.
        shape: const StadiumBorder(),
        onPressed: () => context.push(Routes.buy),
        icon: const Icon(Symbols.add_shopping_cart_rounded),
        label: Text(l10n.navBuy),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppStatusBanner(padding: EdgeInsets.fromLTRB(16, 8, 16, 0)),
          Expanded(child: _past ? const _TicketHistory() : const _ActiveTickets()),
        ],
      ),
    );
  }
}

// The bottom leaves room for the floating button.
const _listPadding = EdgeInsets.fromLTRB(16, 8, 16, 96);

/// Something other than tickets in a list's place. Scrollable, so that
/// pulling to refresh works on it too.
class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 96, 24, 24),
      children: [Center(child: child)],
    );
  }
}

class _ActiveTickets extends ConsumerWidget {
  const _ActiveTickets();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tickets = ref.watch(mkkmTicketsProvider).value;
    final sync = ref.watch(ticketSyncProvider);
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));

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
      content = _Placeholder(
        child: LoadProblem(
          message: sync.error == null ? l10n.ticketsLoadError : describeError(l10n, sync.error!),
          onRetry: () => unawaited(ref.read(ticketSyncProvider.notifier).refresh()),
        ),
      );
    } else if (!online) {
      // No list is asked for while the service is away; the banner says why.
      content = _Placeholder(
        child: LoadProblem(
          message: l10n.ticketsLoadError,
          onRetry: () => unawaited(ref.read(ticketSyncProvider.notifier).refresh()),
        ),
      );
    } else if (tickets == null || sync.lastSyncedAt == null) {
      // Nothing stored and the first sync has not come back yet.
      content = const _Placeholder(child: CircularProgressIndicator());
    } else {
      content = _Placeholder(child: Text(l10n.ticketsEmptyActive));
    }
    return RefreshIndicator(onRefresh: ref.read(ticketSyncProvider.notifier).refresh, child: content);
  }
}

class _ActiveTicketCard extends ConsumerWidget {
  const _ActiveTicketCard(this.stored);

  final StoredTicket stored;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final ticket = stored.ticket;
    final code = ticket.transactionCode;
    return MkkmTicketCard(
      ticket,
      pinned: stored.pinned,
      onTap: code == null ? null : () => context.push(Routes.ticket(code)),
      trailing: PopupMenuButton<bool>(
        tooltip: l10n.ticketOptions,
        icon: const Icon(Symbols.more_vert_rounded),
        onSelected: (pin) => unawaited(ref.read(ticketsDaoProvider).setPinned(pin ? ticket.ticketGuid : null)),
        itemBuilder: (context) => [
          PopupMenuItem(value: !stored.pinned, child: Text(stored.pinned ? l10n.ticketUnpin : l10n.ticketPin)),
        ],
      ),
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
      AsyncValue(value: final entries?) when entries.isNotEmpty => ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: _listPadding,
        itemCount: entries.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _HistoryCard(entries[index]),
      ),
      AsyncValue(hasValue: true) => _Placeholder(child: Text(l10n.ticketsEmptyHistory)),
      AsyncError(:final error) => _Placeholder(
        child: LoadProblem(message: describeError(l10n, error), onRetry: () => ref.invalidate(ticketHistoryProvider)),
      ),
      _ => const _Placeholder(child: CircularProgressIndicator()),
    };
    return RefreshIndicator(
      // A failure shows in the list's place, not here.
      onRefresh: () => ref.refresh(ticketHistoryProvider.future).then<void>((_) {}, onError: (_) {}),
      child: content,
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard(this.entry);

  final TicketHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final name = entry.productName;
    final code = entry.transactionCode;
    return TicketCard(
      title: name == null || name.isEmpty ? AppLocalizations.of(context).ticketTitleGeneric : name,
      start: entry.ticketStartDate,
      end: entry.ticketExpiryDate,
      price: entry.price,
      // The server's own wording (Polish only), like its error messages.
      note: entry.transactionStateDescription,
      onTap: code == null ? null : () => context.push(Routes.ticket(code)),
    );
  }
}
