import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Explains where the e-mailed link will open. On Android the app can take
/// it over once the user allows it in system settings; elsewhere the flow
/// finishes in the browser.
class LinkHint extends ConsumerStatefulWidget {
  const LinkHint({super.key});

  @override
  ConsumerState<LinkHint> createState() => _LinkHintState();
}

class _LinkHintState extends ConsumerState<LinkHint> with WidgetsBindingObserver {
  bool? _canOpenLinks;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_refresh());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Coming back from the system settings: the answer may have changed.
    if (state == AppLifecycleState.resumed) {
      unawaited(_refresh());
    }
  }

  Future<void> _refresh() async {
    final settings = ref.read(linkSettingsProvider);
    if (!settings.isSupported) {
      return;
    }
    final canOpen = await settings.canOpenLinks();
    if (mounted) {
      setState(() => _canOpenLinks = canOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(linkSettingsProvider);

    if (!settings.isSupported) {
      return MessageBanner(l10n.inboxBrowserHint, kind: BannerKind.info, icon: Symbols.open_in_browser_rounded);
    }
    return switch (_canOpenLinks) {
      null => const SizedBox.shrink(),
      true => MessageBanner(l10n.inboxAppHint, kind: BannerKind.info, icon: Symbols.phone_android_rounded),
      false => MessageBanner(
        l10n.inboxEnableLinksHint,
        kind: BannerKind.info,
        icon: Symbols.link_rounded,
        actionLabel: l10n.openLinkSettings,
        onAction: settings.openSettings,
      ),
    };
  }
}
