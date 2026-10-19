import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_providers.dart';
import 'package:mobile_kkm/features/purchase/utils/purchase_format.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The bottom bar of the purchase form (25a): the next thing to answer, the
/// price on its way or arrived, a refusal above it, and Continue.
class PriceBar extends StatelessWidget {
  const PriceBar({super.key, required this.price, required this.hint, required this.onContinue});

  final PriceState price;

  /// What to answer next; empty while loading.
  final String hint;

  /// Only once priced.
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final quiet = theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant);
    final price = this.price;

    final Widget status = switch (price) {
      PriceCalculating() => Row(
        children: [
          SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2, color: scheme.primary)),
          const SizedBox(width: 8),
          Flexible(child: Text(l10n.buyCalculating, style: quiet)),
        ],
      ),
      PricePriced(:final calculation) => MergeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.buyPrice, style: theme.textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant)),
            Text(
              formatPrice(calculation.price ?? 0),
              style: theme.textTheme.titleLarge?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
            ),
          ],
        ),
      ),
      PriceIdle() || PriceRefused() => Text(hint, style: quiet),
    };

    return Material(
      color: scheme.surfaceContainer,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (price is PriceRefused) ...[
                Semantics(
                  liveRegion: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(color: scheme.errorContainer, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Symbols.error_rounded, size: 20, color: scheme.onErrorContainer),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            refusalText(l10n, price),
                            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onErrorContainer),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 56),
                child: Row(
                  children: [
                    Expanded(child: Semantics(liveRegion: true, child: status)),
                    const SizedBox(width: 16),
                    FilledButton(
                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 28)),
                      onPressed: price is PricePriced ? onContinue : null,
                      child: Text(l10n.buyContinue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
