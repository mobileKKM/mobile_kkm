import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/app.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';
import 'package:mobile_kkm/core/platform/location_service.dart';
import 'package:mobile_kkm/core/providers/database_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/services/photo_cache.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';
import 'package:mobile_kkm/features/map/models/map_view_controller.dart';
import 'package:mobile_kkm/features/map/providers/map_providers.dart';

import 'fake_adapter.dart';

class FakeLinkSettings extends LinkSettings {
  FakeLinkSettings({this.supported = true, this.enabled = false});

  final bool supported;
  bool enabled;
  int openedSettings = 0;

  @override
  bool get isSupported => supported;

  @override
  Future<bool> canOpenLinks() async => enabled;

  @override
  Future<void> openSettings() async => openedSettings++;
}

class InMemoryUserDataCache implements UserDataCache {
  InMemoryUserDataCache([this.data]);

  UserDataResponse? data;

  @override
  Future<UserDataResponse?> read() async => data;

  @override
  Future<void> write(UserDataResponse data) async => this.data = data;

  @override
  Future<void> clear() async => data = null;
}

/// Serves a one-pixel image for any URL and notes what was asked of it.
class FakePhotoCache implements PhotoCache {
  static final _pixel = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==',
  );

  final requested = <String>[];
  int cleared = 0;

  @override
  ImageProvider image(String url) {
    requested.add(url);
    return MemoryImage(_pixel);
  }

  @override
  Future<void> clear() async => cleared++;
}

/// Stands in for the native map view, which a widget test cannot create.
const fakeMapKey = Key('fake-map');

/// What the screen asked of the map view.
class FakeMapView {
  final moves = <Coordinates>[];
  bool showLocation = false;
  bool followLocation = false;
  VoidCallback _onFollowEnded = () {};

  /// The user drags the map away from their position.
  void dragAway() => _onFollowEnded();

  Widget build(
    BuildContext context, {
    required MapViewController controller,
    required bool showLocation,
    required bool followLocation,
    required VoidCallback onFollowEnded,
  }) {
    this.showLocation = showLocation;
    this.followLocation = followLocation;
    _onFollowEnded = onFollowEnded;
    controller.attach((target) async => moves.add(target));
    return const SizedBox.expand(key: fakeMapKey);
  }
}

/// A device whose answer to the permission request is [access].
class FakeLocationService extends LocationService {
  FakeLocationService({this.access = LocationAccess.denied, this.granted = false, this.position});

  LocationAccess access;

  /// Whether the permission was given before the app asked.
  bool granted;
  Coordinates? position;

  /// Set to keep [current] waiting, as for a first fix; complete to go on.
  Completer<void>? fix;
  int requests = 0;
  int openedSettings = 0;

  @override
  Future<bool> hasAccess() async => granted;

  @override
  Future<LocationAccess> requestAccess() async {
    requests++;
    return access;
  }

  @override
  Future<Coordinates?> current() async {
    await fix?.future;
    return position;
  }

  @override
  Future<void> openSettings() async => openedSettings++;
}

final signedInSession = AuthSession(
  token: 'aaa.bbb.ccc',
  refresh: 'feedfacefeedfacefeedfacefeedface',
  expires: DateTime.utc(2100),
);

class App {
  App(this.client, this.router, this.database, this.map);

  /// The path of the screen on top.
  String get location => router.state.uri.path;

  final EkpClient client;
  final GoRouter router;
  final AppDatabase database;
  final FakeMapView map;
}

/// Pumps the whole app on a phone-sized surface, backed by [adapter].
Future<App> pumpApp(
  WidgetTester tester,
  FakeAdapter adapter, {
  AuthSession? session,
  LinkSettings? linkSettings,
  List<Uri>? openedUrls,
  UserDataCache? userDataCache,
  AppDatabase? database,
  PhotoCache? photoCache,
  LocationService? location,
  bool settle = true,
}) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final store = InMemoryTokenStore();
  if (session != null) {
    await store.write(session);
  }
  final client = EkpClient(
    dio: Dio(BaseOptions(baseUrl: 'https://ekp.test'))..httpClientAdapter = adapter,
    tokenStore: store,
  );
  addTearDown(client.dispose);
  // Pass one in to seed it, or to keep it across two app runs in one test.
  final db = database ?? AppDatabase(NativeDatabase.memory());

  // Owned here rather than by a ProviderScope in the tree: disposing the
  // providers with the tree would cancel drift's stream queries, which
  // schedules a timer that the test framework then reports as pending.
  final map = FakeMapView();
  final container = ProviderContainer(
    overrides: [
      ekpClientProvider.overrideWithValue(client),
      linkSettingsProvider.overrideWithValue(linkSettings ?? FakeLinkSettings()),
      userDataCacheProvider.overrideWithValue(userDataCache ?? InMemoryUserDataCache()),
      appDatabaseProvider.overrideWithValue(db),
      photoCacheProvider.overrideWithValue(photoCache ?? FakePhotoCache()),
      mapViewProvider.overrideWithValue(map.build),
      locationServiceProvider.overrideWithValue(location ?? FakeLocationService()),
      appVersionProvider.overrideWith((ref) => '1.2.3 (45)'),
      // Records instead of launching a browser.
      urlOpenerProvider.overrideWithValue((url) async {
        openedUrls?.add(url);
        return true;
      }),
    ],
  );
  addTearDown(() async {
    container.dispose();
    if (database == null) {
      await db.close();
    }
  });

  await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const MobileKkmApp()));
  // Not while the splash is meant to stay up: its spinner never settles.
  if (settle) {
    await tester.pumpAndSettle();
  }

  return App(client, container.read(routerProvider), db, map);
}

/// Scrolls [finder] into view, then taps it.
Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  // A focused text field scrolls itself back into view on the next frame,
  // which would undo the scroll below.
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Opens one of the four sections by its label in the navigation bar.
Future<void> openTab(WidgetTester tester, String label) async {
  await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text(label)));
  await tester.pumpAndSettle();
}

/// Pulls the first scrollable down far enough to trigger its refresh.
Future<void> pullToRefresh(WidgetTester tester) async {
  await tester.fling(find.byType(Scrollable).first, const Offset(0, 400), 1000);
  await tester.pumpAndSettle();
}

/// Signs out from the Account section, confirming the dialog.
Future<void> signOut(WidgetTester tester) async {
  await openTab(tester, 'Account');
  await tapVisible(tester, find.widgetWithText(OutlinedButton, 'Sign out'));
  await tester.tap(find.widgetWithText(TextButton, 'Sign out'));
  await tester.pumpAndSettle();
}

Finder field(String label) => find.widgetWithText(TextFormField, label);
