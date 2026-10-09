import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';

/// What a screen is about, in one glance: an optional icon tile, a headline
/// and a line of help.
class LeadHeader extends StatelessWidget {
  const LeadHeader({
    super.key,
    required this.title,
    this.body,
    this.icon,
    this.busy = false,
    this.tileColor,
    this.iconColor,
    this.fill = 0,
    this.centered = false,
    this.titleSize = 28,
  });

  final String title;
  final String? body;
  final IconData? icon;

  /// A spinner in the tile, instead of [icon].
  final bool busy;

  /// primaryContainer with primaryFixed on it unless given.
  final Color? tileColor;
  final Color? iconColor;
  final double fill;
  final bool centered;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final align = centered ? TextAlign.center : TextAlign.start;
    final background = tileColor ?? scheme.primaryContainer;
    final foreground = iconColor ?? scheme.primaryFixed;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
      child: Column(
        crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (busy)
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(24)),
              child: SizedBox.square(
                dimension: 32,
                child: CircularProgressIndicator(strokeWidth: 3, color: foreground),
              ),
            )
          else if (icon != null)
            IconTile(
              icon!,
              size: 72,
              radius: 24,
              iconSize: 36,
              fill: fill,
              background: background,
              foreground: foreground,
            ),
          if (busy || icon != null) const SizedBox(height: 20),
          Semantics(
            header: true,
            child: Text(
              title,
              textAlign: align,
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: titleSize, height: (titleSize + 8) / titleSize),
            ),
          ),
          if (body != null) ...[
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Text(
                body!,
                textAlign: align,
                style: theme.textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
