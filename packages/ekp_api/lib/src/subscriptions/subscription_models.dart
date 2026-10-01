import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/auth_models.dart';

part 'subscription_models.freezed.dart';
part 'subscription_models.g.dart';

/// `GET subscriptions/details` — the 5+1 (Bilet Półroczny) programme.
/// `activeTicket`, `pendingTicket` and `customerDetail` shapes were never
/// observed (null in captures) — kept raw.
@freezed
abstract class SubscriptionDetails with _$SubscriptionDetails {
  const factory SubscriptionDetails({
    bool? isSubscriptionSignedIn,
    int? counter,
    String? maskedCardNumber,
    DateTime? subscriptionSignedInDate,
    dynamic activeTicket,
    dynamic pendingTicket,
    dynamic customerDetail,
    bool? isAutomaticSubscriptionEnabled,
    bool? isCycleRefreshEnabled,
  }) = _SubscriptionDetails;

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDetailsFromJson(json);
}

/// `GET subscriptions/available-actions`
@freezed
abstract class SubscriptionAvailableActions
    with _$SubscriptionAvailableActions {
  const factory SubscriptionAvailableActions({
    bool? newCard,
    bool? changeCard,
    bool? buyTicket,
    bool? changeStorageMedium,
  }) = _SubscriptionAvailableActions;

  factory SubscriptionAvailableActions.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionAvailableActionsFromJson(json);
}

/// `GET subscriptions/marketing-consents` (5+1 regulation consents).
@freezed
abstract class SubscriptionMarketingConsentsResponse
    with _$SubscriptionMarketingConsentsResponse {
  const factory SubscriptionMarketingConsentsResponse({
    @Default(<MarketingConsent>[]) List<MarketingConsent> marketingConsents,
  }) = _SubscriptionMarketingConsentsResponse;

  factory SubscriptionMarketingConsentsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$SubscriptionMarketingConsentsResponseFromJson(json);
}
