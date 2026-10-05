import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// Decorative illustration pinned to the bottom edge of the login screen.
class LoginSkyline extends StatelessWidget {
  const LoginSkyline({super.key, required this.height});

  final double height;

  static const _aspectRatio = 620 / 187;

  /// Full width at the native ratio on phones; capped on wide screens,
  /// where the illustration is cropped from the top instead. Zero on very
  /// short screens (landscape phones), where there is no room for it.
  static double heightFor(Size screen) => screen.height < 560 ? 0 : math.min(screen.width / _aspectRatio, 200);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ExcludeSemantics(
      child: SvgPicture.asset(
        dark ? 'assets/images/login_bottom_bg_dark.svg' : 'assets/images/login_bottom_bg_light.svg',
        height: height,
        fit: BoxFit.cover,
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}
