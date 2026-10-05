import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
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
    final style = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    if (!settings.isSupported) {
      return Text(l10n.inboxBrowserHint, style: style);
    }
    return switch (_canOpenLinks) {
      null => const SizedBox.shrink(),
      true => Text(l10n.inboxAppHint, style: style),
      false => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.inboxEnableLinksHint, style: style),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: settings.openSettings,
            icon: const Icon(Icons.open_in_new, size: 18),
            label: Text(l10n.openLinkSettings),
          ),
        ],
      ),
    };
  }
}
