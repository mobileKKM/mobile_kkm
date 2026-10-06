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
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The user's mobile tickets and, in a second list, the purchase history.
class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  bool _past = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navTickets)),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: false, label: Text(l10n.ticketsActive)),
                ButtonSegment(value: true, label: Text(l10n.ticketsPast)),
              ],
              selected: {_past},
              onSelectionChanged: (selection) => setState(() => _past = selection.single),
            ),
          ),
          const AppStatusBanner(padding: EdgeInsets.fromLTRB(16, 0, 16, 8)),
          Expanded(child: _past ? const _PastTickets() : const _ActiveTickets()),
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
    final phase = phaseOf(ticket, DateTime.now());
    return TicketCard(
      title: ticketTitle(l10n, ticket),
      start: ticket.startDate,
      end: ticket.endDate,
      price: ticket.price,
      statusLabel: phaseLabel(l10n, phase, ticket),
      tone: toneOf(phase),
      pinned: stored.pinned,
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

class _PastTickets extends ConsumerWidget {
  const _PastTickets();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(pastTicketsProvider);

    final Widget content = switch (history) {
      AsyncValue(value: final entries?) when entries.isNotEmpty => ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: _listPadding,
        itemCount: entries.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _PastTicketCard(entries[index]),
      ),
      AsyncValue(hasValue: true) => _Placeholder(child: Text(l10n.ticketsEmptyPast)),
      AsyncError(:final error) => _Placeholder(
        child: LoadProblem(message: describeError(l10n, error), onRetry: () => ref.invalidate(pastTicketsProvider)),
      ),
      _ => const _Placeholder(child: CircularProgressIndicator()),
    };
    return RefreshIndicator(
      // A failure shows in the list's place, not here.
      onRefresh: () => ref.refresh(pastTicketsProvider.future).then<void>((_) {}, onError: (_) {}),
      child: content,
    );
  }
}

class _PastTicketCard extends StatelessWidget {
  const _PastTicketCard(this.entry);

  final TicketHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final name = entry.productName;
    return TicketCard(
      title: name == null || name.isEmpty ? AppLocalizations.of(context).ticketTitleGeneric : name,
      start: entry.ticketStartDate,
      end: entry.ticketExpiryDate,
      price: entry.price,
      // The server's own wording (Polish only), like its error messages.
      note: entry.transactionStateDescription,
    );
  }
}
