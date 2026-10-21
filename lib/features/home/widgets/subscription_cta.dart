import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The 5+1 half-year ticket programme, shown but not available yet: greyed
/// out and leads nowhere until the programme is built.
class SubscriptionCta extends StatelessWidget {
  const SubscriptionCta({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final disabled = scheme.onSurface.withValues(alpha: 0.38);
    return Semantics(
      enabled: false,
      container: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 88),
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 12, 16),
        decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(28)),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: scheme.onSurface.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ExcludeSemantics(
                child: Text(
                  '5+1',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: disabled,
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
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  Text(l10n.subscriptionUnavailable, style: theme.textTheme.bodyMedium?.copyWith(color: disabled)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
