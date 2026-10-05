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
mixin _$SubscriptionTicket {

/// The id [SubscriptionsApi.payTicket] and
/// [SubscriptionsApi.removeTicket] take.
 String? get ticketGuid;/// Present once the ticket has a transaction — the id used by
/// `GET /tickets/{id}`.
 String? get transactionCode; DateTime? get startDate; DateTime? get endDate; String? get commodityName; int? get monthsPeriod; int? get daysPeriod; double? get price;/// The ticket still awaits payment ([SubscriptionsApi.payTicket]).
 bool? get canBePaid;/// The ticket can be deleted ([SubscriptionsApi.removeTicket]).
 bool? get canRemove;
/// Create a copy of SubscriptionTicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionTicketCopyWith<SubscriptionTicket> get copyWith => _$SubscriptionTicketCopyWithImpl<SubscriptionTicket>(this as SubscriptionTicket, _$identity);

  /// Serializes this SubscriptionTicket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionTicket;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionTicket&&(identical(other.ticketGuid, _this.ticketGuid) || other.ticketGuid == _this.ticketGuid)&&(identical(other.transactionCode, _this.transactionCode) || other.transactionCode == _this.transactionCode)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.commodityName, _this.commodityName) || other.commodityName == _this.commodityName)&&(identical(other.monthsPeriod, _this.monthsPeriod) || other.monthsPeriod == _this.monthsPeriod)&&(identical(other.daysPeriod, _this.daysPeriod) || other.daysPeriod == _this.daysPeriod)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.canBePaid, _this.canBePaid) || other.canBePaid == _this.canBePaid)&&(identical(other.canRemove, _this.canRemove) || other.canRemove == _this.canRemove));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionTicket;
  return Object.hash(runtimeType,_this.ticketGuid,_this.transactionCode,_this.startDate,_this.endDate,_this.commodityName,_this.monthsPeriod,_this.daysPeriod,_this.price,_this.canBePaid,_this.canRemove);
}

@override
String toString() {
  final _this = this as SubscriptionTicket;
  return 'SubscriptionTicket(ticketGuid: ${_this.ticketGuid}, transactionCode: ${_this.transactionCode}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, commodityName: ${_this.commodityName}, monthsPeriod: ${_this.monthsPeriod}, daysPeriod: ${_this.daysPeriod}, price: ${_this.price}, canBePaid: ${_this.canBePaid}, canRemove: ${_this.canRemove})';
}


}

/// @nodoc
abstract mixin class $SubscriptionTicketCopyWith<$Res>  {
  factory $SubscriptionTicketCopyWith(SubscriptionTicket value, $Res Function(SubscriptionTicket) _then) = _$SubscriptionTicketCopyWithImpl;
@useResult
$Res call({
 String? ticketGuid, String? transactionCode, DateTime? startDate, DateTime? endDate, String? commodityName, int? monthsPeriod, int? daysPeriod, double? price, bool? canBePaid, bool? canRemove
});




}
/// @nodoc
class _$SubscriptionTicketCopyWithImpl<$Res>
    implements $SubscriptionTicketCopyWith<$Res> {
  _$SubscriptionTicketCopyWithImpl(this._self, this._then);

  final SubscriptionTicket _self;
  final $Res Function(SubscriptionTicket) _then;

/// Create a copy of SubscriptionTicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticketGuid = freezed,Object? transactionCode = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? commodityName = freezed,Object? monthsPeriod = freezed,Object? daysPeriod = freezed,Object? price = freezed,Object? canBePaid = freezed,Object? canRemove = freezed,}) {
  return _then(SubscriptionTicket(
ticketGuid: freezed == ticketGuid ? _self.ticketGuid : ticketGuid // ignore: cast_nullable_to_non_nullable
as String?,transactionCode: freezed == transactionCode ? _self.transactionCode : transactionCode // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,monthsPeriod: freezed == monthsPeriod ? _self.monthsPeriod : monthsPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysPeriod: freezed == daysPeriod ? _self.daysPeriod : daysPeriod // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,canBePaid: freezed == canBePaid ? _self.canBePaid : canBePaid // ignore: cast_nullable_to_non_nullable
as bool?,canRemove: freezed == canRemove ? _self.canRemove : canRemove // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionTicket].
extension SubscriptionTicketPatterns on SubscriptionTicket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionTicket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionTicket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionTicket value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionTicket value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? ticketGuid,  String? transactionCode,  DateTime? startDate,  DateTime? endDate,  String? commodityName,  int? monthsPeriod,  int? daysPeriod,  double? price,  bool? canBePaid,  bool? canRemove)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionTicket() when $default != null:
return $default(_that.ticketGuid,_that.transactionCode,_that.startDate,_that.endDate,_that.commodityName,_that.monthsPeriod,_that.daysPeriod,_that.price,_that.canBePaid,_that.canRemove);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? ticketGuid,  String? transactionCode,  DateTime? startDate,  DateTime? endDate,  String? commodityName,  int? monthsPeriod,  int? daysPeriod,  double? price,  bool? canBePaid,  bool? canRemove)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicket():
return $default(_that.ticketGuid,_that.transactionCode,_that.startDate,_that.endDate,_that.commodityName,_that.monthsPeriod,_that.daysPeriod,_that.price,_that.canBePaid,_that.canRemove);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? ticketGuid,  String? transactionCode,  DateTime? startDate,  DateTime? endDate,  String? commodityName,  int? monthsPeriod,  int? daysPeriod,  double? price,  bool? canBePaid,  bool? canRemove)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicket() when $default != null:
return $default(_that.ticketGuid,_that.transactionCode,_that.startDate,_that.endDate,_that.commodityName,_that.monthsPeriod,_that.daysPeriod,_that.price,_that.canBePaid,_that.canRemove);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionTicket implements SubscriptionTicket {
  const _SubscriptionTicket({this.ticketGuid, this.transactionCode, this.startDate, this.endDate, this.commodityName, this.monthsPeriod, this.daysPeriod, this.price, this.canBePaid, this.canRemove});
  factory _SubscriptionTicket.fromJson(Map<String, dynamic> json) => _$SubscriptionTicketFromJson(json);

/// The id [SubscriptionsApi.payTicket] and
/// [SubscriptionsApi.removeTicket] take.
@override final  String? ticketGuid;
/// Present once the ticket has a transaction — the id used by
/// `GET /tickets/{id}`.
@override final  String? transactionCode;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  String? commodityName;
@override final  int? monthsPeriod;
@override final  int? daysPeriod;
@override final  double? price;
/// The ticket still awaits payment ([SubscriptionsApi.payTicket]).
@override final  bool? canBePaid;
/// The ticket can be deleted ([SubscriptionsApi.removeTicket]).
@override final  bool? canRemove;

/// Create a copy of SubscriptionTicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionTicketCopyWith<_SubscriptionTicket> get copyWith => __$SubscriptionTicketCopyWithImpl<_SubscriptionTicket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionTicketToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionTicket&&(identical(other.ticketGuid, ticketGuid) || other.ticketGuid == ticketGuid)&&(identical(other.transactionCode, transactionCode) || other.transactionCode == transactionCode)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.commodityName, commodityName) || other.commodityName == commodityName)&&(identical(other.monthsPeriod, monthsPeriod) || other.monthsPeriod == monthsPeriod)&&(identical(other.daysPeriod, daysPeriod) || other.daysPeriod == daysPeriod)&&(identical(other.price, price) || other.price == price)&&(identical(other.canBePaid, canBePaid) || other.canBePaid == canBePaid)&&(identical(other.canRemove, canRemove) || other.canRemove == canRemove));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,ticketGuid,transactionCode,startDate,endDate,commodityName,monthsPeriod,daysPeriod,price,canBePaid,canRemove);
}

