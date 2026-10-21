import 'package:collection/collection.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';

/// A note under the zone tiles, worked out from the configuration. Zones
/// are indexes (0 urban, 1 suburban, 2 second suburban), in order.
sealed class ZoneNote {
  const ZoneNote();
}

/// The toggled zones are not sold together, but a larger set is: the
/// [missing] zones would make it one (Strefa I + III → add II).
class UnsoldZonesNote extends ZoneNote {
  const UnsoldZonesNote({required this.zones, required this.missing});

  final List<int> zones;
  final List<int> missing;

  @override
  bool operator ==(Object other) =>
      other is UnsoldZonesNote && _zoneList.equals(other.zones, zones) && _zoneList.equals(other.missing, missing);

  @override
  int get hashCode => Object.hash(_zoneList.hash(zones), _zoneList.hash(missing));

  @override
  String toString() => 'UnsoldZonesNote($zones, add $missing)';
}

/// The fare is not sold for the toggled zones; it is for [sets].
class FareZonesNote extends ZoneNote {
  const FareZonesNote({required this.kind, required this.sets});

  final SalesKindOption kind;
  final List<List<int>> sets;

  @override
  bool operator ==(Object other) => other is FareZonesNote && other.kind == kind && _zoneLists.equals(other.sets, sets);

  @override
  int get hashCode => Object.hash(kind, _zoneLists.hash(sets));

  @override
  String toString() => 'FareZonesNote(${kind.description}: $sets)';
}

/// The network (discount) type covers only [zones], which are fixed.
class DiscountNote extends ZoneNote {
  const DiscountNote({required this.zones});

  final List<int> zones;

  @override
  bool operator ==(Object other) => other is DiscountNote && _zoneList.equals(other.zones, zones);

  @override
  int get hashCode => _zoneList.hash(zones);

  @override
  String toString() => 'DiscountNote($zones)';
}

/// A complete choice, as `tickets/calculate` and `tickets/buy` take it.
class TicketChoice {
  const TicketChoice({
    required this.validFrom,
    required this.ticketNumberOfLineCode,
    required this.ticketKindCode,
    required this.ticketPeriodCode,
    required this.lines,
    this.specialTransportLine,
  });

  /// Local midnight of the first day.
  final DateTime validFrom;
  final int ticketNumberOfLineCode;
  final int ticketKindCode;
  final int ticketPeriodCode;
  final List<TransportLine> lines;

  /// The chosen type, sent for every product as the official client does.
  final String? specialTransportLine;

  @override
  bool operator ==(Object other) =>
      other is TicketChoice &&
      other.validFrom == validFrom &&
      other.ticketNumberOfLineCode == ticketNumberOfLineCode &&
      other.ticketKindCode == ticketKindCode &&
      other.ticketPeriodCode == ticketPeriodCode &&
      const ListEquality<TransportLine>().equals(other.lines, lines) &&
      other.specialTransportLine == specialTransportLine;

  @override
  int get hashCode => Object.hash(
    validFrom,
    ticketNumberOfLineCode,
    ticketKindCode,
    ticketPeriodCode,
    const ListEquality<TransportLine>().hash(lines),
    specialTransportLine,
  );
}

/// What can be bought, from `tickets/ticket-sales-configuration` alone.
///
/// A type (`specialTransportLines`) admits the zone products
/// (`ticketNumberOfLines`) and periods whose `isNetwork` / `isMetropolitan`
/// flag it shares; `priceListConfigurations` then says which (kind,
/// product, period) combinations are sold. Zones are toggled one by one and
/// map onto the product that covers exactly them (`…LineQty` ≥ 0).
class SalesRules {
  SalesRules(this.config)
    : _sold = {
        for (final entry in config.priceListConfigurations)
          if (entry case PriceListConfiguration(
            :final int ticketKindCode,
            :final int ticketNumberOfLineCode,
            :final int ticketPeriodCode,
          ))
            (ticketKindCode, ticketNumberOfLineCode, ticketPeriodCode),
      };

