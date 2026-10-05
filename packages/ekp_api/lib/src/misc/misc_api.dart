import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'misc_models.dart';

/// Miscellaneous endpoints: service status and app configuration.
class MiscApi extends EkpApiService {
  MiscApi(super.dio);

  /// `GET service-status` — whether sales are available at all.
  Future<ServiceStatus> serviceStatus() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.serviceStatus);
      return ServiceStatus.fromJson(response.data ?? const <String, dynamic>{});
    });
  }

  /// `GET client/mobile-app/config`
  Future<MobileAppConfig> mobileAppConfig() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(EkpApiPaths.mobileAppConfig);
      return MobileAppConfig.fromJson(response.data ?? const <String, dynamic>{});
    });
  }
}