@override
String toString() {
    return 'SubscriptionTicket(ticketGuid: $ticketGuid, transactionCode: $transactionCode, startDate: $startDate, endDate: $endDate, commodityName: $commodityName, monthsPeriod: $monthsPeriod, daysPeriod: $daysPeriod, price: $price, canBePaid: $canBePaid, canRemove: $canRemove)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionTicketCopyWith<$Res> implements $SubscriptionTicketCopyWith<$Res> {
  factory _$SubscriptionTicketCopyWith(_SubscriptionTicket value, $Res Function(_SubscriptionTicket) _then) = __$SubscriptionTicketCopyWithImpl;
@override @useResult
$Res call({
 String? ticketGuid, String? transactionCode, DateTime? startDate, DateTime? endDate, String? commodityName, int? monthsPeriod, int? daysPeriod, double? price, bool? canBePaid, bool? canRemove
});




}
/// @nodoc
class __$SubscriptionTicketCopyWithImpl<$Res>
    implements _$SubscriptionTicketCopyWith<$Res> {
  __$SubscriptionTicketCopyWithImpl(this._self, this._then);

  final _SubscriptionTicket _self;
  final $Res Function(_SubscriptionTicket) _then;

/// Create a copy of SubscriptionTicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticketGuid = freezed,Object? transactionCode = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? commodityName = freezed,Object? monthsPeriod = freezed,Object? daysPeriod = freezed,Object? price = freezed,Object? canBePaid = freezed,Object? canRemove = freezed,}) {
  return _then(_SubscriptionTicket(
ticketGuid: freezed == ticketGuid ? _self.ticketGuid : ticketGuid // ignore: cast_nullable_to_non_nullable
as String?,transactionCode: freezed == transactionCode ? _self.transactionCode : transactionCode // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,monthsPeriod: freezed == monthsPeriod ? _self.monthsPeriod : monthsPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysPeriod: freezed == daysPeriod ? _self.daysPeriod : daysPeriod // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,canBePaid: freezed == canBePaid ? _self.canBePaid : canBePaid // ignore: cast_nullable_to_non_nullable
as bool?,canRemove: freezed == canRemove ? _self.canRemove : canRemove // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$SubscriptionDetails {

 bool? get isSubscriptionSignedIn; int? get counter; String? get maskedCardNumber;/// Local time WITHOUT a UTC offset on the wire
/// (e.g. `2026-10-01T15:43:39.107`) — parsed as such; treat as
/// Europe/Warsaw local time when displaying.
 DateTime? get subscriptionSignedInDate; SubscriptionTicket? get activeTicket; SubscriptionTicket? get pendingTicket; SubscriptionCustomerDetail? get customerDetail; bool? get isAutomaticSubscriptionEnabled; bool? get isCycleRefreshEnabled;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionDetails&&(identical(other.isSubscriptionSignedIn, _this.isSubscriptionSignedIn) || other.isSubscriptionSignedIn == _this.isSubscriptionSignedIn)&&(identical(other.counter, _this.counter) || other.counter == _this.counter)&&(identical(other.maskedCardNumber, _this.maskedCardNumber) || other.maskedCardNumber == _this.maskedCardNumber)&&(identical(other.subscriptionSignedInDate, _this.subscriptionSignedInDate) || other.subscriptionSignedInDate == _this.subscriptionSignedInDate)&&(identical(other.activeTicket, _this.activeTicket) || other.activeTicket == _this.activeTicket)&&(identical(other.pendingTicket, _this.pendingTicket) || other.pendingTicket == _this.pendingTicket)&&(identical(other.customerDetail, _this.customerDetail) || other.customerDetail == _this.customerDetail)&&(identical(other.isAutomaticSubscriptionEnabled, _this.isAutomaticSubscriptionEnabled) || other.isAutomaticSubscriptionEnabled == _this.isAutomaticSubscriptionEnabled)&&(identical(other.isCycleRefreshEnabled, _this.isCycleRefreshEnabled) || other.isCycleRefreshEnabled == _this.isCycleRefreshEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionDetails;
  return Object.hash(runtimeType,_this.isSubscriptionSignedIn,_this.counter,_this.maskedCardNumber,_this.subscriptionSignedInDate,_this.activeTicket,_this.pendingTicket,_this.customerDetail,_this.isAutomaticSubscriptionEnabled,_this.isCycleRefreshEnabled);
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
 bool? isSubscriptionSignedIn, int? counter, String? maskedCardNumber, DateTime? subscriptionSignedInDate, SubscriptionTicket? activeTicket, SubscriptionTicket? pendingTicket, SubscriptionCustomerDetail? customerDetail, bool? isAutomaticSubscriptionEnabled, bool? isCycleRefreshEnabled
});


$SubscriptionTicketCopyWith<$Res>? get activeTicket;$SubscriptionTicketCopyWith<$Res>? get pendingTicket;$SubscriptionCustomerDetailCopyWith<$Res>? get customerDetail;

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
as SubscriptionTicket?,pendingTicket: freezed == pendingTicket ? _self.pendingTicket : pendingTicket // ignore: cast_nullable_to_non_nullable
as SubscriptionTicket?,customerDetail: freezed == customerDetail ? _self.customerDetail : customerDetail // ignore: cast_nullable_to_non_nullable
as SubscriptionCustomerDetail?,isAutomaticSubscriptionEnabled: freezed == isAutomaticSubscriptionEnabled ? _self.isAutomaticSubscriptionEnabled : isAutomaticSubscriptionEnabled // ignore: cast_nullable_to_non_nullable
as bool?,isCycleRefreshEnabled: freezed == isCycleRefreshEnabled ? _self.isCycleRefreshEnabled : isCycleRefreshEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionTicketCopyWith<$Res>? get activeTicket {
    if (_self.activeTicket == null) {
    return null;
  }

  return $SubscriptionTicketCopyWith<$Res>(_self.activeTicket!, (value) {
    return _then(_self.copyWith(activeTicket: value));
  });
}/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionTicketCopyWith<$Res>? get pendingTicket {
    if (_self.pendingTicket == null) {
    return null;
  }

  return $SubscriptionTicketCopyWith<$Res>(_self.pendingTicket!, (value) {
    return _then(_self.copyWith(pendingTicket: value));
  });
}/// Create a copy of SubscriptionDetails
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? isSubscriptionSignedIn,  int? counter,  String? maskedCardNumber,  DateTime? subscriptionSignedInDate,  SubscriptionTicket? activeTicket,  SubscriptionTicket? pendingTicket,  SubscriptionCustomerDetail? customerDetail,  bool? isAutomaticSubscriptionEnabled,  bool? isCycleRefreshEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? isSubscriptionSignedIn,  int? counter,  String? maskedCardNumber,  DateTime? subscriptionSignedInDate,  SubscriptionTicket? activeTicket,  SubscriptionTicket? pendingTicket,  SubscriptionCustomerDetail? customerDetail,  bool? isAutomaticSubscriptionEnabled,  bool? isCycleRefreshEnabled)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? isSubscriptionSignedIn,  int? counter,  String? maskedCardNumber,  DateTime? subscriptionSignedInDate,  SubscriptionTicket? activeTicket,  SubscriptionTicket? pendingTicket,  SubscriptionCustomerDetail? customerDetail,  bool? isAutomaticSubscriptionEnabled,  bool? isCycleRefreshEnabled)?  $default,) {final _that = this;
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
@override final  SubscriptionTicket? activeTicket;
@override final  SubscriptionTicket? pendingTicket;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionDetails&&(identical(other.isSubscriptionSignedIn, isSubscriptionSignedIn) || other.isSubscriptionSignedIn == isSubscriptionSignedIn)&&(identical(other.counter, counter) || other.counter == counter)&&(identical(other.maskedCardNumber, maskedCardNumber) || other.maskedCardNumber == maskedCardNumber)&&(identical(other.subscriptionSignedInDate, subscriptionSignedInDate) || other.subscriptionSignedInDate == subscriptionSignedInDate)&&(identical(other.activeTicket, activeTicket) || other.activeTicket == activeTicket)&&(identical(other.pendingTicket, pendingTicket) || other.pendingTicket == pendingTicket)&&(identical(other.customerDetail, customerDetail) || other.customerDetail == customerDetail)&&(identical(other.isAutomaticSubscriptionEnabled, isAutomaticSubscriptionEnabled) || other.isAutomaticSubscriptionEnabled == isAutomaticSubscriptionEnabled)&&(identical(other.isCycleRefreshEnabled, isCycleRefreshEnabled) || other.isCycleRefreshEnabled == isCycleRefreshEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isSubscriptionSignedIn,counter,maskedCardNumber,subscriptionSignedInDate,activeTicket,pendingTicket,customerDetail,isAutomaticSubscriptionEnabled,isCycleRefreshEnabled);
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
 bool? isSubscriptionSignedIn, int? counter, String? maskedCardNumber, DateTime? subscriptionSignedInDate, SubscriptionTicket? activeTicket, SubscriptionTicket? pendingTicket, SubscriptionCustomerDetail? customerDetail, bool? isAutomaticSubscriptionEnabled, bool? isCycleRefreshEnabled
});


