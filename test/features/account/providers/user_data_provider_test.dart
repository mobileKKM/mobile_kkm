import 'dart:convert';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';

Map<String, dynamic> _userData(String firstName) => {
  'userData': {
    'firstName': firstName,
    'lastName': 'Testowy',
    'email': 'jan@example.com',
    'birthDate': '2000-01-03T00:00:00',
  },
  'mkkmData': null,
};

Iterable<Object> _userDataRequests(FakeAdapter adapter) =>
    adapter.requests.where((r) => r.path.endsWith('/account/user-data'));

void main() {
  testWidgets('is fetched once after sign-in and written to the cache', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/account/user-data', 200, _userData('Jan'));
    final cache = InMemoryUserDataCache();
    await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(find.text('jan@example.com'), findsOneWidget);
    expect(_userDataRequests(adapter), hasLength(1));
    expect(cache.data?.userData?.firstName, 'Jan');
  });

  testWidgets('the cached copy is used when the server is unreachable', (tester) async {
    final adapter = FakeAdapter()..fail('GET', '/account/user-data');
    final cache = InMemoryUserDataCache(UserDataResponse.fromJson(_userData('Jan')));
    await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(cache.data?.userData?.firstName, 'Jan');
  });

  testWidgets('a cached copy is refreshed once in the background', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/account/user-data', 200, _userData('Janusz'));
    final cache = InMemoryUserDataCache(UserDataResponse.fromJson(_userData('Jan')));
    await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);

    expect(find.text('Janusz Testowy'), findsOneWidget);
    expect(_userDataRequests(adapter), hasLength(1));
    expect(cache.data?.userData?.firstName, 'Janusz');
  });

  testWidgets('signing out clears the cached copy', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', '/account/user-data', 200, _userData('Jan'))
      ..reply('POST', '/auth/logout', 200);
    final cache = InMemoryUserDataCache();
    await pumpApp(tester, adapter, session: signedInSession, userDataCache: cache);
    expect(cache.data, isNotNull);

    await tapVisible(tester, find.text('Sign out'));

    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
    expect(cache.data, isNull);
  });

  test('the cached model survives a JSON round trip', () {
    final original = UserDataResponse.fromJson(_userData('Jan'));
    // Through a string, as the cache stores it.
    final restored = UserDataResponse.fromJson(jsonDecode(jsonEncode(original.toJson())) as Map<String, dynamic>);
    expect(restored, original);
  });
}
