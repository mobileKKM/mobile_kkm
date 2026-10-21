import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/bullet_card.dart';
import 'package:mobile_kkm/core/widgets/lead_header.dart';
import 'package:mobile_kkm/features/account/constants/contacts.dart';
import 'package:mobile_kkm/features/auth/widgets/auth_page.dart';
import 'package:mobile_kkm/features/auth/widgets/brand_header.dart';
import 'package:mobile_kkm/features/first_start/providers/first_start_provider.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Shown once, before anything else after the splash: the app is unofficial,
/// open source and comes without warranty.
class FirstStartScreen extends ConsumerWidget {
  const FirstStartScreen({super.key, this.next});

  /// Where to go afterwards: an e-mail link the first start was opened with.
  /// Otherwise the splash, which sends the user on as at any start.
  final String? next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return AuthPage(
      showAppBar: false,
      centered: true,
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4,
        children: [
          FilledButton.icon(
            onPressed: () {
              unawaited(ref.read(firstStartSeenProvider.notifier).accept());
              context.go(next ?? Routes.splash);
            },
            icon: const Icon(Symbols.check_rounded),
            label: Text(l10n.firstStartAccept),
          ),
          TextButton(
            style: TextButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            onPressed: () => unawaited(ref.read(urlOpenerProvider)(Contacts.sourceUri)),
            child: Text(l10n.viewSourceCode),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          const BrandHeader(),
          LeadHeader(title: l10n.firstStartTitle, body: l10n.firstStartBody, titleSize: 26),
          BulletCard(
            items: [
              BulletItem(
                icon: Symbols.groups_rounded,
                title: l10n.firstStartUnofficialTitle,
                body: l10n.firstStartUnofficialBody,
              ),
              BulletItem(
                icon: Symbols.code_rounded,
                title: l10n.firstStartOpenSourceTitle,
                body: l10n.firstStartOpenSourceBody,
              ),
              BulletItem(
                icon: Symbols.gavel_rounded,
                title: l10n.firstStartNoWarrantyTitle,
                body: l10n.firstStartNoWarrantyBody,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
