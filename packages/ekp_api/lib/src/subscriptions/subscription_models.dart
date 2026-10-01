import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/auth_models.dart';

part 'subscription_models.freezed.dart';
part 'subscription_models.g.dart';

/// `GET subscriptions/details` — the 5+1 (Bilet Półroczny) programme.
/// `activeTicket` and `pendingTicket` shapes were never observed (null in
/// captures) — kept raw.
@freezed
abstract class SubscriptionDetails with _$SubscriptionDetails {
  const factory SubscriptionDetails({
    bool? isSubscriptionSignedIn,
    int? counter,
    String? maskedCardNumber,

    /// Local time WITHOUT a UTC offset on the wire
    /// (e.g. `2026-10-01T15:43:39.107`) — parsed as such; treat as
    /// Europe/Warsaw local time when displaying.
    DateTime? subscriptionSignedInDate,
    dynamic activeTicket,
    dynamic pendingTicket,
    SubscriptionCustomerDetail? customerDetail,
    bool? isAutomaticSubscriptionEnabled,
    bool? isCycleRefreshEnabled,
  }) = _SubscriptionDetails;

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDetailsFromJson(json);
}

/// Customer snapshot inside the signed-in `subscriptions/details`
/// response. Names arrive UPPERCASED; [clientCode] is the numeric customer
/// code (`customerCode` elsewhere) and [cityCardCode] matches
/// `dictionary/city-card-types` keys (8 = mKKM).
@freezed
abstract class SubscriptionCustomerDetail with _$SubscriptionCustomerDetail {
  const factory SubscriptionCustomerDetail({
    String? firstName,
    String? lastName,
    String? pesel,
    String? email,
    int? cityCardCode,
    int? clientCode,
  }) = _SubscriptionCustomerDetail;

  factory SubscriptionCustomerDetail.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionCustomerDetailFromJson(json);
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
