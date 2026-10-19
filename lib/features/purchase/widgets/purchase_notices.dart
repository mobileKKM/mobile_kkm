import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/app_snack_bar.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_notice_provider.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Shows the purchase's notices on the screen below it, through the
/// nearest messenger: the Tickets list's own.
class PurchaseNotices extends ConsumerStatefulWidget {
  const PurchaseNotices({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<PurchaseNotices> createState() => _PurchaseNoticesState();
}

class _PurchaseNoticesState extends ConsumerState<PurchaseNotices> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _show());
  }

  void _show() {
    if (!mounted) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    for (final notice in ref.read(purchaseNoticeProvider.notifier).take()) {
      final (text, kind) = switch (notice) {
        PurchaseNotice.paymentMade => (l10n.payMade, SnackKind.success),
        PurchaseNotice.ticketReady => (l10n.payReady, SnackKind.success),
        PurchaseNotice.paymentConfirmed => (l10n.ticketPaymentConfirmed, SnackKind.success),
        PurchaseNotice.alreadyPaid => (l10n.payAlreadyPaid, SnackKind.plain),
      };
      showAppSnackBar(messenger, text, kind: kind);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(purchaseNoticeProvider, (_, notices) {
      if (notices.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _show());
      }
    });
    return widget.child;
  }
}
