import 'package:material_ui/material_ui.dart';

/// An icon on a rounded square: what leads a row, a card or a notice.
class IconTile extends StatelessWidget {
  const IconTile(
    this.icon, {
    super.key,
    this.size = 44,
    this.radius = 14,
    this.iconSize = 22,
    this.background,
    this.foreground,
    this.fill = 0,
  });

  final IconData icon;
  final double size;
  final double radius;
  final double iconSize;

  /// The surface and primary unless given.
  final Color? background;
  final Color? foreground;
  final double fill;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background ?? scheme.surface, borderRadius: BorderRadius.circular(radius)),
      child: Icon(icon, size: iconSize, fill: fill, color: foreground ?? scheme.primary),
    );
  }
}