  final TicketSalesConfiguration config;
  final Set<(int, int, int)> _sold;

  /// Urban, suburban, second suburban.
  static const zoneCount = 3;

  static const _numerals = ['I', 'II', 'III'];

  /// The ticket types; the Type section shows only when there are several.
  List<SpecialTransportLine> get types => config.specialTransportLines;

  bool get showsTypes => types.length > 1;

  List<SalesKindOption> get kinds => config.ticketKinds;

  SpecialTransportLine? typeOf(String? code) =>
      code == null ? null : types.firstWhereOrNull((type) => type.specialTransportLine == code);

  /// The zones [option] covers.
  static Set<int> zonesOf(SalesLineOption option) =>
      zonesFromQty(option.urbanLineQty, option.suburbanLineQty, option.suburban2LineQty);

  /// The zones a product covers, from its line counts per zone (≥ 0 means
  /// covered, -1 not). The configuration's products and the line-scope
  /// dictionary carry the same three fields.
  static Set<int> zonesFromQty(int? urban, int? suburban, int? suburban2) => {
    if ((urban ?? -1) >= 0) 0,
    if ((suburban ?? -1) >= 0) 1,
    if ((suburban2 ?? -1) >= 0) 2,
  };

  /// "II": the zone's numeral.
  static String numeral(int zone) => _numerals[zone];

  static bool _matches(SpecialTransportLine type, bool? isNetwork, bool? isMetropolitan) =>
      (type.isNetwork == true && isNetwork == true) || (type.isMetropolitan == true && isMetropolitan == true);

  /// The zone products the type sells, in the configuration's order.
  List<SalesLineOption> optionsFor(String? type) {
    final t = typeOf(type);
    if (t == null) {
      return const [];
    }
    return [
      for (final option in config.ticketNumberOfLines)
        if (option.code != null && _matches(t, option.isNetwork, option.isMetropolitan)) option,
    ];
  }

  /// The periods the type sells: its flag matches and some product of the
  /// type is priced for it.
  List<SalesPeriodOption> periodsFor(String? type) {
    final t = typeOf(type);
    if (t == null) {
      return const [];
    }
    final options = optionsFor(type);
    return [
      for (final period in config.ticketPeriods)
        if (period.code != null &&
            _matches(t, period.isNetwork, period.isMetropolitan) &&
            _sold.any((entry) => entry.$3 == period.code && options.any((o) => o.code == entry.$2)))
          period,
    ];
  }

  /// Whether the price list has the combination.
  bool isSold(int? kind, int? option, int? period) =>
      kind != null && option != null && period != null && _sold.contains((kind, option, period));

  /// Whether [option] of the type is sold for [kind] in any of its periods.
  bool optionSold(String? type, int? kind, SalesLineOption option) =>
      periodsFor(type).any((period) => isSold(kind, option.code, period.code));

  /// Whether anything of the type is sold for [kind].
  bool kindAvailable(String? type, int? kind) => optionsFor(type).any((option) => optionSold(type, kind, option));

  /// The zones every product of the type covers, when they all cover the
  /// same: those are selected and locked (the discount type: Strefa I).
  Set<int>? fixedZones(String? type) {
    final options = optionsFor(type);
    if (options.isEmpty) {
      return null;
    }
    final first = zonesOf(options.first);
    return options.every((option) => _zoneSet.equals(zonesOf(option), first)) ? first : null;
  }

  /// Whether the zone tile can be toggled: some product of the type covers
  /// it for [kind] (any fare while none is chosen).
  bool zoneAvailable(String? type, int? kind, int zone) {
    final fixed = fixedZones(type);
    if (fixed != null) {
      return fixed.contains(zone);
    }
    return optionsFor(type)
        .any((option) => zonesOf(option).contains(zone) && (kind == null || optionSold(type, kind, option)));
  }

