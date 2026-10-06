import 'package:drift/drift.dart';

part 'app_database.g.dart';

/// The mobile tickets from `mkkm/tickets/list`, kept on the device so they
/// are available at once and without a connection.
@DataClassName('TicketRow')
class Tickets extends Table {
  TextColumn get ticketGuid => text()();
  TextColumn get status => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();

  /// The ticket as the server sent it (`MkkmTicket` JSON): the row follows
  /// the wire model without a column, and a migration, per field.
  TextColumn get payload => text()();

  /// Chosen by the user for the home screen; at most one row.
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {ticketGuid};
}

/// On-device database. Unencrypted: it holds no personal data (that stays
/// in the platform keystore), only ticket ids, dates, prices and lines.
@DriftDatabase(tables: [Tickets])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
