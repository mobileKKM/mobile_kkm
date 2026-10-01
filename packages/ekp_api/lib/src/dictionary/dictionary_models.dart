import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/code_message.dart';

part 'dictionary_models.freezed.dart';
part 'dictionary_models.g.dart';

/// `GET dictionary/ticket-kind-list` element.
@freezed
abstract class TicketKind with _$TicketKind {
  const factory TicketKind({
    int? code,
    String? description,
    bool? availableForSell,
    bool? availableWhenCracovCardAuthorizationIsNotValid,
    bool? availableWhenCracovCardAuthorizationIsValid,
    int? groupId,
  }) = _TicketKind;

  factory TicketKind.fromJson(Map<String, dynamic> json) =>
      _$TicketKindFromJson(json);
}

/// `GET dictionary/ticket-kind-list`
@freezed
abstract class TicketKindListResponse with _$TicketKindListResponse {
  const factory TicketKindListResponse({
    @Default(<TicketKind>[]) List<TicketKind> kinds,
  }) = _TicketKindListResponse;

  factory TicketKindListResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketKindListResponseFromJson(json);
}

/// `GET dictionary/ticket-number-of-line-list` element — how many/which
/// lines a ticket is valid on (zone scope).
@freezed
abstract class TicketNumberOfLine with _$TicketNumberOfLine {
  const factory TicketNumberOfLine({
    int? code,
    String? description,
    bool? availableForSell,
    bool? forAll,
    bool? forKK,
    int? urbanLineQty,
    int? suburbanLineQty,
    int? suburban2LineQty,
    bool? selectableLines,
    int? sumLinesToSelection,
  }) = _TicketNumberOfLine;

  factory TicketNumberOfLine.fromJson(Map<String, dynamic> json) =>
      _$TicketNumberOfLineFromJson(json);
}

/// `GET dictionary/ticket-number-of-line-list`
@freezed
abstract class TicketNumberOfLineListResponse
    with _$TicketNumberOfLineListResponse {
  const factory TicketNumberOfLineListResponse({
    @Default(<TicketNumberOfLine>[]) List<TicketNumberOfLine> list,
  }) = _TicketNumberOfLineListResponse;

  factory TicketNumberOfLineListResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketNumberOfLineListResponseFromJson(json);
}

/// `GET dictionary/ticket-period-list` element — validity period.
/// `unit`: 2 = months, 3 = days.
@freezed
abstract class TicketPeriod with _$TicketPeriod {
  const factory TicketPeriod({
    int? code,
    String? description,
    bool? availableForSell,
    bool? forAll,
    bool? forKK,
    int? value,
    int? unit,
  }) = _TicketPeriod;

  factory TicketPeriod.fromJson(Map<String, dynamic> json) =>
      _$TicketPeriodFromJson(json);
}

/// `GET dictionary/ticket-period-list`
@freezed
abstract class TicketPeriodListResponse with _$TicketPeriodListResponse {
  const factory TicketPeriodListResponse({
    @Default(<TicketPeriod>[]) List<TicketPeriod> list,
  }) = _TicketPeriodListResponse;

  factory TicketPeriodListResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketPeriodListResponseFromJson(json);
}

/// `GET dictionary/transport-line?number=...` element.
///
/// Field names on the wire are snake_case (unlike the camelCase used
/// everywhere else in this API), hence the explicit [JsonKey]s.
@freezed
abstract class TransportLine with _$TransportLine {
  const factory TransportLine({
    int? line,
    @JsonKey(name: 'second_zone') bool? secondZone,
    @JsonKey(name: 'has_second_zone') bool? hasSecondZone,
    @JsonKey(name: 'is_tram') bool? isTram,
    @JsonKey(name: 'is_bus') bool? isBus,
  }) = _TransportLine;

  factory TransportLine.fromJson(Map<String, dynamic> json) =>
      _$TransportLineFromJson(json);
}

/// `GET dictionary/transport-line?number=...`
///
/// Prefix search: `number=1` returns every line starting with "1"
/// (1, 10–19, 100–199, …). An empty result is `{"lines": [], "code": null,
/// "message": null}` — the response still carries the code/message envelope.
@freezed
abstract class TransportLineResponse
    with EkpCodeMessage, _$TransportLineResponse {
  const TransportLineResponse._();

  const factory TransportLineResponse({
    @Default(<TransportLine>[]) List<TransportLine> lines,
    Object? code,
    String? message,
  }) = _TransportLineResponse;

  factory TransportLineResponse.fromJson(Map<String, dynamic> json) =>
      _$TransportLineResponseFromJson(json);
}

/// `GET dictionary/city-card-types` — a raw map of code → name
/// (`{"8": "mKKM", ...}`; values arrive with trailing whitespace).
@freezed
abstract class CityCardTypesResponse with _$CityCardTypesResponse {
  @Freezed(fromJson: false, toJson: false)
  const factory CityCardTypesResponse({
    @Default(<String, String>{}) Map<String, String> types,
  }) = _CityCardTypesResponse;

  const CityCardTypesResponse._();

  factory CityCardTypesResponse.fromJson(Map<String, dynamic> json) {
    return CityCardTypesResponse(
      types: json.map((k, dynamic v) => MapEntry(k, (v ?? '').toString())),
    );
  }

  /// Name for a numeric card code (e.g. 8 → `mKKM`), trimmed; null unknown.
  String? nameForCode(int code) {
    final name = types[code.toString()]?.trim();
    return (name == null || name.isEmpty) ? null : name;
  }
}
