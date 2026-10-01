// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_medium_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorageMedium _$StorageMediumFromJson(
  Map<String, dynamic> json,
) => _StorageMedium(
  storageTypeId: (json['storageTypeId'] as num?)?.toInt(),
  cityCardCode: (json['cityCardCode'] as num?)?.toInt(),
  cardNumber: (json['cardNumber'] as num?)?.toInt(),
  customerCode: (json['customerCode'] as num?)?.toInt(),
  ccCustomerCode: (json['ccCustomerCode'] as num?)?.toInt(),
  ccCustomerId: (json['ccCustomerId'] as num?)?.toInt(),
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  hasActiveInhabitantStatus: json['hasActiveInhabitantStatus'] as bool?,
  inhabitantStatusDateFrom: json['inhabitantStatusDateFrom'] == null
      ? null
      : DateTime.parse(json['inhabitantStatusDateFrom'] as String),
  inhabitantStatusDateTo: json['inhabitantStatusDateTo'] == null
      ? null
      : DateTime.parse(json['inhabitantStatusDateTo'] as String),
  deactivationDateToCommunique: json['deactivationDateToCommunique'] as String?,
  blockPlannedStateId: (json['blockPlannedStateId'] as num?)?.toInt(),
  blockPlannedStateDescription: json['blockPlannedStateDescription'] as String?,
  blocked: json['blocked'] as bool?,
  issued: json['issued'] as bool?,
  canBuyTickets: json['canBuyTickets'] as bool?,
  isDefault: json['isDefault'] as bool?,
  storageTypeName: json['storageTypeName'] as String?,
);

Map<String, dynamic> _$StorageMediumToJson(
  _StorageMedium instance,
) => <String, dynamic>{
  'storageTypeId': instance.storageTypeId,
  'cityCardCode': instance.cityCardCode,
  'cardNumber': instance.cardNumber,
  'customerCode': instance.customerCode,
  'ccCustomerCode': instance.ccCustomerCode,
  'ccCustomerId': instance.ccCustomerId,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'hasActiveInhabitantStatus': instance.hasActiveInhabitantStatus,
  'inhabitantStatusDateFrom': instance.inhabitantStatusDateFrom
      ?.toIso8601String(),
  'inhabitantStatusDateTo': instance.inhabitantStatusDateTo?.toIso8601String(),
  'deactivationDateToCommunique': instance.deactivationDateToCommunique,
  'blockPlannedStateId': instance.blockPlannedStateId,
  'blockPlannedStateDescription': instance.blockPlannedStateDescription,
  'blocked': instance.blocked,
  'issued': instance.issued,
  'canBuyTickets': instance.canBuyTickets,
  'isDefault': instance.isDefault,
  'storageTypeName': instance.storageTypeName,
};

_StorageMediumListResponse _$StorageMediumListResponseFromJson(
  Map<String, dynamic> json,
) => _StorageMediumListResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => StorageMedium.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StorageMedium>[],
);

Map<String, dynamic> _$StorageMediumListResponseToJson(
  _StorageMediumListResponse instance,
) => <String, dynamic>{'items': instance.items};
