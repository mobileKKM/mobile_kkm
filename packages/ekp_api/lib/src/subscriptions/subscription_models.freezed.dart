// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionDetails {

 bool? get isSubscriptionSignedIn; int? get counter; String? get maskedCardNumber;/// Local time WITHOUT a UTC offset on the wire
/// (e.g. `2026-10-01T15:43:39.107`) — parsed as such; treat as
/// Europe/Warsaw local time when displaying.
 DateTime? get subscriptionSignedInDate; dynamic get activeTicket; dynamic get pendingTicket; SubscriptionCustomerDetail? get customerDetail; bool? get isAutomaticSubscriptionEnabled; bool? get isCycleRefreshEnabled;
/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDetailsCopyWith<SubscriptionDetails> get copyWith => _$SubscriptionDetailsCopyWithImpl<SubscriptionDetails>(this as SubscriptionDetails, _$identity);

  /// Serializes this SubscriptionDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionDetails&&(identical(other.isSubscriptionSignedIn, _this.isSubscriptionSignedIn) || other.isSubscriptionSignedIn == _this.isSubscriptionSignedIn)&&(identical(other.counter, _this.counter) || other.counter == _this.counter)&&(identical(other.maskedCardNumber, _this.maskedCardNumber) || other.maskedCardNumber == _this.maskedCardNumber)&&(identical(other.subscriptionSignedInDate, _this.subscriptionSignedInDate) || other.subscriptionSignedInDate == _this.subscriptionSignedInDate)&&const DeepCollectionEquality().equals(other.activeTicket, _this.activeTicket)&&const DeepCollectionEquality().equals(other.pendingTicket, _this.pendingTicket)&&(identical(other.customerDetail, _this.customerDetail) || other.customerDetail == _this.customerDetail)&&(identical(other.isAutomaticSubscriptionEnabled, _this.isAutomaticSubscriptionEnabled) || other.isAutomaticSubscriptionEnabled == _this.isAutomaticSubscriptionEnabled)&&(identical(other.isCycleRefreshEnabled, _this.isCycleRefreshEnabled) || other.isCycleRefreshEnabled == _this.isCycleRefreshEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionDetails;
  return Object.hash(runtimeType,_this.isSubscriptionSignedIn,_this.counter,_this.maskedCardNumber,_this.subscriptionSignedInDate,const DeepCollectionEquality().hash(_this.activeTicket),const DeepCollectionEquality().hash(_this.pendingTicket),_this.customerDetail,_this.isAutomaticSubscriptionEnabled,_this.isCycleRefreshEnabled);
}

@override
String toString() {
  final _this = this as SubscriptionDetails;
  return 'SubscriptionDetails(isSubscriptionSignedIn: ${_this.isSubscriptionSignedIn}, counter: ${_this.counter}, maskedCardNumber: ${_this.maskedCardNumber}, subscriptionSignedInDate: ${_this.subscriptionSignedInDate}, activeTicket: ${_this.activeTicket}, pendingTicket: ${_this.pendingTicket}, customerDetail: ${_this.customerDetail}, isAutomaticSubscriptionEnabled: ${_this.isAutomaticSubscriptionEnabled}, isCycleRefreshEnabled: ${_this.isCycleRefreshEnabled})';
}


}

