import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/tickets/models/stored_ticket.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';

/// The stored mobile tickets. Reads the database only; `ticketSyncProvider`
/// is what brings it up to date.
final mkkmTicketsProvider = StreamProvider<List<StoredTicket>>((ref) => ref.watch(ticketsDaoProvider).watchAll());

/// The stored tickets in the order of the Tickets list; see [listRankOf].
final sortedTicketsProvider = Provider<List<StoredTicket>?>((ref) {
  final tickets = ref.watch(mkkmTicketsProvider).value;
  if (tickets == null) {
    return null;
  }
  final now = DateTime.now();
  final ranked = [for (final (index, stored) in tickets.indexed) (listRankOf(stored.ticket, now), index, stored)]
    // The stored order (earliest start first) within a rank.
    ..sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
  return [for (final (_, _, stored) in ranked) stored];
});

/// How many stored tickets still wait for their payment.
final pendingPaymentCountProvider = Provider<int>((ref) {
  final tickets = ref.watch(mkkmTicketsProvider).value ?? const <StoredTicket>[];
  final now = DateTime.now();
  return tickets.where((stored) => phaseOf(stored.ticket, now) == TicketPhase.pending).length;
});

/// When the stored tickets were last brought up to date, also across runs.
final ticketsSyncedAtProvider = StreamProvider<DateTime?>((ref) => ref.watch(ticketsDaoProvider).watchLastSyncedAt());

/// The ticket on the home screen: the user's pin while that ticket is still
/// of use, otherwise the current or the next one.
final homeTicketProvider = Provider<StoredTicket?>((ref) {
  // In the list's order, so that of two running tickets the one that can be
  // shown on this phone is taken before one that other devices hold.
  final tickets = ref.watch(sortedTicketsProvider) ?? const <StoredTicket>[];
  final now = DateTime.now();
  for (final stored in tickets) {
    final phase = phaseOf(stored.ticket, now);
    if (stored.pinned && phase != TicketPhase.expired && phase != TicketPhase.returned) {
      return stored;
    }
  }
  final automatic = currentOrUpcoming(tickets.map((stored) => stored.ticket), now);
  return automatic == null ? null : tickets.firstWhere((stored) => identical(stored.ticket, automatic));
});

/// `GET /tickets?validity=Past` — the purchase history. Not stored: it is
/// fetched whenever the list is opened.
final ticketHistoryProvider = FutureProvider.autoDispose<List<TicketHistoryEntry>>((ref) async {
  final customerCode = await ref.watch(userDataProvider.selectAsync((data) => data?.mkkmData?.customerCode));
  if (customerCode == null) {
    return const [];
  }
  return ref.watch(ekpClientProvider).tickets.history(customerCode, validity: TicketValidity.past);
}, retry: (_, _) => null);

/// `GET /tickets/{transactionCode}` — everything about one purchase. Fetched
/// whenever its screen is opened.
final ticketDetailProvider = FutureProvider.autoDispose.family<TicketDetailResponse, String>(
  (ref, transactionCode) => ref.watch(ekpClientProvider).tickets.detail(transactionCode),
  retry: (_, _) => null,
);
