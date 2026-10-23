import 'package:material_ui/material_ui.dart';

/// An icon on a rounded square: what leads a row, a card or a notice.
class IconTile extends StatelessWidget {
  const IconTile(
    IconData this.icon, {
    super.key,
    this.size = 44,
    this.radius = 14,
    this.iconSize = 22,
    this.background,
    this.foreground,
    this.fill = 0,
  }) : glyph = null;

  /// A tile around a widget that follows the [IconTheme], e.g. a
  /// `KartaKrakowskaIcon`.
  const IconTile.glyph(
    Widget this.glyph, {
    super.key,
    this.size = 44,
    this.radius = 14,
    this.iconSize = 22,
    this.background,
    this.foreground,
  }) : icon = null,
       fill = 0;

  final IconData? icon;
  final Widget? glyph;
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
      child: switch (icon) {
        final icon? => Icon(icon, size: iconSize, fill: fill, color: foreground ?? scheme.primary),
        null => IconTheme(
          data: IconThemeData(size: iconSize, color: foreground ?? scheme.primary),
          child: glyph!,
        ),
      },
    );
  }
}
