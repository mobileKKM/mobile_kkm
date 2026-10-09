import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Says that the app is offline or the service is switched off; nothing
/// while everything works. A compact strip, so that what is stored stays in
/// view under it.
class AppStatusBanner extends ConsumerWidget {
  const AppStatusBanner({super.key, this.padding = EdgeInsets.zero});

  /// Around the banner, so that it takes no room while there is none.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
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
    // How old "saved data" is: only worth saying while there is no asking.
    final syncedAt = status.mode == AppMode.offline ? ref.watch(ticketsSyncedAtProvider).value : null;
    final style = theme.textTheme.bodyMedium?.copyWith(color: scheme.onInverseSurface);
    return Padding(
      padding: padding,
      child: Semantics(
        liveRegion: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(color: scheme.inverseSurface, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Icon(
                status.mode == AppMode.offline ? Symbols.cloud_off_rounded : Symbols.info_rounded,
                size: 20,
                color: scheme.onInverseSurface,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: message,
                    children: [
                      if (syncedAt != null)
                        TextSpan(
                          text: ' ${l10n.offlineSavedAt(_savedAt(l10n.localeName, syncedAt))}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                    ],
                  ),
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The time alone for today, with the date for an older copy.
  static String _savedAt(String locale, DateTime syncedAt) {
    final local = syncedAt.toLocal();
    final now = DateTime.now();
    final today = local.year == now.year && local.month == now.month && local.day == now.day;
    return today ? formatTime(locale, local) : formatDateTime(locale, local);
  }
}
