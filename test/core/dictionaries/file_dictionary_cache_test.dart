import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/dictionaries/dictionary_cache.dart';

void main() {
  late Directory root;
  late Directory directory;
  late FileDictionaryCache cache;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('dictionary_cache_test');
    // Not there yet: the cache has to create it.
    directory = Directory('${root.path}/dictionaries');
    cache = FileDictionaryCache(directory);
  });

  tearDown(() => root.delete(recursive: true));

  final fetchedAt = DateTime.utc(2025, 3, 4, 5, 6, 7);
  const kinds = {
    'kinds': [
      {'code': 1, 'description': 'Testowy'},
    ],
  };

  test('what was written is read back, with the time it was fetched', () async {
    await cache.write('ticket-kind-list', kinds, fetchedAt);

    final stored = await cache.read('ticket-kind-list');
    expect(stored?.json, kinds);
    expect(stored?.fetchedAt, fetchedAt);
  });

  test('each dictionary has a file of its own, and no temporary file is left behind', () async {
    await cache.write('ticket-kind-list', kinds, fetchedAt);
    await cache.write('city-card-types', {'8': 'mKKM'}, fetchedAt);

    final files = [for (final entry in directory.listSync()) entry.uri.pathSegments.last]..sort();
    expect(files, ['city-card-types.json', 'ticket-kind-list.json']);
    expect((await cache.read('city-card-types'))?.json, {'8': 'mKKM'});
  });

  test('a second write replaces the first', () async {
    await cache.write('city-card-types', {'8': 'mKKM'}, fetchedAt);
    final later = fetchedAt.add(const Duration(days: 2));
    await cache.write('city-card-types', {'8': 'mKKM', '9': 'mKK'}, later);

    final stored = await cache.read('city-card-types');
    expect(stored?.json, {'8': 'mKKM', '9': 'mKK'});
    expect(stored?.fetchedAt, later);
  });

  test('a dictionary that was never written is a miss', () async {
    expect(await cache.read('ticket-kind-list'), isNull);
  });

  test('a file that cannot be decoded is a miss', () async {
    await directory.create();
    for (final content in ['', '{"fetchedAt": "2025-03-04T05:06:07Z", "da', '[]', '{"data": {}}', '{"fetchedAt": 5}']) {
      await File('${directory.path}/ticket-kind-list.json').writeAsString(content);
      expect(await cache.read('ticket-kind-list'), isNull, reason: content);
    }
  });
}
