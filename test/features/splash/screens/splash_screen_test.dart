import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';

void main() {
  testWidgets('the splash shows a spinner below the logo', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    final logo = tester.getRect(find.byType(Image));
    final spinner = tester.getRect(find.byType(CircularProgressIndicator));
    final screen = tester.getRect(find.byType(SplashScreen));
    expect(logo.center, screen.center);
    expect(spinner.top, greaterThan(logo.bottom));
    expect(spinner.center.dx, logo.center.dx);
  });
}
