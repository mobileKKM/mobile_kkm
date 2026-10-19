import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/database/app_database.dart';

void main() {
  test('version 1 gains the payments table and keeps its tickets', () async {
    // The schema as version 1 created it.
    final executor = NativeDatabase.memory(
      setup: (raw) {
        raw.execute('''
          CREATE TABLE tickets (
            ticket_guid TEXT NOT NULL, status TEXT, start_date INTEGER, end_date INTEGER,
            payload TEXT NOT NULL, pinned INTEGER NOT NULL DEFAULT 0 CHECK (pinned IN (0, 1)),
            synced_at INTEGER NOT NULL, PRIMARY KEY (ticket_guid)
          )
        ''');
        raw.execute("INSERT INTO tickets (ticket_guid, payload, synced_at) VALUES ('a', '{}', 0)");
        raw.userVersion = 1;
      },
    );
    final db = AppDatabase(executor);
    addTearDown(db.close);

    await db.into(db.payments).insert(PaymentsCompanion.insert(ticketGuid: 'a', madeAt: DateTime(2025, 10, 1)));

    expect(await db.select(db.payments).get(), hasLength(1));
    expect(await db.select(db.tickets).get(), hasLength(1));
    expect(await db.customSelect('PRAGMA user_version').map((row) => row.read<int>('user_version')).getSingle(), 2);
  });
}
