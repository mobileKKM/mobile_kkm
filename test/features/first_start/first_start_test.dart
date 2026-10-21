import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/first_start/screens/first_start_screen.dart';

import '../../support/fake_adapter.dart';
import '../../support/harness.dart';

void main() {
  testWidgets('the first start shows the notice, and I understand leads to Sign in', (tester) async {
    final store = InMemoryFirstStartStore(seen: false);
    final app = await pumpApp(tester, FakeAdapter(), firstStart: store);

    expect(app.location, '/first-start');
    expect(find.text('Before you start'), findsOneWidget);
    expect(find.text('Unofficial'), findsOneWidget);
    expect(find.text('Open source'), findsOneWidget);
    expect(find.text('No warranty'), findsOneWidget);

    await tapVisible(tester, find.text('I understand'));

    expect(app.location, '/login');
    expect(store.seen, isTrue);
  });

  testWidgets('a signed-in first start sees the notice too, then Home', (tester) async {
    final app = await pumpApp(
      tester,
      FakeAdapter(),
      session: signedInSession,
      firstStart: InMemoryFirstStartStore(seen: false),
    );

    expect(app.location, '/first-start');

    await tapVisible(tester, find.text('I understand'));

    expect(app.location, '/home');
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('View source code opens the repository and keeps the notice', (tester) async {
    final opened = <Uri>[];
    final app = await pumpApp(
      tester,
      FakeAdapter(),
      openedUrls: opened,
      firstStart: InMemoryFirstStartStore(seen: false),
    );

    await tapVisible(tester, find.text('View source code'));

    expect(opened, [Uri.parse('https://github.com/mobileKKM/mobile_kkm')]);
    expect(app.location, '/first-start');
  });

  testWidgets('an e-mail link on the first start opens after the notice', (tester) async {
    final app = await pumpApp(tester, FakeAdapter(), firstStart: InMemoryFirstStartStore(seen: false));

    app.router.go('/konto-uzytkownika/activate,0a1b2c.html');
    await tester.pumpAndSettle();
    expect(app.location, '/first-start');

    await tapVisible(tester, find.text('I understand'));

    expect(app.location, '/activate/0a1b2c');
  });

  testWidgets('once seen, the app starts on Sign in', (tester) async {
    final app = await pumpApp(tester, FakeAdapter());

    expect(app.location, '/login');
    expect(find.byType(FirstStartScreen), findsNothing);
  });
}
