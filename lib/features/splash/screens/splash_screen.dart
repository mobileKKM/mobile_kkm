import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';

/// Shown while the service status and the app config are fetched and the
/// stored session is read and, if it has expired, renewed. Nothing else is
/// loaded behind it. Mirrors the native splash
/// (see `flutter_native_splash` in pubspec.yaml) so the hand-over is
/// seamless.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  /// Decoded in `main()` before the first frame, so that frame already shows
  /// it and the native splash is replaced without a flicker.
  static const logo = AssetImage('assets/images/splash_logo.png');
  static const double _logoSize = 128;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ColoredBox(
      color: dark ? AppTheme.splashDark : AppTheme.splashLight,
      child: const Center(
        // The logo stays exactly centred, where the native splash drew it;
        // the spinner hangs below without shifting it.
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Image(image: logo, width: _logoSize, height: _logoSize, excludeFromSemantics: true),
            Positioned(
              top: _logoSize + 32,
              child: SizedBox.square(dimension: 28, child: CircularProgressIndicator(strokeWidth: 3)),
            ),
          ],
        ),
      ),
    );
  }
}
