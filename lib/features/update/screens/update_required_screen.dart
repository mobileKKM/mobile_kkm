import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/features/account/constants/contacts.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The only screen left once the server's `minAppVersion` is above the
/// client version the app speaks: nothing else would work.
class UpdateRequiredScreen extends ConsumerWidget {
  const UpdateRequiredScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    // No way back and none past it; the frame is the one of "Check your inbox".
    return AuthPage(
      showAppBar: false,
      centered: true,
      bottom: FilledButton.icon(
        onPressed: () => unawaited(ref.read(urlOpenerProvider)(Contacts.releasesUri)),
        icon: const Icon(Symbols.open_in_new_rounded),
        label: Text(l10n.updateRequiredAction),
      ),
      // The payment colour: something stands in the way, nothing has failed.
      child: LeadHeader(
        icon: Symbols.system_update_rounded,
        centered: true,
        title: l10n.updateRequiredTitle,
        body: l10n.updateRequiredBody,
        tileColor: scheme.tertiaryContainer,
        iconColor: scheme.onTertiaryContainer,
      ),
    );
  }
}
