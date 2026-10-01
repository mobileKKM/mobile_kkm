import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/code_message.dart';

part 'misc_models.freezed.dart';
part 'misc_models.g.dart';

/// `GET service-status`
@freezed
abstract class ServiceStatus with _$ServiceStatus {
  const factory ServiceStatus({bool? isAvailable, String? customMessage}) =
      _ServiceStatus;

  factory ServiceStatus.fromJson(Map<String, dynamic> json) =>
      _$ServiceStatusFromJson(json);
}

/// `salesViewAnnouncement` in the mobile app config.
@freezed
abstract class SalesAnnouncement with _$SalesAnnouncement {
  const factory SalesAnnouncement({
    String? text,
    DateTime? startDate,
    DateTime? endDate,
  }) = _SalesAnnouncement;

  factory SalesAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$SalesAnnouncementFromJson(json);
}

/// `GET client/mobile-app/config` — feature flags, document URLs and the
/// minimum supported app version.
@freezed
abstract class MobileAppConfig with EkpCodeMessage, _$MobileAppConfig {
  const MobileAppConfig._();

  const factory MobileAppConfig({
    String? minAppVersion,
    String? customerPageUrl,
    String? regulationsUrl,
    String? declarationOfAccessibilityUrl,
    String? regulations5plus1Url,
    String? regulationsPurchaseUrl,
    String? informationObligationUrl,
    String? returnPaymentSuccessUrl,
    String? returnPaymentErrorUrl,
    String? busTimetableUrl,
    bool? busTimetableEnabled,
    String? tramTimetableUrl,
    bool? tramTimetableEnabled,
    SalesAnnouncement? salesViewAnnouncement,
    Object? code,
    String? message,
  }) = _MobileAppConfig;

  factory MobileAppConfig.fromJson(Map<String, dynamic> json) =>
      _$MobileAppConfigFromJson(json);
}
