import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

import 'package:mobile_kkm/core/platform/location_service.dart';
import 'package:mobile_kkm/features/account/widgets/link_sheet.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';

void main() {
  testWidgets('the map section shows the map under a search bar', (tester) async {
    final app = await pumpApp(tester, FakeAdapter(), session: signedInSession);
    expect(find.byKey(fakeMapKey), findsNothing);

    await openTab(tester, 'Map');

    expect(app.location, '/map');
    expect(find.byKey(fakeMapKey), findsOneWidget);
    expect(find.widgetWithText(SearchBar, 'Search for a stop'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    // From the top edge down to the navigation bar.
    expect(tester.getTopLeft(find.byKey(fakeMapKey)), Offset.zero);
    expect(tester.getBottomLeft(find.byKey(fakeMapKey)), tester.getTopLeft(find.byType(NavigationBar)));
  });

  testWidgets('the map is kept while another section is open', (tester) async {
    await pumpApp(tester, FakeAdapter(), session: signedInSession);
    await openTab(tester, 'Map');
    final map = tester.element(find.byKey(fakeMapKey));

    await openTab(tester, 'Home');
    await openTab(tester, 'Map');

    expect(tester.element(find.byKey(fakeMapKey)), same(map));
  });

  testWidgets('the info button names the sources of the map and opens their sites', (tester) async {
    final opened = <Uri>[];
    await pumpApp(tester, FakeAdapter(), session: signedInSession, openedUrls: opened);
    await openTab(tester, 'Map');

    await tester.tap(find.byTooltip('Map data'));
    await tester.pumpAndSettle();
    for (final name in ['© OpenStreetMap contributors', '© OpenMapTiles', 'OpenFreeMap']) {
      expect(find.text(name), findsOneWidget);
    }
    // Each a map source, and marked as leaving the app.
    final sheet = find.byType(LinkSheet);
    expect(find.descendant(of: sheet, matching: find.byIcon(Symbols.map_rounded)), findsNWidgets(3));
    expect(find.descendant(of: sheet, matching: find.byIcon(Symbols.open_in_new_rounded)), findsNWidgets(3));

    await tester.tap(find.text('© OpenStreetMap contributors'));
    await tester.pumpAndSettle();
    expect(opened, [Uri.parse('https://openstreetmap.org/copyright')]);
  });

  testWidgets('the filter button sits above the location button and is not built yet', (tester) async {
    await pumpApp(tester, FakeAdapter(), session: signedInSession);
    await openTab(tester, 'Map');
    final filters = find.byTooltip('Filters');

    // The location button is the one nearest the thumb.
    expect(tester.getBottomLeft(filters).dy, lessThan(tester.getTopLeft(find.byTooltip('My location')).dy));

    await tester.tap(filters);
    await tester.pumpAndSettle();
    expect(find.text('Coming soon'), findsOneWidget);
  });

  group('the location button', () {
    const position = (latitude: 50.07, longitude: 19.95);
    final button = find.byTooltip('My location');

    testWidgets('asks for access, then shows the position, moves the map there and follows it', (tester) async {
      final location = FakeLocationService(access: LocationAccess.granted, position: position);
      final app = await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
      await openTab(tester, 'Map');
      expect(location.requests, 0);
      expect(app.map.showLocation, isFalse);

      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(location.requests, 1);
      expect(app.map.showLocation, isTrue);
      expect(app.map.moves, [position]);
      expect(app.map.followLocation, isTrue);
    });

    testWidgets('stops following when the map is dragged away, and takes it up again', (tester) async {
      final location = FakeLocationService(access: LocationAccess.granted, position: position);
      final app = await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
      await openTab(tester, 'Map');
      await tester.tap(button);
      await tester.pumpAndSettle();

      app.map.dragAway();
      await tester.pumpAndSettle();
      expect(app.map.followLocation, isFalse);
      expect(app.map.showLocation, isTrue);

      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(app.map.followLocation, isTrue);
      expect(app.map.moves, [position, position]);
    });

    testWidgets('shows a spinner until the position is there', (tester) async {
      final location = FakeLocationService(access: LocationAccess.granted, position: position)..fix = Completer();
      final app = await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
      await openTab(tester, 'Map');

      await tester.tap(button);
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.descendant(of: button, matching: find.byType(CircularProgressIndicator)), findsOneWidget);
      expect(app.map.followLocation, isFalse);

      location.fix!.complete();
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(app.map.followLocation, isTrue);
    });

    testWidgets('says so when access is refused, and leaves the map alone', (tester) async {
      final location = FakeLocationService(position: position);
      final app = await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
      await openTab(tester, 'Map');

      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(find.text('Allow access to your location to see where you are.'), findsOneWidget);
      expect(find.text('Settings'), findsNothing);
      expect(app.map.showLocation, isFalse);
      expect(app.map.followLocation, isFalse);
      expect(app.map.moves, isEmpty);
    });

    testWidgets('leads to the settings once access is refused for good', (tester) async {
      final location = FakeLocationService(access: LocationAccess.deniedForever);
      await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
      await openTab(tester, 'Map');

      await tester.tap(button);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(location.openedSettings, 1);
    });

    testWidgets('says so when location is switched off', (tester) async {
      final location = FakeLocationService(access: LocationAccess.serviceOff);
      await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
      await openTab(tester, 'Map');

      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(find.text('Location is turned off on this device.'), findsOneWidget);
    });

    testWidgets('follows as soon as there is a position when there is none yet', (tester) async {
      final location = FakeLocationService(access: LocationAccess.granted);
      final app = await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
      await openTab(tester, 'Map');

      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(app.map.moves, isEmpty);
      expect(app.map.followLocation, isTrue);
    });
  });

  testWidgets('with access given earlier the map goes to the position by itself', (tester) async {
    const position = (latitude: 50.07, longitude: 19.95);
    final location = FakeLocationService(granted: true, position: position);
    final app = await pumpApp(tester, FakeAdapter(), session: signedInSession, location: location);
    await openTab(tester, 'Map');

    expect(app.map.showLocation, isTrue);
    expect(app.map.followLocation, isTrue);
    expect(location.requests, 0);
    expect(app.map.moves, [position]);
  });
}
