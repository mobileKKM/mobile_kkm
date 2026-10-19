import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/features/purchase/services/payments_dao.dart';

void main() {
  late AppDatabase db;
  late PaymentsDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = PaymentsDao(db);
  });
  tearDown(() => db.close());

  test('marks payments as made, once per ticket', () async {
    await dao.markMade('a', DateTime(2025, 10, 1, 12));
    await dao.markMade('b', DateTime(2025, 10, 1, 13));
    await dao.markMade('a', DateTime(2025, 10, 1, 14));

    expect(await dao.watchAll().first, {'a': DateTime(2025, 10, 1, 14), 'b': DateTime(2025, 10, 1, 13)});
  });

  test('removes one mark, or all of them', () async {
    await dao.markMade('a', DateTime(2025, 10, 1));
    await dao.markMade('b', DateTime(2025, 10, 1));

    await dao.remove('a');
    expect((await dao.watchAll().first).keys, ['b']);

    await dao.clear();
    expect(await dao.watchAll().first, isEmpty);
  });

  test('emits again after a write', () async {
    final seen = <int>[];
    final subscription = dao.watchAll().listen((marks) => seen.add(marks.length));
    await pumpEventQueue();
    await dao.markMade('a', DateTime(2025, 10, 1));
    await pumpEventQueue();
    await subscription.cancel();

    expect(seen, [0, 1]);
  });
}
