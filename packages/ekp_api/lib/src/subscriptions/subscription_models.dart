import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/auth_models.dart';
import '../common/code_message.dart';

part 'subscription_models.freezed.dart';
part 'subscription_models.g.dart';

/// Ticket kind offered inside the 5+1 programme — the `ticketKind` query of
/// `subscriptions/tickets/buying-ticket-details` and the `kind` field of
/// `subscriptions/tickets/buy`.
enum SubscriptionTicketKind {
  normal('normal'),
  halfPrice('halfPrice');

  const SubscriptionTicketKind(this.wireValue);
  final String wireValue;
}

/// `activeTicket` / `pendingTicket` of `GET subscriptions/details`.
///
/// Never captured (both are null in every capture): the field set is what
/// the official client reads, and the types are those of the same-named
/// fields of `mkkm/tickets/list` and `tickets/calculate`.
@freezed
abstract class SubscriptionTicket with _$SubscriptionTicket {
  const factory SubscriptionTicket({
    /// The id [SubscriptionsApi.payTicket] and
    /// [SubscriptionsApi.removeTicket] take.
    String? ticketGuid,

    /// Present once the ticket has a transaction — the id used by
    /// `GET /tickets/{id}`.
    String? transactionCode,
    DateTime? startDate,
    DateTime? endDate,
    String? commodityName,
    int? monthsPeriod,
    int? daysPeriod,
    double? price,

    /// The ticket still awaits payment ([SubscriptionsApi.payTicket]).
    bool? canBePaid,

    /// The ticket can be deleted ([SubscriptionsApi.removeTicket]).
    bool? canRemove,
  }) = _SubscriptionTicket;

  factory SubscriptionTicket.fromJson(Map<String, dynamic> json) => _$SubscriptionTicketFromJson(json);
}

/// `GET subscriptions/details` — the 5+1 (Bilet Półroczny) programme.
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
    SubscriptionTicket? activeTicket,
    SubscriptionTicket? pendingTicket,
    SubscriptionCustomerDetail? customerDetail,
    bool? isAutomaticSubscriptionEnabled,
    bool? isCycleRefreshEnabled,
  }) = _SubscriptionDetails;

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) => _$SubscriptionDetailsFromJson(json);
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

    /// Shown by the official client when [pesel] is empty. Never captured,
    /// so the format is unknown and the value is kept as sent.
    String? birthDate,
    String? email,
    int? cityCardCode,
    int? clientCode,
  }) = _SubscriptionCustomerDetail;

  factory SubscriptionCustomerDetail.fromJson(Map<String, dynamic> json) => _$SubscriptionCustomerDetailFromJson(json);
}

/// `GET subscriptions/available-actions`
@freezed
abstract class SubscriptionAvailableActions with _$SubscriptionAvailableActions {
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
abstract class SubscriptionMarketingConsentsResponse with _$SubscriptionMarketingConsentsResponse {
  const factory SubscriptionMarketingConsentsResponse({
    @Default(<MarketingConsent>[]) List<MarketingConsent> marketingConsents,
  }) = _SubscriptionMarketingConsentsResponse;

  factory SubscriptionMarketingConsentsResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionMarketingConsentsResponseFromJson(json);
}

/// `ticketSavedOnCard` of `subscriptions/tickets/buying-ticket-details` —
/// a ticket the customer already holds, which the official client warns
/// about before the purchase. Shape taken from the official client, never
/// captured.
@freezed
abstract class SubscriptionTicketSavedOnCard with _$SubscriptionTicketSavedOnCard {
  const factory SubscriptionTicketSavedOnCard({DateTime? dateStart, DateTime? dateEnd}) =
      _SubscriptionTicketSavedOnCard;

  factory SubscriptionTicketSavedOnCard.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionTicketSavedOnCardFromJson(json);
}

/// `GET subscriptions/tickets/buying-ticket-details` — what a 5+1 ticket of
/// the requested kind would be. Shape taken from the official client, never
/// captured.
@freezed
abstract class SubscriptionBuyingTicketDetails with _$SubscriptionBuyingTicketDetails {
  const factory SubscriptionBuyingTicketDetails({
    String? commodityName,
    double? price,
    SubscriptionTicketSavedOnCard? ticketSavedOnCard,
  }) = _SubscriptionBuyingTicketDetails;

  factory SubscriptionBuyingTicketDetails.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionBuyingTicketDetailsFromJson(json);
}

/// `POST subscriptions/tickets/buy`. Shape taken from the official client,
/// never captured; it treats the purchase as successful only when [code]
/// is absent.
@freezed
abstract class SubscriptionTicketBuyResponse with EkpCodeMessage, _$SubscriptionTicketBuyResponse {
  const SubscriptionTicketBuyResponse._();

  const factory SubscriptionTicketBuyResponse({
    String? commodityName,
    double? price,
    DateTime? ticketStartDate,
    DateTime? ticketEndDate,

    /// tpay payment page for the first charge — lowercase `p`, unlike
    /// `ChangePaymentCardResponse.tPayRedirectUrl`.
    String? tpayRedirectUrl,
    Object? code,
    String? message,
  }) = _SubscriptionTicketBuyResponse;

  factory SubscriptionTicketBuyResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionTicketBuyResponseFromJson(json);
}

/// `POST subscriptions/tickets/pay`. Shape taken from the official client,
/// never captured.
@freezed
abstract class SubscriptionTicketPayResponse with EkpCodeMessage, _$SubscriptionTicketPayResponse {
  const SubscriptionTicketPayResponse._();

  const factory SubscriptionTicketPayResponse({
    /// tpay payment page; null when [needsRepaymentConfirmation].
    String? tpayRedirectUrl,
    Object? code,
    String? message,
  }) = _SubscriptionTicketPayResponse;

  factory SubscriptionTicketPayResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionTicketPayResponseFromJson(json);

  /// The server still waits for an earlier payment of this ticket
  /// (`code: 2`). The official client asks the user to confirm and then
  /// repeats the call with `ignoreWarnings: true`.
  bool get needsRepaymentConfirmation => codeAsInt == 2;
}
