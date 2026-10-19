import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/core/providers/database_provider.dart';

final paymentsDaoProvider = Provider<PaymentsDao>((ref) => PaymentsDao(ref.watch(appDatabaseProvider)));

/// The payments marked as made, by ticket guid.
final paymentMarksProvider = StreamProvider<Map<String, DateTime>>((ref) => ref.watch(paymentsDaoProvider).watchAll());

/// Reads and writes the "payment made" marks.
class PaymentsDao {
  PaymentsDao(this._db);

  final AppDatabase _db;

  /// Marks the payment of [ticketGuid] as made at [madeAt]; a second mark
  /// moves the time.
  Future<void> markMade(String ticketGuid, DateTime madeAt) {
    final row = PaymentsCompanion(ticketGuid: Value(ticketGuid), madeAt: Value(madeAt));
    return _db.into(_db.payments).insert(row, onConflict: DoUpdate((_) => row));
  }

  /// When each marked payment was made, by ticket guid; emits again after
  /// each write.
  Stream<Map<String, DateTime>> watchAll() =>
      _db.select(_db.payments).watch().map((rows) => {for (final row in rows) row.ticketGuid: row.madeAt});

  Future<void> remove(String ticketGuid) =>
      (_db.delete(_db.payments)..where((p) => p.ticketGuid.equals(ticketGuid))).go();

  Future<void> clear() => _db.delete(_db.payments).go();
}