@override $SubscriptionTicketCopyWith<$Res>? get activeTicket;@override $SubscriptionTicketCopyWith<$Res>? get pendingTicket;@override $SubscriptionCustomerDetailCopyWith<$Res>? get customerDetail;

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
as SubscriptionTicket?,pendingTicket: freezed == pendingTicket ? _self.pendingTicket : pendingTicket // ignore: cast_nullable_to_non_nullable
as SubscriptionTicket?,customerDetail: freezed == customerDetail ? _self.customerDetail : customerDetail // ignore: cast_nullable_to_non_nullable
as SubscriptionCustomerDetail?,isAutomaticSubscriptionEnabled: freezed == isAutomaticSubscriptionEnabled ? _self.isAutomaticSubscriptionEnabled : isAutomaticSubscriptionEnabled // ignore: cast_nullable_to_non_nullable
as bool?,isCycleRefreshEnabled: freezed == isCycleRefreshEnabled ? _self.isCycleRefreshEnabled : isCycleRefreshEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionTicketCopyWith<$Res>? get activeTicket {
    if (_self.activeTicket == null) {
    return null;
  }

  return $SubscriptionTicketCopyWith<$Res>(_self.activeTicket!, (value) {
    return _then(_self.copyWith(activeTicket: value));
  });
}/// Create a copy of SubscriptionDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionTicketCopyWith<$Res>? get pendingTicket {
    if (_self.pendingTicket == null) {
    return null;
  }

  return $SubscriptionTicketCopyWith<$Res>(_self.pendingTicket!, (value) {
    return _then(_self.copyWith(pendingTicket: value));
  });
}/// Create a copy of SubscriptionDetails
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

 String? get firstName; String? get lastName; String? get pesel;/// Shown by the official client when [pesel] is empty. Never captured,
