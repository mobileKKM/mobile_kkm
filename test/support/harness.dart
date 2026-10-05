import 'package:dio/dio.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/app.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';

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

final signedInSession = AuthSession(
  token: 'aaa.bbb.ccc',
  refresh: 'feedfacefeedfacefeedfacefeedface',
  expires: DateTime.utc(2100),
);

class App {
  App(this.client, this.router);

  final EkpClient client;
  final GoRouter router;
}

/// Pumps the whole app on a phone-sized surface, backed by [adapter].
Future<App> pumpApp(
  WidgetTester tester,
  FakeAdapter adapter, {
  AuthSession? session,
  LinkSettings? linkSettings,
  List<Uri>? openedUrls,
  UserDataCache? userDataCache,
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

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        ekpClientProvider.overrideWithValue(client),
        linkSettingsProvider.overrideWithValue(linkSettings ?? FakeLinkSettings()),
        userDataCacheProvider.overrideWithValue(userDataCache ?? InMemoryUserDataCache()),
        // Records instead of launching a browser.
        urlOpenerProvider.overrideWithValue((url) async {
          openedUrls?.add(url);
          return true;
        }),
      ],
      child: const MobileKkmApp(),
    ),
  );
  await tester.pumpAndSettle();

  final container = ProviderScope.containerOf(tester.element(find.byType(MobileKkmApp)));
  return App(client, container.read(routerProvider));
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

Finder field(String label) => find.widgetWithText(TextFormField, label);
