import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The four shortcuts on the home screen.
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _QuickAction(
          icon: Symbols.confirmation_number_rounded,
          label: l10n.navTickets,
          onTap: () => context.go(Routes.tickets),
        ),
        _QuickAction(
          icon: Symbols.add_shopping_cart_rounded,
          label: l10n.navBuy,
          onTap: () => context.push(Routes.buy),
        ),
        _QuickAction(
          icon: Symbols.badge_rounded,
          label: l10n.cityCardTitle,
          onTap: () => context.push(Routes.cityCard),
        ),
        _QuickAction(
          icon: Symbols.departure_board_rounded,
          label: l10n.quickActionDepartures,
          onTap: () => context.go(Routes.map),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: scheme.secondaryContainer, borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Icon(icon, color: scheme.onSecondaryContainer),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
