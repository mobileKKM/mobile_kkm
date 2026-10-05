// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Address {

 String? get city; String? get postalCode; String? get street; String? get buildingNumber; String? get apartmentNumber;
/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressCopyWith<Address> get copyWith => _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Address;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Address&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.postalCode, _this.postalCode) || other.postalCode == _this.postalCode)&&(identical(other.street, _this.street) || other.street == _this.street)&&(identical(other.buildingNumber, _this.buildingNumber) || other.buildingNumber == _this.buildingNumber)&&(identical(other.apartmentNumber, _this.apartmentNumber) || other.apartmentNumber == _this.apartmentNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Address;
  return Object.hash(runtimeType,_this.city,_this.postalCode,_this.street,_this.buildingNumber,_this.apartmentNumber);
}

@override
String toString() {
  final _this = this as Address;
  return 'Address(city: ${_this.city}, postalCode: ${_this.postalCode}, street: ${_this.street}, buildingNumber: ${_this.buildingNumber}, apartmentNumber: ${_this.apartmentNumber})';
}


}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res>  {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) = _$AddressCopyWithImpl;
@useResult
$Res call({
 String? city, String? postalCode, String? street, String? buildingNumber, String? apartmentNumber
});




}
/// @nodoc
class _$AddressCopyWithImpl<$Res>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = freezed,Object? postalCode = freezed,Object? street = freezed,Object? buildingNumber = freezed,Object? apartmentNumber = freezed,}) {
  return _then(Address(
city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,buildingNumber: freezed == buildingNumber ? _self.buildingNumber : buildingNumber // ignore: cast_nullable_to_non_nullable
as String?,apartmentNumber: freezed == apartmentNumber ? _self.apartmentNumber : apartmentNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Address].
extension AddressPatterns on Address {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Address value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Address() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Address value)  $default,){
final _that = this;
switch (_that) {
case _Address():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Address value)?  $default,){
final _that = this;
switch (_that) {
case _Address() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? city,  String? postalCode,  String? street,  String? buildingNumber,  String? apartmentNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.city,_that.postalCode,_that.street,_that.buildingNumber,_that.apartmentNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? city,  String? postalCode,  String? street,  String? buildingNumber,  String? apartmentNumber)  $default,) {final _that = this;
switch (_that) {
case _Address():
return $default(_that.city,_that.postalCode,_that.street,_that.buildingNumber,_that.apartmentNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? city,  String? postalCode,  String? street,  String? buildingNumber,  String? apartmentNumber)?  $default,) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.city,_that.postalCode,_that.street,_that.buildingNumber,_that.apartmentNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Address implements Address {
  const _Address({this.city, this.postalCode, this.street, this.buildingNumber, this.apartmentNumber});
  factory _Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

@override final  String? city;
@override final  String? postalCode;
@override final  String? street;
@override final  String? buildingNumber;
@override final  String? apartmentNumber;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressCopyWith<_Address> get copyWith => __$AddressCopyWithImpl<_Address>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Address&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.street, street) || other.street == street)&&(identical(other.buildingNumber, buildingNumber) || other.buildingNumber == buildingNumber)&&(identical(other.apartmentNumber, apartmentNumber) || other.apartmentNumber == apartmentNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,city,postalCode,street,buildingNumber,apartmentNumber);
}