/// @nodoc
abstract mixin class $SubscriptionDetailsCopyWith<$Res>  {
  factory $SubscriptionDetailsCopyWith(SubscriptionDetails value, $Res Function(SubscriptionDetails) _then) = _$SubscriptionDetailsCopyWithImpl;
@useResult
$Res call({
 bool? isSubscriptionSignedIn, int? counter, String? maskedCardNumber, DateTime? subscriptionSignedInDate, dynamic activeTicket, dynamic pendingTicket, SubscriptionCustomerDetail? customerDetail, bool? isAutomaticSubscriptionEnabled, bool? isCycleRefreshEnabled
});


$SubscriptionCustomerDetailCopyWith<$Res>? get customerDetail;

}
/// @nodoc
class _$SubscriptionDetailsCopyWithImpl<$Res>
    implements $SubscriptionDetailsCopyWith<$Res> {
  _$SubscriptionDetailsCopyWithImpl(this._self, this._then);

  final SubscriptionDetails _self;
  final $Res Function(SubscriptionDetails) _then;

/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSubscriptionSignedIn = freezed,Object? counter = freezed,Object? maskedCardNumber = freezed,Object? subscriptionSignedInDate = freezed,Object? activeTicket = freezed,Object? pendingTicket = freezed,Object? customerDetail = freezed,Object? isAutomaticSubscriptionEnabled = freezed,Object? isCycleRefreshEnabled = freezed,}) {
  return _then(SubscriptionDetails(
isSubscriptionSignedIn: freezed == isSubscriptionSignedIn ? _self.isSubscriptionSignedIn : isSubscriptionSignedIn // ignore: cast_nullable_to_non_nullable
as bool?,counter: freezed == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int?,maskedCardNumber: freezed == maskedCardNumber ? _self.maskedCardNumber : maskedCardNumber // ignore: cast_nullable_to_non_nullable
as String?,subscriptionSignedInDate: freezed == subscriptionSignedInDate ? _self.subscriptionSignedInDate : subscriptionSignedInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,activeTicket: freezed == activeTicket ? _self.activeTicket : activeTicket // ignore: cast_nullable_to_non_nullable
as dynamic,pendingTicket: freezed == pendingTicket ? _self.pendingTicket : pendingTicket // ignore: cast_nullable_to_non_nullable
as dynamic,customerDetail: freezed == customerDetail ? _self.customerDetail : customerDetail // ignore: cast_nullable_to_non_nullable
as SubscriptionCustomerDetail?,isAutomaticSubscriptionEnabled: freezed == isAutomaticSubscriptionEnabled ? _self.isAutomaticSubscriptionEnabled : isAutomaticSubscriptionEnabled // ignore: cast_nullable_to_non_nullable
as bool?,isCycleRefreshEnabled: freezed == isCycleRefreshEnabled ? _self.isCycleRefreshEnabled : isCycleRefreshEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionCustomerDetailCopyWith<$Res>? get customerDetail {
    if (_self.customerDetail == null) {
    return null;
  }

  return $SubscriptionCustomerDetailCopyWith<$Res>(_self.customerDetail!, (value) {
    return _then(_self.copyWith(customerDetail: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionDetails].
extension SubscriptionDetailsPatterns on SubscriptionDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionDetails value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionDetails value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? isSubscriptionSignedIn,  int? counter,  String? maskedCardNumber,  DateTime? subscriptionSignedInDate,  dynamic activeTicket,  dynamic pendingTicket,  SubscriptionCustomerDetail? customerDetail,  bool? isAutomaticSubscriptionEnabled,  bool? isCycleRefreshEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionDetails() when $default != null:
return $default(_that.isSubscriptionSignedIn,_that.counter,_that.maskedCardNumber,_that.subscriptionSignedInDate,_that.activeTicket,_that.pendingTicket,_that.customerDetail,_that.isAutomaticSubscriptionEnabled,_that.isCycleRefreshEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? isSubscriptionSignedIn,  int? counter,  String? maskedCardNumber,  DateTime? subscriptionSignedInDate,  dynamic activeTicket,  dynamic pendingTicket,  SubscriptionCustomerDetail? customerDetail,  bool? isAutomaticSubscriptionEnabled,  bool? isCycleRefreshEnabled)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDetails():
return $default(_that.isSubscriptionSignedIn,_that.counter,_that.maskedCardNumber,_that.subscriptionSignedInDate,_that.activeTicket,_that.pendingTicket,_that.customerDetail,_that.isAutomaticSubscriptionEnabled,_that.isCycleRefreshEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? isSubscriptionSignedIn,  int? counter,  String? maskedCardNumber,  DateTime? subscriptionSignedInDate,  dynamic activeTicket,  dynamic pendingTicket,  SubscriptionCustomerDetail? customerDetail,  bool? isAutomaticSubscriptionEnabled,  bool? isCycleRefreshEnabled)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDetails() when $default != null:
return $default(_that.isSubscriptionSignedIn,_that.counter,_that.maskedCardNumber,_that.subscriptionSignedInDate,_that.activeTicket,_that.pendingTicket,_that.customerDetail,_that.isAutomaticSubscriptionEnabled,_that.isCycleRefreshEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionDetails implements SubscriptionDetails {
  const _SubscriptionDetails({this.isSubscriptionSignedIn, this.counter, this.maskedCardNumber, this.subscriptionSignedInDate, this.activeTicket, this.pendingTicket, this.customerDetail, this.isAutomaticSubscriptionEnabled, this.isCycleRefreshEnabled});
  factory _SubscriptionDetails.fromJson(Map<String, dynamic> json) => _$SubscriptionDetailsFromJson(json);

@override final  bool? isSubscriptionSignedIn;
@override final  int? counter;
@override final  String? maskedCardNumber;
/// Local time WITHOUT a UTC offset on the wire
/// (e.g. `2026-10-01T15:43:39.107`) — parsed as such; treat as
/// Europe/Warsaw local time when displaying.
@override final  DateTime? subscriptionSignedInDate;
@override final  dynamic activeTicket;
@override final  dynamic pendingTicket;
@override final  SubscriptionCustomerDetail? customerDetail;
@override final  bool? isAutomaticSubscriptionEnabled;
@override final  bool? isCycleRefreshEnabled;

/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDetailsCopyWith<_SubscriptionDetails> get copyWith => __$SubscriptionDetailsCopyWithImpl<_SubscriptionDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionDetails&&(identical(other.isSubscriptionSignedIn, isSubscriptionSignedIn) || other.isSubscriptionSignedIn == isSubscriptionSignedIn)&&(identical(other.counter, counter) || other.counter == counter)&&(identical(other.maskedCardNumber, maskedCardNumber) || other.maskedCardNumber == maskedCardNumber)&&(identical(other.subscriptionSignedInDate, subscriptionSignedInDate) || other.subscriptionSignedInDate == subscriptionSignedInDate)&&const DeepCollectionEquality().equals(other.activeTicket, activeTicket)&&const DeepCollectionEquality().equals(other.pendingTicket, pendingTicket)&&(identical(other.customerDetail, customerDetail) || other.customerDetail == customerDetail)&&(identical(other.isAutomaticSubscriptionEnabled, isAutomaticSubscriptionEnabled) || other.isAutomaticSubscriptionEnabled == isAutomaticSubscriptionEnabled)&&(identical(other.isCycleRefreshEnabled, isCycleRefreshEnabled) || other.isCycleRefreshEnabled == isCycleRefreshEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isSubscriptionSignedIn,counter,maskedCardNumber,subscriptionSignedInDate,const DeepCollectionEquality().hash(activeTicket),const DeepCollectionEquality().hash(pendingTicket),customerDetail,isAutomaticSubscriptionEnabled,isCycleRefreshEnabled);
}

@override
String toString() {
    return 'SubscriptionDetails(isSubscriptionSignedIn: $isSubscriptionSignedIn, counter: $counter, maskedCardNumber: $maskedCardNumber, subscriptionSignedInDate: $subscriptionSignedInDate, activeTicket: $activeTicket, pendingTicket: $pendingTicket, customerDetail: $customerDetail, isAutomaticSubscriptionEnabled: $isAutomaticSubscriptionEnabled, isCycleRefreshEnabled: $isCycleRefreshEnabled)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDetailsCopyWith<$Res> implements $SubscriptionDetailsCopyWith<$Res> {
  factory _$SubscriptionDetailsCopyWith(_SubscriptionDetails value, $Res Function(_SubscriptionDetails) _then) = __$SubscriptionDetailsCopyWithImpl;
@override @useResult
$Res call({
 bool? isSubscriptionSignedIn, int? counter, String? maskedCardNumber, DateTime? subscriptionSignedInDate, dynamic activeTicket, dynamic pendingTicket, SubscriptionCustomerDetail? customerDetail, bool? isAutomaticSubscriptionEnabled, bool? isCycleRefreshEnabled
});


@override $SubscriptionCustomerDetailCopyWith<$Res>? get customerDetail;

}
/// @nodoc
class __$SubscriptionDetailsCopyWithImpl<$Res>
    implements _$SubscriptionDetailsCopyWith<$Res> {
  __$SubscriptionDetailsCopyWithImpl(this._self, this._then);

  final _SubscriptionDetails _self;
  final $Res Function(_SubscriptionDetails) _then;

/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSubscriptionSignedIn = freezed,Object? counter = freezed,Object? maskedCardNumber = freezed,Object? subscriptionSignedInDate = freezed,Object? activeTicket = freezed,Object? pendingTicket = freezed,Object? customerDetail = freezed,Object? isAutomaticSubscriptionEnabled = freezed,Object? isCycleRefreshEnabled = freezed,}) {
  return _then(_SubscriptionDetails(
isSubscriptionSignedIn: freezed == isSubscriptionSignedIn ? _self.isSubscriptionSignedIn : isSubscriptionSignedIn // ignore: cast_nullable_to_non_nullable
as bool?,counter: freezed == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int?,maskedCardNumber: freezed == maskedCardNumber ? _self.maskedCardNumber : maskedCardNumber // ignore: cast_nullable_to_non_nullable
as String?,subscriptionSignedInDate: freezed == subscriptionSignedInDate ? _self.subscriptionSignedInDate : subscriptionSignedInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,activeTicket: freezed == activeTicket ? _self.activeTicket : activeTicket // ignore: cast_nullable_to_non_nullable
as dynamic,pendingTicket: freezed == pendingTicket ? _self.pendingTicket : pendingTicket // ignore: cast_nullable_to_non_nullable
as dynamic,customerDetail: freezed == customerDetail ? _self.customerDetail : customerDetail // ignore: cast_nullable_to_non_nullable
as SubscriptionCustomerDetail?,isAutomaticSubscriptionEnabled: freezed == isAutomaticSubscriptionEnabled ? _self.isAutomaticSubscriptionEnabled : isAutomaticSubscriptionEnabled // ignore: cast_nullable_to_non_nullable
as bool?,isCycleRefreshEnabled: freezed == isCycleRefreshEnabled ? _self.isCycleRefreshEnabled : isCycleRefreshEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionCustomerDetailCopyWith<$Res>? get customerDetail {
    if (_self.customerDetail == null) {
    return null;
  }

  return $SubscriptionCustomerDetailCopyWith<$Res>(_self.customerDetail!, (value) {
    return _then(_self.copyWith(customerDetail: value));
  });
}
}


/// @nodoc
mixin _$SubscriptionCustomerDetail {

 String? get firstName; String? get lastName; String? get pesel; String? get email; int? get cityCardCode; int? get clientCode;
/// Create a copy of SubscriptionCustomerDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionCustomerDetailCopyWith<SubscriptionCustomerDetail> get copyWith => _$SubscriptionCustomerDetailCopyWithImpl<SubscriptionCustomerDetail>(this as SubscriptionCustomerDetail, _$identity);

  /// Serializes this SubscriptionCustomerDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionCustomerDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionCustomerDetail&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.pesel, _this.pesel) || other.pesel == _this.pesel)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.cityCardCode, _this.cityCardCode) || other.cityCardCode == _this.cityCardCode)&&(identical(other.clientCode, _this.clientCode) || other.clientCode == _this.clientCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionCustomerDetail;
  return Object.hash(runtimeType,_this.firstName,_this.lastName,_this.pesel,_this.email,_this.cityCardCode,_this.clientCode);
}

@override
String toString() {
  final _this = this as SubscriptionCustomerDetail;
  return 'SubscriptionCustomerDetail(firstName: ${_this.firstName}, lastName: ${_this.lastName}, pesel: ${_this.pesel}, email: ${_this.email}, cityCardCode: ${_this.cityCardCode}, clientCode: ${_this.clientCode})';
}


}

/// @nodoc
abstract mixin class $SubscriptionCustomerDetailCopyWith<$Res>  {
  factory $SubscriptionCustomerDetailCopyWith(SubscriptionCustomerDetail value, $Res Function(SubscriptionCustomerDetail) _then) = _$SubscriptionCustomerDetailCopyWithImpl;
@useResult
$Res call({
 String? firstName, String? lastName, String? pesel, String? email, int? cityCardCode, int? clientCode
});




}
/// @nodoc
class _$SubscriptionCustomerDetailCopyWithImpl<$Res>
    implements $SubscriptionCustomerDetailCopyWith<$Res> {
  _$SubscriptionCustomerDetailCopyWithImpl(this._self, this._then);

  final SubscriptionCustomerDetail _self;
  final $Res Function(SubscriptionCustomerDetail) _then;

/// Create a copy of SubscriptionCustomerDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? pesel = freezed,Object? email = freezed,Object? cityCardCode = freezed,Object? clientCode = freezed,}) {
  return _then(SubscriptionCustomerDetail(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,pesel: freezed == pesel ? _self.pesel : pesel // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,cityCardCode: freezed == cityCardCode ? _self.cityCardCode : cityCardCode // ignore: cast_nullable_to_non_nullable
as int?,clientCode: freezed == clientCode ? _self.clientCode : clientCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionCustomerDetail].
extension SubscriptionCustomerDetailPatterns on SubscriptionCustomerDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionCustomerDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionCustomerDetail value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionCustomerDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? firstName,  String? lastName,  String? pesel,  String? email,  int? cityCardCode,  int? clientCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail() when $default != null:
return $default(_that.firstName,_that.lastName,_that.pesel,_that.email,_that.cityCardCode,_that.clientCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? firstName,  String? lastName,  String? pesel,  String? email,  int? cityCardCode,  int? clientCode)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail():
return $default(_that.firstName,_that.lastName,_that.pesel,_that.email,_that.cityCardCode,_that.clientCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? firstName,  String? lastName,  String? pesel,  String? email,  int? cityCardCode,  int? clientCode)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail() when $default != null:
return $default(_that.firstName,_that.lastName,_that.pesel,_that.email,_that.cityCardCode,_that.clientCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionCustomerDetail implements SubscriptionCustomerDetail {
  const _SubscriptionCustomerDetail({this.firstName, this.lastName, this.pesel, this.email, this.cityCardCode, this.clientCode});
  factory _SubscriptionCustomerDetail.fromJson(Map<String, dynamic> json) => _$SubscriptionCustomerDetailFromJson(json);

@override final  String? firstName;
@override final  String? lastName;
@override final  String? pesel;
@override final  String? email;
@override final  int? cityCardCode;
@override final  int? clientCode;

/// Create a copy of SubscriptionCustomerDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionCustomerDetailCopyWith<_SubscriptionCustomerDetail> get copyWith => __$SubscriptionCustomerDetailCopyWithImpl<_SubscriptionCustomerDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionCustomerDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionCustomerDetail&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.pesel, pesel) || other.pesel == pesel)&&(identical(other.email, email) || other.email == email)&&(identical(other.cityCardCode, cityCardCode) || other.cityCardCode == cityCardCode)&&(identical(other.clientCode, clientCode) || other.clientCode == clientCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName,pesel,email,cityCardCode,clientCode);
}

@override
String toString() {
    return 'SubscriptionCustomerDetail(firstName: $firstName, lastName: $lastName, pesel: $pesel, email: $email, cityCardCode: $cityCardCode, clientCode: $clientCode)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionCustomerDetailCopyWith<$Res> implements $SubscriptionCustomerDetailCopyWith<$Res> {
  factory _$SubscriptionCustomerDetailCopyWith(_SubscriptionCustomerDetail value, $Res Function(_SubscriptionCustomerDetail) _then) = __$SubscriptionCustomerDetailCopyWithImpl;
@override @useResult
$Res call({
 String? firstName, String? lastName, String? pesel, String? email, int? cityCardCode, int? clientCode
});




}
/// @nodoc
class __$SubscriptionCustomerDetailCopyWithImpl<$Res>
    implements _$SubscriptionCustomerDetailCopyWith<$Res> {
  __$SubscriptionCustomerDetailCopyWithImpl(this._self, this._then);

  final _SubscriptionCustomerDetail _self;
  final $Res Function(_SubscriptionCustomerDetail) _then;

/// Create a copy of SubscriptionCustomerDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? pesel = freezed,Object? email = freezed,Object? cityCardCode = freezed,Object? clientCode = freezed,}) {
  return _then(_SubscriptionCustomerDetail(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,pesel: freezed == pesel ? _self.pesel : pesel // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,cityCardCode: freezed == cityCardCode ? _self.cityCardCode : cityCardCode // ignore: cast_nullable_to_non_nullable
as int?,clientCode: freezed == clientCode ? _self.clientCode : clientCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SubscriptionAvailableActions {

 bool? get newCard; bool? get changeCard; bool? get buyTicket; bool? get changeStorageMedium;
/// Create a copy of SubscriptionAvailableActions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionAvailableActionsCopyWith<SubscriptionAvailableActions> get copyWith => _$SubscriptionAvailableActionsCopyWithImpl<SubscriptionAvailableActions>(this as SubscriptionAvailableActions, _$identity);

  /// Serializes this SubscriptionAvailableActions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionAvailableActions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionAvailableActions&&(identical(other.newCard, _this.newCard) || other.newCard == _this.newCard)&&(identical(other.changeCard, _this.changeCard) || other.changeCard == _this.changeCard)&&(identical(other.buyTicket, _this.buyTicket) || other.buyTicket == _this.buyTicket)&&(identical(other.changeStorageMedium, _this.changeStorageMedium) || other.changeStorageMedium == _this.changeStorageMedium));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionAvailableActions;
  return Object.hash(runtimeType,_this.newCard,_this.changeCard,_this.buyTicket,_this.changeStorageMedium);
}

@override
String toString() {
  final _this = this as SubscriptionAvailableActions;
  return 'SubscriptionAvailableActions(newCard: ${_this.newCard}, changeCard: ${_this.changeCard}, buyTicket: ${_this.buyTicket}, changeStorageMedium: ${_this.changeStorageMedium})';
}


}

/// @nodoc
abstract mixin class $SubscriptionAvailableActionsCopyWith<$Res>  {
  factory $SubscriptionAvailableActionsCopyWith(SubscriptionAvailableActions value, $Res Function(SubscriptionAvailableActions) _then) = _$SubscriptionAvailableActionsCopyWithImpl;
@useResult
$Res call({
 bool? newCard, bool? changeCard, bool? buyTicket, bool? changeStorageMedium
});




}
/// @nodoc
class _$SubscriptionAvailableActionsCopyWithImpl<$Res>
    implements $SubscriptionAvailableActionsCopyWith<$Res> {
  _$SubscriptionAvailableActionsCopyWithImpl(this._self, this._then);

  final SubscriptionAvailableActions _self;
  final $Res Function(SubscriptionAvailableActions) _then;

/// Create a copy of SubscriptionAvailableActions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newCard = freezed,Object? changeCard = freezed,Object? buyTicket = freezed,Object? changeStorageMedium = freezed,}) {
  return _then(SubscriptionAvailableActions(
newCard: freezed == newCard ? _self.newCard : newCard // ignore: cast_nullable_to_non_nullable
as bool?,changeCard: freezed == changeCard ? _self.changeCard : changeCard // ignore: cast_nullable_to_non_nullable
as bool?,buyTicket: freezed == buyTicket ? _self.buyTicket : buyTicket // ignore: cast_nullable_to_non_nullable
as bool?,changeStorageMedium: freezed == changeStorageMedium ? _self.changeStorageMedium : changeStorageMedium // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionAvailableActions].
extension SubscriptionAvailableActionsPatterns on SubscriptionAvailableActions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionAvailableActions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionAvailableActions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionAvailableActions value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionAvailableActions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionAvailableActions value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionAvailableActions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? newCard,  bool? changeCard,  bool? buyTicket,  bool? changeStorageMedium)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionAvailableActions() when $default != null:
return $default(_that.newCard,_that.changeCard,_that.buyTicket,_that.changeStorageMedium);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? newCard,  bool? changeCard,  bool? buyTicket,  bool? changeStorageMedium)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionAvailableActions():
return $default(_that.newCard,_that.changeCard,_that.buyTicket,_that.changeStorageMedium);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? newCard,  bool? changeCard,  bool? buyTicket,  bool? changeStorageMedium)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionAvailableActions() when $default != null:
return $default(_that.newCard,_that.changeCard,_that.buyTicket,_that.changeStorageMedium);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionAvailableActions implements SubscriptionAvailableActions {
  const _SubscriptionAvailableActions({this.newCard, this.changeCard, this.buyTicket, this.changeStorageMedium});
  factory _SubscriptionAvailableActions.fromJson(Map<String, dynamic> json) => _$SubscriptionAvailableActionsFromJson(json);

@override final  bool? newCard;
@override final  bool? changeCard;
@override final  bool? buyTicket;
@override final  bool? changeStorageMedium;

/// Create a copy of SubscriptionAvailableActions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionAvailableActionsCopyWith<_SubscriptionAvailableActions> get copyWith => __$SubscriptionAvailableActionsCopyWithImpl<_SubscriptionAvailableActions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionAvailableActionsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionAvailableActions&&(identical(other.newCard, newCard) || other.newCard == newCard)&&(identical(other.changeCard, changeCard) || other.changeCard == changeCard)&&(identical(other.buyTicket, buyTicket) || other.buyTicket == buyTicket)&&(identical(other.changeStorageMedium, changeStorageMedium) || other.changeStorageMedium == changeStorageMedium));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,newCard,changeCard,buyTicket,changeStorageMedium);
}

@override
String toString() {
    return 'SubscriptionAvailableActions(newCard: $newCard, changeCard: $changeCard, buyTicket: $buyTicket, changeStorageMedium: $changeStorageMedium)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionAvailableActionsCopyWith<$Res> implements $SubscriptionAvailableActionsCopyWith<$Res> {
  factory _$SubscriptionAvailableActionsCopyWith(_SubscriptionAvailableActions value, $Res Function(_SubscriptionAvailableActions) _then) = __$SubscriptionAvailableActionsCopyWithImpl;
@override @useResult
$Res call({
 bool? newCard, bool? changeCard, bool? buyTicket, bool? changeStorageMedium
});




}
/// @nodoc
class __$SubscriptionAvailableActionsCopyWithImpl<$Res>
    implements _$SubscriptionAvailableActionsCopyWith<$Res> {
  __$SubscriptionAvailableActionsCopyWithImpl(this._self, this._then);

  final _SubscriptionAvailableActions _self;
  final $Res Function(_SubscriptionAvailableActions) _then;

/// Create a copy of SubscriptionAvailableActions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newCard = freezed,Object? changeCard = freezed,Object? buyTicket = freezed,Object? changeStorageMedium = freezed,}) {
  return _then(_SubscriptionAvailableActions(
newCard: freezed == newCard ? _self.newCard : newCard // ignore: cast_nullable_to_non_nullable
as bool?,changeCard: freezed == changeCard ? _self.changeCard : changeCard // ignore: cast_nullable_to_non_nullable
as bool?,buyTicket: freezed == buyTicket ? _self.buyTicket : buyTicket // ignore: cast_nullable_to_non_nullable
as bool?,changeStorageMedium: freezed == changeStorageMedium ? _self.changeStorageMedium : changeStorageMedium // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$SubscriptionMarketingConsentsResponse {

 List<MarketingConsent> get marketingConsents;
/// Create a copy of SubscriptionMarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionMarketingConsentsResponseCopyWith<SubscriptionMarketingConsentsResponse> get copyWith => _$SubscriptionMarketingConsentsResponseCopyWithImpl<SubscriptionMarketingConsentsResponse>(this as SubscriptionMarketingConsentsResponse, _$identity);

  /// Serializes this SubscriptionMarketingConsentsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionMarketingConsentsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionMarketingConsentsResponse&&const DeepCollectionEquality().equals(other.marketingConsents, _this.marketingConsents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionMarketingConsentsResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.marketingConsents));
}

@override
String toString() {
  final _this = this as SubscriptionMarketingConsentsResponse;
  return 'SubscriptionMarketingConsentsResponse(marketingConsents: ${_this.marketingConsents})';
}


}

/// @nodoc
abstract mixin class $SubscriptionMarketingConsentsResponseCopyWith<$Res>  {
  factory $SubscriptionMarketingConsentsResponseCopyWith(SubscriptionMarketingConsentsResponse value, $Res Function(SubscriptionMarketingConsentsResponse) _then) = _$SubscriptionMarketingConsentsResponseCopyWithImpl;
@useResult
$Res call({
 List<MarketingConsent> marketingConsents
});




}
/// @nodoc
class _$SubscriptionMarketingConsentsResponseCopyWithImpl<$Res>
    implements $SubscriptionMarketingConsentsResponseCopyWith<$Res> {
  _$SubscriptionMarketingConsentsResponseCopyWithImpl(this._self, this._then);

  final SubscriptionMarketingConsentsResponse _self;
  final $Res Function(SubscriptionMarketingConsentsResponse) _then;

/// Create a copy of SubscriptionMarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? marketingConsents = null,}) {
  return _then(SubscriptionMarketingConsentsResponse(
marketingConsents: null == marketingConsents ? _self.marketingConsents : marketingConsents // ignore: cast_nullable_to_non_nullable
as List<MarketingConsent>,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionMarketingConsentsResponse].
extension SubscriptionMarketingConsentsResponsePatterns on SubscriptionMarketingConsentsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionMarketingConsentsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionMarketingConsentsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionMarketingConsentsResponse value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionMarketingConsentsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionMarketingConsentsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionMarketingConsentsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MarketingConsent> marketingConsents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionMarketingConsentsResponse() when $default != null:
return $default(_that.marketingConsents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MarketingConsent> marketingConsents)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionMarketingConsentsResponse():
return $default(_that.marketingConsents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MarketingConsent> marketingConsents)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionMarketingConsentsResponse() when $default != null:
return $default(_that.marketingConsents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionMarketingConsentsResponse implements SubscriptionMarketingConsentsResponse {
  const _SubscriptionMarketingConsentsResponse({ List<MarketingConsent> marketingConsents = const <MarketingConsent>[]}): _marketingConsents = marketingConsents;
  factory _SubscriptionMarketingConsentsResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionMarketingConsentsResponseFromJson(json);

 final  List<MarketingConsent> _marketingConsents;
@override@JsonKey() List<MarketingConsent> get marketingConsents {
  if (_marketingConsents is EqualUnmodifiableListView) return _marketingConsents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marketingConsents);
}


/// Create a copy of SubscriptionMarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionMarketingConsentsResponseCopyWith<_SubscriptionMarketingConsentsResponse> get copyWith => __$SubscriptionMarketingConsentsResponseCopyWithImpl<_SubscriptionMarketingConsentsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionMarketingConsentsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionMarketingConsentsResponse&&const DeepCollectionEquality().equals(other.marketingConsents, _marketingConsents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_marketingConsents));
}

@override
String toString() {
    return 'SubscriptionMarketingConsentsResponse(marketingConsents: $marketingConsents)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionMarketingConsentsResponseCopyWith<$Res> implements $SubscriptionMarketingConsentsResponseCopyWith<$Res> {
  factory _$SubscriptionMarketingConsentsResponseCopyWith(_SubscriptionMarketingConsentsResponse value, $Res Function(_SubscriptionMarketingConsentsResponse) _then) = __$SubscriptionMarketingConsentsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<MarketingConsent> marketingConsents
});




}
/// @nodoc
class __$SubscriptionMarketingConsentsResponseCopyWithImpl<$Res>
    implements _$SubscriptionMarketingConsentsResponseCopyWith<$Res> {
  __$SubscriptionMarketingConsentsResponseCopyWithImpl(this._self, this._then);

  final _SubscriptionMarketingConsentsResponse _self;
  final $Res Function(_SubscriptionMarketingConsentsResponse) _then;

/// Create a copy of SubscriptionMarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? marketingConsents = null,}) {
  return _then(_SubscriptionMarketingConsentsResponse(
marketingConsents: null == marketingConsents ? _self._marketingConsents : marketingConsents // ignore: cast_nullable_to_non_nullable
as List<MarketingConsent>,
  ));
}


}

// dart format on
