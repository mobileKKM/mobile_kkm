import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Says that the app is offline or the service is switched off; nothing
/// while everything works.
class AppStatusBanner extends ConsumerWidget {
  const AppStatusBanner({super.key, this.padding = EdgeInsets.zero});

  /// Around the banner, so that it takes no room while there is none.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(appStatusProvider);
    final message = switch (status.mode) {
      // An outdated app never gets as far as a screen with this banner.
      AppMode.online || AppMode.outdated => null,
      AppMode.offline => l10n.offlineNotice,
      // The server's own wording (Polish only), like its error messages.
      AppMode.unavailable => (status.message?.isNotEmpty ?? false) ? status.message! : l10n.serviceUnavailableNotice,
    };
    if (message == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: padding,
      child: MessageBanner(message, kind: BannerKind.info),
    );
  }
}
