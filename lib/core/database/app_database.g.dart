// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TicketsTable extends Tickets with TableInfo<$TicketsTable, TicketRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TicketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ticketGuidMeta = const VerificationMeta('ticketGuid');
  @override
  late final GeneratedColumn<String> ticketGuid = GeneratedColumn<String>(
    'ticket_guid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
    'pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("pinned" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [ticketGuid, status, startDate, endDate, payload, pinned, syncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tickets';
  @override
  VerificationContext validateIntegrity(Insertable<TicketRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ticket_guid')) {
      context.handle(_ticketGuidMeta, ticketGuid.isAcceptableOrUnknown(data['ticket_guid']!, _ticketGuidMeta));
    } else if (isInserting) {
      context.missing(_ticketGuidMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta, startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta, endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta, payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('pinned')) {
      context.handle(_pinnedMeta, pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ticketGuid};
  @override
  TicketRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TicketRow(
      ticketGuid: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}ticket_guid'])!,
      status: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status']),
      startDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      payload: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      pinned: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}pinned'])!,
      syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at'])!,
    );
  }

  @override
  $TicketsTable createAlias(String alias) {
    return $TicketsTable(attachedDatabase, alias);
  }
}

class TicketRow extends DataClass implements Insertable<TicketRow> {
  final String ticketGuid;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;

  /// The ticket as the server sent it (`MkkmTicket` JSON): the row follows
  /// the wire model without a column, and a migration, per field.
  final String payload;

