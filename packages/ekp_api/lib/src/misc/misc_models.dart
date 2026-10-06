import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/code_message.dart';
import '../common/ekp_defaults.dart';

part 'misc_models.freezed.dart';
part 'misc_models.g.dart';

/// `GET service-status`
@freezed
abstract class ServiceStatus with _$ServiceStatus {
  const factory ServiceStatus({bool? isAvailable, String? customMessage}) = _ServiceStatus;

  factory ServiceStatus.fromJson(Map<String, dynamic> json) => _$ServiceStatusFromJson(json);
}

/// `salesViewAnnouncement` in the mobile app config.
@freezed
abstract class SalesAnnouncement with _$SalesAnnouncement {
  const factory SalesAnnouncement({String? text, DateTime? startDate, DateTime? endDate}) = _SalesAnnouncement;

  factory SalesAnnouncement.fromJson(Map<String, dynamic> json) => _$SalesAnnouncementFromJson(json);
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

  factory MobileAppConfig.fromJson(Map<String, dynamic> json) => _$MobileAppConfigFromJson(json);

  /// Whether the server still accepts a client of [clientVersion] — by
  /// default the official client version this package mimics
  /// ([EkpDefaults.clientVersion], sent as `x-client-version`).
  ///
  /// False only when [minAppVersion] is a dotted number version that is
  /// higher. A missing or unreadable [minAppVersion] gates nothing.
  bool supportsClient([String clientVersion = EkpDefaults.clientVersion]) {
    final minimum = _versionParts(minAppVersion);
    final client = _versionParts(clientVersion);
    if (minimum == null || client == null) {
      return true;
    }
    for (var i = 0; i < minimum.length || i < client.length; i++) {
      final wanted = i < minimum.length ? minimum[i] : 0;
      final have = i < client.length ? client[i] : 0;
      if (have != wanted) {
        return have > wanted;
      }
    }
    return true;
  }
}

/// `1.6.10` → `[1, 6, 10]`; null for anything else.
List<int>? _versionParts(String? version) {
  if (version == null || version.trim().isEmpty) {
    return null;
  }
  final parts = <int>[];
  for (final part in version.trim().split('.')) {
    final number = int.tryParse(part);
    if (number == null || number < 0) {
      return null;
    }
    parts.add(number);
  }
  return parts;
}
