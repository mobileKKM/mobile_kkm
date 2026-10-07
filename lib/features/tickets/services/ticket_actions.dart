import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

/// What can be done to a ticket straight from its card. The state is the
/// guids of the tickets with a call under way.
class TicketActionsController extends Notifier<Set<String>> {
  @override
  Set<String> build() => const {};

  /// `assign-e`: lets this device show the ticket's code. Throws
  /// [TicketActionFailure] when the server refuses.
  Future<void> assign(String ticketGuid) => _run(ticketGuid, () async {
    final response = await ref.read(ekpClientProvider).tickets.assign(ticketGuid);
    if (!(response.assigned ?? false)) {
      throw TicketActionFailure(response.message);
    }
    await _reload();
  });

  /// `payments/check`: whether a payment for the ticket has arrived.
  Future<PaymentCheckResult> checkPayment(String ticketGuid) => _run(ticketGuid, () async {
    final result = await ref.read(ekpClientProvider).payments.check(ticketGuid);
    if (result.status == PaymentCheckStatus.confirmed) {
      await _reload();
    }
    return result;
  });

  Future<T> _run<T>(String ticketGuid, Future<T> Function() call) async {
    state = {...state, ticketGuid};
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

final ticketActionsProvider = NotifierProvider<TicketActionsController, Set<String>>(TicketActionsController.new);
