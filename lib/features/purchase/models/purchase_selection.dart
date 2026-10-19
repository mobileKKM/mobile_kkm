import 'package:ekp_api/ekp_api.dart';

/// Where the selection comes from: an empty form, or filled in from a
/// ticket to extend or to buy again.
enum PurchaseSource { fresh, extend, similar }

/// The sections of the purchase form, in the official order.
enum PurchaseSection { type, fare, zone, lines, period, start }

/// What the user has chosen on the purchase form so far. Codes are the
/// sales configuration's; validity is judged by `SalesRules`.
class PurchaseSelection {
  const PurchaseSelection({
    this.type,
    this.kind,
    this.zones = const {},
    this.lineOption,
    this.lines = const [],
    this.period,
    this.startDate,
  });

  /// `specialTransportLine` of the chosen ticket type.
  final String? type;

  /// `ticketKinds` code: the fare.
  final int? kind;

  /// Zone indexes (0 urban, 1 suburban, 2 second suburban) toggled on.
  final Set<int> zones;

  /// `ticketNumberOfLines` code picked in the Lines section, when the
  /// zones leave more than one.
  final int? lineOption;

  /// The lines picked for a line-scoped [lineOption].
  final List<TransportLine> lines;

  /// `ticketPeriods` code.
  final int? period;

  /// The first day of validity (a local date).
  final DateTime? startDate;

  PurchaseSelection copyWith({
    String? Function()? type,
    int? Function()? kind,
    Set<int>? zones,
    int? Function()? lineOption,
    List<TransportLine>? lines,
    int? Function()? period,
    DateTime? Function()? startDate,
  }) => PurchaseSelection(
    type: type == null ? this.type : type(),
    kind: kind == null ? this.kind : kind(),
    zones: zones ?? this.zones,
    lineOption: lineOption == null ? this.lineOption : lineOption(),
    lines: lines ?? this.lines,
    period: period == null ? this.period : period(),
    startDate: startDate == null ? this.startDate : startDate(),
  );

  @override
  bool operator ==(Object other) =>
      other is PurchaseSelection &&
      other.type == type &&
      other.kind == kind &&
      other.zones.length == zones.length &&
      other.zones.containsAll(zones) &&
      other.lineOption == lineOption &&
      _sameLines(other.lines, lines) &&
      other.period == period &&
      other.startDate == startDate;

  @override
  int get hashCode =>
      Object.hash(type, kind, Object.hashAllUnordered(zones), lineOption, Object.hashAll(lines), period, startDate);

  @override
  String toString() =>
      'PurchaseSelection(type: $type, kind: $kind, zones: $zones, lineOption: $lineOption, '
      'lines: ${[for (final line in lines) line.line]}, period: $period, startDate: $startDate)';

  static bool _sameLines(List<TransportLine> a, List<TransportLine> b) {
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}

/// The days the ticket may start on, and the one picked at first.
class StartBounds {
  const StartBounds({required this.initial, this.first, this.last, this.extending = false});

  final DateTime initial;
  final DateTime? first;
  final DateTime? last;

  /// The range follows the ticket being extended, not the configuration.
  final bool extending;

  /// [day] moved into the range.
  DateTime clamp(DateTime day) {
    final first = this.first;
    final last = this.last;
    if (first != null && day.isBefore(first)) {
      return first;
    }
    if (last != null && day.isAfter(last)) {
      return last;
    }
    return day;
  }

  @override
  bool operator ==(Object other) =>
      other is StartBounds &&
      other.initial == initial &&
      other.first == first &&
      other.last == last &&
      other.extending == extending;

  @override
  int get hashCode => Object.hash(initial, first, last, extending);

  @override
  String toString() => 'StartBounds($initial in $first…$last, extending: $extending)';
}
