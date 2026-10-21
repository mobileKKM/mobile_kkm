import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/features/purchase/services/payment_session.dart';
import 'package:mobile_kkm/features/purchase/widgets/payment_widgets.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Payment (28a, 28b): tPay opens over it, and it shows how the payment
/// went, in place: Opening, Finishing, Checking, Rejected, Not booked.
class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  /// What the screen showed last: the session is idle again while the
  /// screen is on its way out, and it shouldn't change on the way.
  PaymentSession? _shown;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(paymentSessionProvider);
    if (current.phase != PaymentPhase.idle || _shown == null) {
      _shown = current;
    }
    final session = _shown!;
    final controller = ref.read(paymentSessionProvider.notifier);
    final localizations = MaterialLocalizations.of(context);
    final message = session.message;

    final close = IconButton(
      tooltip: localizations.closeButtonTooltip,
      icon: const Icon(Symbols.close_rounded),
      onPressed: controller.leave,
    );
    final back = IconButton(
      tooltip: localizations.backButtonTooltip,
      icon: const Icon(Symbols.arrow_back_rounded),
      onPressed: controller.back,
    );
    final backToTickets = TextButton(onPressed: controller.leave, child: Text(l10n.payBackToTickets));

    final Widget view = switch (session.phase) {
      PaymentPhase.idle || PaymentPhase.opening => PaymentStatusView(
        title: l10n.payOpeningTpay,
        body: switch (session.linksAllowed) {
          _ when defaultTargetPlatform == TargetPlatform.iOS => l10n.payOpenBodyIos,
          false => l10n.payOpenBodyAndroidNoLink,
          _ => l10n.payOpenBodyAndroid,
        },
      ),
      PaymentPhase.finishing => PaymentStatusView(title: l10n.payFinishing, body: l10n.payFinishingBody),
      PaymentPhase.checking => PaymentStatusView(title: l10n.payChecking, leading: close, bottom: backToTickets),
      PaymentPhase.rejected => PaymentStatusView(
        title: l10n.payRejectedTitle,
        body: l10n.payRejectedBody,
        icon: Symbols.credit_card_off_rounded,
        leading: back,
        bottom: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(onPressed: controller.back, child: Text(l10n.payTryAgain)),
            const SizedBox(height: 8),
            backToTickets,
          ],
        ),
      ),
      PaymentPhase.notBooked => PaymentStatusView(
        title: l10n.payNotYet,
        body: l10n.payNotYetBody,
        icon: Symbols.hourglass_top_rounded,
        leading: back,
        notice: message == null || message.isEmpty
            ? null
            : MessageBanner(message, kind: BannerKind.info, icon: Symbols.info_rounded),
        bottom: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(onPressed: controller.back, child: Text(l10n.payAgain)),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              onPressed: controller.checkAgain,
              icon: const Icon(Symbols.refresh_rounded),
              label: Text(l10n.payCheckAgain),
            ),
            const SizedBox(height: 8),
            backToTickets,
          ],
        ),
      ),
    };

    // Back does what the leading button does; while tPay opens and while
    // the payment is reported there is nothing to go back to.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        switch (ref.read(paymentSessionProvider).phase) {
          case PaymentPhase.checking:
            controller.leave();
          case PaymentPhase.rejected || PaymentPhase.notBooked:
            controller.back();
          case PaymentPhase.idle || PaymentPhase.opening || PaymentPhase.finishing:
            break;
        }
      },
      child: view,
    );
  }
}
