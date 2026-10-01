// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceListResponse _$InvoiceListResponseFromJson(Map<String, dynamic> json) =>
    _InvoiceListResponse(
      list: json['list'] as List<dynamic>? ?? const <dynamic>[],
      rowCount: (json['rowCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InvoiceListResponseToJson(
  _InvoiceListResponse instance,
) => <String, dynamic>{'list': instance.list, 'rowCount': instance.rowCount};
