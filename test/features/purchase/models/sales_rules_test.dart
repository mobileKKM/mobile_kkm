import 'dart:convert';
import 'dart:io';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';

Map<String, dynamic> _fixture(String name) =>
    jsonDecode(File('packages/ekp_api/test/fixtures/$name.json').readAsStringSync()) as Map<String, dynamic>;

final privileged = SalesRules(TicketSalesConfiguration.fromJson(_fixture('sales_config_privileged')));
final notPrivileged = SalesRules(TicketSalesConfiguration.fromJson(_fixture('sales_config')));
final kindDictionary = TicketKindListResponse.fromJson(_fixture('ticket_kind_list')).kinds;

const network = '1001';
const metropolitan = '1003';
const normalny = 2;
const ulgowy = 14;
const aktywizujacy = 17;

/// Design 26e: which (kind, product, period) each configuration sells.
const _p3 = [1, 2, 3];
const _allZones = {3: _p3, 12: _p3, 15: _p3, 48: _p3, 60: _p3, 63: _p3};
const _akt = {3: _p3, 15: _p3, 63: _p3};
final _privilegedMatrix = {
  normalny: {1: _p3, ..._allZones}..[3] = [1, 2, 3, 6],
  ulgowy: {1: _p3, ..._allZones}..[3] = [1, 2, 3, 6, 12],
  aktywizujacy: _akt,
};
const _notPrivilegedMatrix = {normalny: _allZones, ulgowy: _allZones, aktywizujacy: _akt};

/// Which type each product and period belongs to (26e's `LN` / `PD`).
const _networkProducts = {1, 3};
const _metropolitanProducts = {3, 12, 15, 48, 60, 63};
const _networkPeriods = {1, 2, 3, 6, 12};
const _metropolitanPeriods = {1, 2, 3};

PurchaseSelection select({
  String? type,
  int? kind,
  Set<int> zones = const {},
  int? lineOption,
  List<TransportLine> lines = const [],
  int? period,
  DateTime? start,
}) => PurchaseSelection(
  type: type,
  kind: kind,
  zones: zones,
  lineOption: lineOption,
  lines: lines,
  period: period,
  startDate: start,
);

const line52 = TransportLine(line: 52, secondZone: false, hasSecondZone: false, isTram: true, isBus: false);

MkkmTicket ticket({
  String? specialTransportLine,
  bool isNetwork = false,
  bool isMetropolitan = false,
  int kind = 21,
  int lineScope = 3,
  int period = 1,
  List<TransportLine> lines = const [],
  DateTime? endDate,
}) => MkkmTicket(
  specialTransportLine: specialTransportLine,
  isNetwork: isNetwork,
  isMetropolitan: isMetropolitan,
  ticketKindCode: kind,
  ticketNumberOfLineCode: lineScope,
  ticketPeriodCode: period,
  lines: lines,
  endDate: endDate,
);

