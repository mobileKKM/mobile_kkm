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

/// The ticket on the home screen: the user's pin while that ticket is still
/// of use, otherwise the current or the next one.
final homeTicketProvider = Provider<StoredTicket?>((ref) {
  final tickets = ref.watch(mkkmTicketsProvider).value ?? const <StoredTicket>[];
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
final pastTicketsProvider = FutureProvider.autoDispose<List<TicketHistoryEntry>>((ref) async {
  final customerCode = await ref.watch(userDataProvider.selectAsync((data) => data?.mkkmData?.customerCode));
  if (customerCode == null) {
    return const [];
  }
  return ref.watch(ekpClientProvider).tickets.history(customerCode, validity: TicketValidity.past);
}, retry: (_, _) => null);
