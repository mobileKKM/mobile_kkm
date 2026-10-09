import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/features/tickets/models/stored_ticket.dart';

/// Reads and writes the stored mobile tickets.
class TicketsDao {
  TicketsDao(this._db);

  final AppDatabase _db;

  /// Every stored ticket, earliest start first; emits again after each write.
  Stream<List<StoredTicket>> watchAll() {
    final query = _db.select(_db.tickets)..orderBy([(t) => OrderingTerm.asc(t.startDate)]);
    return query.watch().map((rows) => [for (final row in rows) _fromRow(row)]);
  }

  /// When the stored tickets last matched the server; null while there are
  /// none. Unlike the sync's own state this outlives the app run.
  Stream<DateTime?> watchLastSyncedAt() {
    final latest = _db.tickets.syncedAt.max();
    final query = _db.selectOnly(_db.tickets)..addColumns([latest]);
    return query.map((row) => row.read(latest)).watchSingle();
  }

  /// Makes the stored set match [tickets], the server's current list.
  ///
  /// A ticket that is still there keeps its pin; one the server no longer
  /// returns is deleted, and its pin with it. Tickets without a guid cannot
  /// be told apart and are skipped.
  Future<void> replaceWith(List<MkkmTicket> tickets) {
    final syncedAt = DateTime.now();
    return _db.transaction(() async {
      final guids = [for (final ticket in tickets) ?ticket.ticketGuid];
      await (_db.delete(_db.tickets)..where((t) => t.ticketGuid.isNotIn(guids))).go();
      for (final ticket in tickets) {
        final guid = ticket.ticketGuid;
        if (guid == null) {
          continue;
        }
        // `pinned` is left out: the default on insert, untouched on update.
        final row = TicketsCompanion(
          ticketGuid: Value(guid),
          status: Value(ticket.status),
          startDate: Value(ticket.startDate),
          endDate: Value(ticket.endDate),
          payload: Value(jsonEncode(ticket.toJson())),
          syncedAt: Value(syncedAt),
        );
        await _db.into(_db.tickets).insert(row, onConflict: DoUpdate((_) => row));
      }
    });
  }

  /// Pins the ticket with [ticketGuid] instead of any other, or with null
  /// removes the pin.
  Future<void> setPinned(String? ticketGuid) {
    return _db.transaction(() async {
      await (_db.update(_db.tickets)..where((t) => t.pinned)).write(const TicketsCompanion(pinned: Value(false)));
      if (ticketGuid != null) {
        await (_db.update(
          _db.tickets,
        )..where((t) => t.ticketGuid.equals(ticketGuid))).write(const TicketsCompanion(pinned: Value(true)));
      }
    });
  }

  Future<void> clear() => _db.delete(_db.tickets).go();

  static StoredTicket _fromRow(TicketRow row) =>
      StoredTicket(MkkmTicket.fromJson(jsonDecode(row.payload) as Map<String, dynamic>), pinned: row.pinned);
}
