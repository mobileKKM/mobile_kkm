// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionTicket _$SubscriptionTicketFromJson(Map<String, dynamic> json) => _SubscriptionTicket(
  ticketGuid: json['ticketGuid'] as String?,
  transactionCode: json['transactionCode'] as String?,
  startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
  commodityName: json['commodityName'] as String?,
  monthsPeriod: (json['monthsPeriod'] as num?)?.toInt(),
  daysPeriod: (json['daysPeriod'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  canBePaid: json['canBePaid'] as bool?,
  canRemove: json['canRemove'] as bool?,
);

Map<String, dynamic> _$SubscriptionTicketToJson(_SubscriptionTicket instance) => <String, dynamic>{
  'ticketGuid': instance.ticketGuid,
  'transactionCode': instance.transactionCode,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'commodityName': instance.commodityName,
  'monthsPeriod': instance.monthsPeriod,
  'daysPeriod': instance.daysPeriod,
  'price': instance.price,
  'canBePaid': instance.canBePaid,
  'canRemove': instance.canRemove,
};

_SubscriptionDetails _$SubscriptionDetailsFromJson(Map<String, dynamic> json) => _SubscriptionDetails(
  isSubscriptionSignedIn: json['isSubscriptionSignedIn'] as bool?,
  counter: (json['counter'] as num?)?.toInt(),
  maskedCardNumber: json['maskedCardNumber'] as String?,
  subscriptionSignedInDate: json['subscriptionSignedInDate'] == null
      ? null
      : DateTime.parse(json['subscriptionSignedInDate'] as String),
  activeTicket: json['activeTicket'] == null
      ? null
      : SubscriptionTicket.fromJson(json['activeTicket'] as Map<String, dynamic>),
  pendingTicket: json['pendingTicket'] == null
      ? null
      : SubscriptionTicket.fromJson(json['pendingTicket'] as Map<String, dynamic>),
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
      birthDate: json['birthDate'] as String?,
      email: json['email'] as String?,
      cityCardCode: (json['cityCardCode'] as num?)?.toInt(),
      clientCode: (json['clientCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubscriptionCustomerDetailToJson(_SubscriptionCustomerDetail instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'pesel': instance.pesel,
  'birthDate': instance.birthDate,
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

_SubscriptionTicketSavedOnCard _$SubscriptionTicketSavedOnCardFromJson(Map<String, dynamic> json) =>
    _SubscriptionTicketSavedOnCard(
      dateStart: json['dateStart'] == null ? null : DateTime.parse(json['dateStart'] as String),
      dateEnd: json['dateEnd'] == null ? null : DateTime.parse(json['dateEnd'] as String),
    );

Map<String, dynamic> _$SubscriptionTicketSavedOnCardToJson(_SubscriptionTicketSavedOnCard instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toIso8601String(),
      'dateEnd': instance.dateEnd?.toIso8601String(),
    };

_SubscriptionBuyingTicketDetails _$SubscriptionBuyingTicketDetailsFromJson(Map<String, dynamic> json) =>
    _SubscriptionBuyingTicketDetails(
      commodityName: json['commodityName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      ticketSavedOnCard: json['ticketSavedOnCard'] == null
          ? null
          : SubscriptionTicketSavedOnCard.fromJson(json['ticketSavedOnCard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionBuyingTicketDetailsToJson(_SubscriptionBuyingTicketDetails instance) =>
    <String, dynamic>{
      'commodityName': instance.commodityName,
      'price': instance.price,
      'ticketSavedOnCard': instance.ticketSavedOnCard,
    };

_SubscriptionTicketBuyResponse _$SubscriptionTicketBuyResponseFromJson(Map<String, dynamic> json) =>
    _SubscriptionTicketBuyResponse(
      commodityName: json['commodityName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      ticketStartDate: json['ticketStartDate'] == null ? null : DateTime.parse(json['ticketStartDate'] as String),
      ticketEndDate: json['ticketEndDate'] == null ? null : DateTime.parse(json['ticketEndDate'] as String),
      tpayRedirectUrl: json['tpayRedirectUrl'] as String?,
      code: json['code'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SubscriptionTicketBuyResponseToJson(_SubscriptionTicketBuyResponse instance) =>
    <String, dynamic>{
      'commodityName': instance.commodityName,
      'price': instance.price,
      'ticketStartDate': instance.ticketStartDate?.toIso8601String(),
      'ticketEndDate': instance.ticketEndDate?.toIso8601String(),
      'tpayRedirectUrl': instance.tpayRedirectUrl,
      'code': instance.code,
      'message': instance.message,
    };

_SubscriptionTicketPayResponse _$SubscriptionTicketPayResponseFromJson(Map<String, dynamic> json) =>
    _SubscriptionTicketPayResponse(
      tpayRedirectUrl: json['tpayRedirectUrl'] as String?,
      code: json['code'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SubscriptionTicketPayResponseToJson(_SubscriptionTicketPayResponse instance) =>
    <String, dynamic>{'tpayRedirectUrl': instance.tpayRedirectUrl, 'code': instance.code, 'message': instance.message};