/// so the format is unknown and the value is kept as sent.
 String? get birthDate; String? get email; int? get cityCardCode; int? get clientCode;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionCustomerDetail&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.pesel, _this.pesel) || other.pesel == _this.pesel)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.cityCardCode, _this.cityCardCode) || other.cityCardCode == _this.cityCardCode)&&(identical(other.clientCode, _this.clientCode) || other.clientCode == _this.clientCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionCustomerDetail;
  return Object.hash(runtimeType,_this.firstName,_this.lastName,_this.pesel,_this.birthDate,_this.email,_this.cityCardCode,_this.clientCode);
}

@override
String toString() {
  final _this = this as SubscriptionCustomerDetail;
  return 'SubscriptionCustomerDetail(firstName: ${_this.firstName}, lastName: ${_this.lastName}, pesel: ${_this.pesel}, birthDate: ${_this.birthDate}, email: ${_this.email}, cityCardCode: ${_this.cityCardCode}, clientCode: ${_this.clientCode})';
}


}

/// @nodoc
abstract mixin class $SubscriptionCustomerDetailCopyWith<$Res>  {
  factory $SubscriptionCustomerDetailCopyWith(SubscriptionCustomerDetail value, $Res Function(SubscriptionCustomerDetail) _then) = _$SubscriptionCustomerDetailCopyWithImpl;
@useResult
$Res call({
 String? firstName, String? lastName, String? pesel, String? birthDate, String? email, int? cityCardCode, int? clientCode
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
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? pesel = freezed,Object? birthDate = freezed,Object? email = freezed,Object? cityCardCode = freezed,Object? clientCode = freezed,}) {
  return _then(SubscriptionCustomerDetail(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,pesel: freezed == pesel ? _self.pesel : pesel // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? firstName,  String? lastName,  String? pesel,  String? birthDate,  String? email,  int? cityCardCode,  int? clientCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail() when $default != null:
return $default(_that.firstName,_that.lastName,_that.pesel,_that.birthDate,_that.email,_that.cityCardCode,_that.clientCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? firstName,  String? lastName,  String? pesel,  String? birthDate,  String? email,  int? cityCardCode,  int? clientCode)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail():
return $default(_that.firstName,_that.lastName,_that.pesel,_that.birthDate,_that.email,_that.cityCardCode,_that.clientCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? firstName,  String? lastName,  String? pesel,  String? birthDate,  String? email,  int? cityCardCode,  int? clientCode)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionCustomerDetail() when $default != null:
return $default(_that.firstName,_that.lastName,_that.pesel,_that.birthDate,_that.email,_that.cityCardCode,_that.clientCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionCustomerDetail implements SubscriptionCustomerDetail {
  const _SubscriptionCustomerDetail({this.firstName, this.lastName, this.pesel, this.birthDate, this.email, this.cityCardCode, this.clientCode});
  factory _SubscriptionCustomerDetail.fromJson(Map<String, dynamic> json) => _$SubscriptionCustomerDetailFromJson(json);

@override final  String? firstName;
@override final  String? lastName;
@override final  String? pesel;
/// Shown by the official client when [pesel] is empty. Never captured,
/// so the format is unknown and the value is kept as sent.
@override final  String? birthDate;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionCustomerDetail&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.pesel, pesel) || other.pesel == pesel)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.email, email) || other.email == email)&&(identical(other.cityCardCode, cityCardCode) || other.cityCardCode == cityCardCode)&&(identical(other.clientCode, clientCode) || other.clientCode == clientCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName,pesel,birthDate,email,cityCardCode,clientCode);
}

@override
String toString() {
    return 'SubscriptionCustomerDetail(firstName: $firstName, lastName: $lastName, pesel: $pesel, birthDate: $birthDate, email: $email, cityCardCode: $cityCardCode, clientCode: $clientCode)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionCustomerDetailCopyWith<$Res> implements $SubscriptionCustomerDetailCopyWith<$Res> {
  factory _$SubscriptionCustomerDetailCopyWith(_SubscriptionCustomerDetail value, $Res Function(_SubscriptionCustomerDetail) _then) = __$SubscriptionCustomerDetailCopyWithImpl;
@override @useResult
$Res call({
 String? firstName, String? lastName, String? pesel, String? birthDate, String? email, int? cityCardCode, int? clientCode
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
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? pesel = freezed,Object? birthDate = freezed,Object? email = freezed,Object? cityCardCode = freezed,Object? clientCode = freezed,}) {
  return _then(_SubscriptionCustomerDetail(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,pesel: freezed == pesel ? _self.pesel : pesel // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
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


/// @nodoc
mixin _$SubscriptionTicketSavedOnCard {

 DateTime? get dateStart; DateTime? get dateEnd;
/// Create a copy of SubscriptionTicketSavedOnCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionTicketSavedOnCardCopyWith<SubscriptionTicketSavedOnCard> get copyWith => _$SubscriptionTicketSavedOnCardCopyWithImpl<SubscriptionTicketSavedOnCard>(this as SubscriptionTicketSavedOnCard, _$identity);

  /// Serializes this SubscriptionTicketSavedOnCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionTicketSavedOnCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionTicketSavedOnCard&&(identical(other.dateStart, _this.dateStart) || other.dateStart == _this.dateStart)&&(identical(other.dateEnd, _this.dateEnd) || other.dateEnd == _this.dateEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionTicketSavedOnCard;
  return Object.hash(runtimeType,_this.dateStart,_this.dateEnd);
}

@override
String toString() {
  final _this = this as SubscriptionTicketSavedOnCard;
  return 'SubscriptionTicketSavedOnCard(dateStart: ${_this.dateStart}, dateEnd: ${_this.dateEnd})';
}


}

/// @nodoc
abstract mixin class $SubscriptionTicketSavedOnCardCopyWith<$Res>  {
  factory $SubscriptionTicketSavedOnCardCopyWith(SubscriptionTicketSavedOnCard value, $Res Function(SubscriptionTicketSavedOnCard) _then) = _$SubscriptionTicketSavedOnCardCopyWithImpl;
@useResult
$Res call({
 DateTime? dateStart, DateTime? dateEnd
});




}
/// @nodoc
class _$SubscriptionTicketSavedOnCardCopyWithImpl<$Res>
    implements $SubscriptionTicketSavedOnCardCopyWith<$Res> {
  _$SubscriptionTicketSavedOnCardCopyWithImpl(this._self, this._then);

  final SubscriptionTicketSavedOnCard _self;
  final $Res Function(SubscriptionTicketSavedOnCard) _then;

/// Create a copy of SubscriptionTicketSavedOnCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateStart = freezed,Object? dateEnd = freezed,}) {
  return _then(SubscriptionTicketSavedOnCard(
dateStart: freezed == dateStart ? _self.dateStart : dateStart // ignore: cast_nullable_to_non_nullable
as DateTime?,dateEnd: freezed == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionTicketSavedOnCard].
extension SubscriptionTicketSavedOnCardPatterns on SubscriptionTicketSavedOnCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionTicketSavedOnCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionTicketSavedOnCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionTicketSavedOnCard value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicketSavedOnCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionTicketSavedOnCard value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicketSavedOnCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? dateStart,  DateTime? dateEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionTicketSavedOnCard() when $default != null:
return $default(_that.dateStart,_that.dateEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? dateStart,  DateTime? dateEnd)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicketSavedOnCard():
return $default(_that.dateStart,_that.dateEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? dateStart,  DateTime? dateEnd)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicketSavedOnCard() when $default != null:
return $default(_that.dateStart,_that.dateEnd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionTicketSavedOnCard implements SubscriptionTicketSavedOnCard {
  const _SubscriptionTicketSavedOnCard({this.dateStart, this.dateEnd});
  factory _SubscriptionTicketSavedOnCard.fromJson(Map<String, dynamic> json) => _$SubscriptionTicketSavedOnCardFromJson(json);

@override final  DateTime? dateStart;
@override final  DateTime? dateEnd;

/// Create a copy of SubscriptionTicketSavedOnCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionTicketSavedOnCardCopyWith<_SubscriptionTicketSavedOnCard> get copyWith => __$SubscriptionTicketSavedOnCardCopyWithImpl<_SubscriptionTicketSavedOnCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionTicketSavedOnCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionTicketSavedOnCard&&(identical(other.dateStart, dateStart) || other.dateStart == dateStart)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dateStart,dateEnd);
}

@override
String toString() {
    return 'SubscriptionTicketSavedOnCard(dateStart: $dateStart, dateEnd: $dateEnd)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionTicketSavedOnCardCopyWith<$Res> implements $SubscriptionTicketSavedOnCardCopyWith<$Res> {
  factory _$SubscriptionTicketSavedOnCardCopyWith(_SubscriptionTicketSavedOnCard value, $Res Function(_SubscriptionTicketSavedOnCard) _then) = __$SubscriptionTicketSavedOnCardCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateStart, DateTime? dateEnd
});




}
/// @nodoc
class __$SubscriptionTicketSavedOnCardCopyWithImpl<$Res>
    implements _$SubscriptionTicketSavedOnCardCopyWith<$Res> {
  __$SubscriptionTicketSavedOnCardCopyWithImpl(this._self, this._then);

  final _SubscriptionTicketSavedOnCard _self;
  final $Res Function(_SubscriptionTicketSavedOnCard) _then;

/// Create a copy of SubscriptionTicketSavedOnCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateStart = freezed,Object? dateEnd = freezed,}) {
  return _then(_SubscriptionTicketSavedOnCard(
dateStart: freezed == dateStart ? _self.dateStart : dateStart // ignore: cast_nullable_to_non_nullable
as DateTime?,dateEnd: freezed == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SubscriptionBuyingTicketDetails {

 String? get commodityName; double? get price; SubscriptionTicketSavedOnCard? get ticketSavedOnCard;
/// Create a copy of SubscriptionBuyingTicketDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionBuyingTicketDetailsCopyWith<SubscriptionBuyingTicketDetails> get copyWith => _$SubscriptionBuyingTicketDetailsCopyWithImpl<SubscriptionBuyingTicketDetails>(this as SubscriptionBuyingTicketDetails, _$identity);

  /// Serializes this SubscriptionBuyingTicketDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionBuyingTicketDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionBuyingTicketDetails&&(identical(other.commodityName, _this.commodityName) || other.commodityName == _this.commodityName)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.ticketSavedOnCard, _this.ticketSavedOnCard) || other.ticketSavedOnCard == _this.ticketSavedOnCard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionBuyingTicketDetails;
  return Object.hash(runtimeType,_this.commodityName,_this.price,_this.ticketSavedOnCard);
}

@override
String toString() {
  final _this = this as SubscriptionBuyingTicketDetails;
  return 'SubscriptionBuyingTicketDetails(commodityName: ${_this.commodityName}, price: ${_this.price}, ticketSavedOnCard: ${_this.ticketSavedOnCard})';
}


}

/// @nodoc
abstract mixin class $SubscriptionBuyingTicketDetailsCopyWith<$Res>  {
  factory $SubscriptionBuyingTicketDetailsCopyWith(SubscriptionBuyingTicketDetails value, $Res Function(SubscriptionBuyingTicketDetails) _then) = _$SubscriptionBuyingTicketDetailsCopyWithImpl;
@useResult
$Res call({
 String? commodityName, double? price, SubscriptionTicketSavedOnCard? ticketSavedOnCard
});


$SubscriptionTicketSavedOnCardCopyWith<$Res>? get ticketSavedOnCard;

}
/// @nodoc
class _$SubscriptionBuyingTicketDetailsCopyWithImpl<$Res>
    implements $SubscriptionBuyingTicketDetailsCopyWith<$Res> {
  _$SubscriptionBuyingTicketDetailsCopyWithImpl(this._self, this._then);

  final SubscriptionBuyingTicketDetails _self;
  final $Res Function(SubscriptionBuyingTicketDetails) _then;

/// Create a copy of SubscriptionBuyingTicketDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commodityName = freezed,Object? price = freezed,Object? ticketSavedOnCard = freezed,}) {
  return _then(SubscriptionBuyingTicketDetails(
commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,ticketSavedOnCard: freezed == ticketSavedOnCard ? _self.ticketSavedOnCard : ticketSavedOnCard // ignore: cast_nullable_to_non_nullable
as SubscriptionTicketSavedOnCard?,
  ));
}
/// Create a copy of SubscriptionBuyingTicketDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionTicketSavedOnCardCopyWith<$Res>? get ticketSavedOnCard {
    if (_self.ticketSavedOnCard == null) {
    return null;
  }

  return $SubscriptionTicketSavedOnCardCopyWith<$Res>(_self.ticketSavedOnCard!, (value) {
    return _then(_self.copyWith(ticketSavedOnCard: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionBuyingTicketDetails].
extension SubscriptionBuyingTicketDetailsPatterns on SubscriptionBuyingTicketDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionBuyingTicketDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionBuyingTicketDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionBuyingTicketDetails value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionBuyingTicketDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionBuyingTicketDetails value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionBuyingTicketDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? commodityName,  double? price,  SubscriptionTicketSavedOnCard? ticketSavedOnCard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionBuyingTicketDetails() when $default != null:
return $default(_that.commodityName,_that.price,_that.ticketSavedOnCard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? commodityName,  double? price,  SubscriptionTicketSavedOnCard? ticketSavedOnCard)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionBuyingTicketDetails():
return $default(_that.commodityName,_that.price,_that.ticketSavedOnCard);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? commodityName,  double? price,  SubscriptionTicketSavedOnCard? ticketSavedOnCard)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionBuyingTicketDetails() when $default != null:
return $default(_that.commodityName,_that.price,_that.ticketSavedOnCard);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionBuyingTicketDetails implements SubscriptionBuyingTicketDetails {
  const _SubscriptionBuyingTicketDetails({this.commodityName, this.price, this.ticketSavedOnCard});
  factory _SubscriptionBuyingTicketDetails.fromJson(Map<String, dynamic> json) => _$SubscriptionBuyingTicketDetailsFromJson(json);

@override final  String? commodityName;
@override final  double? price;
@override final  SubscriptionTicketSavedOnCard? ticketSavedOnCard;

/// Create a copy of SubscriptionBuyingTicketDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionBuyingTicketDetailsCopyWith<_SubscriptionBuyingTicketDetails> get copyWith => __$SubscriptionBuyingTicketDetailsCopyWithImpl<_SubscriptionBuyingTicketDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionBuyingTicketDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionBuyingTicketDetails&&(identical(other.commodityName, commodityName) || other.commodityName == commodityName)&&(identical(other.price, price) || other.price == price)&&(identical(other.ticketSavedOnCard, ticketSavedOnCard) || other.ticketSavedOnCard == ticketSavedOnCard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,commodityName,price,ticketSavedOnCard);
}

@override
String toString() {
    return 'SubscriptionBuyingTicketDetails(commodityName: $commodityName, price: $price, ticketSavedOnCard: $ticketSavedOnCard)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionBuyingTicketDetailsCopyWith<$Res> implements $SubscriptionBuyingTicketDetailsCopyWith<$Res> {
  factory _$SubscriptionBuyingTicketDetailsCopyWith(_SubscriptionBuyingTicketDetails value, $Res Function(_SubscriptionBuyingTicketDetails) _then) = __$SubscriptionBuyingTicketDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? commodityName, double? price, SubscriptionTicketSavedOnCard? ticketSavedOnCard
});


@override $SubscriptionTicketSavedOnCardCopyWith<$Res>? get ticketSavedOnCard;

}
/// @nodoc
class __$SubscriptionBuyingTicketDetailsCopyWithImpl<$Res>
    implements _$SubscriptionBuyingTicketDetailsCopyWith<$Res> {
  __$SubscriptionBuyingTicketDetailsCopyWithImpl(this._self, this._then);

  final _SubscriptionBuyingTicketDetails _self;
  final $Res Function(_SubscriptionBuyingTicketDetails) _then;

/// Create a copy of SubscriptionBuyingTicketDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commodityName = freezed,Object? price = freezed,Object? ticketSavedOnCard = freezed,}) {
  return _then(_SubscriptionBuyingTicketDetails(
commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,ticketSavedOnCard: freezed == ticketSavedOnCard ? _self.ticketSavedOnCard : ticketSavedOnCard // ignore: cast_nullable_to_non_nullable
as SubscriptionTicketSavedOnCard?,
  ));
}

/// Create a copy of SubscriptionBuyingTicketDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionTicketSavedOnCardCopyWith<$Res>? get ticketSavedOnCard {
    if (_self.ticketSavedOnCard == null) {
    return null;
  }

  return $SubscriptionTicketSavedOnCardCopyWith<$Res>(_self.ticketSavedOnCard!, (value) {
    return _then(_self.copyWith(ticketSavedOnCard: value));
  });
}
}


/// @nodoc
mixin _$SubscriptionTicketBuyResponse {

 String? get commodityName; double? get price; DateTime? get ticketStartDate; DateTime? get ticketEndDate;/// tpay payment page for the first charge — lowercase `p`, unlike
/// `ChangePaymentCardResponse.tPayRedirectUrl`.
 String? get tpayRedirectUrl; Object? get code; String? get message;
/// Create a copy of SubscriptionTicketBuyResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionTicketBuyResponseCopyWith<SubscriptionTicketBuyResponse> get copyWith => _$SubscriptionTicketBuyResponseCopyWithImpl<SubscriptionTicketBuyResponse>(this as SubscriptionTicketBuyResponse, _$identity);

  /// Serializes this SubscriptionTicketBuyResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionTicketBuyResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionTicketBuyResponse&&(identical(other.commodityName, _this.commodityName) || other.commodityName == _this.commodityName)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.ticketStartDate, _this.ticketStartDate) || other.ticketStartDate == _this.ticketStartDate)&&(identical(other.ticketEndDate, _this.ticketEndDate) || other.ticketEndDate == _this.ticketEndDate)&&(identical(other.tpayRedirectUrl, _this.tpayRedirectUrl) || other.tpayRedirectUrl == _this.tpayRedirectUrl)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionTicketBuyResponse;
  return Object.hash(runtimeType,_this.commodityName,_this.price,_this.ticketStartDate,_this.ticketEndDate,_this.tpayRedirectUrl,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as SubscriptionTicketBuyResponse;
  return 'SubscriptionTicketBuyResponse(commodityName: ${_this.commodityName}, price: ${_this.price}, ticketStartDate: ${_this.ticketStartDate}, ticketEndDate: ${_this.ticketEndDate}, tpayRedirectUrl: ${_this.tpayRedirectUrl}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $SubscriptionTicketBuyResponseCopyWith<$Res>  {
  factory $SubscriptionTicketBuyResponseCopyWith(SubscriptionTicketBuyResponse value, $Res Function(SubscriptionTicketBuyResponse) _then) = _$SubscriptionTicketBuyResponseCopyWithImpl;
@useResult
$Res call({
 String? commodityName, double? price, DateTime? ticketStartDate, DateTime? ticketEndDate, String? tpayRedirectUrl, Object? code, String? message
});




}
/// @nodoc
class _$SubscriptionTicketBuyResponseCopyWithImpl<$Res>
    implements $SubscriptionTicketBuyResponseCopyWith<$Res> {
  _$SubscriptionTicketBuyResponseCopyWithImpl(this._self, this._then);

  final SubscriptionTicketBuyResponse _self;
  final $Res Function(SubscriptionTicketBuyResponse) _then;

/// Create a copy of SubscriptionTicketBuyResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commodityName = freezed,Object? price = freezed,Object? ticketStartDate = freezed,Object? ticketEndDate = freezed,Object? tpayRedirectUrl = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(SubscriptionTicketBuyResponse(
commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,ticketStartDate: freezed == ticketStartDate ? _self.ticketStartDate : ticketStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketEndDate: freezed == ticketEndDate ? _self.ticketEndDate : ticketEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,tpayRedirectUrl: freezed == tpayRedirectUrl ? _self.tpayRedirectUrl : tpayRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionTicketBuyResponse].
extension SubscriptionTicketBuyResponsePatterns on SubscriptionTicketBuyResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionTicketBuyResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionTicketBuyResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionTicketBuyResponse value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicketBuyResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionTicketBuyResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicketBuyResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? commodityName,  double? price,  DateTime? ticketStartDate,  DateTime? ticketEndDate,  String? tpayRedirectUrl,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionTicketBuyResponse() when $default != null:
return $default(_that.commodityName,_that.price,_that.ticketStartDate,_that.ticketEndDate,_that.tpayRedirectUrl,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? commodityName,  double? price,  DateTime? ticketStartDate,  DateTime? ticketEndDate,  String? tpayRedirectUrl,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicketBuyResponse():
return $default(_that.commodityName,_that.price,_that.ticketStartDate,_that.ticketEndDate,_that.tpayRedirectUrl,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? commodityName,  double? price,  DateTime? ticketStartDate,  DateTime? ticketEndDate,  String? tpayRedirectUrl,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicketBuyResponse() when $default != null:
return $default(_that.commodityName,_that.price,_that.ticketStartDate,_that.ticketEndDate,_that.tpayRedirectUrl,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionTicketBuyResponse extends SubscriptionTicketBuyResponse {
  const _SubscriptionTicketBuyResponse({this.commodityName, this.price, this.ticketStartDate, this.ticketEndDate, this.tpayRedirectUrl, this.code, this.message}): super._();
  factory _SubscriptionTicketBuyResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionTicketBuyResponseFromJson(json);

@override final  String? commodityName;
@override final  double? price;
@override final  DateTime? ticketStartDate;
@override final  DateTime? ticketEndDate;
/// tpay payment page for the first charge — lowercase `p`, unlike
/// `ChangePaymentCardResponse.tPayRedirectUrl`.
@override final  String? tpayRedirectUrl;
@override final  Object? code;
@override final  String? message;

/// Create a copy of SubscriptionTicketBuyResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionTicketBuyResponseCopyWith<_SubscriptionTicketBuyResponse> get copyWith => __$SubscriptionTicketBuyResponseCopyWithImpl<_SubscriptionTicketBuyResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionTicketBuyResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionTicketBuyResponse&&(identical(other.commodityName, commodityName) || other.commodityName == commodityName)&&(identical(other.price, price) || other.price == price)&&(identical(other.ticketStartDate, ticketStartDate) || other.ticketStartDate == ticketStartDate)&&(identical(other.ticketEndDate, ticketEndDate) || other.ticketEndDate == ticketEndDate)&&(identical(other.tpayRedirectUrl, tpayRedirectUrl) || other.tpayRedirectUrl == tpayRedirectUrl)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,commodityName,price,ticketStartDate,ticketEndDate,tpayRedirectUrl,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'SubscriptionTicketBuyResponse(commodityName: $commodityName, price: $price, ticketStartDate: $ticketStartDate, ticketEndDate: $ticketEndDate, tpayRedirectUrl: $tpayRedirectUrl, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionTicketBuyResponseCopyWith<$Res> implements $SubscriptionTicketBuyResponseCopyWith<$Res> {
  factory _$SubscriptionTicketBuyResponseCopyWith(_SubscriptionTicketBuyResponse value, $Res Function(_SubscriptionTicketBuyResponse) _then) = __$SubscriptionTicketBuyResponseCopyWithImpl;
@override @useResult
$Res call({
 String? commodityName, double? price, DateTime? ticketStartDate, DateTime? ticketEndDate, String? tpayRedirectUrl, Object? code, String? message
});




}
/// @nodoc
class __$SubscriptionTicketBuyResponseCopyWithImpl<$Res>
    implements _$SubscriptionTicketBuyResponseCopyWith<$Res> {
  __$SubscriptionTicketBuyResponseCopyWithImpl(this._self, this._then);

  final _SubscriptionTicketBuyResponse _self;
  final $Res Function(_SubscriptionTicketBuyResponse) _then;

/// Create a copy of SubscriptionTicketBuyResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commodityName = freezed,Object? price = freezed,Object? ticketStartDate = freezed,Object? ticketEndDate = freezed,Object? tpayRedirectUrl = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_SubscriptionTicketBuyResponse(
commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,ticketStartDate: freezed == ticketStartDate ? _self.ticketStartDate : ticketStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketEndDate: freezed == ticketEndDate ? _self.ticketEndDate : ticketEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,tpayRedirectUrl: freezed == tpayRedirectUrl ? _self.tpayRedirectUrl : tpayRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SubscriptionTicketPayResponse {

/// tpay payment page; null when [needsRepaymentConfirmation].
 String? get tpayRedirectUrl; Object? get code; String? get message;
/// Create a copy of SubscriptionTicketPayResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionTicketPayResponseCopyWith<SubscriptionTicketPayResponse> get copyWith => _$SubscriptionTicketPayResponseCopyWithImpl<SubscriptionTicketPayResponse>(this as SubscriptionTicketPayResponse, _$identity);

  /// Serializes this SubscriptionTicketPayResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionTicketPayResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionTicketPayResponse&&(identical(other.tpayRedirectUrl, _this.tpayRedirectUrl) || other.tpayRedirectUrl == _this.tpayRedirectUrl)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionTicketPayResponse;
  return Object.hash(runtimeType,_this.tpayRedirectUrl,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as SubscriptionTicketPayResponse;
  return 'SubscriptionTicketPayResponse(tpayRedirectUrl: ${_this.tpayRedirectUrl}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $SubscriptionTicketPayResponseCopyWith<$Res>  {
  factory $SubscriptionTicketPayResponseCopyWith(SubscriptionTicketPayResponse value, $Res Function(SubscriptionTicketPayResponse) _then) = _$SubscriptionTicketPayResponseCopyWithImpl;
@useResult
$Res call({
 String? tpayRedirectUrl, Object? code, String? message
});




}
/// @nodoc
class _$SubscriptionTicketPayResponseCopyWithImpl<$Res>
    implements $SubscriptionTicketPayResponseCopyWith<$Res> {
  _$SubscriptionTicketPayResponseCopyWithImpl(this._self, this._then);

  final SubscriptionTicketPayResponse _self;
  final $Res Function(SubscriptionTicketPayResponse) _then;

/// Create a copy of SubscriptionTicketPayResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tpayRedirectUrl = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(SubscriptionTicketPayResponse(
tpayRedirectUrl: freezed == tpayRedirectUrl ? _self.tpayRedirectUrl : tpayRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionTicketPayResponse].
extension SubscriptionTicketPayResponsePatterns on SubscriptionTicketPayResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionTicketPayResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionTicketPayResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionTicketPayResponse value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicketPayResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionTicketPayResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionTicketPayResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tpayRedirectUrl,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionTicketPayResponse() when $default != null:
return $default(_that.tpayRedirectUrl,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tpayRedirectUrl,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicketPayResponse():
return $default(_that.tpayRedirectUrl,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tpayRedirectUrl,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionTicketPayResponse() when $default != null:
return $default(_that.tpayRedirectUrl,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionTicketPayResponse extends SubscriptionTicketPayResponse {
  const _SubscriptionTicketPayResponse({this.tpayRedirectUrl, this.code, this.message}): super._();
  factory _SubscriptionTicketPayResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionTicketPayResponseFromJson(json);

/// tpay payment page; null when [needsRepaymentConfirmation].
@override final  String? tpayRedirectUrl;
@override final  Object? code;
@override final  String? message;

/// Create a copy of SubscriptionTicketPayResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionTicketPayResponseCopyWith<_SubscriptionTicketPayResponse> get copyWith => __$SubscriptionTicketPayResponseCopyWithImpl<_SubscriptionTicketPayResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionTicketPayResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionTicketPayResponse&&(identical(other.tpayRedirectUrl, tpayRedirectUrl) || other.tpayRedirectUrl == tpayRedirectUrl)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tpayRedirectUrl,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'SubscriptionTicketPayResponse(tpayRedirectUrl: $tpayRedirectUrl, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionTicketPayResponseCopyWith<$Res> implements $SubscriptionTicketPayResponseCopyWith<$Res> {
  factory _$SubscriptionTicketPayResponseCopyWith(_SubscriptionTicketPayResponse value, $Res Function(_SubscriptionTicketPayResponse) _then) = __$SubscriptionTicketPayResponseCopyWithImpl;
@override @useResult
$Res call({
 String? tpayRedirectUrl, Object? code, String? message
});




}
/// @nodoc
class __$SubscriptionTicketPayResponseCopyWithImpl<$Res>
    implements _$SubscriptionTicketPayResponseCopyWith<$Res> {
  __$SubscriptionTicketPayResponseCopyWithImpl(this._self, this._then);

  final _SubscriptionTicketPayResponse _self;
  final $Res Function(_SubscriptionTicketPayResponse) _then;

/// Create a copy of SubscriptionTicketPayResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tpayRedirectUrl = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_SubscriptionTicketPayResponse(
tpayRedirectUrl: freezed == tpayRedirectUrl ? _self.tpayRedirectUrl : tpayRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
