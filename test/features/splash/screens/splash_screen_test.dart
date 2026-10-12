import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/providers/card_gate_provider.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

class _FixedAuth extends AuthController {
  _FixedAuth(this.status);

  final AuthStatus status;

  @override
  AuthState build() => AuthState(status);
}

Future<void> _pump(WidgetTester tester, {AuthStatus status = AuthStatus.unknown}) => tester.pumpWidget(
  ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(() => _FixedAuth(status)),
      cardGateProvider.overrideWithValue(CardGate.checking),
    ],
    child: const MaterialApp(localizationsDelegates: AppLocalizations.localizationsDelegates, home: SplashScreen()),
  ),
);

void main() {
  testWidgets('the splash is the logo alone, then a spinner near the bottom', (tester) async {
    await _pump(tester);

    final screen = tester.getRect(find.byType(SplashScreen));
    expect(tester.getRect(find.byType(Image)).center, screen.center);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.pump(SplashScreen.spinnerDelay);
    final spinner = tester.getRect(find.byType(CircularProgressIndicator));
    expect(spinner.size, const Size.square(32));
    expect(spinner.bottom, screen.bottom - 96);
    expect(spinner.center.dx, screen.center.dx);
    // The logo has not moved.
    expect(tester.getRect(find.byType(Image)).center, screen.center);

    // Nothing is said about an account while there is no session.
    await tester.pump(SplashScreen.hintDelay);
    expect(find.text('Loading your account…'), findsNothing);
  });

  testWidgets('a long wait for the first user data is explained', (tester) async {
    await _pump(tester, status: AuthStatus.authenticated);

    await tester.pump(SplashScreen.spinnerDelay);
    expect(find.text('Loading your account…'), findsNothing);

    await tester.pump(SplashScreen.hintDelay - SplashScreen.spinnerDelay);
    expect(find.text('Loading your account…'), findsOneWidget);
    // The words go under the spinner, which makes room for them.
    final spinner = tester.getRect(find.byType(CircularProgressIndicator));
    final hint = tester.getRect(find.text('Loading your account…'));
    expect(hint.top, spinner.bottom + 12);
    expect(hint.bottom, tester.getRect(find.byType(SplashScreen)).bottom - 96);
  });
}