  /// The products of the type covering exactly [zones].
  List<SalesLineOption> optionsForZones(String? type, Set<int> zones) => [
    for (final option in optionsFor(type))
      if (_zoneSet.equals(zonesOf(option), zones)) option,
  ];

  /// The products of the type covering exactly [zones] that [kind] is sold
  /// for.
  List<SalesLineOption> productsFor(String? type, int? kind, Set<int> zones) => [
    for (final option in optionsForZones(type, zones))
      if (optionSold(type, kind, option)) option,
  ];

  /// The Lines section's choices for the zones: shown when more than one
  /// product covers them, or only line-scoped ones do. All lines first,
  /// then by the number of lines; empty when there is nothing to choose.
  List<SalesLineOption> lineChoices(String? type, Set<int> zones) {
    final options = optionsForZones(type, zones);
    if (options.isEmpty || (options.length == 1 && options.single.selectableLines != true)) {
      return const [];
    }
    return [
      ...options.where((option) => option.selectableLines != true),
      ...options
          .where((option) => option.selectableLines == true)
          .sortedBy<num>((option) => option.sumLinesToSelection ?? 0),
    ];
  }

  /// Whether the period chip is enabled for the product.
  bool periodAvailable(String? type, int? kind, int? option, int period) =>
      periodsFor(type).any((p) => p.code == period) && isSold(kind, option, period);

  /// The zones in effect: the fixed ones, else the toggled ones.
  Set<int> zonesIn(PurchaseSelection selection) => fixedZones(selection.type) ?? selection.zones;

  /// The product the selection comes to, once its zones (and lines
  /// choice) settle on one that the fare is sold for.
  SalesLineOption? productOf(PurchaseSelection selection) {
    final type = selection.type;
    final kind = selection.kind;
    if (typeOf(type) == null || kind == null) {
      return null;
    }
    final zones = zonesIn(selection);
    final choices = lineChoices(type, zones);
    if (choices.isNotEmpty) {
      for (final option in choices) {
        if (option.code == selection.lineOption && optionSold(type, kind, option)) {
          return option;
        }
      }
      return null;
    }
    final products = productsFor(type, kind, zones);
    return products.length == 1 ? products.single : null;
  }

  /// The first section still to answer, or null when the choice is
  /// complete. It decides the bar's hint and which sections show.
  PurchaseSection? nextMissing(PurchaseSelection selection) {
    final type = selection.type;
    if (typeOf(type) == null) {
      return PurchaseSection.type;
    }
    if (!kindAvailable(type, selection.kind)) {
      return PurchaseSection.fare;
    }
    final zones = zonesIn(selection);
    if (productsFor(type, selection.kind, zones).isEmpty) {
      return PurchaseSection.zone;
    }
    final product = productOf(selection);
    if (product == null) {
      return PurchaseSection.lines;
    }
    if (linesLeft(selection) > 0) {
      return PurchaseSection.lines;
    }
    final period = selection.period;
    if (period == null || !periodAvailable(type, selection.kind, product.code, period)) {
      return PurchaseSection.period;
    }
    if (selection.startDate == null) {
      return PurchaseSection.start;
    }
    return null;
  }

  /// How many more lines the chosen line-scoped product needs.
  int linesLeft(PurchaseSelection selection) {
    final product = productOf(selection);
    if (product == null || product.selectableLines != true) {
      return 0;
    }
    final left = (product.sumLinesToSelection ?? 0) - selection.lines.length;
    return left < 0 ? 0 : left;
  }

  /// The sections on screen: each once the one above is answered, without
  /// Type for a single type and Lines where there is nothing to choose.
  List<PurchaseSection> visibleSections(PurchaseSelection selection) {
    if (types.isEmpty) {
      return const [];
    }
    final missing = nextMissing(selection);
    final visible = <PurchaseSection>[];
    for (final section in PurchaseSection.values) {
      if (section == PurchaseSection.type && !showsTypes) {
        continue;
      }
      if (section == PurchaseSection.lines && lineChoices(selection.type, zonesIn(selection)).isEmpty) {
        continue;
      }
      visible.add(section);
      if (section == missing) {
        break;
      }
    }
    return visible;
  }

