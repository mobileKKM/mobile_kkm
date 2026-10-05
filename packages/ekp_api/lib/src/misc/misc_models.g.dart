// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'misc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceStatus _$ServiceStatusFromJson(Map<String, dynamic> json) =>
    _ServiceStatus(isAvailable: json['isAvailable'] as bool?, customMessage: json['customMessage'] as String?);

Map<String, dynamic> _$ServiceStatusToJson(_ServiceStatus instance) => <String, dynamic>{
  'isAvailable': instance.isAvailable,
  'customMessage': instance.customMessage,
};

_SalesAnnouncement _$SalesAnnouncementFromJson(Map<String, dynamic> json) => _SalesAnnouncement(
  text: json['text'] as String?,
  startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
);

Map<String, dynamic> _$SalesAnnouncementToJson(_SalesAnnouncement instance) => <String, dynamic>{
  'text': instance.text,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
};

_MobileAppConfig _$MobileAppConfigFromJson(Map<String, dynamic> json) => _MobileAppConfig(
  minAppVersion: json['minAppVersion'] as String?,
  customerPageUrl: json['customerPageUrl'] as String?,
  regulationsUrl: json['regulationsUrl'] as String?,
  declarationOfAccessibilityUrl: json['declarationOfAccessibilityUrl'] as String?,
  regulations5plus1Url: json['regulations5plus1Url'] as String?,
  regulationsPurchaseUrl: json['regulationsPurchaseUrl'] as String?,
  informationObligationUrl: json['informationObligationUrl'] as String?,
  returnPaymentSuccessUrl: json['returnPaymentSuccessUrl'] as String?,
  returnPaymentErrorUrl: json['returnPaymentErrorUrl'] as String?,
  busTimetableUrl: json['busTimetableUrl'] as String?,
  busTimetableEnabled: json['busTimetableEnabled'] as bool?,
  tramTimetableUrl: json['tramTimetableUrl'] as String?,
  tramTimetableEnabled: json['tramTimetableEnabled'] as bool?,
  salesViewAnnouncement: json['salesViewAnnouncement'] == null
      ? null
      : SalesAnnouncement.fromJson(json['salesViewAnnouncement'] as Map<String, dynamic>),
  code: json['code'],
  message: json['message'] as String?,
);

Map<String, dynamic> _$MobileAppConfigToJson(_MobileAppConfig instance) => <String, dynamic>{
  'minAppVersion': instance.minAppVersion,
  'customerPageUrl': instance.customerPageUrl,
  'regulationsUrl': instance.regulationsUrl,
  'declarationOfAccessibilityUrl': instance.declarationOfAccessibilityUrl,
  'regulations5plus1Url': instance.regulations5plus1Url,
  'regulationsPurchaseUrl': instance.regulationsPurchaseUrl,
  'informationObligationUrl': instance.informationObligationUrl,
  'returnPaymentSuccessUrl': instance.returnPaymentSuccessUrl,
  'returnPaymentErrorUrl': instance.returnPaymentErrorUrl,
  'busTimetableUrl': instance.busTimetableUrl,
  'busTimetableEnabled': instance.busTimetableEnabled,
  'tramTimetableUrl': instance.tramTimetableUrl,
  'tramTimetableEnabled': instance.tramTimetableEnabled,
  'salesViewAnnouncement': instance.salesViewAnnouncement,
  'code': instance.code,
  'message': instance.message,
};
