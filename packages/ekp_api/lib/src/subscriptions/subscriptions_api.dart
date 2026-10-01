import '../common/api_paths.dart';
import '../common/api_service.dart';
import 'subscription_models.dart';

/// Subscriptions (5+1 / Bilet Półroczny) domain. Only read endpoints were
/// captured; sign-up/activation flows are not implemented.
class SubscriptionsApi extends EkpApiService {
  SubscriptionsApi(super.dio);

  /// `GET subscriptions/details`
  Future<SubscriptionDetails> details() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsDetails,
      );
      return SubscriptionDetails.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET subscriptions/available-actions`
  Future<SubscriptionAvailableActions> availableActions() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsAvailableActions,
      );
      return SubscriptionAvailableActions.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }

  /// `GET subscriptions/marketing-consents`
  Future<SubscriptionMarketingConsentsResponse> marketingConsents() async {
    return guard(() async {
      final response = await dio.get<Map<String, dynamic>>(
        EkpApiPaths.subscriptionsMarketingConsents,
      );
      return SubscriptionMarketingConsentsResponse.fromJson(
        response.data ?? const <String, dynamic>{},
      );
    });
  }
}
