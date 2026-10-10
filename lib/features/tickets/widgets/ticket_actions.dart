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
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The stub of a mobile ticket's card: what can be done with the ticket
/// next (show its code, assign it to this device, see to its payment), or
/// why nothing can.
class TicketActions extends ConsumerWidget {
  const TicketActions(this.ticket, {super.key});

  final MkkmTicket ticket;

  /// Whether there is anything to put on the stub of [ticket]'s card.
  static bool appliesTo(MkkmTicket ticket) =>
      ticket.ticketGuid != null &&
      switch (actionOf(ticket)) {
        TicketAction.control || TicketAction.payment || TicketAction.assign || TicketAction.assignedElsewhere => true,
        // Nothing to do but wait; the card's label says so.
        TicketAction.processing || TicketAction.none => false,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = TicketCardColors.of(context);
    final guid = ticket.ticketGuid;
    if (guid == null) {
      return const SizedBox.shrink();
    }
    final busy = ref.watch(ticketActionsProvider.select((running) => running.contains(guid)));
    final now = DateTime.now();
    final start = ticket.startDate;
    final startsLater = start != null && now.isBefore(start);
    final startText = start == null ? '' : formatDateTime(l10n.localeName, start);

    final main = FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(56),
      iconSize: 24,
      backgroundColor: palette.button,
      foregroundColor: palette.onButton,
      disabledBackgroundColor: palette.high.withValues(alpha: 0.12),
      disabledForegroundColor: palette.high.withValues(alpha: 0.45),
    );

    switch (actionOf(ticket)) {
      case TicketAction.control:
        final available = canControl(ticket, now);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            FilledButton.icon(
              style: main,
              onPressed: available ? () => context.push(Routes.ticketControl(guid)) : null,
              icon: const Icon(Symbols.qr_code_2_rounded),
              label: Text(l10n.ticketActionControl),
            ),
            if (!available && start != null) _Helper(l10n.ticketControlAvailableFrom(startText)),
          ],
        );
      case TicketAction.assign:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            FilledButton.icon(
              style: main,
              onPressed: busy ? null : () => unawaited(_assign(context, ref, guid)),
              icon: busy ? const _Spinner() : const Icon(Symbols.add_to_home_screen_rounded),
              label: Text(l10n.ticketActionAssign),
            ),
            // Assigning works ahead of time; the code only from the start on.
            if (startsLater) _Helper(l10n.ticketControlFrom(startText)),
          ],
        );
      case TicketAction.payment:
        // From the theme, for its font; a bare style would fall back to the system's.
        final text = Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 15);
        const padding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        final pay = FilledButton.icon(
          style: main.copyWith(
            iconSize: const WidgetStatePropertyAll(22),
            textStyle: WidgetStatePropertyAll(text),
            padding: const WidgetStatePropertyAll(padding),
          ),
          // The payment itself belongs to the purchase flow.
          onPressed: () => context.push(Routes.buy),
          icon: const Icon(Symbols.payments_rounded),
          label: Text(l10n.ticketActionContinuePayment, textAlign: TextAlign.center),
        );
        final check = OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            padding: padding,
            textStyle: text,
            foregroundColor: palette.high,
            side: BorderSide(color: palette.medium, width: 1.5),
          ),
          onPressed: busy ? null : () => unawaited(_checkPayment(context, ref, guid)),
          icon: busy ? const _Spinner() : const Icon(Symbols.refresh_rounded),
          label: Text(l10n.ticketActionCheckPayment, textAlign: TextAlign.center),
        );
        // Side by side where both fit, one above the other where not.
        return LayoutBuilder(
          builder: (context, constraints) => constraints.maxWidth >= 308
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8,
                    children: [
                      Expanded(child: pay),
                      Expanded(child: check),
                    ],
                  ),
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 8, children: [pay, check]),
        );
      case TicketAction.assignedElsewhere:
        return TicketNote(Symbols.devices_off_rounded, l10n.ticketStatusAssignedElsewhere);
      case TicketAction.processing || TicketAction.none:
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

/// When a button under it becomes of use.
class _Helper extends StatelessWidget {
  const _Helper(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final color = TicketCardColors.of(context).medium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Symbols.schedule_rounded, size: 18, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: color),
          ),
        ),
      ],
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) =>
      const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2));
}

/// Why there is nothing to do with the ticket, in place of a button: on the
/// stub of a [TicketCard].
class TicketNote extends StatelessWidget {
  const TicketNote(this.icon, this.text, {super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final palette = TicketCardColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: palette.medium),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: palette.high)),
          ),
        ],
      ),
    );
  }
}
