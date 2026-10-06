import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// One destination in a [LinkSheet].
class SheetLink {
  const SheetLink({required this.icon, required this.label, required this.uri, this.subtitle});

  final IconData icon;
  final String label;

  /// The address or number itself, readable even if nothing can open it.
  final String? subtitle;
  final Uri uri;
}

Future<void> showLinkSheet(BuildContext context, {required String title, required List<SheetLink> links}) {
  return showModalBottomSheet<void>(
    context: context,
    // Over the whole screen: the section's own navigator ends above the
    // navigation bar, and the sheet would sit behind it.
    useRootNavigator: true,
    showDragHandle: true,
    builder: (context) => LinkSheet(title: title, children: [for (final link in links) LinkTile(link)]),
  );
}

/// The three regulations from the app config.
Future<void> showRegulationsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    // Over the whole screen: the section's own navigator ends above the
    // navigation bar, and the sheet would sit behind it.
    useRootNavigator: true,
    showDragHandle: true,
    builder: (context) => const _RegulationsSheet(),
  );
}

/// A bottom sheet listing places to go: web pages, a phone number, an
/// e-mail address.
class LinkSheet extends StatelessWidget {
  const LinkSheet({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            ...children,
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class LinkTile extends ConsumerWidget {
  const LinkTile(this.link, {super.key});

  final SheetLink link;

  Future<void> _open(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    final open = ref.read(urlOpenerProvider);
    Navigator.of(context).pop();

    var opened = false;
    try {
      opened = await open(link.uri);
    } catch (_) {
      // No app for this kind of link.
    }
    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.linkOpenFailed)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(link.icon),
      title: Text(link.label),
      subtitle: link.subtitle == null ? null : Text(link.subtitle!),
      onTap: () => unawaited(_open(context, ref)),
    );
  }
}

class _RegulationsSheet extends ConsumerWidget {
  const _RegulationsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final config = ref.watch(mobileAppConfigProvider);

    SheetLink? link(String label, String? url) => url == null || url.isEmpty
        ? null
        // The server's URLs contain raw spaces.
        : SheetLink(icon: Symbols.description_rounded, label: label, uri: Uri.parse(Uri.encodeFull(url)));

    return LinkSheet(
      title: l10n.accountRegulations,
      children: switch (config) {
        AsyncValue(:final value?) => [
          for (final entry in [
            link(l10n.regulationsAccount, value.regulationsUrl),
            link(l10n.regulationsPurchase, value.regulationsPurchaseUrl),
            link(l10n.regulationsSubscription, value.regulations5plus1Url),
          ].nonNulls)
            LinkTile(entry),
        ],
        AsyncError(:final error) => [
          Padding(
            padding: const EdgeInsets.all(24),
            child: LoadProblem(
              message: '${l10n.regulationsLoadError} ${describeError(l10n, error)}',
              onRetry: () => unawaited(ref.read(appStatusProvider.notifier).check()),
            ),
          ),
        ],
        _ => const [
          Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      },
    );
  }
}