void main() {
  final day = DateTime(2025, 10, 6);

  group('types', () {
    test('privileged: network and metropolitan, so the Type section shows', () {
      expect(privileged.types.map((t) => t.specialTransportLine), [network, metropolitan]);
      expect(privileged.showsTypes, isTrue);
    });

    test('not privileged: metropolitan only, no Type section, chosen silently', () {
      expect(notPrivileged.showsTypes, isFalse);
      expect(notPrivileged.reconcile(const PurchaseSelection()).type, metropolitan);
      expect(notPrivileged.visibleSections(notPrivileged.reconcile(const PurchaseSelection())), [PurchaseSection.fare]);
    });

    test('each type has its own products and periods', () {
      expect(privileged.optionsFor(network).map((o) => o.code), [1, 3]);
      expect(privileged.optionsFor(metropolitan).map((o) => o.code), [3, 12, 15, 48, 60, 63]);
      expect(privileged.periodsFor(network).map((p) => p.code), [1, 2, 3, 6, 12]);
      expect(privileged.periodsFor(metropolitan).map((p) => p.code), [1, 2, 3]);
      expect(notPrivileged.optionsFor(metropolitan).map((o) => o.code), [3, 12, 15, 48, 60, 63]);
      expect(notPrivileged.periodsFor(metropolitan).map((p) => p.code), [1, 2, 3]);
    });
  });

  group("26e's matrix", () {
    void expectMatrix(SalesRules rules, Map<int, Map<int, List<int>>> matrix) {
      for (final type in rules.types) {
        final code = type.specialTransportLine;
        final products = code == network ? _networkProducts : _metropolitanProducts;
        final periods = code == network ? _networkPeriods : _metropolitanPeriods;
        for (final kind in [normalny, ulgowy, aktywizujacy]) {
          for (final product in [1, 3, 12, 15, 48, 60, 63]) {
            for (final period in [1, 2, 3, 6, 12]) {
              final expected =
                  products.contains(product) &&
                  periods.contains(period) &&
                  (matrix[kind]?[product] ?? const []).contains(period);
              expect(
                rules.optionsFor(code).any((o) => o.code == product) &&
                    rules.periodAvailable(code, kind, product, period),
                expected,
                reason: 'type $code, kind $kind, product $product, period $period',
              );
            }
          }
        }
      }
    }

    test('privileged', () => expectMatrix(privileged, _privilegedMatrix));
    test('not privileged', () => expectMatrix(notPrivileged, _notPrivilegedMatrix));
  });

  group('availability', () {
    test('Aktywizujący with the discount: all lines only, never 1 line', () {
      expect(privileged.kindAvailable(network, aktywizujacy), isTrue);
      final [allLines, oneLine] = privileged.lineChoices(network, {0});
      expect(privileged.optionSold(network, aktywizujacy, allLines), isTrue);
      expect(privileged.optionSold(network, aktywizujacy, oneLine), isFalse);
      expect(privileged.optionSold(network, normalny, oneLine), isTrue);
    });

    test('the discount fixes Strefa I and disables II and III', () {
      expect(privileged.fixedZones(network), {0});
      expect(privileged.fixedZones(metropolitan), isNull);
      expect([for (var z = 0; z < 3; z++) privileged.zoneAvailable(network, normalny, z)], [true, false, false]);
      expect([for (var z = 0; z < 3; z++) privileged.zoneAvailable(metropolitan, aktywizujacy, z)], [true, true, true]);
    });

    test('Lines: All lines, then 1 line, only with the discount', () {
      expect(privileged.lineChoices(network, {0}).map((o) => o.code), [3, 1]);
      expect(privileged.lineChoices(metropolitan, {0}), isEmpty);
      expect(notPrivileged.lineChoices(metropolitan, {0, 1}), isEmpty);
    });

    test('6 months only with all lines; Studencki Roczny only Ulgowy, all lines', () {
      expect(privileged.periodAvailable(network, normalny, 3, 6), isTrue);
      expect(privileged.periodAvailable(network, normalny, 3, 12), isFalse);
      expect(privileged.periodAvailable(network, ulgowy, 3, 12), isTrue);
      expect(privileged.periodAvailable(network, normalny, 1, 6), isFalse);
      expect(privileged.periodAvailable(network, ulgowy, 1, 12), isFalse);
      expect(privileged.periodAvailable(metropolitan, ulgowy, 3, 6), isFalse);
    });
  });

  group('sections and the next answer', () {
    test('privileged, with the discount and one line', () {
      final rules = privileged;
      var s = rules.reconcile(const PurchaseSelection());
      expect(rules.nextMissing(s), PurchaseSection.type);
      expect(rules.visibleSections(s), [PurchaseSection.type]);

      s = rules.reconcile(s.copyWith(type: () => network));
      expect(rules.nextMissing(s), PurchaseSection.fare);
      expect(rules.visibleSections(s), [PurchaseSection.type, PurchaseSection.fare]);

      s = rules.reconcile(s.copyWith(kind: () => normalny));
      expect(s.zones, {0});
      expect(rules.nextMissing(s), PurchaseSection.lines);
      expect(rules.visibleSections(s), [
        PurchaseSection.type,
        PurchaseSection.fare,
        PurchaseSection.zone,
        PurchaseSection.lines,
      ]);

      s = rules.reconcile(s.copyWith(lineOption: () => 1));
      expect(rules.nextMissing(s), PurchaseSection.lines);
      expect(rules.linesLeft(s), 1);

      s = rules.reconcile(s.copyWith(lines: [line52]));
      expect(rules.linesLeft(s), 0);
      expect(rules.nextMissing(s), PurchaseSection.period);
      expect(rules.visibleSections(s).last, PurchaseSection.period);

      s = rules.reconcile(s.copyWith(period: () => 3, startDate: () => day));
      expect(rules.nextMissing(s), isNull);
      expect(rules.visibleSections(s), PurchaseSection.values);
      expect(
        rules.choiceOf(s),
        TicketChoice(
          validFrom: day,
          ticketNumberOfLineCode: 1,
          ticketKindCode: normalny,
          ticketPeriodCode: 3,
          lines: const [line52],
          specialTransportLine: network,
        ),
      );
    });

    test('privileged, without the discount: three zones, no Lines', () {
      final s = privileged.reconcile(
        select(type: metropolitan, kind: normalny, zones: {0, 1, 2}, period: 3, start: day),
      );
      expect(privileged.nextMissing(s), isNull);
      expect(privileged.visibleSections(s), [
        PurchaseSection.type,
        PurchaseSection.fare,
        PurchaseSection.zone,
        PurchaseSection.period,
        PurchaseSection.start,
      ]);
      expect(privileged.choiceOf(s)?.ticketNumberOfLineCode, 63);
      expect(privileged.choiceOf(s)?.lines, isEmpty);
    });

    test('not privileged: the zones wait until they make a product', () {
      final rules = notPrivileged;
      var s = rules.reconcile(select(kind: normalny));
      expect(rules.nextMissing(s), PurchaseSection.zone);
      s = rules.reconcile(s.copyWith(zones: {0, 2}));
      expect(rules.nextMissing(s), PurchaseSection.zone);
      s = rules.reconcile(s.copyWith(zones: {0, 1, 2}));
      expect(rules.nextMissing(s), PurchaseSection.period);
      expect(rules.choiceOf(s), isNull);
    });
  });

  group('notes', () {
    test('Strefa I + III: add Strefa II', () {
      final s = notPrivileged.reconcile(select(kind: normalny, zones: {0, 2}));
      expect(notPrivileged.notes(s), [
        const UnsoldZonesNote(zones: [0, 2], missing: [1]),
      ]);
    });

    test('Aktywizujący in Strefa II: the sets it is sold for', () {
      final s = notPrivileged.reconcile(select(kind: aktywizujacy, zones: {1}));
      final notes = notPrivileged.notes(s);
      expect(notes, hasLength(1));
      final note = notes.single as FareZonesNote;
      expect(note.kind.description, 'Aktywizujący');
      expect(note.sets, [
        [0],
        [0, 1],
        [0, 1, 2],
      ]);
    });

    test('the discount is for Strefa I only', () {
      final s = privileged.reconcile(select(type: network, kind: normalny));
      expect(privileged.notes(s), [
        const DiscountNote(zones: [0]),
      ]);
    });

    test('no note for a sold set, or before a fare', () {
      expect(notPrivileged.notes(notPrivileged.reconcile(select(kind: normalny, zones: {1, 2}))), isEmpty);
      expect(notPrivileged.notes(notPrivileged.reconcile(select(zones: {0, 2}))), isEmpty);
    });

    test('zone labels come from the descriptions', () {
      expect([for (var z = 0; z < 3; z++) privileged.zoneLabel(z)], ['Strefa I', 'Strefa II', 'Strefa III']);
      expect([for (var z = 0; z < 3; z++) privileged.zoneNumeral(z)], ['I', 'II', 'III']);
    });
  });

  group('reconcile keeps what is still valid', () {
    test('1 line drops 6 months; All lines keeps it', () {
      final allLines = privileged.reconcile(select(type: network, kind: normalny, lineOption: 3, period: 6));
      expect(allLines.period, 6);
      final oneLine = privileged.reconcile(allLines.copyWith(lineOption: () => 1));
      expect(oneLine.period, isNull);
    });

    test('switching to the discount fixes the zones and keeps a fare it sells', () {
      final s = privileged.reconcile(
        select(type: metropolitan, kind: aktywizujacy, zones: {0, 1}, period: 1).copyWith(type: () => network),
      );
      expect(s.kind, aktywizujacy);
      expect(s.zones, {0});
      expect(s.period, 1);
      expect(privileged.nextMissing(s), PurchaseSection.lines);
    });

    test('Aktywizujący drops 1 line and its lines', () {
      final s = privileged.reconcile(
        select(type: network, kind: normalny, lineOption: 1, lines: [line52]).copyWith(kind: () => aktywizujacy),
      );
      expect(s.lineOption, isNull);
      expect(s.lines, isEmpty);
    });

    test('a fare the type does not sell is dropped', () {
      final rules = SalesRules(
        privileged.config.copyWith(
          priceListConfigurations: [
            for (final entry in privileged.config.priceListConfigurations)
              if (!(entry.ticketKindCode == aktywizujacy && entry.ticketNumberOfLineCode == 3)) entry,
          ],
        ),
      );
      expect(rules.kindAvailable(network, aktywizujacy), isFalse);
      expect(rules.reconcile(select(type: network, kind: aktywizujacy)).kind, isNull);
    });

    test('a period survives a set that is briefly not sold', () {
      final s = notPrivileged.reconcile(select(kind: normalny, zones: {0, 2}, period: 3));
      expect(s.period, 3);
      expect(notPrivileged.reconcile(s.copyWith(zones: {0, 1, 2})).period, 3);
    });

    test('leaving the line-scoped product drops its lines', () {
      final s = privileged.reconcile(select(type: network, kind: normalny, lineOption: 1, lines: [line52]));
      expect(s.lines, [line52]);
      expect(privileged.reconcile(s.copyWith(lineOption: () => 3)).lines, isEmpty);
    });

    test('an unknown type is dropped', () {
      expect(privileged.reconcile(select(type: '9999')).type, isNull);
    });
  });

  group('prefill', () {
    test('an inhabitant fare maps through the kind group: 21 → Normalny, 22 → Ulgowy', () {
      for (final (kind, expected) in [(21, normalny), (22, ulgowy)]) {
        final s = privileged.prefill(
          ticket(specialTransportLine: network, isNetwork: true, kind: kind),
          kindDictionary: kindDictionary,
          startDate: day,
        );
        expect(s.kind, expected, reason: 'kind $kind');
        expect(s.type, network);
        expect(s.lineOption, 3);
        expect(privileged.nextMissing(s), isNull);
      }
    });

    test('a line ticket has no type: it is a network one, lines kept', () {
      final s = privileged.prefill(
        ticket(kind: 21, lineScope: 1, lines: [line52]),
        kindDictionary: kindDictionary,
        startDate: day,
      );
      expect(
        s,
        select(type: network, kind: normalny, zones: {0}, lineOption: 1, lines: [line52], period: 1, start: day),
      );
      expect(privileged.nextMissing(s), isNull);
    });

    test('a metropolitan ticket keeps its zones', () {
      final s = privileged.prefill(
        ticket(specialTransportLine: metropolitan, isMetropolitan: true, kind: ulgowy, lineScope: 60, period: 3),
        kindDictionary: kindDictionary,
        startDate: day,
      );
      expect(s.type, metropolitan);
      expect(s.zones, {1, 2});
      expect(s.lineOption, isNull);
      expect(privileged.nextMissing(s), isNull);
      expect(privileged.choiceOf(s)?.ticketNumberOfLineCode, 60);
    });

    test('without the status a discount ticket becomes metropolitan Strefa I', () {
      final s = notPrivileged.prefill(
        ticket(specialTransportLine: network, isNetwork: true, kind: 21, period: 1),
        kindDictionary: kindDictionary,
        startDate: day,
      );
      expect(s.type, metropolitan);
      expect(s.kind, normalny);
      expect(s.zones, {0});
      expect(notPrivileged.nextMissing(s), isNull);
    });

    test('a period this type does not sell is dropped', () {
      final s = notPrivileged.prefill(
        ticket(specialTransportLine: network, isNetwork: true, kind: 22, period: 6),
        kindDictionary: kindDictionary,
        startDate: day,
      );
      expect(s.period, isNull);
      expect(notPrivileged.nextMissing(s), PurchaseSection.period);
    });
  });

  group('start bounds', () {
    final now = DateTime(2025, 10, 5, 14, 30);

    test('a new ticket starts tomorrow, within the configuration as sent', () {
      expect(
        privileged.startBounds(now),
        StartBounds(initial: DateTime(2025, 10, 6), first: DateTime(2025, 9, 30), last: DateTime(2025, 10, 30)),
      );
    });

    test('tomorrow outside the configuration is moved into it', () {
      expect(privileged.startBounds(DateTime(2025, 10, 30, 9)).initial, DateTime(2025, 10, 30));
    });

    test('extending a running ticket: the day after it ends, up to 30 days later', () {
      final running = ticket(endDate: DateTime(2025, 11, 2, 23, 59, 59));
      expect(
        privileged.startBounds(now, extending: running),
        StartBounds(
          initial: DateTime(2025, 11, 3),
          first: DateTime(2025, 11, 3),
          last: DateTime(2025, 12, 3),
          extending: true,
        ),
      );
    });

    test('extending an ended ticket is like a new one', () {
      final ended = ticket(endDate: DateTime(2025, 10, 1, 23, 59, 59));
      expect(privileged.startBounds(now, extending: ended), privileged.startBounds(now));
    });
  });
}
