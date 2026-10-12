import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/providers/card_gate_provider.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Shown while the service status and the app config are fetched and the
/// stored session is read and, if it has expired, renewed. Nothing else is
/// loaded behind it, except the user data of a session that has no stored
/// copy of it: the app does not open before it is known whether the account
/// has a card. Mirrors the native splash (see `flutter_native_splash` in
/// pubspec.yaml) so the hand-over is seamless.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  /// Decoded in `main()` before the first frame, so that frame already shows
  /// it and the native splash is replaced without a flicker.
  static const logo = AssetImage('assets/images/splash_logo.png');
  static const double _logoSize = 128;

  /// A normal start is over before anything but the logo shows.
  static const spinnerDelay = Duration(seconds: 1);

  /// When the wait for the user data is worth a word.
  static const hintDelay = Duration(seconds: 3);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final Timer _spinnerTimer;
  late final Timer _hintTimer;
  bool _spinner = false;
  bool _hintDue = false;

  @override
  void initState() {
    super.initState();
    _spinnerTimer = Timer(SplashScreen.spinnerDelay, () => setState(() => _spinner = true));
    _hintTimer = Timer(SplashScreen.hintDelay, () => setState(() => _hintDue = true));
  }

  @override
  void dispose() {
    _spinnerTimer.cancel();
    _hintTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    // A session, but nothing stored about the account yet.
    final loadingAccount =
        ref.watch(authControllerProvider.select((state) => state.status == AuthStatus.authenticated)) &&
        ref.watch(cardGateProvider) == CardGate.checking;

    return ColoredBox(
      color: dark ? AppTheme.splashDark : AppTheme.splashLight,
      child: Stack(
        children: [
          // The logo stays exactly centred, where the native splash drew it.
          const Center(
            child: Image(
              image: SplashScreen.logo,
              width: SplashScreen._logoSize,
              height: SplashScreen._logoSize,
              excludeFromSemantics: true,
            ),
          ),
          if (_spinner)
            Positioned(
              left: 24,
              right: 24,
              bottom: 96,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox.square(dimension: 32, child: CircularProgressIndicator(strokeWidth: 3)),
                  if (_hintDue && loadingAccount) ...[
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context).splashLoadingAccount,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
