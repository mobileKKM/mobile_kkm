import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/aztec_key_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';

/// The server answered, and said no. [message] is its own wording, if any.
class TicketActionFailure implements Exception {
  const TicketActionFailure([this.message]);

  final String? message;

  @override
  String toString() => 'TicketActionFailure: $message';
}

/// A card's call under way.
enum TicketBusy { assign, checkPayment, openPayment }

/// What can be done to a ticket straight from its card. The state is the
/// call under way for each ticket, by guid.
class TicketActionsController extends Notifier<Map<String, TicketBusy>> {
  @override
  Map<String, TicketBusy> build() => const {};

  /// `assign-e`: lets this device show the ticket's code. Throws
  /// [TicketActionFailure] when the server refuses.
  Future<void> assign(String ticketGuid) => _run(ticketGuid, TicketBusy.assign, () async {
    final response = await ref
        .read(aztecKeyProvider.notifier)
        .guard(
          () => ref.read(ekpClientProvider).tickets.assign(ticketGuid),
          refused: (response) => !(response.assigned ?? false),
        );
    if (!(response.assigned ?? false)) {
      throw TicketActionFailure(response.message);
    }
    await _reload();
  });

  /// `payments/check`: whether a payment for the ticket has arrived.
  Future<PaymentCheckResult> checkPayment(String ticketGuid) => _run(ticketGuid, TicketBusy.checkPayment, () async {
    final result = await ref.read(ekpClientProvider).payments.check(ticketGuid);
    if (result.status == PaymentCheckStatus.confirmed) {
      await _reload();
    }
    return result;
  });

  /// The ticket's details, which Pay for ticket needs before it opens
  /// (the product name): the open details' copy, else fetched.
  Future<TicketDetailResponse> detailsForPayment(String ticketGuid, String transactionCode) =>
      _run(ticketGuid, TicketBusy.openPayment, () async {
        // Listened to, as the provider is dropped once no one is.
        final details = ref.listen(ticketDetailProvider(transactionCode).future, (_, _) {});
        try {
          return await details.read();
        } finally {
          details.close();
        }
      });

  Future<T> _run<T>(String ticketGuid, TicketBusy busy, Future<T> Function() call) async {
    state = {...state, ticketGuid: busy};
    try {
      return await call();
    } finally {
      if (ref.mounted) {
        state = {...state}..remove(ticketGuid);
      }
    }
  }

  /// The ticket has changed on the server: fetch the list and any open
  /// details again.
  Future<void> _reload() async {
    ref.invalidate(ticketDetailProvider);
    await ref.read(ticketSyncProvider.notifier).refresh();
  }
}

final ticketActionsProvider = NotifierProvider<TicketActionsController, Map<String, TicketBusy>>(
  TicketActionsController.new,
);
