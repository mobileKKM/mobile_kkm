import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/bottom_action_bar.dart';
import 'package:mobile_kkm/core/widgets/empty_state_card.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/status_chip.dart';
import 'package:mobile_kkm/features/account/constants/contacts.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The Karta Krakowska status on the mKKM card: whether there is one, from
/// when until when, and the way to the code that proves it.
///
/// It is what the user data says (`mkkmData`), so it is there at once and
/// without a connection; opening the screen and pulling down ask the server
/// for the user data again. Only the server's yes or no counts: the dates
/// are shown as sent, never compared with today, and whether a code can be
/// had is for the server to say when it is asked for one.
class CityCardScreen extends ConsumerStatefulWidget {
  const CityCardScreen({super.key});

  @override
  ConsumerState<CityCardScreen> createState() => _CityCardScreenState();
}

class _CityCardScreenState extends ConsumerState<CityCardScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(_refresh());
  }

  /// Asks for the user data again. [pulled]: the user asked, so while
  /// offline it is first found out whether the server is back.
  Future<void> _refresh({bool pulled = false}) async {
    final status = ref.read(appStatusProvider.notifier);
    if (ref.read(appStatusProvider).mode == AppMode.offline) {
      if (!pulled) {
        return;
      }
      await status.check();
      if (!mounted || ref.read(appStatusProvider).mode == AppMode.offline) {
        return;
      }
    }
    try {
      await ref.read(userDataProvider.notifier).refresh();
    } on EkpNetworkException {
      // No answer: the strip says why, and the stored copy stays.
      if (mounted) {
        status.markOffline();
      }
    } on Exception {
      // The server's trouble: the stored copy stays in use.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final data = ref.watch(userDataProvider).value;
    final user = data?.userData;
    final card = data?.mkkmData;
    final offline = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.offline));
    final name = [user?.firstName, user?.lastName].whereType<String>().join(' ');
    // A detached card needs no word here: the card set-up stands in the
    // app's place until there is an attached one.
    final active = card?.hasInhabitantPrivilege ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cityCardTitle)),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _refresh(pulled: true),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                children: [
                  const AppStatusBanner(padding: EdgeInsets.only(bottom: 16)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                    child: Column(
                      children: [
                        UserAvatar(user: user, size: 120),
                        if (name.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(name, textAlign: TextAlign.center, style: theme.textTheme.headlineMedium),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (active && card != null)
                    _StatusCard(card)
                  else
                    EmptyStateCard(
                      icon: Symbols.badge_rounded,
                      title: l10n.cityCardNone,
                      actionIcon: Symbols.open_in_new_rounded,
                      actionLabel: l10n.cityCardHowTo,
                      onAction: () => unawaited(ref.read(urlOpenerProvider)(Contacts.cityCardHowToUri)),
                      tonal: true,
                      quiet: true,
                    ),
                  if (active && offline) ...[
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        l10n.cityCardOfflineCode,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 13,
                          height: 18 / 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Without a status there is no code to ask for.
          if (active)
            BottomActionBar(
              child: FilledButton.icon(
                // The code is a request: nothing to show without the server.
                onPressed: offline ? null : () => unawaited(context.push(Routes.cityCardCode)),
                icon: const Icon(Symbols.verified_user_rounded),
                label: Text(l10n.cityCardShow),
              ),
            ),
        ],
      ),
    );
  }
}

/// The status as the server reports it: active, from when until when, and
/// the customer number it is stored under.
class _StatusCard extends StatelessWidget {
  const _StatusCard(this.card);

  final MkkmData card;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = AppColors.of(context);
    final from = card.inhabitantPrivilegeDateFrom;
    final until = card.inhabitantPrivilegeDateTo;
    final customerCode = card.customerCode;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: scheme.surfaceContainerLow, borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Row(
            spacing: 12,
            children: [
              IconTile(
                Symbols.badge_rounded,
                iconSize: 24,
                background: scheme.primaryContainer,
                foreground: scheme.primaryFixed,
              ),
              Expanded(
                child: Text(
                  l10n.cityCardTitle,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 17, height: 22 / 17),
                ),
              ),
              StatusChip(
                l10n.cityCardActive,
                icon: Symbols.check_circle_rounded,
                background: colors.successContainer,
                foreground: colors.onSuccessContainer,
                compact: true,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              if (from != null || until != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Expanded(
                      child: from == null
                          ? const SizedBox.shrink()
                          : _Fact(l10n.cityCardFrom, formatDate(l10n.localeName, from)),
                    ),
                    Expanded(
                      child: until == null
                          ? const SizedBox.shrink()
                          : _Fact(l10n.cityCardUntil, formatDate(l10n.localeName, until)),
                    ),
                  ],
                ),
              if (customerCode != null) _Fact(l10n.accountCustomerCode, customerCode),
            ],
          ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 13,
            height: 18 / 13,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.labelLarge?.copyWith(
            fontSize: 18,
            height: 24 / 18,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
