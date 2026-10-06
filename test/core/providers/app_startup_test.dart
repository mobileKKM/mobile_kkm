import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';

import '../../support/fake_adapter.dart';
import '../../support/harness.dart';
import '../../support/sample_data.dart';

const _offline = "You're offline. Showing saved data.";

void main() {
  testWidgets('the splash stays up until the service status and the config have answered', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/service-status', 200, {'isAvailable': true});
    final releaseStatus = adapter.hold('GET', '/service-status');
    final releaseConfig = adapter.hold('GET', '/client/mobile-app/config');
    await pumpApp(tester, adapter, session: signedInSession, settle: false);

    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(SplashScreen), findsOneWidget);

    releaseStatus();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(adapter.requestsTo('/client/mobile-app/config'), hasLength(1));

    releaseConfig();
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('an unreachable server starts the app offline, without asking for the config', (tester) async {
    final adapter = FakeAdapter()..fail('GET', '/service-status');
    await pumpApp(tester, adapter, session: signedInSession);

    expect(find.text(_offline), findsOneWidget);
    expect(adapter.requestsTo('/client/mobile-app/config'), isEmpty);
  });

  testWidgets('a switched-off service shows its message and still loads the config', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', '/service-status', 200, {'isAvailable': false, 'customMessage': 'Przerwa techniczna do 12:00.'});
    await pumpApp(tester, adapter, session: signedInSession);

    expect(find.text('Przerwa techniczna do 12:00.'), findsOneWidget);
    expect(adapter.requestsTo('/client/mobile-app/config'), hasLength(1));
  });

  testWidgets('a config that cannot be loaded does not hold up the app', (tester) async {
    final adapter = FakeAdapter()..fail('GET', '/client/mobile-app/config');
    await pumpApp(tester, adapter, session: signedInSession);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text(_offline), findsNothing);
  });

  testWidgets('the config is requested once per run', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/client/mobile-app/config', 200, appConfigJson);
    await pumpApp(tester, adapter, session: signedInSession);

    await openTab(tester, 'Account');
    for (var i = 0; i < 2; i++) {
      await tapVisible(tester, find.text('Regulations'));
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
    }
    await openTab(tester, 'Home');
    await pullToRefresh(tester);

    expect(adapter.requestsTo('/client/mobile-app/config'), hasLength(1));
  });

  testWidgets('the user data and the tickets are asked for only after the config', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/client/mobile-app/config', 200, appConfigJson);
    final releaseConfig = adapter.hold('GET', '/client/mobile-app/config');
    await pumpApp(tester, adapter, session: signedInSession, settle: false);

    await tester.pump(const Duration(seconds: 1));
    expect(adapter.requestsTo('/client/mobile-app/config'), hasLength(1));
    expect(adapter.requestsTo('/account/user-data'), isEmpty);
    expect(adapter.requestsTo('/mkkm/tickets/list'), isEmpty);

    releaseConfig();
    await tester.pumpAndSettle();
    // The user data and the tickets follow in no particular order.
    final paths = [for (final request in adapter.requests) request.path.replaceFirst('/api/v1', '')];
    const expected = ['/service-status', '/client/mobile-app/config', '/account/user-data', '/mkkm/tickets/list'];
    final seen = paths.where(expected.contains).toList();
    expect(seen.take(2), expected.take(2));
    expect(seen.skip(2), unorderedEquals(expected.skip(2)));
  });

  group('a server that wants a newer client', () {
    FakeAdapter adapter() =>
        FakeAdapter()..reply('GET', '/client/mobile-app/config', 200, {...appConfigJson, 'minAppVersion': '99.0.0'});

    testWidgets('stops a signed-in user before anything else is requested', (tester) async {
      final requests = adapter();
      final opened = <Uri>[];
      final app = await pumpApp(tester, requests, session: signedInSession, openedUrls: opened);

      expect(app.location, '/update-required');
      expect(find.text('Update required'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(requests.requestsTo('/account/user-data'), isEmpty);
      expect(requests.requestsTo('/mkkm/tickets/list'), isEmpty);

      await tester.tap(find.text('Get the latest version'));
      await tester.pumpAndSettle();
      expect(opened.single.toString(), 'https://github.com/mobileKKM/mobile_kkm/releases');
    });

    testWidgets('stops a signed-out user before the login screen', (tester) async {
      final app = await pumpApp(tester, adapter());

      expect(app.location, '/update-required');
      app.router.go('/login');
      await tester.pumpAndSettle();
      expect(app.location, '/update-required');
    });
  });

  testWidgets('a minimum version the client meets lets the app through', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', '/client/mobile-app/config', 200, {...appConfigJson, 'minAppVersion': EkpDefaults.clientVersion});
    final app = await pumpApp(tester, adapter, session: signedInSession);

    expect(app.location, '/home');
  });

  testWidgets('pulling to refresh leaves offline mode and loads the config', (tester) async {
    final adapter = FakeAdapter()..fail('GET', '/service-status');
    await pumpApp(tester, adapter, session: signedInSession);
    expect(find.text(_offline), findsOneWidget);

    adapter.reply('GET', '/service-status', 200, {'isAvailable': true});
    await pullToRefresh(tester);

    expect(find.text(_offline), findsNothing);
    expect(adapter.requestsTo('/client/mobile-app/config'), hasLength(1));
  });
}
