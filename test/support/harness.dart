import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/app.dart';
import 'package:mobile_kkm/core/crypto/aztec_key.dart';
import 'package:mobile_kkm/core/crypto/aztec_key_relay.dart';
import 'package:mobile_kkm/core/crypto/aztec_key_store.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/core/dictionaries/dictionary_cache.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';
import 'package:mobile_kkm/core/platform/location_service.dart';
import 'package:mobile_kkm/core/platform/payment_browser.dart';
import 'package:mobile_kkm/core/platform/photo_picker.dart';
import 'package:mobile_kkm/core/platform/scan_display.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/aztec_key_provider.dart';
import 'package:mobile_kkm/core/providers/database_provider.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/services/photo_cache.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';
import 'package:mobile_kkm/features/map/models/map_view_controller.dart';
import 'package:mobile_kkm/features/map/providers/map_providers.dart';
import 'package:mobile_kkm/features/purchase/services/last_payment_method_store.dart';

import 'fake_adapter.dart';
import 'sample_data.dart';

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

class InMemoryLastPaymentMethodStore implements LastPaymentMethodStore {
  InMemoryLastPaymentMethodStore([this.groupId]);

  String? groupId;

  @override
  Future<String?> read() async => groupId;

  @override
  Future<void> write(String groupId) async => this.groupId = groupId;

  @override
  Future<void> clear() async => groupId = null;
}

/// Keeps the dictionaries as the JSON text a file would hold.
class InMemoryDictionaryCache implements DictionaryCache {
  final _stored = <String, (String, DateTime)>{};

  Iterable<String> get names => _stored.keys;

  @override
  Future<CachedDictionary?> read(String name) async {
    final stored = _stored[name];
    return stored == null ? null : CachedDictionary(jsonDecode(stored.$1) as Map<String, dynamic>, stored.$2);
  }

  @override
  Future<void> write(String name, Map<String, dynamic> json, DateTime fetchedAt) async =>
      _stored[name] = (jsonEncode(json), fetchedAt);
}

/// Keeps the relay's key as the JSON text a file would hold.
class InMemoryAztecKeyStore implements AztecKeyStore {
  InMemoryAztecKeyStore([AztecKey? key]) : _stored = key == null ? null : jsonEncode(key.toJson());

  String? _stored;
  int writes = 0;

  @override
  Future<AztecKey?> read() async {
    final stored = _stored;
    return stored == null ? null : AztecKey.fromJson(jsonDecode(stored) as Map<String, dynamic>);
  }

  @override
  Future<void> write(AztecKey key) async {
    writes++;
    _stored = jsonEncode(key.toJson());
  }
}

/// A PNG of one pixel.
final onePixelPng = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==',
);

/// Hands over [photo] for the camera and the gallery alike, and notes which
/// was asked for. Without one, the user backed out.
class FakePhotoPicker extends PhotoPicker {
  FakePhotoPicker([this.photo]);

  Uint8List? photo;
  final sources = <PhotoSource>[];

  @override
  Future<Uint8List?> pick(PhotoSource source) async {
    sources.add(source);
    return photo;
  }
}

/// Serves a one-pixel image for any URL and notes what was asked of it.
class FakePhotoCache implements PhotoCache {
  final requested = <String>[];
  int cleared = 0;

