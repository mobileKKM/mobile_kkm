import 'package:drift/native.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/features/tickets/services/tickets_dao.dart';

void main() {
  late AppDatabase db;
  late TicketsDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = TicketsDao(db);
  });
  tearDown(() => db.close());

  MkkmTicket ticket(String guid, {int startDay = 1, double price = 99}) =>
      MkkmTicket(ticketGuid: guid, status: 'active', startDate: DateTime.utc(2026, 6, startDay), price: price);

  Future<Map<String, bool>> pins() async => {
    for (final stored in await dao.watchAll().first) stored.ticket.ticketGuid!: stored.pinned,
  };

  test('stores the tickets as received, earliest start first', () async {
    await dao.replaceWith([ticket('b', startDay: 20), ticket('a', startDay: 5)]);

    final stored = await dao.watchAll().first;
    expect(stored.map((s) => s.ticket), [ticket('a', startDay: 5), ticket('b', startDay: 20)]);
  });

  test('a later list updates what is there and drops what is gone', () async {
    await dao.replaceWith([ticket('a'), ticket('b')]);
    await dao.replaceWith([ticket('b', price: 120), ticket('c')]);

    final stored = await dao.watchAll().first;
    expect(stored.map((s) => s.ticket.ticketGuid), unorderedEquals(['b', 'c']));
    expect(stored.firstWhere((s) => s.ticket.ticketGuid == 'b').ticket.price, 120);
  });

  test('an empty list empties the store', () async {
    await dao.replaceWith([ticket('a')]);
    await dao.replaceWith(const []);
    expect(await dao.watchAll().first, isEmpty);
  });

  test('a ticket without a guid is skipped', () async {
    await dao.replaceWith([const MkkmTicket(status: 'active'), ticket('a')]);
    expect((await dao.watchAll().first).single.ticket.ticketGuid, 'a');
  });

  test('only one ticket is pinned at a time', () async {
    await dao.replaceWith([ticket('a'), ticket('b')]);
    await dao.setPinned('a');
    await dao.setPinned('b');
    expect(await pins(), {'a': false, 'b': true});

    await dao.setPinned(null);
    expect(await pins(), {'a': false, 'b': false});
  });

  test('a pin survives a sync and goes with its ticket', () async {
    await dao.replaceWith([ticket('a'), ticket('b')]);
    await dao.setPinned('a');

    await dao.replaceWith([ticket('a'), ticket('b')]);
    expect(await pins(), {'a': true, 'b': false});

    await dao.replaceWith([ticket('b')]);
    await dao.replaceWith([ticket('a'), ticket('b')]);
    expect(await pins(), {'a': false, 'b': false});
  });
}
