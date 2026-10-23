import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// The Karta Krakowska glyph, ported from the old mobileKKM Android app
/// (`ic_menu_kk.xml`). Sized and tinted by the ambient [IconTheme] like a
/// font icon, so it can stand wherever an [Icon] does, e.g. in an
/// [IconTile.glyph].
class KartaKrakowskaIcon extends StatelessWidget {
  const KartaKrakowskaIcon({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final size = this.size ?? iconTheme.size ?? 24;
    final color = this.color ?? iconTheme.color ?? Theme.of(context).colorScheme.onSurface;
    // The art is taller than wide: contained in a square, like a font icon.
    return SizedBox.square(
      dimension: size,
      child: SvgPicture.asset(
        'assets/images/karta_krakowska.svg',
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        excludeFromSemantics: true,
      ),
    );
  }
}
