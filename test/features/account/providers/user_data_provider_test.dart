import 'dart:convert';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';

Map<String, dynamic> _userData(String firstName) => {
  'userData': {
    'firstName': firstName,
    'lastName': 'Testowy',
    'email': 'jan@example.com',
    'birthDate': '2000-01-03T00:00:00',
  },
  'mkkmData': {'customerCode': '100001'},
};

Iterable<Object> _userDataRequests(FakeAdapter adapter) =>
    adapter.requests.where((r) => r.path.endsWith('/account/user-data'));

void main() {
  testWidgets('is fetched once after sign-in and written to the cache', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/account/user-data', 200, _userData('Jan'));
    final cache = InMemoryUserDataCache();
    await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    await openTab(tester, 'Account');
    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(_userDataRequests(adapter), hasLength(1));
    expect(cache.data?.userData?.firstName, 'Jan');
  });

  testWidgets('the cached copy is used when the server is unreachable', (tester) async {
    final adapter = FakeAdapter()..fail('GET', '/account/user-data');
    final cache = InMemoryUserDataCache(UserDataResponse.fromJson(_userData('Jan')));
    await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    expect(find.text('Hello, Jan!'), findsOneWidget);
    expect(cache.data?.userData?.firstName, 'Jan');
  });

  testWidgets('without a cached copy an unreachable server ends the session', (tester) async {
    final adapter = FakeAdapter()..fail('GET', '/account/user-data');
    final cache = InMemoryUserDataCache();
    final app = await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    expect(app.location, '/login');
    expect(await app.client.session.currentSession(), isNull);
    expect(cache.data, isNull);
  });

  testWidgets('an answer that comes after the limit is not stored', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/account/user-data', 200, _userData('Jan'));
    final release = adapter.hold('GET', '/account/user-data');
    final cache = InMemoryUserDataCache();
    final app = await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache, settle: false);

    await tester.pump(const Duration(seconds: 9));
    release();
    await tester.pumpAndSettle();

    expect(app.location, '/login');
    expect(cache.data, isNull);
  });

  testWidgets('a cached copy is refreshed once in the background', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/account/user-data', 200, _userData('Janusz'));
    final cache = InMemoryUserDataCache(UserDataResponse.fromJson(_userData('Jan')));
    await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    expect(find.text('Hello, Janusz!'), findsOneWidget);
    expect(_userDataRequests(adapter), hasLength(1));
    expect(cache.data?.userData?.firstName, 'Janusz');
  });

  testWidgets('signing out clears the cached copy, the stored photo and the last payment method', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', '/account/user-data', 200, _userData('Jan'))
      ..reply('POST', '/auth/logout', 200);
    final cache = InMemoryUserDataCache();
    final photos = FakePhotoCache();
    final method = InMemoryLastPaymentMethodStore('150');
    await pumpApp(
      tester,
      adapter,
      session: signedInSession,
      userDataCache: cache,
      photoCache: photos,
      lastPaymentMethod: method,
    );
    expect(cache.data, isNotNull);
    expect(photos.cleared, 0);
    expect(method.groupId, '150');

    await signOut(tester);

    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
    expect(cache.data, isNull);
    expect(photos.cleared, 1);
    expect(method.groupId, isNull);
  });

  testWidgets('a background refresh answered after the sign-out is not stored', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', '/account/user-data', 200, _userData('Janusz'))
      ..reply('POST', '/auth/logout', 200);
    final release = adapter.hold('GET', '/account/user-data');
    final cache = InMemoryUserDataCache(UserDataResponse.fromJson(_userData('Jan')));
    final app = await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);
    expect(_userDataRequests(adapter), hasLength(1));

    await signOut(tester);
    expect(cache.data, isNull);

    release();
    await tester.pumpAndSettle();
    expect(cache.data, isNull);
    expect(app.container.read(userDataProvider).value, isNull);
  });

  testWidgets('a reload answered after the sign-out is not stored', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', '/account/user-data', 200, _userData('Jan'))
      ..reply('POST', '/auth/logout', 200);
    final cache = InMemoryUserDataCache();
    final app = await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    final release = adapter.hold('GET', '/account/user-data');
    final reload = app.container.read(userDataProvider.notifier).refresh();
    await signOut(tester);
    expect(cache.data, isNull);

    release();
    await tester.pumpAndSettle();
    await reload;
    expect(cache.data, isNull);
    expect(app.container.read(userDataProvider).value, isNull);
  });

  test('the cached model survives a JSON round trip', () {
    final original = UserDataResponse.fromJson(_userData('Jan'));
    // Through a string, as the cache stores it.
    final restored = UserDataResponse.fromJson(jsonDecode(jsonEncode(original.toJson())) as Map<String, dynamic>);
    expect(restored, original);
  });
}