  /// Chosen by the user for the home screen; at most one row.
  final bool pinned;
  final DateTime syncedAt;
  const TicketRow({
    required this.ticketGuid,
    this.status,
    this.startDate,
    this.endDate,
    required this.payload,
    required this.pinned,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ticket_guid'] = Variable<String>(ticketGuid);
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['payload'] = Variable<String>(payload);
    map['pinned'] = Variable<bool>(pinned);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  TicketsCompanion toCompanion(bool nullToAbsent) {
    return TicketsCompanion(
      ticketGuid: Value(ticketGuid),
      status: status == null && nullToAbsent ? const Value.absent() : Value(status),
      startDate: startDate == null && nullToAbsent ? const Value.absent() : Value(startDate),
      endDate: endDate == null && nullToAbsent ? const Value.absent() : Value(endDate),
      payload: Value(payload),
      pinned: Value(pinned),
      syncedAt: Value(syncedAt),
    );
  }

  factory TicketRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TicketRow(
      ticketGuid: serializer.fromJson<String>(json['ticketGuid']),
      status: serializer.fromJson<String?>(json['status']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      payload: serializer.fromJson<String>(json['payload']),
      pinned: serializer.fromJson<bool>(json['pinned']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ticketGuid': serializer.toJson<String>(ticketGuid),
      'status': serializer.toJson<String?>(status),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'payload': serializer.toJson<String>(payload),
      'pinned': serializer.toJson<bool>(pinned),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  TicketRow copyWith({
    String? ticketGuid,
    Value<String?> status = const Value.absent(),
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    String? payload,
    bool? pinned,
    DateTime? syncedAt,
  }) => TicketRow(
    ticketGuid: ticketGuid ?? this.ticketGuid,
    status: status.present ? status.value : this.status,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    payload: payload ?? this.payload,
    pinned: pinned ?? this.pinned,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  TicketRow copyWithCompanion(TicketsCompanion data) {
    return TicketRow(
      ticketGuid: data.ticketGuid.present ? data.ticketGuid.value : this.ticketGuid,
      status: data.status.present ? data.status.value : this.status,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      payload: data.payload.present ? data.payload.value : this.payload,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TicketRow(')
          ..write('ticketGuid: $ticketGuid, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('payload: $payload, ')
          ..write('pinned: $pinned, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ticketGuid, status, startDate, endDate, payload, pinned, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TicketRow &&
          other.ticketGuid == this.ticketGuid &&
          other.status == this.status &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.payload == this.payload &&
          other.pinned == this.pinned &&
          other.syncedAt == this.syncedAt);
}

class TicketsCompanion extends UpdateCompanion<TicketRow> {
  final Value<String> ticketGuid;
  final Value<String?> status;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String> payload;
  final Value<bool> pinned;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const TicketsCompanion({
    this.ticketGuid = const Value.absent(),
    this.status = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.payload = const Value.absent(),
    this.pinned = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TicketsCompanion.insert({
    required String ticketGuid,
    this.status = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required String payload,
    this.pinned = const Value.absent(),
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : ticketGuid = Value(ticketGuid),
       payload = Value(payload),
       syncedAt = Value(syncedAt);
  static Insertable<TicketRow> custom({
    Expression<String>? ticketGuid,
    Expression<String>? status,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? payload,
    Expression<bool>? pinned,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ticketGuid != null) 'ticket_guid': ticketGuid,
      if (status != null) 'status': status,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (payload != null) 'payload': payload,
      if (pinned != null) 'pinned': pinned,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TicketsCompanion copyWith({
    Value<String>? ticketGuid,
    Value<String?>? status,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<String>? payload,
    Value<bool>? pinned,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return TicketsCompanion(
      ticketGuid: ticketGuid ?? this.ticketGuid,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      payload: payload ?? this.payload,
      pinned: pinned ?? this.pinned,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ticketGuid.present) {
      map['ticket_guid'] = Variable<String>(ticketGuid.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TicketsCompanion(')
          ..write('ticketGuid: $ticketGuid, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('payload: $payload, ')
          ..write('pinned: $pinned, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TicketsTable tickets = $TicketsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tickets];
}

typedef $$TicketsTableCreateCompanionBuilder = TicketsCompanion Function({
  required String ticketGuid,
  Value<String?> status,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  required String payload,
  Value<bool> pinned,
  required DateTime syncedAt,
  Value<int> rowid,
});
typedef $$TicketsTableUpdateCompanionBuilder = TicketsCompanion Function({
  Value<String> ticketGuid,
  Value<String?> status,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String> payload,
  Value<bool> pinned,
  Value<DateTime> syncedAt,
  Value<int> rowid,
});

class $$TicketsTableFilterComposer extends Composer<_$AppDatabase, $TicketsTable> {
  $$TicketsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ticketGuid =>
      $composableBuilder(column: $table.ticketGuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => ColumnFilters(column));
}

class $$TicketsTableOrderingComposer extends Composer<_$AppDatabase, $TicketsTable> {
  $$TicketsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ticketGuid =>
      $composableBuilder(column: $table.ticketGuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => ColumnOrderings(column));
}

class $$TicketsTableAnnotationComposer extends Composer<_$AppDatabase, $TicketsTable> {
  $$TicketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ticketGuid => $composableBuilder(column: $table.ticketGuid, builder: (column) => column);

  GeneratedColumn<String> get status => $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate => $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate => $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get payload => $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get pinned => $composableBuilder(column: $table.pinned, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt => $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$TicketsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TicketsTable,
          TicketRow,
          $$TicketsTableFilterComposer,
          $$TicketsTableOrderingComposer,
          $$TicketsTableAnnotationComposer,
          $$TicketsTableCreateCompanionBuilder,
          $$TicketsTableUpdateCompanionBuilder,
          (TicketRow, BaseReferences<_$AppDatabase, $TicketsTable, TicketRow>),
          TicketRow,
          PrefetchHooks Function()
        > {
  $$TicketsTableTableManager(_$AppDatabase db, $TicketsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$TicketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$TicketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$TicketsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ticketGuid = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TicketsCompanion(
                ticketGuid: ticketGuid,
                status: status,
                startDate: startDate,
                endDate: endDate,
                payload: payload,
                pinned: pinned,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ticketGuid,
                Value<String?> status = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                required String payload,
                Value<bool> pinned = const Value.absent(),
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => TicketsCompanion.insert(
                ticketGuid: ticketGuid,
                status: status,
                startDate: startDate,
                endDate: endDate,
                payload: payload,
                pinned: pinned,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TicketsTable, TicketRow>(table),
                  BaseReferences<_$AppDatabase, $TicketsTable, TicketRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TicketsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TicketsTable,
      TicketRow,
      $$TicketsTableFilterComposer,
      $$TicketsTableOrderingComposer,
      $$TicketsTableAnnotationComposer,
      $$TicketsTableCreateCompanionBuilder,
      $$TicketsTableUpdateCompanionBuilder,
      (TicketRow, BaseReferences<_$AppDatabase, $TicketsTable, TicketRow>),
      TicketRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TicketsTableTableManager get tickets => $$TicketsTableTableManager(_db, _db.tickets);
}
