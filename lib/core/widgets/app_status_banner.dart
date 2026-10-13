import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Says that the app is offline or the service is switched off; nothing
/// while everything works. A compact strip, so that what is stored stays in
/// view under it. It goes below a screen's app bar, never into it.
class AppStatusBanner extends ConsumerStatefulWidget {
  const AppStatusBanner({super.key, this.padding = EdgeInsets.zero});

  /// Around the banner, so that it takes no room while there is none.
  final EdgeInsetsGeometry padding;

  @override
  ConsumerState<AppStatusBanner> createState() => _AppStatusBannerState();
}

class _AppStatusBannerState extends ConsumerState<AppStatusBanner> {
  /// Fires when "today" becomes another day, while a saved time is shown.
  Timer? _midnight;

  @override
  void dispose() {
    _midnight?.cancel();
    super.dispose();
  }

  void _watchMidnight(bool needed) {
    _midnight?.cancel();
    _midnight = null;
    if (needed) {
      final now = DateTime.now();
      final next = DateTime(now.year, now.month, now.day + 1);
      _midnight = Timer(next.difference(now), () => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final status = ref.watch(appStatusProvider);
    final offline = status.mode == AppMode.offline;
    // An outdated app never gets as far as a screen with this banner.
    final shown = offline || status.mode == AppMode.unavailable;
    // How old "saved data" is: only worth saying while there is no asking.
    final syncedAt = offline ? ref.watch(ticketsSyncedAtProvider).value?.toLocal() : null;
    _watchMidnight(syncedAt != null);

    final style = theme.textTheme.bodyMedium?.copyWith(color: scheme.onInverseSurface);
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      child: !shown
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: widget.padding,
              child: Semantics(
                liveRegion: true,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(color: scheme.inverseSurface, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Icon(
                        offline ? Symbols.cloud_off_rounded : Symbols.construction_rounded,
                        size: 20,
                        color: scheme.onInverseSurface,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: offline
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: l10n.offlineBannerTitle,
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: ' ${l10n.offlineBanner}',
                                          style: const TextStyle(fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    style: style,
                                  ),
                                  if (syncedAt != null) Text(_saved(l10n, syncedAt), style: style),
                                ],
                              )
                            // The server's own wording (Polish only), like its error messages.
                            : Text(
                                (status.message?.isNotEmpty ?? false) ? status.message! : l10n.serviceUnavailableBanner,
                                style: style,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  /// The time alone for today, with the date for an older copy.
  static String _saved(AppLocalizations l10n, DateTime syncedAt) {
    final now = DateTime.now();
    final today = syncedAt.year == now.year && syncedAt.month == now.month && syncedAt.day == now.day;
    final time = DateFormat('HH:mm').format(syncedAt);
    return today
        ? l10n.offlineSavedToday(time)
        : l10n.offlineSavedOn(DateFormat('d MMM', l10n.localeName).format(syncedAt), time);
  }
}
