// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_medium_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorageMedium {

 int? get storageTypeId;/// 8 identifies the mobile mKKM medium.
 int? get cityCardCode; int? get cardNumber; int? get customerCode; int? get ccCustomerCode; int? get ccCustomerId; String? get firstName; String? get lastName; bool? get hasActiveInhabitantStatus; DateTime? get inhabitantStatusDateFrom; DateTime? get inhabitantStatusDateTo; String? get deactivationDateToCommunique; int? get blockPlannedStateId; String? get blockPlannedStateDescription; bool? get blocked; bool? get issued; bool? get canBuyTickets; bool? get isDefault; String? get storageTypeName;
/// Create a copy of StorageMedium
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageMediumCopyWith<StorageMedium> get copyWith => _$StorageMediumCopyWithImpl<StorageMedium>(this as StorageMedium, _$identity);

  /// Serializes this StorageMedium to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StorageMedium;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageMedium&&(identical(other.storageTypeId, _this.storageTypeId) || other.storageTypeId == _this.storageTypeId)&&(identical(other.cityCardCode, _this.cityCardCode) || other.cityCardCode == _this.cityCardCode)&&(identical(other.cardNumber, _this.cardNumber) || other.cardNumber == _this.cardNumber)&&(identical(other.customerCode, _this.customerCode) || other.customerCode == _this.customerCode)&&(identical(other.ccCustomerCode, _this.ccCustomerCode) || other.ccCustomerCode == _this.ccCustomerCode)&&(identical(other.ccCustomerId, _this.ccCustomerId) || other.ccCustomerId == _this.ccCustomerId)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.hasActiveInhabitantStatus, _this.hasActiveInhabitantStatus) || other.hasActiveInhabitantStatus == _this.hasActiveInhabitantStatus)&&(identical(other.inhabitantStatusDateFrom, _this.inhabitantStatusDateFrom) || other.inhabitantStatusDateFrom == _this.inhabitantStatusDateFrom)&&(identical(other.inhabitantStatusDateTo, _this.inhabitantStatusDateTo) || other.inhabitantStatusDateTo == _this.inhabitantStatusDateTo)&&(identical(other.deactivationDateToCommunique, _this.deactivationDateToCommunique) || other.deactivationDateToCommunique == _this.deactivationDateToCommunique)&&(identical(other.blockPlannedStateId, _this.blockPlannedStateId) || other.blockPlannedStateId == _this.blockPlannedStateId)&&(identical(other.blockPlannedStateDescription, _this.blockPlannedStateDescription) || other.blockPlannedStateDescription == _this.blockPlannedStateDescription)&&(identical(other.blocked, _this.blocked) || other.blocked == _this.blocked)&&(identical(other.issued, _this.issued) || other.issued == _this.issued)&&(identical(other.canBuyTickets, _this.canBuyTickets) || other.canBuyTickets == _this.canBuyTickets)&&(identical(other.isDefault, _this.isDefault) || other.isDefault == _this.isDefault)&&(identical(other.storageTypeName, _this.storageTypeName) || other.storageTypeName == _this.storageTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StorageMedium;
  return Object.hashAll([runtimeType,_this.storageTypeId,_this.cityCardCode,_this.cardNumber,_this.customerCode,_this.ccCustomerCode,_this.ccCustomerId,_this.firstName,_this.lastName,_this.hasActiveInhabitantStatus,_this.inhabitantStatusDateFrom,_this.inhabitantStatusDateTo,_this.deactivationDateToCommunique,_this.blockPlannedStateId,_this.blockPlannedStateDescription,_this.blocked,_this.issued,_this.canBuyTickets,_this.isDefault,_this.storageTypeName]);
}

