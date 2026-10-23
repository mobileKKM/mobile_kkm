import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/karta_krakowska_icon.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The four shortcuts on the home screen, two by two.
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final actions = [
      _QuickAction(
        icon: Symbols.confirmation_number_rounded,
        label: l10n.navTickets,
        onTap: () => context.go(Routes.tickets),
      ),
      _QuickAction(icon: Symbols.add_shopping_cart_rounded, label: l10n.navBuy, onTap: () => context.push(Routes.buy)),
      _QuickAction(
        glyph: const KartaKrakowskaIcon(),
        label: l10n.cityCardTitle,
        onTap: () => context.push(Routes.cityCard),
      ),
      _QuickAction(
        icon: Symbols.departure_board_rounded,
        label: l10n.quickActionDepartures,
        onTap: () => context.go(Routes.map),
      ),
    ];
    return Column(
      spacing: 8,
      children: [
        for (var row = 0; row < actions.length; row += 2)
          // Equal cards: a pair is as tall as its taller label needs.
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                Expanded(child: actions[row]),
                Expanded(child: actions[row + 1]),
              ],
            ),
          ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({this.icon, this.glyph, required this.label, required this.onTap})
    : assert((icon == null) != (glyph == null));

  final IconData? icon;
  final Widget? glyph;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // On a narrow phone the tile gives way, so that a label breaks between
    // its words rather than inside one. By the screen, not the card: the
    // pair's shared height rules out a LayoutBuilder here.
    final narrow = MediaQuery.sizeOf(context).width < 380;
    return Material(
      color: theme.colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 72),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 12, narrow ? 8 : 14, 12),
            child: Row(
              children: [
                if (icon case final icon?)
                  IconTile(icon, size: narrow ? 40 : 44)
                else
                  IconTile.glyph(glyph!, size: narrow ? 40 : 44),
                SizedBox(width: narrow ? 10 : 12),
                Expanded(
                  child: Text(label, style: theme.textTheme.labelLarge?.copyWith(fontSize: 15, height: 20 / 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