  @override
  ImageProvider image(String url) {
    requested.add(url);
    return MemoryImage(onePixelPng);
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

/// Notes when the screen was protected, and plays a screen recording.
class FakeScreenSecurity extends ScreenSecurity {
  final _captured = StreamController<bool>.broadcast();

  /// Every change asked for, in order.
  final changes = <bool>[];

  bool get secure => changes.isNotEmpty && changes.last;

  /// A recording starts or stops (iOS).
  void capture(bool capturing) => _captured.add(capturing);

  @override
  Future<void> setSecure(bool secure) async => changes.add(secure);

  @override
  Stream<bool> get captured => _captured.stream;
}

/// Notes when the display was turned up and kept awake.
/// The payment browser: records what it opened, and plays the return link,
/// the closing, or a return link the app was started with.
class FakePaymentBrowser implements PaymentBrowser {
  FakePaymentBrowser({this.initial});

  final opened = <Uri>[];
  var closed = 0;

  /// What [initialReturn] hands out once.
  Uri? initial;
  final _events = StreamController<PaymentBrowserEvent>.broadcast();

  void returnTo(Uri url) => _events.add(PaymentReturned(url));

  void closeByUser() => _events.add(const PaymentBrowserClosed());

  @override
  Stream<PaymentBrowserEvent> get events => _events.stream;

  @override
  Future<void> open(Uri url, {required Color toolbarColor, required Color tintColor}) async => opened.add(url);

  @override
  Future<void> close() async => closed++;

  @override
  Future<Uri?> initialReturn() async {
    final url = initial;
    initial = null;
    return url;
  }
}

class FakeScanDisplay extends ScanDisplay {
  /// Every change asked for, in order.
  final changes = <bool>[];

  bool get active => changes.isNotEmpty && changes.last;

  @override
  Future<void> setActive(bool active) async => changes.add(active);
}

final signedInSession = AuthSession(
  token: 'aaa.bbb.ccc',
  refresh: 'feedfacefeedfacefeedfacefeedface',
  expires: DateTime.utc(2100),
);

/// What the device calls itself in the tests.
const testHardwareName = 'Test Phone';

/// One identity the debug menu stored.
typedef SavedIdentity = ({String deviceId, String? deviceName});

class App {
  App(
    this.client,
    this.relay,
    this.router,
    this.database,
    this.map,
    this.screen,
    this.scanDisplay,
    this.savedIdentities,
    this.container,
    this.paymentBrowser,
  );

  /// The path of the screen on top.
  String get location => router.state.uri.path;

  final EkpClient client;

  /// The aztec key relay. Without a canned reply it has no key to give (404),
  /// and the app keeps the one it has.
  final FakeAdapter relay;
  final GoRouter router;
  final AppDatabase database;
  final FakeMapView map;
  final FakeScreenSecurity screen;
  final FakeScanDisplay scanDisplay;

  /// Every identity the debug menu stored, in order.
  final List<SavedIdentity> savedIdentities;

  /// For providers that no screen shows.
  final ProviderContainer container;

  /// tPay's page: what was opened, and its return link or closing.
  final FakePaymentBrowser paymentBrowser;
}

/// Pumps the whole app on a phone-sized surface, backed by [adapter].
Future<App> pumpApp(
  WidgetTester tester,
  FakeAdapter adapter, {
  AuthSession? session,
  LinkSettings? linkSettings,
  List<Uri>? openedUrls,
  UserDataCache? userDataCache,
  LastPaymentMethodStore? lastPaymentMethod,
  DictionaryCache? dictionaryCache,
  AppDatabase? database,
  PhotoCache? photoCache,
  LocationService? location,
  PhotoPicker? photoPicker,
  FakeAdapter? relay,
  FakePaymentBrowser? paymentBrowser,
  AztecKeyStore? aztecKeyStore,
  bool settle = true,
  bool tall = false,
}) async {
  // [tall]: room for a whole list, where a test is about all of its entries.
  tester.view.physicalSize = tall ? const Size(1080, 9000) : const Size(1080, 2400);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  // A signed-in app without user data signs out again, so there is an
  // account with a card unless the test says otherwise.
  adapter.fallback('GET', '/account/user-data', 200, userDataJson());

  final store = InMemoryTokenStore();
  if (session != null) {
    await store.write(session);
  }
  late final ProviderContainer container;
  final browser = paymentBrowser ?? FakePaymentBrowser();
  final client = EkpClient(
    dio: Dio(BaseOptions(baseUrl: 'https://ekp.test'))..httpClientAdapter = adapter,
    tokenStore: store,
    // As `ekpClientProvider` does it.
    aztecKey: () => container.read(aztecKeyInUseProvider).pem,
  );
  final keyRelay = relay ?? FakeAdapter();
  addTearDown(client.dispose);
  // Pass one in to seed it, or to keep it across two app runs in one test.
  final db = database ?? AppDatabase(NativeDatabase.memory());

  // Owned here rather than by a ProviderScope in the tree: disposing the
  // providers with the tree would cancel drift's stream queries, which
  // schedules a timer that the test framework then reports as pending.
  final map = FakeMapView();
  final screen = FakeScreenSecurity();
  final scanDisplay = FakeScanDisplay();
  final savedIdentities = <SavedIdentity>[];
  container = ProviderContainer(
    overrides: [
      ekpClientProvider.overrideWithValue(client),
      // Only the debug menu reads it here: the client above is fixed.
      deviceIdentityProvider.overrideWith(
        () => DeviceIdentityController(
          client.device,
          hardwareName: testHardwareName,
          save: ({required deviceId, required deviceName}) async =>
              savedIdentities.add((deviceId: deviceId, deviceName: deviceName)),
        ),
      ),
      linkSettingsProvider.overrideWithValue(linkSettings ?? FakeLinkSettings()),
      userDataCacheProvider.overrideWithValue(userDataCache ?? InMemoryUserDataCache()),
      lastPaymentMethodStoreProvider.overrideWithValue(lastPaymentMethod ?? InMemoryLastPaymentMethodStore()),
      appDatabaseProvider.overrideWithValue(db),
      dictionaryCacheProvider.overrideWithValue(dictionaryCache ?? InMemoryDictionaryCache()),
      aztecKeyRelayProvider.overrideWithValue(
        AztecKeyRelay(
          Dio(BaseOptions(baseUrl: 'https://relay.test/api/v1/'))..httpClientAdapter = keyRelay,
          userAgent: 'mobileKKM/1.2.3',
        ),
      ),
      aztecKeyStoreProvider.overrideWithValue(aztecKeyStore ?? InMemoryAztecKeyStore()),
      photoCacheProvider.overrideWithValue(photoCache ?? FakePhotoCache()),
      mapViewProvider.overrideWithValue(map.build),
      locationServiceProvider.overrideWithValue(location ?? FakeLocationService()),
      photoPickerProvider.overrideWithValue(photoPicker ?? FakePhotoPicker()),
      screenSecurityProvider.overrideWithValue(screen),
      scanDisplayProvider.overrideWithValue(scanDisplay),
      paymentBrowserProvider.overrideWithValue(browser),
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

  return App(
    client,
    keyRelay,
    container.read(routerProvider),
    db,
    map,
    screen,
    scanDisplay,
    savedIdentities,
    container,
    browser,
  );
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

/// A frame, and time for a route to come or go, on a screen with a spinner
/// up (the Payment screen while tPay opens or a check runs), which never
/// settles.
Future<void> pumpWithSpinner(WidgetTester tester) => pumpWithCode(tester);

/// A frame, and time for a route to come or go: in `pumpAndSettle`'s place
/// on a screen with a code up, whose ring moves for as long as it is open
/// and so never settles.
Future<void> pumpWithCode(WidgetTester tester) async {
  await tester.pump();
  // Longer than a page transition, shorter than the second a code counts.
  await tester.pump(const Duration(milliseconds: 850));
  // The transition is through; this takes the route it left off the stage.
  await tester.pump(const Duration(milliseconds: 50));
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
  await tester.tap(find.widgetWithText(FilledButton, 'Sign out'));
  await tester.pumpAndSettle();
}

Finder field(String label) => find.widgetWithText(TextFormField, label);

/// What a password manager is told about the text field under [finder].
Iterable<String>? autofillHintsOf(WidgetTester tester, Finder finder) =>
    tester.widget<TextField>(find.descendant(of: finder, matching: find.byType(TextField))).autofillHints;
