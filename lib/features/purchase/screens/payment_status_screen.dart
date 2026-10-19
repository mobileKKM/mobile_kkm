import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/features/purchase/services/payment_session.dart';
import 'package:mobile_kkm/features/purchase/widgets/payment_widgets.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Finishing, Checking and Not yet: where a payment ends while the app
/// finds out how it went.
class PaymentStatusScreen extends ConsumerWidget {
  const PaymentStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(paymentSessionProvider);
    final controller = ref.read(paymentSessionProvider.notifier);
    final message = session.message;

    final Widget view = switch (session.phase) {
      PaymentPhase.checking => PaymentStatusView(
        title: l10n.payChecking,
        bottom: TextButton(onPressed: controller.backToTickets, child: Text(l10n.payBackToTickets)),
      ),
      PaymentPhase.notYet => PaymentStatusView(
        title: l10n.payNotYet,
        body: l10n.payNotYetBody,
        waiting: false,
        notice: message == null || message.isEmpty
            ? null
            : MessageBanner(message, kind: BannerKind.info, icon: Symbols.info_rounded),
        bottom: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(onPressed: controller.payAgain, child: Text(l10n.payAgain)),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              onPressed: controller.checkAgain,
              icon: const Icon(Symbols.refresh_rounded),
              label: Text(l10n.payCheckAgain),
            ),
            const SizedBox(height: 8),
            TextButton(onPressed: controller.backToTickets, child: Text(l10n.payBackToTickets)),
          ],
        ),
      ),
      PaymentPhase.finishing ||
      PaymentPhase.idle ||
      PaymentPhase.inBrowser => PaymentStatusView(title: l10n.payFinishing, body: l10n.payFinishingBody),
    };
    // While it waits there is nothing to go back to; Not yet's buttons and
    // the back gesture leave alike.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && session.phase == PaymentPhase.notYet) {
          controller.payAgain();
        }
      },
      child: view,
    );
  }
}