  /// The notes under the zone tiles.
  List<ZoneNote> notes(PurchaseSelection selection) {
    final type = typeOf(selection.type);
    final kind = selection.kind;
    if (type == null || kind == null) {
      return const [];
    }
    final fixed = fixedZones(selection.type);
    if (fixed != null) {
      final sold = {for (final option in config.ticketNumberOfLines) ...zonesOf(option)};
      final restricts = type.isNetwork == true && !fixed.containsAll(sold);
      return restricts ? [DiscountNote(zones: _sorted(fixed))] : const [];
    }
    final zones = selection.zones;
    if (zones.isEmpty) {
      return const [];
    }
    if (optionsForZones(selection.type, zones).isEmpty) {
      final smallest = minBy(
        optionsFor(selection.type).where((option) => zonesOf(option).containsAll(zones)),
        (option) => zonesOf(option).length,
      );
      if (smallest == null) {
        return const [];
      }
      return [UnsoldZonesNote(zones: _sorted(zones), missing: _sorted(zonesOf(smallest).difference(zones)))];
    }
    if (productsFor(selection.type, kind, zones).isEmpty) {
      final kindOption = kinds.firstWhereOrNull((k) => k.code == kind) ?? SalesKindOption(code: kind);
      final sets = EqualitySet<List<int>>(_zoneList)
        ..addAll([
          for (final option in optionsFor(selection.type))
            if (optionSold(selection.type, kind, option)) _sorted(zonesOf(option)),
        ]);
      return [FareZonesNote(kind: kindOption, sets: sets.toList())];
    }
    return const [];
  }

  /// [selection] with every answer that is no longer valid dropped, and
  /// the answers that follow from it (the only type, fixed zones) filled
  /// in. Valid answers are kept, even in sections now hidden.
  PurchaseSelection reconcile(PurchaseSelection selection) {
    var s = selection;
    if (types.length == 1) {
      if (s.type != types.single.specialTransportLine) {
        s = s.copyWith(type: () => types.single.specialTransportLine);
      }
    } else if (s.type != null && typeOf(s.type) == null) {
      s = s.copyWith(type: () => null);
    }
    final type = s.type;
    if (typeOf(type) == null) {
      return s;
    }
    if (s.kind != null && !kindAvailable(type, s.kind)) {
      s = s.copyWith(kind: () => null);
    }
    final fixed = fixedZones(type);
    if (fixed != null) {
      if (!_zoneSet.equals(s.zones, fixed)) {
        s = s.copyWith(zones: fixed);
      }
    } else {
      final covered = {for (final option in optionsFor(type)) ...zonesOf(option)};
      if (!covered.containsAll(s.zones)) {
        s = s.copyWith(zones: s.zones.intersection(covered));
      }
    }
    final zones = zonesIn(s);
    SalesLineOption? lineOption;
    if (s.lineOption != null) {
      lineOption = lineChoices(type, zones).firstWhereOrNull((option) => option.code == s.lineOption);
      if (lineOption == null || (s.kind != null && !optionSold(type, s.kind, lineOption))) {
        lineOption = null;
        s = s.copyWith(lineOption: () => null);
      }
    }
    final maxLines = lineOption?.selectableLines == true ? (lineOption?.sumLinesToSelection ?? 0) : 0;
    if (s.lines.length > maxLines) {
      s = s.copyWith(lines: s.lines.take(maxLines).toList(growable: false));
    }
    final period = s.period;
    if (period != null) {
      final product = productOf(s);
      final offered = periodsFor(type).any((p) => p.code == period);
      if (!offered || (product != null && !isSold(s.kind, product.code, period))) {
        s = s.copyWith(period: () => null);
      }
    }
    return s;
  }

