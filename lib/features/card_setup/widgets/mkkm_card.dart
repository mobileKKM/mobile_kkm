import 'package:ekp_api/ekp_api.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/perforation.dart';
import 'package:mobile_kkm/core/widgets/status_chip.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

enum MkkmCardStatus { active, detached }

/// The user's mKKM card as a card: whose it is, its customer code and what
/// state it is in. In the brand colour in both themes.
class MkkmCard extends StatelessWidget {
  const MkkmCard({super.key, required this.user, required this.status, this.customerCode});

  final UserData? user;
  final MkkmCardStatus status;
  final String? customerCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = AppColors.of(context);
    // The fixed roles: the card is the brand colour in both themes.
    final onCard = scheme.primaryFixed;
    final quiet = scheme.onPrimaryContainer;
    final small = theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: quiet);
    final name = [user?.firstName, user?.lastName].nonNulls.where((part) => part.isNotEmpty).join(' ');
    final code = customerCode;
    final chip = switch (status) {
      MkkmCardStatus.active => StatusChip(
        l10n.cardChipActive,
        icon: Symbols.check_circle_rounded,
        background: colors.successContainer,
        foreground: colors.onSuccessContainer,
        compact: true,
      ),
      // The payment colour: something stands in the way, nothing has failed.
      MkkmCardStatus.detached => StatusChip(
        l10n.cardChipDetached,
        icon: Symbols.link_off_rounded,
        background: scheme.tertiaryContainer,
        foreground: scheme.onTertiaryContainer,
        compact: true,
      ),
    };

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        'mKKM',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 26,
                          height: 32 / 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: onCard,
                        ),
                      ),
                      Text(l10n.cardSubtitle, style: small),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                chip,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            // The card always lies on the surface, so the notches are drawn
            // in its colour.
            child: Perforation(line: onCard.withValues(alpha: 0.35), notch: scheme.surface, height: 28),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                UserAvatar(user: user, size: 56, background: onCard, foreground: scheme.onPrimaryFixed),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      if (name.isNotEmpty)
                        Text(
                          name,
                          style: theme.textTheme.titleMedium?.copyWith(fontSize: 17, height: 22 / 17, color: onCard),
                        ),
                      Wrap(
                        spacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(l10n.accountCustomerCode, style: small),
                          if (code != null)
                            Text(
                              code,
                              style: small?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                color: onCard,
                                fontFeatures: const [FontFeature.tabularFigures()],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
