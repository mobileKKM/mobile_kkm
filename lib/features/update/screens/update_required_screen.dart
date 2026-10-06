import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/features/account/constants/contacts.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The only screen left once the server's `minAppVersion` is above the
/// client version the app speaks: nothing else would work.
class UpdateRequiredScreen extends ConsumerWidget {
  const UpdateRequiredScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Symbols.system_update_rounded, size: 64, color: theme.colorScheme.primary),
                  const SizedBox(height: 24),
                  Text(l10n.updateRequiredTitle, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    l10n.updateRequiredBody,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () => unawaited(ref.read(urlOpenerProvider)(Contacts.releasesUri)),
                    child: Text(l10n.updateRequiredAction),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