@override
String toString() {
    return 'Address(city: $city, postalCode: $postalCode, street: $street, buildingNumber: $buildingNumber, apartmentNumber: $apartmentNumber)';
}


}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) = __$AddressCopyWithImpl;
@override @useResult
$Res call({
 String? city, String? postalCode, String? street, String? buildingNumber, String? apartmentNumber
});




}
/// @nodoc
class __$AddressCopyWithImpl<$Res>
    implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = freezed,Object? postalCode = freezed,Object? street = freezed,Object? buildingNumber = freezed,Object? apartmentNumber = freezed,}) {
  return _then(_Address(
city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,buildingNumber: freezed == buildingNumber ? _self.buildingNumber : buildingNumber // ignore: cast_nullable_to_non_nullable
as String?,apartmentNumber: freezed == apartmentNumber ? _self.apartmentNumber : apartmentNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserData {

 String? get pesel; DateTime? get birthDate; String? get email; String? get firstName; String? get lastName; String? get phoneNumber; String? get photoUrl; Address? get registeredAddress; bool? get invoiceByInternet; bool? get autoInvoice; bool? get mailNotifications; bool? get pushNotifications; bool? get hasStorageMediumWithCCCustomer;
/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataCopyWith<UserData> get copyWith => _$UserDataCopyWithImpl<UserData>(this as UserData, _$identity);

  /// Serializes this UserData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserData&&(identical(other.pesel, _this.pesel) || other.pesel == _this.pesel)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.registeredAddress, _this.registeredAddress) || other.registeredAddress == _this.registeredAddress)&&(identical(other.invoiceByInternet, _this.invoiceByInternet) || other.invoiceByInternet == _this.invoiceByInternet)&&(identical(other.autoInvoice, _this.autoInvoice) || other.autoInvoice == _this.autoInvoice)&&(identical(other.mailNotifications, _this.mailNotifications) || other.mailNotifications == _this.mailNotifications)&&(identical(other.pushNotifications, _this.pushNotifications) || other.pushNotifications == _this.pushNotifications)&&(identical(other.hasStorageMediumWithCCCustomer, _this.hasStorageMediumWithCCCustomer) || other.hasStorageMediumWithCCCustomer == _this.hasStorageMediumWithCCCustomer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserData;
  return Object.hash(runtimeType,_this.pesel,_this.birthDate,_this.email,_this.firstName,_this.lastName,_this.phoneNumber,_this.photoUrl,_this.registeredAddress,_this.invoiceByInternet,_this.autoInvoice,_this.mailNotifications,_this.pushNotifications,_this.hasStorageMediumWithCCCustomer);
}

@override
String toString() {
  final _this = this as UserData;
  return 'UserData(pesel: ${_this.pesel}, birthDate: ${_this.birthDate}, email: ${_this.email}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, phoneNumber: ${_this.phoneNumber}, photoUrl: ${_this.photoUrl}, registeredAddress: ${_this.registeredAddress}, invoiceByInternet: ${_this.invoiceByInternet}, autoInvoice: ${_this.autoInvoice}, mailNotifications: ${_this.mailNotifications}, pushNotifications: ${_this.pushNotifications}, hasStorageMediumWithCCCustomer: ${_this.hasStorageMediumWithCCCustomer})';
}


}

/// @nodoc
abstract mixin class $UserDataCopyWith<$Res>  {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) _then) = _$UserDataCopyWithImpl;
@useResult
$Res call({
 String? pesel, DateTime? birthDate, String? email, String? firstName, String? lastName, String? phoneNumber, String? photoUrl, Address? registeredAddress, bool? invoiceByInternet, bool? autoInvoice, bool? mailNotifications, bool? pushNotifications, bool? hasStorageMediumWithCCCustomer
});


$AddressCopyWith<$Res>? get registeredAddress;

}
/// @nodoc
class _$UserDataCopyWithImpl<$Res>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._self, this._then);

  final UserData _self;
  final $Res Function(UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pesel = freezed,Object? birthDate = freezed,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? photoUrl = freezed,Object? registeredAddress = freezed,Object? invoiceByInternet = freezed,Object? autoInvoice = freezed,Object? mailNotifications = freezed,Object? pushNotifications = freezed,Object? hasStorageMediumWithCCCustomer = freezed,}) {
  return _then(UserData(
pesel: freezed == pesel ? _self.pesel : pesel // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,registeredAddress: freezed == registeredAddress ? _self.registeredAddress : registeredAddress // ignore: cast_nullable_to_non_nullable
as Address?,invoiceByInternet: freezed == invoiceByInternet ? _self.invoiceByInternet : invoiceByInternet // ignore: cast_nullable_to_non_nullable
as bool?,autoInvoice: freezed == autoInvoice ? _self.autoInvoice : autoInvoice // ignore: cast_nullable_to_non_nullable
as bool?,mailNotifications: freezed == mailNotifications ? _self.mailNotifications : mailNotifications // ignore: cast_nullable_to_non_nullable
as bool?,pushNotifications: freezed == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool?,hasStorageMediumWithCCCustomer: freezed == hasStorageMediumWithCCCustomer ? _self.hasStorageMediumWithCCCustomer : hasStorageMediumWithCCCustomer // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get registeredAddress {
    if (_self.registeredAddress == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.registeredAddress!, (value) {
    return _then(_self.copyWith(registeredAddress: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserData].
extension UserDataPatterns on UserData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserData value)  $default,){
final _that = this;
switch (_that) {
case _UserData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserData value)?  $default,){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? pesel,  DateTime? birthDate,  String? email,  String? firstName,  String? lastName,  String? phoneNumber,  String? photoUrl,  Address? registeredAddress,  bool? invoiceByInternet,  bool? autoInvoice,  bool? mailNotifications,  bool? pushNotifications,  bool? hasStorageMediumWithCCCustomer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.pesel,_that.birthDate,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.photoUrl,_that.registeredAddress,_that.invoiceByInternet,_that.autoInvoice,_that.mailNotifications,_that.pushNotifications,_that.hasStorageMediumWithCCCustomer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? pesel,  DateTime? birthDate,  String? email,  String? firstName,  String? lastName,  String? phoneNumber,  String? photoUrl,  Address? registeredAddress,  bool? invoiceByInternet,  bool? autoInvoice,  bool? mailNotifications,  bool? pushNotifications,  bool? hasStorageMediumWithCCCustomer)  $default,) {final _that = this;
switch (_that) {
case _UserData():
return $default(_that.pesel,_that.birthDate,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.photoUrl,_that.registeredAddress,_that.invoiceByInternet,_that.autoInvoice,_that.mailNotifications,_that.pushNotifications,_that.hasStorageMediumWithCCCustomer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? pesel,  DateTime? birthDate,  String? email,  String? firstName,  String? lastName,  String? phoneNumber,  String? photoUrl,  Address? registeredAddress,  bool? invoiceByInternet,  bool? autoInvoice,  bool? mailNotifications,  bool? pushNotifications,  bool? hasStorageMediumWithCCCustomer)?  $default,) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.pesel,_that.birthDate,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.photoUrl,_that.registeredAddress,_that.invoiceByInternet,_that.autoInvoice,_that.mailNotifications,_that.pushNotifications,_that.hasStorageMediumWithCCCustomer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserData implements UserData {
  const _UserData({this.pesel, this.birthDate, this.email, this.firstName, this.lastName, this.phoneNumber, this.photoUrl, this.registeredAddress, this.invoiceByInternet, this.autoInvoice, this.mailNotifications, this.pushNotifications, this.hasStorageMediumWithCCCustomer});
  factory _UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

@override final  String? pesel;
@override final  DateTime? birthDate;
@override final  String? email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? phoneNumber;
@override final  String? photoUrl;
@override final  Address? registeredAddress;
@override final  bool? invoiceByInternet;
@override final  bool? autoInvoice;
@override final  bool? mailNotifications;
@override final  bool? pushNotifications;
@override final  bool? hasStorageMediumWithCCCustomer;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataCopyWith<_UserData> get copyWith => __$UserDataCopyWithImpl<_UserData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserData&&(identical(other.pesel, pesel) || other.pesel == pesel)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.registeredAddress, registeredAddress) || other.registeredAddress == registeredAddress)&&(identical(other.invoiceByInternet, invoiceByInternet) || other.invoiceByInternet == invoiceByInternet)&&(identical(other.autoInvoice, autoInvoice) || other.autoInvoice == autoInvoice)&&(identical(other.mailNotifications, mailNotifications) || other.mailNotifications == mailNotifications)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.hasStorageMediumWithCCCustomer, hasStorageMediumWithCCCustomer) || other.hasStorageMediumWithCCCustomer == hasStorageMediumWithCCCustomer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pesel,birthDate,email,firstName,lastName,phoneNumber,photoUrl,registeredAddress,invoiceByInternet,autoInvoice,mailNotifications,pushNotifications,hasStorageMediumWithCCCustomer);
}

@override
String toString() {
    return 'UserData(pesel: $pesel, birthDate: $birthDate, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, photoUrl: $photoUrl, registeredAddress: $registeredAddress, invoiceByInternet: $invoiceByInternet, autoInvoice: $autoInvoice, mailNotifications: $mailNotifications, pushNotifications: $pushNotifications, hasStorageMediumWithCCCustomer: $hasStorageMediumWithCCCustomer)';
}


}

