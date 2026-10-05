import 'package:flutter/material.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';

/// Shown while the stored session is read and, if it has expired, renewed.
/// Mirrors the native splash
/// (see `flutter_native_splash` in pubspec.yaml) so the hand-over is
/// seamless.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const double _logoSize = 128;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ColoredBox(
      color: dark ? AppTheme.splashDark : AppTheme.splashLight,
      child: Center(
        // The logo stays exactly centred, where the native splash drew it;
        // the spinner hangs below without shifting it.
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              width: _logoSize,
              height: _logoSize,
              excludeFromSemantics: true,
            ),
            const Positioned(
              top: _logoSize + 32,
              child: SizedBox.square(dimension: 28, child: CircularProgressIndicator(strokeWidth: 3)),
            ),
          ],
        ),
      ),
    );
  }
}