@override
String toString() {
  final _this = this as StorageMedium;
  return 'StorageMedium(storageTypeId: ${_this.storageTypeId}, cityCardCode: ${_this.cityCardCode}, cardNumber: ${_this.cardNumber}, customerCode: ${_this.customerCode}, ccCustomerCode: ${_this.ccCustomerCode}, ccCustomerId: ${_this.ccCustomerId}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, hasActiveInhabitantStatus: ${_this.hasActiveInhabitantStatus}, inhabitantStatusDateFrom: ${_this.inhabitantStatusDateFrom}, inhabitantStatusDateTo: ${_this.inhabitantStatusDateTo}, deactivationDateToCommunique: ${_this.deactivationDateToCommunique}, blockPlannedStateId: ${_this.blockPlannedStateId}, blockPlannedStateDescription: ${_this.blockPlannedStateDescription}, blocked: ${_this.blocked}, issued: ${_this.issued}, canBuyTickets: ${_this.canBuyTickets}, isDefault: ${_this.isDefault}, storageTypeName: ${_this.storageTypeName})';
}


}

/// @nodoc
abstract mixin class $StorageMediumCopyWith<$Res>  {
  factory $StorageMediumCopyWith(StorageMedium value, $Res Function(StorageMedium) _then) = _$StorageMediumCopyWithImpl;
@useResult
$Res call({
 int? storageTypeId, int? cityCardCode, int? cardNumber, int? customerCode, int? ccCustomerCode, int? ccCustomerId, String? firstName, String? lastName, bool? hasActiveInhabitantStatus, DateTime? inhabitantStatusDateFrom, DateTime? inhabitantStatusDateTo, String? deactivationDateToCommunique, int? blockPlannedStateId, String? blockPlannedStateDescription, bool? blocked, bool? issued, bool? canBuyTickets, bool? isDefault, String? storageTypeName
});




}
/// @nodoc
class _$StorageMediumCopyWithImpl<$Res>
    implements $StorageMediumCopyWith<$Res> {
  _$StorageMediumCopyWithImpl(this._self, this._then);

  final StorageMedium _self;
  final $Res Function(StorageMedium) _then;

/// Create a copy of StorageMedium
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storageTypeId = freezed,Object? cityCardCode = freezed,Object? cardNumber = freezed,Object? customerCode = freezed,Object? ccCustomerCode = freezed,Object? ccCustomerId = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? hasActiveInhabitantStatus = freezed,Object? inhabitantStatusDateFrom = freezed,Object? inhabitantStatusDateTo = freezed,Object? deactivationDateToCommunique = freezed,Object? blockPlannedStateId = freezed,Object? blockPlannedStateDescription = freezed,Object? blocked = freezed,Object? issued = freezed,Object? canBuyTickets = freezed,Object? isDefault = freezed,Object? storageTypeName = freezed,}) {
  return _then(StorageMedium(
storageTypeId: freezed == storageTypeId ? _self.storageTypeId : storageTypeId // ignore: cast_nullable_to_non_nullable
as int?,cityCardCode: freezed == cityCardCode ? _self.cityCardCode : cityCardCode // ignore: cast_nullable_to_non_nullable
as int?,cardNumber: freezed == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as int?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as int?,ccCustomerCode: freezed == ccCustomerCode ? _self.ccCustomerCode : ccCustomerCode // ignore: cast_nullable_to_non_nullable
as int?,ccCustomerId: freezed == ccCustomerId ? _self.ccCustomerId : ccCustomerId // ignore: cast_nullable_to_non_nullable
as int?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,hasActiveInhabitantStatus: freezed == hasActiveInhabitantStatus ? _self.hasActiveInhabitantStatus : hasActiveInhabitantStatus // ignore: cast_nullable_to_non_nullable
as bool?,inhabitantStatusDateFrom: freezed == inhabitantStatusDateFrom ? _self.inhabitantStatusDateFrom : inhabitantStatusDateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,inhabitantStatusDateTo: freezed == inhabitantStatusDateTo ? _self.inhabitantStatusDateTo : inhabitantStatusDateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,deactivationDateToCommunique: freezed == deactivationDateToCommunique ? _self.deactivationDateToCommunique : deactivationDateToCommunique // ignore: cast_nullable_to_non_nullable
as String?,blockPlannedStateId: freezed == blockPlannedStateId ? _self.blockPlannedStateId : blockPlannedStateId // ignore: cast_nullable_to_non_nullable
as int?,blockPlannedStateDescription: freezed == blockPlannedStateDescription ? _self.blockPlannedStateDescription : blockPlannedStateDescription // ignore: cast_nullable_to_non_nullable
as String?,blocked: freezed == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool?,issued: freezed == issued ? _self.issued : issued // ignore: cast_nullable_to_non_nullable
as bool?,canBuyTickets: freezed == canBuyTickets ? _self.canBuyTickets : canBuyTickets // ignore: cast_nullable_to_non_nullable
as bool?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,storageTypeName: freezed == storageTypeName ? _self.storageTypeName : storageTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageMedium].
extension StorageMediumPatterns on StorageMedium {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageMedium value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageMedium() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageMedium value)  $default,){
final _that = this;
switch (_that) {
case _StorageMedium():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageMedium value)?  $default,){
final _that = this;
switch (_that) {
case _StorageMedium() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? storageTypeId,  int? cityCardCode,  int? cardNumber,  int? customerCode,  int? ccCustomerCode,  int? ccCustomerId,  String? firstName,  String? lastName,  bool? hasActiveInhabitantStatus,  DateTime? inhabitantStatusDateFrom,  DateTime? inhabitantStatusDateTo,  String? deactivationDateToCommunique,  int? blockPlannedStateId,  String? blockPlannedStateDescription,  bool? blocked,  bool? issued,  bool? canBuyTickets,  bool? isDefault,  String? storageTypeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageMedium() when $default != null:
return $default(_that.storageTypeId,_that.cityCardCode,_that.cardNumber,_that.customerCode,_that.ccCustomerCode,_that.ccCustomerId,_that.firstName,_that.lastName,_that.hasActiveInhabitantStatus,_that.inhabitantStatusDateFrom,_that.inhabitantStatusDateTo,_that.deactivationDateToCommunique,_that.blockPlannedStateId,_that.blockPlannedStateDescription,_that.blocked,_that.issued,_that.canBuyTickets,_that.isDefault,_that.storageTypeName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? storageTypeId,  int? cityCardCode,  int? cardNumber,  int? customerCode,  int? ccCustomerCode,  int? ccCustomerId,  String? firstName,  String? lastName,  bool? hasActiveInhabitantStatus,  DateTime? inhabitantStatusDateFrom,  DateTime? inhabitantStatusDateTo,  String? deactivationDateToCommunique,  int? blockPlannedStateId,  String? blockPlannedStateDescription,  bool? blocked,  bool? issued,  bool? canBuyTickets,  bool? isDefault,  String? storageTypeName)  $default,) {final _that = this;
switch (_that) {
case _StorageMedium():
return $default(_that.storageTypeId,_that.cityCardCode,_that.cardNumber,_that.customerCode,_that.ccCustomerCode,_that.ccCustomerId,_that.firstName,_that.lastName,_that.hasActiveInhabitantStatus,_that.inhabitantStatusDateFrom,_that.inhabitantStatusDateTo,_that.deactivationDateToCommunique,_that.blockPlannedStateId,_that.blockPlannedStateDescription,_that.blocked,_that.issued,_that.canBuyTickets,_that.isDefault,_that.storageTypeName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? storageTypeId,  int? cityCardCode,  int? cardNumber,  int? customerCode,  int? ccCustomerCode,  int? ccCustomerId,  String? firstName,  String? lastName,  bool? hasActiveInhabitantStatus,  DateTime? inhabitantStatusDateFrom,  DateTime? inhabitantStatusDateTo,  String? deactivationDateToCommunique,  int? blockPlannedStateId,  String? blockPlannedStateDescription,  bool? blocked,  bool? issued,  bool? canBuyTickets,  bool? isDefault,  String? storageTypeName)?  $default,) {final _that = this;
switch (_that) {
case _StorageMedium() when $default != null:
return $default(_that.storageTypeId,_that.cityCardCode,_that.cardNumber,_that.customerCode,_that.ccCustomerCode,_that.ccCustomerId,_that.firstName,_that.lastName,_that.hasActiveInhabitantStatus,_that.inhabitantStatusDateFrom,_that.inhabitantStatusDateTo,_that.deactivationDateToCommunique,_that.blockPlannedStateId,_that.blockPlannedStateDescription,_that.blocked,_that.issued,_that.canBuyTickets,_that.isDefault,_that.storageTypeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorageMedium extends StorageMedium {
  const _StorageMedium({this.storageTypeId, this.cityCardCode, this.cardNumber, this.customerCode, this.ccCustomerCode, this.ccCustomerId, this.firstName, this.lastName, this.hasActiveInhabitantStatus, this.inhabitantStatusDateFrom, this.inhabitantStatusDateTo, this.deactivationDateToCommunique, this.blockPlannedStateId, this.blockPlannedStateDescription, this.blocked, this.issued, this.canBuyTickets, this.isDefault, this.storageTypeName}): super._();
  factory _StorageMedium.fromJson(Map<String, dynamic> json) => _$StorageMediumFromJson(json);

@override final  int? storageTypeId;
/// 8 identifies the mobile mKKM medium.
@override final  int? cityCardCode;
@override final  int? cardNumber;
@override final  int? customerCode;
@override final  int? ccCustomerCode;
@override final  int? ccCustomerId;
@override final  String? firstName;
@override final  String? lastName;
@override final  bool? hasActiveInhabitantStatus;
@override final  DateTime? inhabitantStatusDateFrom;
@override final  DateTime? inhabitantStatusDateTo;
@override final  String? deactivationDateToCommunique;
@override final  int? blockPlannedStateId;
@override final  String? blockPlannedStateDescription;
@override final  bool? blocked;
@override final  bool? issued;
@override final  bool? canBuyTickets;
@override final  bool? isDefault;
@override final  String? storageTypeName;

/// Create a copy of StorageMedium
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageMediumCopyWith<_StorageMedium> get copyWith => __$StorageMediumCopyWithImpl<_StorageMedium>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorageMediumToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageMedium&&(identical(other.storageTypeId, storageTypeId) || other.storageTypeId == storageTypeId)&&(identical(other.cityCardCode, cityCardCode) || other.cityCardCode == cityCardCode)&&(identical(other.cardNumber, cardNumber) || other.cardNumber == cardNumber)&&(identical(other.customerCode, customerCode) || other.customerCode == customerCode)&&(identical(other.ccCustomerCode, ccCustomerCode) || other.ccCustomerCode == ccCustomerCode)&&(identical(other.ccCustomerId, ccCustomerId) || other.ccCustomerId == ccCustomerId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.hasActiveInhabitantStatus, hasActiveInhabitantStatus) || other.hasActiveInhabitantStatus == hasActiveInhabitantStatus)&&(identical(other.inhabitantStatusDateFrom, inhabitantStatusDateFrom) || other.inhabitantStatusDateFrom == inhabitantStatusDateFrom)&&(identical(other.inhabitantStatusDateTo, inhabitantStatusDateTo) || other.inhabitantStatusDateTo == inhabitantStatusDateTo)&&(identical(other.deactivationDateToCommunique, deactivationDateToCommunique) || other.deactivationDateToCommunique == deactivationDateToCommunique)&&(identical(other.blockPlannedStateId, blockPlannedStateId) || other.blockPlannedStateId == blockPlannedStateId)&&(identical(other.blockPlannedStateDescription, blockPlannedStateDescription) || other.blockPlannedStateDescription == blockPlannedStateDescription)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.issued, issued) || other.issued == issued)&&(identical(other.canBuyTickets, canBuyTickets) || other.canBuyTickets == canBuyTickets)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.storageTypeName, storageTypeName) || other.storageTypeName == storageTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,storageTypeId,cityCardCode,cardNumber,customerCode,ccCustomerCode,ccCustomerId,firstName,lastName,hasActiveInhabitantStatus,inhabitantStatusDateFrom,inhabitantStatusDateTo,deactivationDateToCommunique,blockPlannedStateId,blockPlannedStateDescription,blocked,issued,canBuyTickets,isDefault,storageTypeName]);
}

