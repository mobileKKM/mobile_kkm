import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';

import '../../support/fake_adapter.dart';
import '../../support/harness.dart';

const _path = '/dictionary/ticket-kind-list';
const _name = 'ticket-kind-list';

Map<String, dynamic> _kinds(String description) => {
  'kinds': [
    {
      'code': 1,
      'description': description,
      'availableForSell': true,
      'availableWhenCracovCardAuthorizationIsNotValid': true,
      'availableWhenCracovCardAuthorizationIsValid': true,
      'groupId': 1,
    },
  ],
};

/// Starts loading the ticket kinds, as a screen watching them would.
Future<void> _watchKinds(WidgetTester tester, App app) async {
  final subscription = app.container.listen(ticketKindsProvider, (_, _) {});
  addTearDown(subscription.close);
  await tester.pumpAndSettle();
}

String? _description(App app) => app.container.read(ticketKindsProvider).value?.kinds.single.description;

DateTime _ago(Duration age) => DateTime.now().subtract(age);

void main() {
  testWidgets('nothing is asked for before a dictionary is used', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _path, 200, _kinds('Nowy'));
    await pumpApp(tester, adapter, session: signedInSession);

    expect(adapter.requestsTo(_path), isEmpty);
  });

  testWidgets('without a stored copy it is fetched once and stored', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _path, 200, _kinds('Nowy'));
    final cache = InMemoryDictionaryCache();
    final app = await pumpApp(tester, adapter, session: signedInSession, dictionaryCache: cache);

    await _watchKinds(tester, app);

    expect(_description(app), 'Nowy');
    expect(adapter.requestsTo(_path), hasLength(1));
    final stored = await cache.read(_name);
    expect(stored?.json, _kinds('Nowy'));
    expect(DateTime.now().difference(stored!.fetchedAt), lessThan(const Duration(minutes: 1)));
  });

  testWidgets('a stored copy younger than a day is used without asking the server', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _path, 200, _kinds('Nowy'));
    final cache = InMemoryDictionaryCache();
    await cache.write(_name, _kinds('Stary'), _ago(const Duration(hours: 23)));
    final app = await pumpApp(tester, adapter, session: signedInSession, dictionaryCache: cache);

    await _watchKinds(tester, app);

    expect(_description(app), 'Stary');
    expect(adapter.requestsTo(_path), isEmpty);
  });

  testWidgets('a stored copy older than a day is used at once and replaced in the background', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _path, 200, _kinds('Nowy'));
    final release = adapter.hold('GET', _path);
    final cache = InMemoryDictionaryCache();
    await cache.write(_name, _kinds('Stary'), _ago(const Duration(hours: 25)));
    final app = await pumpApp(tester, adapter, session: signedInSession, dictionaryCache: cache);

    await _watchKinds(tester, app);
    expect(_description(app), 'Stary');
    expect(adapter.requestsTo(_path), hasLength(1));

    release();
    await tester.pumpAndSettle();
    expect(_description(app), 'Nowy');
    expect(adapter.requestsTo(_path), hasLength(1));
    final stored = await cache.read(_name);
    expect(stored?.json, _kinds('Nowy'));
    expect(DateTime.now().difference(stored!.fetchedAt), lessThan(const Duration(minutes: 1)));
  });

  testWidgets('an old stored copy stays in use when the server is unreachable', (tester) async {
    final adapter = FakeAdapter()..fail('GET', _path);
    final cache = InMemoryDictionaryCache();
    final fetchedAt = _ago(const Duration(days: 30));
    await cache.write(_name, _kinds('Stary'), fetchedAt);
    final app = await pumpApp(tester, adapter, session: signedInSession, dictionaryCache: cache);

    await _watchKinds(tester, app);

    expect(adapter.requestsTo(_path), hasLength(1));
    expect(app.container.read(ticketKindsProvider).error, isNull);
    expect(_description(app), 'Stary');
    expect((await cache.read(_name))?.fetchedAt, fetchedAt);
  });

  testWidgets('without a stored copy an unreachable server is an error, and the app goes offline', (tester) async {
    final adapter = FakeAdapter()..fail('GET', _path);
    final app = await pumpApp(tester, adapter, session: signedInSession);
    expect(app.container.read(appStatusProvider).mode, AppMode.online);

    await _watchKinds(tester, app);

    expect(app.container.read(ticketKindsProvider).error, isA<EkpNetworkException>());
    expect(app.container.read(appStatusProvider).mode, AppMode.offline);
  });

  testWidgets('a stored copy the app cannot read any more is fetched again', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _path, 200, _kinds('Nowy'));
    final cache = InMemoryDictionaryCache();
    await cache.write(_name, {'kinds': 'not a list'}, _ago(const Duration(hours: 1)));
    final app = await pumpApp(tester, adapter, session: signedInSession, dictionaryCache: cache);

    await _watchKinds(tester, app);

    expect(_description(app), 'Nowy');
    expect((await cache.read(_name))?.json, _kinds('Nowy'));
  });

  testWidgets('signed out, the server is not asked', (tester) async {
    final adapter = FakeAdapter()..reply('GET', _path, 200, _kinds('Nowy'));
    final app = await pumpApp(tester, adapter);

    await _watchKinds(tester, app);

    expect(app.container.read(ticketKindsProvider).error, isA<DictionaryUnavailableException>());
    expect(adapter.requestsTo(_path), isEmpty);
  });

  testWidgets('the stored copy outlives the session', (tester) async {
    final adapter = FakeAdapter()
      ..reply('GET', _path, 200, _kinds('Nowy'))
      ..reply('POST', '/auth/logout', 200);
    final cache = InMemoryDictionaryCache();
    final app = await pumpApp(tester, adapter, session: signedInSession, dictionaryCache: cache);
    await _watchKinds(tester, app);

    await signOut(tester);

    expect(app.location, '/login');
    expect(_description(app), 'Nowy');
    expect(cache.names, [_name]);
    expect(adapter.requestsTo(_path), hasLength(1));
  });

  testWidgets('the card types come back from the store as they were sent', (tester) async {
    final adapter = FakeAdapter()..reply('GET', '/dictionary/city-card-types', 200, {'8': 'mKKM      '});
    final cache = InMemoryDictionaryCache();
    final app = await pumpApp(tester, adapter, session: signedInSession, dictionaryCache: cache);

    final subscription = app.container.listen(cityCardTypesProvider, (_, _) {});
    addTearDown(subscription.close);
    await tester.pumpAndSettle();

    expect(app.container.read(cityCardTypesProvider).value?.nameForCode(8), 'mKKM');
    expect((await cache.read('city-card-types'))?.json, {'8': 'mKKM      '});
  });
}
