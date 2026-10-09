import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/dashed_border.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';

/// Stands where a ticket or a list would be: says what is missing and
/// offers the one thing to do about it.
class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.icon,
    required this.title,
    this.body,
    required this.actionIcon,
    required this.actionLabel,
    required this.onAction,
    this.tonal = false,
  });

  final IconData icon;
  final String title;
  final String? body;
  final IconData actionIcon;
  final String actionLabel;
  final VoidCallback onAction;

  /// A quieter button, for trying again rather than moving on.
  final bool tonal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final actionChild = Text(actionLabel);
    final actionIconWidget = Icon(actionIcon);
    return DashedBorder(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          children: [
            IconTile(
              icon,
              size: 72,
              radius: 24,
              iconSize: 36,
              background: scheme.primaryFixed,
              foreground: scheme.onPrimaryFixed,
            ),
            const SizedBox(height: 16),
            Text(title, textAlign: TextAlign.center, style: theme.textTheme.titleLarge),
            if (body != null) ...[
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
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
            const SizedBox(height: 22),
            if (tonal)
              FilledButton.tonalIcon(onPressed: onAction, icon: actionIconWidget, label: actionChild)
            else
              FilledButton.icon(onPressed: onAction, icon: actionIconWidget, label: actionChild),
          ],
        ),
      ),
    );
  }
}