  /// The form filled in from [ticket], as far as the configuration allows.
  ///
  /// The type is the ticket's own, else the metropolitan type for a
  /// metropolitan ticket and the network type for any other (a line
  /// ticket has neither flag), as the official client picks it. A fare the
  /// configuration doesn't sell (an inhabitant's 21 or 22) becomes the one
  /// in the same `groupId` of the kind dictionary ([kindDictionary]).
  PurchaseSelection prefill(
    MkkmTicket ticket, {
    required List<TicketKind> kindDictionary,
    required DateTime startDate,
  }) {
    final type =
        typeOf(ticket.specialTransportLine) ??
        (ticket.isMetropolitan == true
            ? types.firstWhereOrNull((t) => t.isMetropolitan == true)
            : types.firstWhereOrNull((t) => t.isNetwork == true));
    final typeCode = type?.specialTransportLine;
    final option = config.ticketNumberOfLines.firstWhereOrNull((o) => o.code == ticket.ticketNumberOfLineCode);
    return reconcile(
      PurchaseSelection(
        type: typeCode,
        kind: _kindFor(ticket.ticketKindCode, typeCode, kindDictionary),
        zones: option == null ? const {} : zonesOf(option),
        lineOption: option?.code,
        lines: ticket.lines,
        period: ticket.ticketPeriodCode,
        startDate: startDate,
      ),
    );
  }

  int? _kindFor(int? code, String? type, List<TicketKind> dictionary) {
    bool sells(int? kind) => kinds.any((k) => k.code == kind) && (typeOf(type) == null || kindAvailable(type, kind));
    if (code == null || sells(code)) {
      return code;
    }
    final group = dictionary.firstWhereOrNull((k) => k.code == code)?.groupId;
    if (group == null) {
      return null;
    }
    return kinds
        .firstWhereOrNull(
          (kind) => dictionary.firstWhereOrNull((k) => k.code == kind.code)?.groupId == group && sells(kind.code),
        )
        ?.code;
  }

  /// The start day's range and default.
  ///
  /// A new ticket starts tomorrow, within the configuration's first and
  /// last day as sent. Extending a ticket that is still running starts the
  /// day after it ends, up to 30 days after that; one that has ended is
  /// treated as new.
  StartBounds startBounds(DateTime now, {MkkmTicket? extending}) {
    final end = extending?.endDate?.toLocal();
    if (end != null && end.isAfter(now)) {
      final after = DateTime(end.year, end.month, end.day + 1);
      return StartBounds(
        initial: after,
        first: after,
        last: DateTime(after.year, after.month, after.day + 30),
        extending: true,
      );
    }
    final local = now.toLocal();
    final bounds = StartBounds(
      initial: DateTime(local.year, local.month, local.day + 1),
      first: _dayOf(config.firstDayOfValidity),
      last: _dayOf(config.lastDayOfValidity),
    );
    return StartBounds(initial: bounds.clamp(bounds.initial), first: bounds.first, last: bounds.last);
  }

  /// The complete choice for `tickets/calculate`, or null while something
  /// is missing.
  TicketChoice? choiceOf(PurchaseSelection selection) {
    final product = productOf(selection);
    final kind = selection.kind;
    final period = selection.period;
    final start = selection.startDate;
    if (nextMissing(selection) != null || product?.code == null || kind == null || period == null || start == null) {
      return null;
    }
    return TicketChoice(
      validFrom: DateTime(start.year, start.month, start.day),
      ticketNumberOfLineCode: product!.code!,
      ticketKindCode: kind,
      ticketPeriodCode: period,
      lines: product.selectableLines == true ? selection.lines : const [],
      specialTransportLine: selection.type,
    );
  }

  static DateTime? _dayOf(DateTime? value) {
    if (value == null) {
      return null;
    }
    final local = value.isUtc ? value.toLocal() : value;
    return DateTime(local.year, local.month, local.day);
  }
}

const _zoneSet = SetEquality<int>();
const _zoneList = ListEquality<int>();
const _zoneLists = ListEquality<List<int>>(_zoneList);

List<int> _sorted(Iterable<int> zones) => zones.toList()..sort();