/// @nodoc
abstract mixin class _$UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) _then) = __$UserDataCopyWithImpl;
@override @useResult
$Res call({
 String? pesel, DateTime? birthDate, String? email, String? firstName, String? lastName, String? phoneNumber, String? photoUrl, Address? registeredAddress, bool? invoiceByInternet, bool? autoInvoice, bool? mailNotifications, bool? pushNotifications, bool? hasStorageMediumWithCCCustomer
});


@override $AddressCopyWith<$Res>? get registeredAddress;

}
/// @nodoc
class __$UserDataCopyWithImpl<$Res>
    implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(this._self, this._then);

  final _UserData _self;
  final $Res Function(_UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pesel = freezed,Object? birthDate = freezed,Object? email = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? photoUrl = freezed,Object? registeredAddress = freezed,Object? invoiceByInternet = freezed,Object? autoInvoice = freezed,Object? mailNotifications = freezed,Object? pushNotifications = freezed,Object? hasStorageMediumWithCCCustomer = freezed,}) {
  return _then(_UserData(
pesel: freezed == pesel ? _self.pesel : pesel // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,registeredAddress: freezed == registeredAddress ? _self.registeredAddress : registeredAddress // ignore: cast_nullable_to_non_nullable
as Address?,invoiceByInternet: freezed == invoiceByInternet ? _self.invoiceByInternet : invoiceByInternet // ignore: cast_nullable_to_non_nullable
as bool?,autoInvoice: freezed == autoInvoice ? _self.autoInvoice : autoInvoice // ignore: cast_nullable_to_non_nullable
as bool?,mailNotifications: freezed == mailNotifications ? _self.mailNotifications : mailNotifications // ignore: cast_nullable_to_non_nullable
as bool?,pushNotifications: freezed == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool?,hasStorageMediumWithCCCustomer: freezed == hasStorageMediumWithCCCustomer ? _self.hasStorageMediumWithCCCustomer : hasStorageMediumWithCCCustomer // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res>? get registeredAddress {
    if (_self.registeredAddress == null) {
    return null;
  }

  return $AddressCopyWith<$Res>(_self.registeredAddress!, (value) {
    return _then(_self.copyWith(registeredAddress: value));
  });
}
}


/// @nodoc
mixin _$MkkmData {

/// Note: a String here (e.g. "100001"), unlike the numeric customer
/// codes used by the tickets endpoints.
 String? get customerCode; bool? get hasInhabitantPrivilege; DateTime? get inhabitantPrivilegeDateFrom; DateTime? get inhabitantPrivilegeDateTo; bool? get hasActiveSubscription; bool? get hadAnyInhabitantPrivilege; bool? get detached;
/// Create a copy of MkkmData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MkkmDataCopyWith<MkkmData> get copyWith => _$MkkmDataCopyWithImpl<MkkmData>(this as MkkmData, _$identity);

  /// Serializes this MkkmData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MkkmData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MkkmData&&(identical(other.customerCode, _this.customerCode) || other.customerCode == _this.customerCode)&&(identical(other.hasInhabitantPrivilege, _this.hasInhabitantPrivilege) || other.hasInhabitantPrivilege == _this.hasInhabitantPrivilege)&&(identical(other.inhabitantPrivilegeDateFrom, _this.inhabitantPrivilegeDateFrom) || other.inhabitantPrivilegeDateFrom == _this.inhabitantPrivilegeDateFrom)&&(identical(other.inhabitantPrivilegeDateTo, _this.inhabitantPrivilegeDateTo) || other.inhabitantPrivilegeDateTo == _this.inhabitantPrivilegeDateTo)&&(identical(other.hasActiveSubscription, _this.hasActiveSubscription) || other.hasActiveSubscription == _this.hasActiveSubscription)&&(identical(other.hadAnyInhabitantPrivilege, _this.hadAnyInhabitantPrivilege) || other.hadAnyInhabitantPrivilege == _this.hadAnyInhabitantPrivilege)&&(identical(other.detached, _this.detached) || other.detached == _this.detached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MkkmData;
  return Object.hash(runtimeType,_this.customerCode,_this.hasInhabitantPrivilege,_this.inhabitantPrivilegeDateFrom,_this.inhabitantPrivilegeDateTo,_this.hasActiveSubscription,_this.hadAnyInhabitantPrivilege,_this.detached);
}

@override
String toString() {
  final _this = this as MkkmData;
  return 'MkkmData(customerCode: ${_this.customerCode}, hasInhabitantPrivilege: ${_this.hasInhabitantPrivilege}, inhabitantPrivilegeDateFrom: ${_this.inhabitantPrivilegeDateFrom}, inhabitantPrivilegeDateTo: ${_this.inhabitantPrivilegeDateTo}, hasActiveSubscription: ${_this.hasActiveSubscription}, hadAnyInhabitantPrivilege: ${_this.hadAnyInhabitantPrivilege}, detached: ${_this.detached})';
}


}

