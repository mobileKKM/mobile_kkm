// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketKind _$TicketKindFromJson(Map<String, dynamic> json) => _TicketKind(
  code: (json['code'] as num?)?.toInt(),
  description: json['description'] as String?,
  availableForSell: json['availableForSell'] as bool?,
  availableWhenCracovCardAuthorizationIsNotValid: json['availableWhenCracovCardAuthorizationIsNotValid'] as bool?,
  availableWhenCracovCardAuthorizationIsValid: json['availableWhenCracovCardAuthorizationIsValid'] as bool?,
  groupId: (json['groupId'] as num?)?.toInt(),
);

Map<String, dynamic> _$TicketKindToJson(_TicketKind instance) => <String, dynamic>{
  'code': instance.code,
  'description': instance.description,
  'availableForSell': instance.availableForSell,
  'availableWhenCracovCardAuthorizationIsNotValid': instance.availableWhenCracovCardAuthorizationIsNotValid,
  'availableWhenCracovCardAuthorizationIsValid': instance.availableWhenCracovCardAuthorizationIsValid,
  'groupId': instance.groupId,
};

_TicketKindListResponse _$TicketKindListResponseFromJson(Map<String, dynamic> json) => _TicketKindListResponse(
  kinds:
      (json['kinds'] as List<dynamic>?)?.map((e) => TicketKind.fromJson(e as Map<String, dynamic>)).toList() ??
      const <TicketKind>[],
);

Map<String, dynamic> _$TicketKindListResponseToJson(_TicketKindListResponse instance) => <String, dynamic>{
  'kinds': instance.kinds,
};

_TicketNumberOfLine _$TicketNumberOfLineFromJson(Map<String, dynamic> json) => _TicketNumberOfLine(
  code: (json['code'] as num?)?.toInt(),
  description: json['description'] as String?,
  availableForSell: json['availableForSell'] as bool?,
  forAll: json['forAll'] as bool?,
  forKK: json['forKK'] as bool?,
  urbanLineQty: (json['urbanLineQty'] as num?)?.toInt(),
  suburbanLineQty: (json['suburbanLineQty'] as num?)?.toInt(),
  suburban2LineQty: (json['suburban2LineQty'] as num?)?.toInt(),
  selectableLines: json['selectableLines'] as bool?,
  sumLinesToSelection: (json['sumLinesToSelection'] as num?)?.toInt(),
);

Map<String, dynamic> _$TicketNumberOfLineToJson(_TicketNumberOfLine instance) => <String, dynamic>{
  'code': instance.code,
  'description': instance.description,
  'availableForSell': instance.availableForSell,
  'forAll': instance.forAll,
  'forKK': instance.forKK,
  'urbanLineQty': instance.urbanLineQty,
  'suburbanLineQty': instance.suburbanLineQty,
  'suburban2LineQty': instance.suburban2LineQty,
  'selectableLines': instance.selectableLines,
  'sumLinesToSelection': instance.sumLinesToSelection,
};

_TicketNumberOfLineListResponse _$TicketNumberOfLineListResponseFromJson(Map<String, dynamic> json) =>
    _TicketNumberOfLineListResponse(
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => TicketNumberOfLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TicketNumberOfLine>[],
    );

Map<String, dynamic> _$TicketNumberOfLineListResponseToJson(_TicketNumberOfLineListResponse instance) =>
    <String, dynamic>{'list': instance.list};

_TicketPeriod _$TicketPeriodFromJson(Map<String, dynamic> json) => _TicketPeriod(
  code: (json['code'] as num?)?.toInt(),
  description: json['description'] as String?,
  availableForSell: json['availableForSell'] as bool?,
  forAll: json['forAll'] as bool?,
  forKK: json['forKK'] as bool?,
  value: (json['value'] as num?)?.toInt(),
  unit: (json['unit'] as num?)?.toInt(),
);

Map<String, dynamic> _$TicketPeriodToJson(_TicketPeriod instance) => <String, dynamic>{
  'code': instance.code,
  'description': instance.description,
  'availableForSell': instance.availableForSell,
  'forAll': instance.forAll,
  'forKK': instance.forKK,
  'value': instance.value,
  'unit': instance.unit,
};

_TicketPeriodListResponse _$TicketPeriodListResponseFromJson(Map<String, dynamic> json) => _TicketPeriodListResponse(
  list:
      (json['list'] as List<dynamic>?)?.map((e) => TicketPeriod.fromJson(e as Map<String, dynamic>)).toList() ??
      const <TicketPeriod>[],
);

Map<String, dynamic> _$TicketPeriodListResponseToJson(_TicketPeriodListResponse instance) => <String, dynamic>{
  'list': instance.list,
};

_TransportLine _$TransportLineFromJson(Map<String, dynamic> json) => _TransportLine(
  line: (json['line'] as num?)?.toInt(),
  secondZone: json['second_zone'] as bool?,
  hasSecondZone: json['has_second_zone'] as bool?,
  isTram: json['is_tram'] as bool?,
  isBus: json['is_bus'] as bool?,
);

Map<String, dynamic> _$TransportLineToJson(_TransportLine instance) => <String, dynamic>{
  'line': instance.line,
  'second_zone': instance.secondZone,
  'has_second_zone': instance.hasSecondZone,
  'is_tram': instance.isTram,
  'is_bus': instance.isBus,
};

_TransportLineResponse _$TransportLineResponseFromJson(Map<String, dynamic> json) => _TransportLineResponse(
  lines:
      (json['lines'] as List<dynamic>?)?.map((e) => TransportLine.fromJson(e as Map<String, dynamic>)).toList() ??
      const <TransportLine>[],
  code: json['code'],
  message: json['message'] as String?,
);

Map<String, dynamic> _$TransportLineResponseToJson(_TransportLineResponse instance) => <String, dynamic>{
  'lines': instance.lines,
  'code': instance.code,
  'message': instance.message,
};
