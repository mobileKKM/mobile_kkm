// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bank _$BankFromJson(Map<String, dynamic> json) => _Bank(
  id: json['id'] as String?,
  name: json['name'] as String?,
  banks: json['banks'] as String?,
  img: json['img'] as String?,
  mainBankId: json['main_bank_id'] as String?,
  availableViaWebview: json['available_via_webview'] as bool?,
);

Map<String, dynamic> _$BankToJson(_Bank instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'banks': instance.banks,
  'img': instance.img,
  'main_bank_id': instance.mainBankId,
  'available_via_webview': instance.availableViaWebview,
};

_BankListResponse _$BankListResponseFromJson(Map<String, dynamic> json) =>
    _BankListResponse(
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => Bank.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Bank>[],
    );

Map<String, dynamic> _$BankListResponseToJson(_BankListResponse instance) =>
    <String, dynamic>{'list': instance.list};