/// @nodoc
abstract mixin class $MkkmDataCopyWith<$Res>  {
  factory $MkkmDataCopyWith(MkkmData value, $Res Function(MkkmData) _then) = _$MkkmDataCopyWithImpl;
@useResult
$Res call({
 String? customerCode, bool? hasInhabitantPrivilege, DateTime? inhabitantPrivilegeDateFrom, DateTime? inhabitantPrivilegeDateTo, bool? hasActiveSubscription, bool? hadAnyInhabitantPrivilege, bool? detached
});




}
/// @nodoc
class _$MkkmDataCopyWithImpl<$Res>
    implements $MkkmDataCopyWith<$Res> {
  _$MkkmDataCopyWithImpl(this._self, this._then);

  final MkkmData _self;
  final $Res Function(MkkmData) _then;

/// Create a copy of MkkmData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerCode = freezed,Object? hasInhabitantPrivilege = freezed,Object? inhabitantPrivilegeDateFrom = freezed,Object? inhabitantPrivilegeDateTo = freezed,Object? hasActiveSubscription = freezed,Object? hadAnyInhabitantPrivilege = freezed,Object? detached = freezed,}) {
  return _then(MkkmData(
customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as String?,hasInhabitantPrivilege: freezed == hasInhabitantPrivilege ? _self.hasInhabitantPrivilege : hasInhabitantPrivilege // ignore: cast_nullable_to_non_nullable
as bool?,inhabitantPrivilegeDateFrom: freezed == inhabitantPrivilegeDateFrom ? _self.inhabitantPrivilegeDateFrom : inhabitantPrivilegeDateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,inhabitantPrivilegeDateTo: freezed == inhabitantPrivilegeDateTo ? _self.inhabitantPrivilegeDateTo : inhabitantPrivilegeDateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,hasActiveSubscription: freezed == hasActiveSubscription ? _self.hasActiveSubscription : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
as bool?,hadAnyInhabitantPrivilege: freezed == hadAnyInhabitantPrivilege ? _self.hadAnyInhabitantPrivilege : hadAnyInhabitantPrivilege // ignore: cast_nullable_to_non_nullable
as bool?,detached: freezed == detached ? _self.detached : detached // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MkkmData].
extension MkkmDataPatterns on MkkmData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MkkmData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MkkmData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MkkmData value)  $default,){
final _that = this;
switch (_that) {
case _MkkmData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MkkmData value)?  $default,){
final _that = this;
switch (_that) {
case _MkkmData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? customerCode,  bool? hasInhabitantPrivilege,  DateTime? inhabitantPrivilegeDateFrom,  DateTime? inhabitantPrivilegeDateTo,  bool? hasActiveSubscription,  bool? hadAnyInhabitantPrivilege,  bool? detached)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MkkmData() when $default != null:
return $default(_that.customerCode,_that.hasInhabitantPrivilege,_that.inhabitantPrivilegeDateFrom,_that.inhabitantPrivilegeDateTo,_that.hasActiveSubscription,_that.hadAnyInhabitantPrivilege,_that.detached);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? customerCode,  bool? hasInhabitantPrivilege,  DateTime? inhabitantPrivilegeDateFrom,  DateTime? inhabitantPrivilegeDateTo,  bool? hasActiveSubscription,  bool? hadAnyInhabitantPrivilege,  bool? detached)  $default,) {final _that = this;
switch (_that) {
case _MkkmData():
return $default(_that.customerCode,_that.hasInhabitantPrivilege,_that.inhabitantPrivilegeDateFrom,_that.inhabitantPrivilegeDateTo,_that.hasActiveSubscription,_that.hadAnyInhabitantPrivilege,_that.detached);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? customerCode,  bool? hasInhabitantPrivilege,  DateTime? inhabitantPrivilegeDateFrom,  DateTime? inhabitantPrivilegeDateTo,  bool? hasActiveSubscription,  bool? hadAnyInhabitantPrivilege,  bool? detached)?  $default,) {final _that = this;
switch (_that) {
case _MkkmData() when $default != null:
return $default(_that.customerCode,_that.hasInhabitantPrivilege,_that.inhabitantPrivilegeDateFrom,_that.inhabitantPrivilegeDateTo,_that.hasActiveSubscription,_that.hadAnyInhabitantPrivilege,_that.detached);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MkkmData implements MkkmData {
  const _MkkmData({this.customerCode, this.hasInhabitantPrivilege, this.inhabitantPrivilegeDateFrom, this.inhabitantPrivilegeDateTo, this.hasActiveSubscription, this.hadAnyInhabitantPrivilege, this.detached});
  factory _MkkmData.fromJson(Map<String, dynamic> json) => _$MkkmDataFromJson(json);

/// Note: a String here (e.g. "100001"), unlike the numeric customer
/// codes used by the tickets endpoints.
@override final  String? customerCode;
@override final  bool? hasInhabitantPrivilege;
@override final  DateTime? inhabitantPrivilegeDateFrom;
@override final  DateTime? inhabitantPrivilegeDateTo;
@override final  bool? hasActiveSubscription;
@override final  bool? hadAnyInhabitantPrivilege;
@override final  bool? detached;

/// Create a copy of MkkmData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MkkmDataCopyWith<_MkkmData> get copyWith => __$MkkmDataCopyWithImpl<_MkkmData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MkkmDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MkkmData&&(identical(other.customerCode, customerCode) || other.customerCode == customerCode)&&(identical(other.hasInhabitantPrivilege, hasInhabitantPrivilege) || other.hasInhabitantPrivilege == hasInhabitantPrivilege)&&(identical(other.inhabitantPrivilegeDateFrom, inhabitantPrivilegeDateFrom) || other.inhabitantPrivilegeDateFrom == inhabitantPrivilegeDateFrom)&&(identical(other.inhabitantPrivilegeDateTo, inhabitantPrivilegeDateTo) || other.inhabitantPrivilegeDateTo == inhabitantPrivilegeDateTo)&&(identical(other.hasActiveSubscription, hasActiveSubscription) || other.hasActiveSubscription == hasActiveSubscription)&&(identical(other.hadAnyInhabitantPrivilege, hadAnyInhabitantPrivilege) || other.hadAnyInhabitantPrivilege == hadAnyInhabitantPrivilege)&&(identical(other.detached, detached) || other.detached == detached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,customerCode,hasInhabitantPrivilege,inhabitantPrivilegeDateFrom,inhabitantPrivilegeDateTo,hasActiveSubscription,hadAnyInhabitantPrivilege,detached);
}

@override
String toString() {
    return 'MkkmData(customerCode: $customerCode, hasInhabitantPrivilege: $hasInhabitantPrivilege, inhabitantPrivilegeDateFrom: $inhabitantPrivilegeDateFrom, inhabitantPrivilegeDateTo: $inhabitantPrivilegeDateTo, hasActiveSubscription: $hasActiveSubscription, hadAnyInhabitantPrivilege: $hadAnyInhabitantPrivilege, detached: $detached)';
}


}

/// @nodoc
abstract mixin class _$MkkmDataCopyWith<$Res> implements $MkkmDataCopyWith<$Res> {
  factory _$MkkmDataCopyWith(_MkkmData value, $Res Function(_MkkmData) _then) = __$MkkmDataCopyWithImpl;
@override @useResult
$Res call({
 String? customerCode, bool? hasInhabitantPrivilege, DateTime? inhabitantPrivilegeDateFrom, DateTime? inhabitantPrivilegeDateTo, bool? hasActiveSubscription, bool? hadAnyInhabitantPrivilege, bool? detached
});




}
/// @nodoc
class __$MkkmDataCopyWithImpl<$Res>
    implements _$MkkmDataCopyWith<$Res> {
  __$MkkmDataCopyWithImpl(this._self, this._then);

  final _MkkmData _self;
  final $Res Function(_MkkmData) _then;

/// Create a copy of MkkmData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerCode = freezed,Object? hasInhabitantPrivilege = freezed,Object? inhabitantPrivilegeDateFrom = freezed,Object? inhabitantPrivilegeDateTo = freezed,Object? hasActiveSubscription = freezed,Object? hadAnyInhabitantPrivilege = freezed,Object? detached = freezed,}) {
  return _then(_MkkmData(
customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as String?,hasInhabitantPrivilege: freezed == hasInhabitantPrivilege ? _self.hasInhabitantPrivilege : hasInhabitantPrivilege // ignore: cast_nullable_to_non_nullable
as bool?,inhabitantPrivilegeDateFrom: freezed == inhabitantPrivilegeDateFrom ? _self.inhabitantPrivilegeDateFrom : inhabitantPrivilegeDateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,inhabitantPrivilegeDateTo: freezed == inhabitantPrivilegeDateTo ? _self.inhabitantPrivilegeDateTo : inhabitantPrivilegeDateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,hasActiveSubscription: freezed == hasActiveSubscription ? _self.hasActiveSubscription : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
as bool?,hadAnyInhabitantPrivilege: freezed == hadAnyInhabitantPrivilege ? _self.hadAnyInhabitantPrivilege : hadAnyInhabitantPrivilege // ignore: cast_nullable_to_non_nullable
as bool?,detached: freezed == detached ? _self.detached : detached // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$UserDataResponse {

 UserData? get userData; MkkmData? get mkkmData; bool? get cardsNotAdded; bool? get hasKkmCard; bool? get hasActiveSubscription; bool? get canIssueInvoice; Object? get code; String? get message;
/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataResponseCopyWith<UserDataResponse> get copyWith => _$UserDataResponseCopyWithImpl<UserDataResponse>(this as UserDataResponse, _$identity);

  /// Serializes this UserDataResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserDataResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataResponse&&(identical(other.userData, _this.userData) || other.userData == _this.userData)&&(identical(other.mkkmData, _this.mkkmData) || other.mkkmData == _this.mkkmData)&&(identical(other.cardsNotAdded, _this.cardsNotAdded) || other.cardsNotAdded == _this.cardsNotAdded)&&(identical(other.hasKkmCard, _this.hasKkmCard) || other.hasKkmCard == _this.hasKkmCard)&&(identical(other.hasActiveSubscription, _this.hasActiveSubscription) || other.hasActiveSubscription == _this.hasActiveSubscription)&&(identical(other.canIssueInvoice, _this.canIssueInvoice) || other.canIssueInvoice == _this.canIssueInvoice)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserDataResponse;
  return Object.hash(runtimeType,_this.userData,_this.mkkmData,_this.cardsNotAdded,_this.hasKkmCard,_this.hasActiveSubscription,_this.canIssueInvoice,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as UserDataResponse;
  return 'UserDataResponse(userData: ${_this.userData}, mkkmData: ${_this.mkkmData}, cardsNotAdded: ${_this.cardsNotAdded}, hasKkmCard: ${_this.hasKkmCard}, hasActiveSubscription: ${_this.hasActiveSubscription}, canIssueInvoice: ${_this.canIssueInvoice}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $UserDataResponseCopyWith<$Res>  {
  factory $UserDataResponseCopyWith(UserDataResponse value, $Res Function(UserDataResponse) _then) = _$UserDataResponseCopyWithImpl;
@useResult
$Res call({
 UserData? userData, MkkmData? mkkmData, bool? cardsNotAdded, bool? hasKkmCard, bool? hasActiveSubscription, bool? canIssueInvoice, Object? code, String? message
});


$UserDataCopyWith<$Res>? get userData;$MkkmDataCopyWith<$Res>? get mkkmData;

}
/// @nodoc
class _$UserDataResponseCopyWithImpl<$Res>
    implements $UserDataResponseCopyWith<$Res> {
  _$UserDataResponseCopyWithImpl(this._self, this._then);

  final UserDataResponse _self;
  final $Res Function(UserDataResponse) _then;

/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userData = freezed,Object? mkkmData = freezed,Object? cardsNotAdded = freezed,Object? hasKkmCard = freezed,Object? hasActiveSubscription = freezed,Object? canIssueInvoice = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(UserDataResponse(
userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as UserData?,mkkmData: freezed == mkkmData ? _self.mkkmData : mkkmData // ignore: cast_nullable_to_non_nullable
as MkkmData?,cardsNotAdded: freezed == cardsNotAdded ? _self.cardsNotAdded : cardsNotAdded // ignore: cast_nullable_to_non_nullable
as bool?,hasKkmCard: freezed == hasKkmCard ? _self.hasKkmCard : hasKkmCard // ignore: cast_nullable_to_non_nullable
as bool?,hasActiveSubscription: freezed == hasActiveSubscription ? _self.hasActiveSubscription : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
as bool?,canIssueInvoice: freezed == canIssueInvoice ? _self.canIssueInvoice : canIssueInvoice // ignore: cast_nullable_to_non_nullable
as bool?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res>? get userData {
    if (_self.userData == null) {
    return null;
  }

  return $UserDataCopyWith<$Res>(_self.userData!, (value) {
    return _then(_self.copyWith(userData: value));
  });
}/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MkkmDataCopyWith<$Res>? get mkkmData {
    if (_self.mkkmData == null) {
    return null;
  }

  return $MkkmDataCopyWith<$Res>(_self.mkkmData!, (value) {
    return _then(_self.copyWith(mkkmData: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserDataResponse].
extension UserDataResponsePatterns on UserDataResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDataResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDataResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDataResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserDataResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDataResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserDataResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserData? userData,  MkkmData? mkkmData,  bool? cardsNotAdded,  bool? hasKkmCard,  bool? hasActiveSubscription,  bool? canIssueInvoice,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDataResponse() when $default != null:
return $default(_that.userData,_that.mkkmData,_that.cardsNotAdded,_that.hasKkmCard,_that.hasActiveSubscription,_that.canIssueInvoice,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserData? userData,  MkkmData? mkkmData,  bool? cardsNotAdded,  bool? hasKkmCard,  bool? hasActiveSubscription,  bool? canIssueInvoice,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _UserDataResponse():
return $default(_that.userData,_that.mkkmData,_that.cardsNotAdded,_that.hasKkmCard,_that.hasActiveSubscription,_that.canIssueInvoice,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserData? userData,  MkkmData? mkkmData,  bool? cardsNotAdded,  bool? hasKkmCard,  bool? hasActiveSubscription,  bool? canIssueInvoice,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _UserDataResponse() when $default != null:
return $default(_that.userData,_that.mkkmData,_that.cardsNotAdded,_that.hasKkmCard,_that.hasActiveSubscription,_that.canIssueInvoice,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserDataResponse extends UserDataResponse {
  const _UserDataResponse({this.userData, this.mkkmData, this.cardsNotAdded, this.hasKkmCard, this.hasActiveSubscription, this.canIssueInvoice, this.code, this.message}): super._();
  factory _UserDataResponse.fromJson(Map<String, dynamic> json) => _$UserDataResponseFromJson(json);

@override final  UserData? userData;
@override final  MkkmData? mkkmData;
@override final  bool? cardsNotAdded;
@override final  bool? hasKkmCard;
@override final  bool? hasActiveSubscription;
@override final  bool? canIssueInvoice;
@override final  Object? code;
@override final  String? message;

/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataResponseCopyWith<_UserDataResponse> get copyWith => __$UserDataResponseCopyWithImpl<_UserDataResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDataResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataResponse&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.mkkmData, mkkmData) || other.mkkmData == mkkmData)&&(identical(other.cardsNotAdded, cardsNotAdded) || other.cardsNotAdded == cardsNotAdded)&&(identical(other.hasKkmCard, hasKkmCard) || other.hasKkmCard == hasKkmCard)&&(identical(other.hasActiveSubscription, hasActiveSubscription) || other.hasActiveSubscription == hasActiveSubscription)&&(identical(other.canIssueInvoice, canIssueInvoice) || other.canIssueInvoice == canIssueInvoice)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userData,mkkmData,cardsNotAdded,hasKkmCard,hasActiveSubscription,canIssueInvoice,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'UserDataResponse(userData: $userData, mkkmData: $mkkmData, cardsNotAdded: $cardsNotAdded, hasKkmCard: $hasKkmCard, hasActiveSubscription: $hasActiveSubscription, canIssueInvoice: $canIssueInvoice, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$UserDataResponseCopyWith<$Res> implements $UserDataResponseCopyWith<$Res> {
  factory _$UserDataResponseCopyWith(_UserDataResponse value, $Res Function(_UserDataResponse) _then) = __$UserDataResponseCopyWithImpl;
@override @useResult
$Res call({
 UserData? userData, MkkmData? mkkmData, bool? cardsNotAdded, bool? hasKkmCard, bool? hasActiveSubscription, bool? canIssueInvoice, Object? code, String? message
});


@override $UserDataCopyWith<$Res>? get userData;@override $MkkmDataCopyWith<$Res>? get mkkmData;

}
/// @nodoc
class __$UserDataResponseCopyWithImpl<$Res>
    implements _$UserDataResponseCopyWith<$Res> {
  __$UserDataResponseCopyWithImpl(this._self, this._then);

  final _UserDataResponse _self;
  final $Res Function(_UserDataResponse) _then;

/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userData = freezed,Object? mkkmData = freezed,Object? cardsNotAdded = freezed,Object? hasKkmCard = freezed,Object? hasActiveSubscription = freezed,Object? canIssueInvoice = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_UserDataResponse(
userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as UserData?,mkkmData: freezed == mkkmData ? _self.mkkmData : mkkmData // ignore: cast_nullable_to_non_nullable
as MkkmData?,cardsNotAdded: freezed == cardsNotAdded ? _self.cardsNotAdded : cardsNotAdded // ignore: cast_nullable_to_non_nullable
as bool?,hasKkmCard: freezed == hasKkmCard ? _self.hasKkmCard : hasKkmCard // ignore: cast_nullable_to_non_nullable
as bool?,hasActiveSubscription: freezed == hasActiveSubscription ? _self.hasActiveSubscription : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
as bool?,canIssueInvoice: freezed == canIssueInvoice ? _self.canIssueInvoice : canIssueInvoice // ignore: cast_nullable_to_non_nullable
as bool?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res>? get userData {
    if (_self.userData == null) {
    return null;
  }

  return $UserDataCopyWith<$Res>(_self.userData!, (value) {
    return _then(_self.copyWith(userData: value));
  });
}/// Create a copy of UserDataResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MkkmDataCopyWith<$Res>? get mkkmData {
    if (_self.mkkmData == null) {
    return null;
  }

  return $MkkmDataCopyWith<$Res>(_self.mkkmData!, (value) {
    return _then(_self.copyWith(mkkmData: value));
  });
}
}


/// @nodoc
mixin _$InhabitantStatus {

 DateTime? get dateFromUtc; DateTime? get dateToUtc; bool? get isActive; String? get firstName; String? get lastName; String? get photoUrl; String? get customerCode; Object? get code; String? get message;
/// Create a copy of InhabitantStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InhabitantStatusCopyWith<InhabitantStatus> get copyWith => _$InhabitantStatusCopyWithImpl<InhabitantStatus>(this as InhabitantStatus, _$identity);

  /// Serializes this InhabitantStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InhabitantStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InhabitantStatus&&(identical(other.dateFromUtc, _this.dateFromUtc) || other.dateFromUtc == _this.dateFromUtc)&&(identical(other.dateToUtc, _this.dateToUtc) || other.dateToUtc == _this.dateToUtc)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.customerCode, _this.customerCode) || other.customerCode == _this.customerCode)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InhabitantStatus;
  return Object.hash(runtimeType,_this.dateFromUtc,_this.dateToUtc,_this.isActive,_this.firstName,_this.lastName,_this.photoUrl,_this.customerCode,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as InhabitantStatus;
  return 'InhabitantStatus(dateFromUtc: ${_this.dateFromUtc}, dateToUtc: ${_this.dateToUtc}, isActive: ${_this.isActive}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, photoUrl: ${_this.photoUrl}, customerCode: ${_this.customerCode}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $InhabitantStatusCopyWith<$Res>  {
  factory $InhabitantStatusCopyWith(InhabitantStatus value, $Res Function(InhabitantStatus) _then) = _$InhabitantStatusCopyWithImpl;
@useResult
$Res call({
 DateTime? dateFromUtc, DateTime? dateToUtc, bool? isActive, String? firstName, String? lastName, String? photoUrl, String? customerCode, Object? code, String? message
});




}
/// @nodoc
class _$InhabitantStatusCopyWithImpl<$Res>
    implements $InhabitantStatusCopyWith<$Res> {
  _$InhabitantStatusCopyWithImpl(this._self, this._then);

  final InhabitantStatus _self;
  final $Res Function(InhabitantStatus) _then;

/// Create a copy of InhabitantStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateFromUtc = freezed,Object? dateToUtc = freezed,Object? isActive = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? photoUrl = freezed,Object? customerCode = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(InhabitantStatus(
dateFromUtc: freezed == dateFromUtc ? _self.dateFromUtc : dateFromUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,dateToUtc: freezed == dateToUtc ? _self.dateToUtc : dateToUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InhabitantStatus].
extension InhabitantStatusPatterns on InhabitantStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InhabitantStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InhabitantStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InhabitantStatus value)  $default,){
final _that = this;
switch (_that) {
case _InhabitantStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InhabitantStatus value)?  $default,){
final _that = this;
switch (_that) {
case _InhabitantStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? dateFromUtc,  DateTime? dateToUtc,  bool? isActive,  String? firstName,  String? lastName,  String? photoUrl,  String? customerCode,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InhabitantStatus() when $default != null:
return $default(_that.dateFromUtc,_that.dateToUtc,_that.isActive,_that.firstName,_that.lastName,_that.photoUrl,_that.customerCode,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? dateFromUtc,  DateTime? dateToUtc,  bool? isActive,  String? firstName,  String? lastName,  String? photoUrl,  String? customerCode,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _InhabitantStatus():
return $default(_that.dateFromUtc,_that.dateToUtc,_that.isActive,_that.firstName,_that.lastName,_that.photoUrl,_that.customerCode,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? dateFromUtc,  DateTime? dateToUtc,  bool? isActive,  String? firstName,  String? lastName,  String? photoUrl,  String? customerCode,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _InhabitantStatus() when $default != null:
return $default(_that.dateFromUtc,_that.dateToUtc,_that.isActive,_that.firstName,_that.lastName,_that.photoUrl,_that.customerCode,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InhabitantStatus extends InhabitantStatus {
  const _InhabitantStatus({this.dateFromUtc, this.dateToUtc, this.isActive, this.firstName, this.lastName, this.photoUrl, this.customerCode, this.code, this.message}): super._();
  factory _InhabitantStatus.fromJson(Map<String, dynamic> json) => _$InhabitantStatusFromJson(json);

@override final  DateTime? dateFromUtc;
@override final  DateTime? dateToUtc;
@override final  bool? isActive;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? photoUrl;
@override final  String? customerCode;
@override final  Object? code;
@override final  String? message;

/// Create a copy of InhabitantStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InhabitantStatusCopyWith<_InhabitantStatus> get copyWith => __$InhabitantStatusCopyWithImpl<_InhabitantStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InhabitantStatusToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InhabitantStatus&&(identical(other.dateFromUtc, dateFromUtc) || other.dateFromUtc == dateFromUtc)&&(identical(other.dateToUtc, dateToUtc) || other.dateToUtc == dateToUtc)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.customerCode, customerCode) || other.customerCode == customerCode)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dateFromUtc,dateToUtc,isActive,firstName,lastName,photoUrl,customerCode,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'InhabitantStatus(dateFromUtc: $dateFromUtc, dateToUtc: $dateToUtc, isActive: $isActive, firstName: $firstName, lastName: $lastName, photoUrl: $photoUrl, customerCode: $customerCode, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$InhabitantStatusCopyWith<$Res> implements $InhabitantStatusCopyWith<$Res> {
  factory _$InhabitantStatusCopyWith(_InhabitantStatus value, $Res Function(_InhabitantStatus) _then) = __$InhabitantStatusCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateFromUtc, DateTime? dateToUtc, bool? isActive, String? firstName, String? lastName, String? photoUrl, String? customerCode, Object? code, String? message
});




}
/// @nodoc
class __$InhabitantStatusCopyWithImpl<$Res>
    implements _$InhabitantStatusCopyWith<$Res> {
  __$InhabitantStatusCopyWithImpl(this._self, this._then);

  final _InhabitantStatus _self;
  final $Res Function(_InhabitantStatus) _then;

/// Create a copy of InhabitantStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateFromUtc = freezed,Object? dateToUtc = freezed,Object? isActive = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? photoUrl = freezed,Object? customerCode = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_InhabitantStatus(
dateFromUtc: freezed == dateFromUtc ? _self.dateFromUtc : dateFromUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,dateToUtc: freezed == dateToUtc ? _self.dateToUtc : dateToUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InhabitantContract {

/// Epoch milliseconds — the only date in the whole API that is not an
/// ISO-8601 string (json_serializable has no built-in epoch support,
/// hence the local [_parseEpochMs] hook).
@JsonKey(fromJson: _parseEpochMs) DateTime? get expirationDate;/// Base64-encoded PNG of the AZTEC barcode (signed server-side).
 String? get contract;
/// Create a copy of InhabitantContract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InhabitantContractCopyWith<InhabitantContract> get copyWith => _$InhabitantContractCopyWithImpl<InhabitantContract>(this as InhabitantContract, _$identity);

  /// Serializes this InhabitantContract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InhabitantContract;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InhabitantContract&&(identical(other.expirationDate, _this.expirationDate) || other.expirationDate == _this.expirationDate)&&(identical(other.contract, _this.contract) || other.contract == _this.contract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InhabitantContract;
  return Object.hash(runtimeType,_this.expirationDate,_this.contract);
}

@override
String toString() {
  final _this = this as InhabitantContract;
  return 'InhabitantContract(expirationDate: ${_this.expirationDate}, contract: ${_this.contract})';
}


}

/// @nodoc
abstract mixin class $InhabitantContractCopyWith<$Res>  {
  factory $InhabitantContractCopyWith(InhabitantContract value, $Res Function(InhabitantContract) _then) = _$InhabitantContractCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _parseEpochMs) DateTime? expirationDate, String? contract
});




}
/// @nodoc
class _$InhabitantContractCopyWithImpl<$Res>
    implements $InhabitantContractCopyWith<$Res> {
  _$InhabitantContractCopyWithImpl(this._self, this._then);

  final InhabitantContract _self;
  final $Res Function(InhabitantContract) _then;

/// Create a copy of InhabitantContract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expirationDate = freezed,Object? contract = freezed,}) {
  return _then(InhabitantContract(
expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InhabitantContract].
extension InhabitantContractPatterns on InhabitantContract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InhabitantContract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InhabitantContract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InhabitantContract value)  $default,){
final _that = this;
switch (_that) {
case _InhabitantContract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InhabitantContract value)?  $default,){
final _that = this;
switch (_that) {
case _InhabitantContract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _parseEpochMs)  DateTime? expirationDate,  String? contract)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InhabitantContract() when $default != null:
return $default(_that.expirationDate,_that.contract);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _parseEpochMs)  DateTime? expirationDate,  String? contract)  $default,) {final _that = this;
switch (_that) {
case _InhabitantContract():
return $default(_that.expirationDate,_that.contract);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _parseEpochMs)  DateTime? expirationDate,  String? contract)?  $default,) {final _that = this;
switch (_that) {
case _InhabitantContract() when $default != null:
return $default(_that.expirationDate,_that.contract);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InhabitantContract extends InhabitantContract {
  const _InhabitantContract({@JsonKey(fromJson: _parseEpochMs) this.expirationDate, this.contract}): super._();
  factory _InhabitantContract.fromJson(Map<String, dynamic> json) => _$InhabitantContractFromJson(json);

/// Epoch milliseconds — the only date in the whole API that is not an
/// ISO-8601 string (json_serializable has no built-in epoch support,
/// hence the local [_parseEpochMs] hook).
@override@JsonKey(fromJson: _parseEpochMs) final  DateTime? expirationDate;
/// Base64-encoded PNG of the AZTEC barcode (signed server-side).
@override final  String? contract;

/// Create a copy of InhabitantContract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InhabitantContractCopyWith<_InhabitantContract> get copyWith => __$InhabitantContractCopyWithImpl<_InhabitantContract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InhabitantContractToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InhabitantContract&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.contract, contract) || other.contract == contract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,expirationDate,contract);
}

@override
String toString() {
    return 'InhabitantContract(expirationDate: $expirationDate, contract: $contract)';
}


}

/// @nodoc
abstract mixin class _$InhabitantContractCopyWith<$Res> implements $InhabitantContractCopyWith<$Res> {
  factory _$InhabitantContractCopyWith(_InhabitantContract value, $Res Function(_InhabitantContract) _then) = __$InhabitantContractCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _parseEpochMs) DateTime? expirationDate, String? contract
});




}
/// @nodoc
class __$InhabitantContractCopyWithImpl<$Res>
    implements _$InhabitantContractCopyWith<$Res> {
  __$InhabitantContractCopyWithImpl(this._self, this._then);

  final _InhabitantContract _self;
  final $Res Function(_InhabitantContract) _then;

/// Create a copy of InhabitantContract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expirationDate = freezed,Object? contract = freezed,}) {
  return _then(_InhabitantContract(
expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StreetAutocompleteResponse {

 List<String> get streets; Object? get code; String? get message;
/// Create a copy of StreetAutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreetAutocompleteResponseCopyWith<StreetAutocompleteResponse> get copyWith => _$StreetAutocompleteResponseCopyWithImpl<StreetAutocompleteResponse>(this as StreetAutocompleteResponse, _$identity);

  /// Serializes this StreetAutocompleteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StreetAutocompleteResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreetAutocompleteResponse&&const DeepCollectionEquality().equals(other.streets, _this.streets)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StreetAutocompleteResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.streets),const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as StreetAutocompleteResponse;
  return 'StreetAutocompleteResponse(streets: ${_this.streets}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $StreetAutocompleteResponseCopyWith<$Res>  {
  factory $StreetAutocompleteResponseCopyWith(StreetAutocompleteResponse value, $Res Function(StreetAutocompleteResponse) _then) = _$StreetAutocompleteResponseCopyWithImpl;
@useResult
$Res call({
 List<String> streets, Object? code, String? message
});




}
/// @nodoc
class _$StreetAutocompleteResponseCopyWithImpl<$Res>
    implements $StreetAutocompleteResponseCopyWith<$Res> {
  _$StreetAutocompleteResponseCopyWithImpl(this._self, this._then);

  final StreetAutocompleteResponse _self;
  final $Res Function(StreetAutocompleteResponse) _then;

/// Create a copy of StreetAutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streets = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(StreetAutocompleteResponse(
streets: null == streets ? _self.streets : streets // ignore: cast_nullable_to_non_nullable
as List<String>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StreetAutocompleteResponse].
extension StreetAutocompleteResponsePatterns on StreetAutocompleteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreetAutocompleteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreetAutocompleteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreetAutocompleteResponse value)  $default,){
final _that = this;
switch (_that) {
case _StreetAutocompleteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreetAutocompleteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StreetAutocompleteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> streets,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreetAutocompleteResponse() when $default != null:
return $default(_that.streets,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> streets,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _StreetAutocompleteResponse():
return $default(_that.streets,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> streets,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _StreetAutocompleteResponse() when $default != null:
return $default(_that.streets,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StreetAutocompleteResponse extends StreetAutocompleteResponse {
  const _StreetAutocompleteResponse({ List<String> streets = const <String>[], this.code, this.message}): _streets = streets,super._();
  factory _StreetAutocompleteResponse.fromJson(Map<String, dynamic> json) => _$StreetAutocompleteResponseFromJson(json);

 final  List<String> _streets;
@override@JsonKey() List<String> get streets {
  if (_streets is EqualUnmodifiableListView) return _streets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_streets);
}

@override final  Object? code;
@override final  String? message;

/// Create a copy of StreetAutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreetAutocompleteResponseCopyWith<_StreetAutocompleteResponse> get copyWith => __$StreetAutocompleteResponseCopyWithImpl<_StreetAutocompleteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StreetAutocompleteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreetAutocompleteResponse&&const DeepCollectionEquality().equals(other.streets, _streets)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_streets),const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'StreetAutocompleteResponse(streets: $streets, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$StreetAutocompleteResponseCopyWith<$Res> implements $StreetAutocompleteResponseCopyWith<$Res> {
  factory _$StreetAutocompleteResponseCopyWith(_StreetAutocompleteResponse value, $Res Function(_StreetAutocompleteResponse) _then) = __$StreetAutocompleteResponseCopyWithImpl;
@override @useResult
$Res call({
 List<String> streets, Object? code, String? message
});




}
/// @nodoc
class __$StreetAutocompleteResponseCopyWithImpl<$Res>
    implements _$StreetAutocompleteResponseCopyWith<$Res> {
  __$StreetAutocompleteResponseCopyWithImpl(this._self, this._then);

  final _StreetAutocompleteResponse _self;
  final $Res Function(_StreetAutocompleteResponse) _then;

/// Create a copy of StreetAutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streets = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(_StreetAutocompleteResponse(
streets: null == streets ? _self._streets : streets // ignore: cast_nullable_to_non_nullable
as List<String>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
