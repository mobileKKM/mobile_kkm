import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/dashed_border.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';

/// Stands where a ticket or a list would be: says what is missing and
/// offers the one thing to do about it, if there is one.
class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    this.icon,
    this.glyph,
    required this.title,
    this.body,
    this.actionIcon,
    this.actionLabel,
    this.onAction,
    this.tonal = false,
    this.quiet = false,
  }) : assert((icon == null) != (glyph == null));

  final IconData? icon;

  /// A widget following the [IconTheme] in place of [icon].
  final Widget? glyph;
  final String title;
  final String? body;
  final IconData? actionIcon;

  /// No button without it.
  final String? actionLabel;
  final VoidCallback? onAction;

  /// A quieter button, for trying again rather than moving on.
  final bool tonal;

  /// For a part of a screen rather than its subject: a grey tile and a
  /// smaller title.
  final bool quiet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final actionLabel = this.actionLabel;
    final style = FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 28));
    return DashedBorder(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, quiet ? 28 : 32, 24, 24),
        child: Column(
          children: [
            if (icon case final icon?)
              IconTile(
                icon,
                size: 72,
                radius: 24,
                iconSize: 36,
                background: quiet ? scheme.surfaceContainerHigh : scheme.primaryFixed,
                foreground: quiet ? scheme.onSurfaceVariant : scheme.onPrimaryFixed,
              )
            else
              IconTile.glyph(
                glyph!,
                size: 72,
                radius: 24,
                iconSize: 36,
                background: quiet ? scheme.surfaceContainerHigh : scheme.primaryFixed,
                foreground: quiet ? scheme.onSurfaceVariant : scheme.onPrimaryFixed,
              ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: quiet
                  ? theme.textTheme.titleLarge?.copyWith(fontSize: 20, height: 26 / 20)
                  : theme.textTheme.titleLarge,
            ),
            if (body != null) ...[
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: quiet ? 300 : 280),
                child: Text(
                  body!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    height: 22 / 15,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
            if (actionLabel != null) ...[
              const SizedBox(height: 22),
              if (tonal)
                FilledButton.tonalIcon(
                  style: style,
                  onPressed: onAction,
                  icon: Icon(actionIcon),
                  label: Text(actionLabel),
                )
              else
                FilledButton.icon(style: style, onPressed: onAction, icon: Icon(actionIcon), label: Text(actionLabel)),
            ],
          ],
        ),
      ),
    );
  }
}
