// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
  city: json['city'] as String?,
  postalCode: json['postalCode'] as String?,
  street: json['street'] as String?,
  buildingNumber: json['buildingNumber'] as String?,
  apartmentNumber: json['apartmentNumber'] as String?,
);

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
  'city': instance.city,
  'postalCode': instance.postalCode,
  'street': instance.street,
  'buildingNumber': instance.buildingNumber,
  'apartmentNumber': instance.apartmentNumber,
};

_UserData _$UserDataFromJson(Map<String, dynamic> json) => _UserData(
  pesel: json['pesel'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  email: json['email'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  photoUrl: json['photoUrl'] as String?,
  registeredAddress: json['registeredAddress'] == null
      ? null
      : Address.fromJson(json['registeredAddress'] as Map<String, dynamic>),
  invoiceByInternet: json['invoiceByInternet'] as bool?,
  autoInvoice: json['autoInvoice'] as bool?,
  mailNotifications: json['mailNotifications'] as bool?,
  pushNotifications: json['pushNotifications'] as bool?,
  hasStorageMediumWithCCCustomer:
      json['hasStorageMediumWithCCCustomer'] as bool?,
);

Map<String, dynamic> _$UserDataToJson(_UserData instance) => <String, dynamic>{
  'pesel': instance.pesel,
  'birthDate': instance.birthDate?.toIso8601String(),
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'photoUrl': instance.photoUrl,
  'registeredAddress': instance.registeredAddress,
  'invoiceByInternet': instance.invoiceByInternet,
  'autoInvoice': instance.autoInvoice,
  'mailNotifications': instance.mailNotifications,
  'pushNotifications': instance.pushNotifications,
  'hasStorageMediumWithCCCustomer': instance.hasStorageMediumWithCCCustomer,
};

_MkkmData _$MkkmDataFromJson(Map<String, dynamic> json) => _MkkmData(
  customerCode: json['customerCode'] as String?,
  hasInhabitantPrivilege: json['hasInhabitantPrivilege'] as bool?,
  inhabitantPrivilegeDateFrom: json['inhabitantPrivilegeDateFrom'] == null
      ? null
      : DateTime.parse(json['inhabitantPrivilegeDateFrom'] as String),
  inhabitantPrivilegeDateTo: json['inhabitantPrivilegeDateTo'] == null
      ? null
      : DateTime.parse(json['inhabitantPrivilegeDateTo'] as String),
  hasActiveSubscription: json['hasActiveSubscription'] as bool?,
  hadAnyInhabitantPrivilege: json['hadAnyInhabitantPrivilege'] as bool?,
  detached: json['detached'] as bool?,
);

Map<String, dynamic> _$MkkmDataToJson(_MkkmData instance) => <String, dynamic>{
  'customerCode': instance.customerCode,
  'hasInhabitantPrivilege': instance.hasInhabitantPrivilege,
  'inhabitantPrivilegeDateFrom': instance.inhabitantPrivilegeDateFrom
      ?.toIso8601String(),
  'inhabitantPrivilegeDateTo': instance.inhabitantPrivilegeDateTo
      ?.toIso8601String(),
  'hasActiveSubscription': instance.hasActiveSubscription,
  'hadAnyInhabitantPrivilege': instance.hadAnyInhabitantPrivilege,
  'detached': instance.detached,
};

_UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    _UserDataResponse(
      userData: json['userData'] == null
          ? null
          : UserData.fromJson(json['userData'] as Map<String, dynamic>),
      mkkmData: json['mkkmData'] == null
          ? null
          : MkkmData.fromJson(json['mkkmData'] as Map<String, dynamic>),
      cardsNotAdded: json['cardsNotAdded'] as bool?,
      hasKkmCard: json['hasKkmCard'] as bool?,
      hasActiveSubscription: json['hasActiveSubscription'] as bool?,
      canIssueInvoice: json['canIssueInvoice'] as bool?,
      code: json['code'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UserDataResponseToJson(_UserDataResponse instance) =>
    <String, dynamic>{
      'userData': instance.userData,
      'mkkmData': instance.mkkmData,
      'cardsNotAdded': instance.cardsNotAdded,
      'hasKkmCard': instance.hasKkmCard,
      'hasActiveSubscription': instance.hasActiveSubscription,
      'canIssueInvoice': instance.canIssueInvoice,
      'code': instance.code,
      'message': instance.message,
    };

_InhabitantStatus _$InhabitantStatusFromJson(Map<String, dynamic> json) =>
    _InhabitantStatus(
      dateFromUtc: json['dateFromUtc'] == null
          ? null
          : DateTime.parse(json['dateFromUtc'] as String),
      dateToUtc: json['dateToUtc'] == null
          ? null
          : DateTime.parse(json['dateToUtc'] as String),
      isActive: json['isActive'] as bool?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      customerCode: json['customerCode'] as String?,
      code: json['code'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$InhabitantStatusToJson(_InhabitantStatus instance) =>
    <String, dynamic>{
      'dateFromUtc': instance.dateFromUtc?.toIso8601String(),
      'dateToUtc': instance.dateToUtc?.toIso8601String(),
      'isActive': instance.isActive,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'photoUrl': instance.photoUrl,
      'customerCode': instance.customerCode,
      'code': instance.code,
      'message': instance.message,
    };

_InhabitantContract _$InhabitantContractFromJson(Map<String, dynamic> json) =>
    _InhabitantContract(
      expirationDate: _parseEpochMs(json['expirationDate']),
      contract: json['contract'] as String?,
    );

Map<String, dynamic> _$InhabitantContractToJson(_InhabitantContract instance) =>
    <String, dynamic>{
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'contract': instance.contract,
    };

_StreetAutocompleteResponse _$StreetAutocompleteResponseFromJson(
  Map<String, dynamic> json,
) => _StreetAutocompleteResponse(
  streets:
      (json['streets'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  code: json['code'],
  message: json['message'] as String?,
);

Map<String, dynamic> _$StreetAutocompleteResponseToJson(
  _StreetAutocompleteResponse instance,
) => <String, dynamic>{
  'streets': instance.streets,
  'code': instance.code,
  'message': instance.message,
};
