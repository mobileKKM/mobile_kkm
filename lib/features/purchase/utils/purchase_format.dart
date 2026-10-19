import 'package:ekp_api/ekp_api.dart';
import 'package:intl/intl.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';
import 'package:mobile_kkm/features/purchase/models/sales_rules.dart';
import 'package:mobile_kkm/features/purchase/providers/purchase_providers.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// "I, II and III" / "I, II i III".
String joinList(AppLocalizations l10n, List<String> items) {
  if (items.length < 2) {
    return items.join();
  }
  return l10n.buyZoneList(items.sublist(0, items.length - 1).join(', '), items.last);
}

/// "I+II+III": a set of zones by their numerals.
String zoneSet(SalesRules rules, Iterable<int> zones) => [for (final zone in zones) rules.zoneNumeral(zone)].join('+');

/// The text of a note under the zone tiles.
String zoneNoteText(AppLocalizations l10n, SalesRules rules, ZoneNote note) => switch (note) {
  UnsoldZonesNote(:final zones, :final missing) => l10n.buyZonesNotTogether(
    joinList(l10n, [for (final zone in zones) rules.zoneNumeral(zone)]),
    joinList(l10n, [for (final zone in missing) rules.zoneNumeral(zone)]),
  ),
  FareZonesNote(:final kind, :final sets) => l10n.buyFareZones(
    kind.description ?? '',
    joinList(l10n, [for (final set in sets) zoneSet(rules, set)]),
  ),
  DiscountNote(:final zones) => l10n.buyDiscountZones(zoneSet(rules, zones)),
};

/// A duration chip: the period's own description when it asks for it
/// ("Studencki Roczny"), else its months or days.
String periodLabel(AppLocalizations l10n, SalesPeriodOption period) {
  final value = period.value;
  if (period.useDescription == true || value == null) {
    return period.description ?? '';
  }
  return switch (period.unit) {
    2 => l10n.buyMonths(value),
    3 => l10n.buyDays(value),
    _ => period.description ?? '',
  };
}

/// A Lines chip: "All lines", or "1 line" for a line-scoped product.
String lineOptionLabel(AppLocalizations l10n, SalesLineOption option) =>
    option.selectableLines == true ? l10n.buyLineCount(option.sumLinesToSelection ?? 1) : l10n.buyAllLines;

/// The bar's hint: the next thing to answer.
String needHint(AppLocalizations l10n, PurchaseForm form) {
  final linesLeft = form.rules.linesLeft(form.selection);
  return switch (form.nextMissing) {
    PurchaseSection.type => l10n.buyNeedType,
    PurchaseSection.fare => l10n.buyNeedFare,
    PurchaseSection.zone => l10n.buyNeedZone,
    PurchaseSection.lines => linesLeft > 0 ? l10n.buyNeedMoreLines(linesLeft) : l10n.buyNeedLines,
    PurchaseSection.period => l10n.buyNeedDuration,
    PurchaseSection.start || null => '',
  };
}

/// "Sat, Oct 17, 2026" / "sob., 17 paź 2026": the start field's value.
String startDayLabel(String locale, DateTime day) => DateFormat.yMMMEd(locale).format(day);

/// "Oct 16" / "16 paź": a day in the start's range.
String shortDay(String locale, DateTime day) => DateFormat.MMMd(locale).format(day);

/// The start field's helper line.
String startRangeLabel(AppLocalizations l10n, String locale, StartBounds bounds) {
  final first = bounds.first;
  final last = bounds.last;
  if (first == null || last == null) {
    return '';
  }
  return bounds.extending
      ? l10n.buyExtendRange(shortDay(locale, first), shortDay(locale, last))
      : l10n.buyStartsRange(shortDay(locale, first), shortDay(locale, last));
}

/// What the price bar says for a refusal.
String refusalText(AppLocalizations l10n, PriceRefused refused) {
  if (refused.fieldErrors) {
    return l10n.buyFieldErrors;
  }
  final message = refused.message;
  if (message != null && message.isNotEmpty) {
    return message;
  }
  return describeError(l10n, refused.error ?? Object());
}
