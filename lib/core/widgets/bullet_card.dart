import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';

/// One point of a [BulletCard].
class BulletItem {
  const BulletItem({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;
}

/// A few points worth knowing before going on, each a tile, a title and a
/// line, on one card.
class BulletCard extends StatelessWidget {
  const BulletCard({super.key, required this.items, this.iconColor});

  final List<BulletItem> items;

  /// Of the icons; primary unless given.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: scheme.surfaceContainerLow, borderRadius: BorderRadius.circular(28)),
      child: Column(
        spacing: 18,
        children: [
          for (final item in items)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconTile(item.icon, size: 40, foreground: iconColor),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          height: 20 / 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(item.body, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
