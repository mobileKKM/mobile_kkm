import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/code_message.dart';

part 'account_models.freezed.dart';
part 'account_models.g.dart';

/// Registered address, used in [UserData] and as input for
/// `POST account/user-data` / `POST storage-medium/create-mkkm`.
@freezed
abstract class Address with _$Address {
  const factory Address({
    String? city,
    String? postalCode,
    String? street,
    String? buildingNumber,
    String? apartmentNumber,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

/// Personal data of the logged in user (`userData` in `account/user-data`).
@freezed
abstract class UserData with _$UserData {
  const factory UserData({
    String? pesel,
    DateTime? birthDate,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? photoUrl,
    Address? registeredAddress,
    bool? invoiceByInternet,
    bool? autoInvoice,
    bool? mailNotifications,
    bool? pushNotifications,
    bool? hasStorageMediumWithCCCustomer,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}

/// mKKM specific data (`mkkmData` in `account/user-data`).
@freezed
abstract class MkkmData with _$MkkmData {
  const factory MkkmData({
    /// Note: a String here (e.g. "100001"), unlike the numeric customer
    /// codes used by the tickets endpoints.
    String? customerCode,
    bool? hasInhabitantPrivilege,
    DateTime? inhabitantPrivilegeDateFrom,
    DateTime? inhabitantPrivilegeDateTo,
    bool? hasActiveSubscription,
    bool? hadAnyInhabitantPrivilege,
    bool? detached,
  }) = _MkkmData;

  factory MkkmData.fromJson(Map<String, dynamic> json) => _$MkkmDataFromJson(json);
}

/// `GET account/user-data`
@freezed
abstract class UserDataResponse with EkpCodeMessage, _$UserDataResponse {
  const UserDataResponse._();

  const factory UserDataResponse({
    UserData? userData,
    MkkmData? mkkmData,
    bool? cardsNotAdded,
    bool? hasKkmCard,
    bool? hasActiveSubscription,
    bool? canIssueInvoice,
    Object? code,
    String? message,
  }) = _UserDataResponse;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) => _$UserDataResponseFromJson(json);
}

/// `GET account/inhabitant-status`
@freezed
abstract class InhabitantStatus with EkpCodeMessage, _$InhabitantStatus {
  const InhabitantStatus._();

  const factory InhabitantStatus({
    DateTime? dateFromUtc,
    DateTime? dateToUtc,
    bool? isActive,
    String? firstName,
    String? lastName,
    String? photoUrl,
    String? customerCode,
    Object? code,
    String? message,
  }) = _InhabitantStatus;

  factory InhabitantStatus.fromJson(Map<String, dynamic> json) => _$InhabitantStatusFromJson(json);
}

/// `GET account/inhabitant-contract` — the inhabitant (Karta Krakowska)
/// contract's AZTEC barcode, signed server-side and returned as a
/// base64-encoded PNG ready to display and scan. No crypto is involved
/// on this endpoint and there is no client-side signing step — unlike
/// the mKKM AZTEC `contract-e`, whose barcode must be rendered
/// client-side from the decrypted token.
@freezed
abstract class InhabitantContract with _$InhabitantContract {
  const factory InhabitantContract({
    /// Epoch milliseconds — the only date in the whole API that is not an
    /// ISO-8601 string (json_serializable has no built-in epoch support,
    /// hence the local [_parseEpochMs] hook).
    @JsonKey(fromJson: _parseEpochMs) DateTime? expirationDate,

    /// Base64-encoded PNG of the AZTEC barcode (signed server-side).
    String? contract,
  }) = _InhabitantContract;

  const InhabitantContract._();

  factory InhabitantContract.fromJson(Map<String, dynamic> json) => _$InhabitantContractFromJson(json);

  /// Decodes [contract] into PNG bytes (empty when absent).
  List<int> decodeContractPng() => contract == null ? const <int>[] : base64Decode(contract!);
}

/// `1790718445082` → UTC DateTime (tolerates a string just in case).
/// Top-level so both `fromJson` codegen and freezed's copied annotations
/// can reference it as a constant tear-off.
DateTime? _parseEpochMs(Object? value) => value is num
    ? DateTime.fromMillisecondsSinceEpoch(value.round(), isUtc: true)
    : value == null
    ? null
    : DateTime.parse(value as String);

/// `GET account/street-autocomplete/{cityId}/{query}`
@freezed
abstract class StreetAutocompleteResponse with EkpCodeMessage, _$StreetAutocompleteResponse {
  const StreetAutocompleteResponse._();

  const factory StreetAutocompleteResponse({@Default(<String>[]) List<String> streets, Object? code, String? message}) =
      _StreetAutocompleteResponse;

  factory StreetAutocompleteResponse.fromJson(Map<String, dynamic> json) => _$StreetAutocompleteResponseFromJson(json);
}
