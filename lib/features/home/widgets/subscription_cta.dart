import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Leads to the 5+1 half-year ticket programme. The home screen's one
/// highlight; in the fixed roles, so not one of the ticket state colours.
class SubscriptionCta extends StatelessWidget {
  const SubscriptionCta({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Material(
      color: scheme.primaryFixed,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(Routes.subscription),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 88),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 12, 16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: scheme.onPrimaryFixed, borderRadius: BorderRadius.circular(20)),
                  child: ExcludeSemantics(
                    child: Text(
                      '5+1',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: scheme.primaryFixed,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        l10n.subscriptionTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 17,
                          height: 22 / 17,
                          color: scheme.onPrimaryFixed,
                        ),
                      ),
                      Text(
                        l10n.subscriptionCtaBody,
                        style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onPrimaryFixedVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: scheme.onPrimaryFixed, shape: BoxShape.circle),
                  child: Icon(Symbols.arrow_forward_rounded, size: 22, color: scheme.primaryFixed),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
