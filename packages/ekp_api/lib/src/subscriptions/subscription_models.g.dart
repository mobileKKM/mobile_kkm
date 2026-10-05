// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionDetails _$SubscriptionDetailsFromJson(Map<String, dynamic> json) => _SubscriptionDetails(
  isSubscriptionSignedIn: json['isSubscriptionSignedIn'] as bool?,
  counter: (json['counter'] as num?)?.toInt(),
  maskedCardNumber: json['maskedCardNumber'] as String?,
  subscriptionSignedInDate: json['subscriptionSignedInDate'] == null
      ? null
      : DateTime.parse(json['subscriptionSignedInDate'] as String),
  activeTicket: json['activeTicket'],
  pendingTicket: json['pendingTicket'],
  customerDetail: json['customerDetail'] == null
      ? null
      : SubscriptionCustomerDetail.fromJson(json['customerDetail'] as Map<String, dynamic>),
  isAutomaticSubscriptionEnabled: json['isAutomaticSubscriptionEnabled'] as bool?,
  isCycleRefreshEnabled: json['isCycleRefreshEnabled'] as bool?,
);

Map<String, dynamic> _$SubscriptionDetailsToJson(_SubscriptionDetails instance) => <String, dynamic>{
  'isSubscriptionSignedIn': instance.isSubscriptionSignedIn,
  'counter': instance.counter,
  'maskedCardNumber': instance.maskedCardNumber,
  'subscriptionSignedInDate': instance.subscriptionSignedInDate?.toIso8601String(),
  'activeTicket': instance.activeTicket,
  'pendingTicket': instance.pendingTicket,
  'customerDetail': instance.customerDetail,
  'isAutomaticSubscriptionEnabled': instance.isAutomaticSubscriptionEnabled,
  'isCycleRefreshEnabled': instance.isCycleRefreshEnabled,
};

_SubscriptionCustomerDetail _$SubscriptionCustomerDetailFromJson(Map<String, dynamic> json) =>
    _SubscriptionCustomerDetail(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      pesel: json['pesel'] as String?,
      email: json['email'] as String?,
      cityCardCode: (json['cityCardCode'] as num?)?.toInt(),
      clientCode: (json['clientCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubscriptionCustomerDetailToJson(_SubscriptionCustomerDetail instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'pesel': instance.pesel,
  'email': instance.email,
  'cityCardCode': instance.cityCardCode,
  'clientCode': instance.clientCode,
};

_SubscriptionAvailableActions _$SubscriptionAvailableActionsFromJson(Map<String, dynamic> json) =>
    _SubscriptionAvailableActions(
      newCard: json['newCard'] as bool?,
      changeCard: json['changeCard'] as bool?,
      buyTicket: json['buyTicket'] as bool?,
      changeStorageMedium: json['changeStorageMedium'] as bool?,
    );

Map<String, dynamic> _$SubscriptionAvailableActionsToJson(_SubscriptionAvailableActions instance) => <String, dynamic>{
  'newCard': instance.newCard,
  'changeCard': instance.changeCard,
  'buyTicket': instance.buyTicket,
  'changeStorageMedium': instance.changeStorageMedium,
};

_SubscriptionMarketingConsentsResponse _$SubscriptionMarketingConsentsResponseFromJson(Map<String, dynamic> json) =>
    _SubscriptionMarketingConsentsResponse(
      marketingConsents:
          (json['marketingConsents'] as List<dynamic>?)
              ?.map((e) => MarketingConsent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MarketingConsent>[],
    );

Map<String, dynamic> _$SubscriptionMarketingConsentsResponseToJson(_SubscriptionMarketingConsentsResponse instance) =>
    <String, dynamic>{'marketingConsents': instance.marketingConsents};
