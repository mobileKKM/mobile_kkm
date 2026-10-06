import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../support/fake_adapter.dart';
import '../../support/harness.dart';

void main() {
  testWidgets('each section has its own location', (tester) async {
    final app = await pumpApp(tester, FakeAdapter(), session: signedInSession);
    expect(app.location, '/home');

    for (final (label, location) in [
      ('Tickets', '/tickets'),
      ('Map', '/map'),
      ('Account', '/account'),
      ('Home', '/home'),
    ]) {
      await openTab(tester, label);
      expect(app.location, location);
    }
  });

  testWidgets('a section keeps its state while another one is open', (tester) async {
    await pumpApp(tester, FakeAdapter(), session: signedInSession);
    await openTab(tester, 'Tickets');
    await tester.tap(find.text('Past'));
    await tester.pumpAndSettle();

    await openTab(tester, 'Home');
    await openTab(tester, 'Tickets');

    expect(tester.widget<SegmentedButton<bool>>(find.byType(SegmentedButton<bool>)).selected, {true});
  });

  testWidgets('a screen that is not built yet opens above the navigation bar and can be left', (tester) async {
    final app = await pumpApp(tester, FakeAdapter(), session: signedInSession);

    await tester.tap(find.text('Karta Krakowska'));
    await tester.pumpAndSettle();
    expect(app.location, '/karta-krakowska');
    expect(find.text('Coming soon'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(app.location, '/home');
  });
}
