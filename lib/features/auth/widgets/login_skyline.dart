import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// Decorative illustration pinned to the bottom edge of the login screen.
class LoginSkyline extends StatelessWidget {
  const LoginSkyline({super.key, required this.height, this.bottomInset = 0});

  final double height;

  /// Height of the system navigation area below the illustration. It is
  /// filled with the ground colour, so the buildings stand above the
  /// navigation buttons instead of behind them.
  final double bottomInset;

  /// The ground band at the bottom of both SVGs.
  static const _ground = Color(0xFF5460B0);

  static const _aspectRatio = 620 / 187;

  /// Full width at the native ratio on phones; capped on wide screens,
  /// where the illustration is cropped from the top instead. Zero on very
  /// short screens (landscape phones), where there is no room for it.
  static double heightFor(Size screen) => screen.height < 560 ? 0 : math.min(screen.width / _aspectRatio, 200);

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    // The navigation buttons sit on the ground colour, so they are light in
    // both themes.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              dark ? 'assets/images/login_bottom_bg_dark.svg' : 'assets/images/login_bottom_bg_light.svg',
              height: height,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
            if (bottomInset > 0)
              ColoredBox(
                color: _ground,
                child: SizedBox(height: bottomInset),
              ),
          ],
        ),
      ),
    );
  }
}