@override
String toString() {
    return 'StorageMedium(storageTypeId: $storageTypeId, cityCardCode: $cityCardCode, cardNumber: $cardNumber, customerCode: $customerCode, ccCustomerCode: $ccCustomerCode, ccCustomerId: $ccCustomerId, firstName: $firstName, lastName: $lastName, hasActiveInhabitantStatus: $hasActiveInhabitantStatus, inhabitantStatusDateFrom: $inhabitantStatusDateFrom, inhabitantStatusDateTo: $inhabitantStatusDateTo, deactivationDateToCommunique: $deactivationDateToCommunique, blockPlannedStateId: $blockPlannedStateId, blockPlannedStateDescription: $blockPlannedStateDescription, blocked: $blocked, issued: $issued, canBuyTickets: $canBuyTickets, isDefault: $isDefault, storageTypeName: $storageTypeName)';
}


}

/// @nodoc
abstract mixin class _$StorageMediumCopyWith<$Res> implements $StorageMediumCopyWith<$Res> {
  factory _$StorageMediumCopyWith(_StorageMedium value, $Res Function(_StorageMedium) _then) = __$StorageMediumCopyWithImpl;
@override @useResult
$Res call({
 int? storageTypeId, int? cityCardCode, int? cardNumber, int? customerCode, int? ccCustomerCode, int? ccCustomerId, String? firstName, String? lastName, bool? hasActiveInhabitantStatus, DateTime? inhabitantStatusDateFrom, DateTime? inhabitantStatusDateTo, String? deactivationDateToCommunique, int? blockPlannedStateId, String? blockPlannedStateDescription, bool? blocked, bool? issued, bool? canBuyTickets, bool? isDefault, String? storageTypeName
});




}
/// @nodoc
class __$StorageMediumCopyWithImpl<$Res>
    implements _$StorageMediumCopyWith<$Res> {
  __$StorageMediumCopyWithImpl(this._self, this._then);

  final _StorageMedium _self;
  final $Res Function(_StorageMedium) _then;

/// Create a copy of StorageMedium
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storageTypeId = freezed,Object? cityCardCode = freezed,Object? cardNumber = freezed,Object? customerCode = freezed,Object? ccCustomerCode = freezed,Object? ccCustomerId = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? hasActiveInhabitantStatus = freezed,Object? inhabitantStatusDateFrom = freezed,Object? inhabitantStatusDateTo = freezed,Object? deactivationDateToCommunique = freezed,Object? blockPlannedStateId = freezed,Object? blockPlannedStateDescription = freezed,Object? blocked = freezed,Object? issued = freezed,Object? canBuyTickets = freezed,Object? isDefault = freezed,Object? storageTypeName = freezed,}) {
  return _then(_StorageMedium(
storageTypeId: freezed == storageTypeId ? _self.storageTypeId : storageTypeId // ignore: cast_nullable_to_non_nullable
as int?,cityCardCode: freezed == cityCardCode ? _self.cityCardCode : cityCardCode // ignore: cast_nullable_to_non_nullable
as int?,cardNumber: freezed == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as int?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as int?,ccCustomerCode: freezed == ccCustomerCode ? _self.ccCustomerCode : ccCustomerCode // ignore: cast_nullable_to_non_nullable
as int?,ccCustomerId: freezed == ccCustomerId ? _self.ccCustomerId : ccCustomerId // ignore: cast_nullable_to_non_nullable
as int?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,hasActiveInhabitantStatus: freezed == hasActiveInhabitantStatus ? _self.hasActiveInhabitantStatus : hasActiveInhabitantStatus // ignore: cast_nullable_to_non_nullable
as bool?,inhabitantStatusDateFrom: freezed == inhabitantStatusDateFrom ? _self.inhabitantStatusDateFrom : inhabitantStatusDateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,inhabitantStatusDateTo: freezed == inhabitantStatusDateTo ? _self.inhabitantStatusDateTo : inhabitantStatusDateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,deactivationDateToCommunique: freezed == deactivationDateToCommunique ? _self.deactivationDateToCommunique : deactivationDateToCommunique // ignore: cast_nullable_to_non_nullable
as String?,blockPlannedStateId: freezed == blockPlannedStateId ? _self.blockPlannedStateId : blockPlannedStateId // ignore: cast_nullable_to_non_nullable
as int?,blockPlannedStateDescription: freezed == blockPlannedStateDescription ? _self.blockPlannedStateDescription : blockPlannedStateDescription // ignore: cast_nullable_to_non_nullable
as String?,blocked: freezed == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool?,issued: freezed == issued ? _self.issued : issued // ignore: cast_nullable_to_non_nullable
as bool?,canBuyTickets: freezed == canBuyTickets ? _self.canBuyTickets : canBuyTickets // ignore: cast_nullable_to_non_nullable
as bool?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,storageTypeName: freezed == storageTypeName ? _self.storageTypeName : storageTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StorageMediumListResponse {

 List<StorageMedium> get items;
/// Create a copy of StorageMediumListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageMediumListResponseCopyWith<StorageMediumListResponse> get copyWith => _$StorageMediumListResponseCopyWithImpl<StorageMediumListResponse>(this as StorageMediumListResponse, _$identity);

  /// Serializes this StorageMediumListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StorageMediumListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageMediumListResponse&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StorageMediumListResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as StorageMediumListResponse;
  return 'StorageMediumListResponse(items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $StorageMediumListResponseCopyWith<$Res>  {
  factory $StorageMediumListResponseCopyWith(StorageMediumListResponse value, $Res Function(StorageMediumListResponse) _then) = _$StorageMediumListResponseCopyWithImpl;
@useResult
$Res call({
 List<StorageMedium> items
});




}
/// @nodoc
class _$StorageMediumListResponseCopyWithImpl<$Res>
    implements $StorageMediumListResponseCopyWith<$Res> {
  _$StorageMediumListResponseCopyWithImpl(this._self, this._then);

  final StorageMediumListResponse _self;
  final $Res Function(StorageMediumListResponse) _then;

/// Create a copy of StorageMediumListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(StorageMediumListResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<StorageMedium>,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageMediumListResponse].
extension StorageMediumListResponsePatterns on StorageMediumListResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageMediumListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageMediumListResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageMediumListResponse value)  $default,){
final _that = this;
switch (_that) {
case _StorageMediumListResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageMediumListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StorageMediumListResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StorageMedium> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageMediumListResponse() when $default != null:
return $default(_that.items);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StorageMedium> items)  $default,) {final _that = this;
switch (_that) {
case _StorageMediumListResponse():
return $default(_that.items);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StorageMedium> items)?  $default,) {final _that = this;
switch (_that) {
case _StorageMediumListResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorageMediumListResponse extends StorageMediumListResponse {
  const _StorageMediumListResponse({ List<StorageMedium> items = const <StorageMedium>[]}): _items = items,super._();
  factory _StorageMediumListResponse.fromJson(Map<String, dynamic> json) => _$StorageMediumListResponseFromJson(json);

 final  List<StorageMedium> _items;
@override@JsonKey() List<StorageMedium> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of StorageMediumListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageMediumListResponseCopyWith<_StorageMediumListResponse> get copyWith => __$StorageMediumListResponseCopyWithImpl<_StorageMediumListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorageMediumListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageMediumListResponse&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'StorageMediumListResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$StorageMediumListResponseCopyWith<$Res> implements $StorageMediumListResponseCopyWith<$Res> {
  factory _$StorageMediumListResponseCopyWith(_StorageMediumListResponse value, $Res Function(_StorageMediumListResponse) _then) = __$StorageMediumListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<StorageMedium> items
});




}
/// @nodoc
class __$StorageMediumListResponseCopyWithImpl<$Res>
    implements _$StorageMediumListResponseCopyWith<$Res> {
  __$StorageMediumListResponseCopyWithImpl(this._self, this._then);

  final _StorageMediumListResponse _self;
  final $Res Function(_StorageMediumListResponse) _then;

/// Create a copy of StorageMediumListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_StorageMediumListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<StorageMedium>,
  ));
}


}

// dart format on
