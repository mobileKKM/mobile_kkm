import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_actions.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The buttons for what can be done with a mobile ticket next: show its
/// code, assign it to this device, or see to its payment.
class TicketActions extends ConsumerWidget {
  const TicketActions(this.ticket, {super.key});

  final MkkmTicket ticket;

  /// Whether there is any button to show for [ticket].
  static bool appliesTo(MkkmTicket ticket) =>
      ticket.ticketGuid != null &&
      switch (actionOf(ticket)) {
        TicketAction.control || TicketAction.processing || TicketAction.payment || TicketAction.assign => true,
        TicketAction.assignedElsewhere || TicketAction.none => false,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final guid = ticket.ticketGuid;
    if (guid == null) {
      return const SizedBox.shrink();
    }
    final busy = ref.watch(ticketActionsProvider.select((running) => running.contains(guid)));

    switch (actionOf(ticket)) {
      case TicketAction.control:
        return FilledButton.tonalIcon(
          onPressed: canControl(ticket, DateTime.now()) ? () => context.push(Routes.ticketControl(guid)) : null,
          icon: const Icon(Symbols.qr_code_2_rounded),
          label: Text(l10n.ticketActionControl),
        );
      case TicketAction.assign:
        return FilledButton.tonalIcon(
          onPressed: busy ? null : () => unawaited(_assign(context, ref, guid)),
          icon: busy ? const _Spinner() : const Icon(Symbols.add_link_rounded),
          label: Text(l10n.ticketActionAssign),
        );
      case TicketAction.processing:
        return FilledButton.tonalIcon(
          onPressed: null,
          icon: const Icon(Symbols.hourglass_top_rounded),
          label: Text(l10n.ticketStatusProcessing),
        );
      case TicketAction.payment:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                // The payment itself belongs to the purchase flow.
                onPressed: () => context.push(Routes.buy),
                child: Text(l10n.ticketActionContinuePayment, textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: busy ? null : () => unawaited(_checkPayment(context, ref, guid)),
                child: busy ? const _Spinner() : Text(l10n.ticketActionCheckPayment, textAlign: TextAlign.center),
              ),
            ),
          ],
        );
      case TicketAction.assignedElsewhere || TicketAction.none:
        return const SizedBox.shrink();
    }
  }

  Future<void> _assign(BuildContext context, WidgetRef ref, String guid) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    String message;
    try {
      await ref.read(ticketActionsProvider.notifier).assign(guid);
      message = l10n.ticketAssignDone;
    } on TicketActionFailure catch (failure) {
      // The server's own wording (Polish only), like its error messages.
      message = failure.message ?? l10n.ticketAssignError;
    } on EkpNetworkException catch (error) {
      message = describeError(l10n, error);
    } on Exception {
      // Also when the request could not be encrypted.
      message = l10n.ticketAssignError;
    }
    // Instead of an earlier answer, not after it.
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _checkPayment(BuildContext context, WidgetRef ref, String guid) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    String message;
    try {
      final result = await ref.read(ticketActionsProvider.notifier).checkPayment(guid);
      message = switch (result.status) {
        PaymentCheckStatus.confirmed => l10n.ticketPaymentConfirmed,
        PaymentCheckStatus.pending => result.message ?? l10n.ticketPaymentPending,
      };
    } on Exception catch (error) {
      message = describeError(l10n, error);
    }
    // Instead of an earlier answer, not after it.
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) =>
      const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2));
}
