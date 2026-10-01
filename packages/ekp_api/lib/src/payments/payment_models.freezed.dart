// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bank {

/// tpay group id, e.g. `150` = BLIK, `103` = card.
 String? get id; String? get name; String? get banks; String? get img;@JsonKey(name: 'main_bank_id') String? get mainBankId;@JsonKey(name: 'available_via_webview') bool? get availableViaWebview;
/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankCopyWith<Bank> get copyWith => _$BankCopyWithImpl<Bank>(this as Bank, _$identity);

  /// Serializes this Bank to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Bank;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bank&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.banks, _this.banks) || other.banks == _this.banks)&&(identical(other.img, _this.img) || other.img == _this.img)&&(identical(other.mainBankId, _this.mainBankId) || other.mainBankId == _this.mainBankId)&&(identical(other.availableViaWebview, _this.availableViaWebview) || other.availableViaWebview == _this.availableViaWebview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Bank;
  return Object.hash(runtimeType,_this.id,_this.name,_this.banks,_this.img,_this.mainBankId,_this.availableViaWebview);
}

@override
String toString() {
  final _this = this as Bank;
  return 'Bank(id: ${_this.id}, name: ${_this.name}, banks: ${_this.banks}, img: ${_this.img}, mainBankId: ${_this.mainBankId}, availableViaWebview: ${_this.availableViaWebview})';
}


}

/// @nodoc
abstract mixin class $BankCopyWith<$Res>  {
  factory $BankCopyWith(Bank value, $Res Function(Bank) _then) = _$BankCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? banks, String? img,@JsonKey(name: 'main_bank_id') String? mainBankId,@JsonKey(name: 'available_via_webview') bool? availableViaWebview
});




}
/// @nodoc
class _$BankCopyWithImpl<$Res>
    implements $BankCopyWith<$Res> {
  _$BankCopyWithImpl(this._self, this._then);

  final Bank _self;
  final $Res Function(Bank) _then;

/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? banks = freezed,Object? img = freezed,Object? mainBankId = freezed,Object? availableViaWebview = freezed,}) {
  return _then(Bank(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,banks: freezed == banks ? _self.banks : banks // ignore: cast_nullable_to_non_nullable
as String?,img: freezed == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String?,mainBankId: freezed == mainBankId ? _self.mainBankId : mainBankId // ignore: cast_nullable_to_non_nullable
as String?,availableViaWebview: freezed == availableViaWebview ? _self.availableViaWebview : availableViaWebview // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [Bank].
extension BankPatterns on Bank {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bank value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bank() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bank value)  $default,){
final _that = this;
switch (_that) {
case _Bank():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bank value)?  $default,){
final _that = this;
switch (_that) {
case _Bank() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? banks,  String? img, @JsonKey(name: 'main_bank_id')  String? mainBankId, @JsonKey(name: 'available_via_webview')  bool? availableViaWebview)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bank() when $default != null:
return $default(_that.id,_that.name,_that.banks,_that.img,_that.mainBankId,_that.availableViaWebview);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? banks,  String? img, @JsonKey(name: 'main_bank_id')  String? mainBankId, @JsonKey(name: 'available_via_webview')  bool? availableViaWebview)  $default,) {final _that = this;
switch (_that) {
case _Bank():
return $default(_that.id,_that.name,_that.banks,_that.img,_that.mainBankId,_that.availableViaWebview);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? banks,  String? img, @JsonKey(name: 'main_bank_id')  String? mainBankId, @JsonKey(name: 'available_via_webview')  bool? availableViaWebview)?  $default,) {final _that = this;
switch (_that) {
case _Bank() when $default != null:
return $default(_that.id,_that.name,_that.banks,_that.img,_that.mainBankId,_that.availableViaWebview);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bank extends Bank {
  const _Bank({this.id, this.name, this.banks, this.img, @JsonKey(name: 'main_bank_id') this.mainBankId, @JsonKey(name: 'available_via_webview') this.availableViaWebview}): super._();
  factory _Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

/// tpay group id, e.g. `150` = BLIK, `103` = card.
@override final  String? id;
@override final  String? name;
@override final  String? banks;
@override final  String? img;
@override@JsonKey(name: 'main_bank_id') final  String? mainBankId;
@override@JsonKey(name: 'available_via_webview') final  bool? availableViaWebview;

/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankCopyWith<_Bank> get copyWith => __$BankCopyWithImpl<_Bank>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BankToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bank&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.banks, banks) || other.banks == banks)&&(identical(other.img, img) || other.img == img)&&(identical(other.mainBankId, mainBankId) || other.mainBankId == mainBankId)&&(identical(other.availableViaWebview, availableViaWebview) || other.availableViaWebview == availableViaWebview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,banks,img,mainBankId,availableViaWebview);
}

@override
String toString() {
    return 'Bank(id: $id, name: $name, banks: $banks, img: $img, mainBankId: $mainBankId, availableViaWebview: $availableViaWebview)';
}


}

/// @nodoc
abstract mixin class _$BankCopyWith<$Res> implements $BankCopyWith<$Res> {
  factory _$BankCopyWith(_Bank value, $Res Function(_Bank) _then) = __$BankCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? banks, String? img,@JsonKey(name: 'main_bank_id') String? mainBankId,@JsonKey(name: 'available_via_webview') bool? availableViaWebview
});




}
/// @nodoc
class __$BankCopyWithImpl<$Res>
    implements _$BankCopyWith<$Res> {
  __$BankCopyWithImpl(this._self, this._then);

  final _Bank _self;
  final $Res Function(_Bank) _then;

/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? banks = freezed,Object? img = freezed,Object? mainBankId = freezed,Object? availableViaWebview = freezed,}) {
  return _then(_Bank(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,banks: freezed == banks ? _self.banks : banks // ignore: cast_nullable_to_non_nullable
as String?,img: freezed == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String?,mainBankId: freezed == mainBankId ? _self.mainBankId : mainBankId // ignore: cast_nullable_to_non_nullable
as String?,availableViaWebview: freezed == availableViaWebview ? _self.availableViaWebview : availableViaWebview // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$BankListResponse {

 List<Bank> get list;
/// Create a copy of BankListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankListResponseCopyWith<BankListResponse> get copyWith => _$BankListResponseCopyWithImpl<BankListResponse>(this as BankListResponse, _$identity);

  /// Serializes this BankListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BankListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BankListResponse&&const DeepCollectionEquality().equals(other.list, _this.list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BankListResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.list));
}

@override
String toString() {
  final _this = this as BankListResponse;
  return 'BankListResponse(list: ${_this.list})';
}


}

/// @nodoc
abstract mixin class $BankListResponseCopyWith<$Res>  {
  factory $BankListResponseCopyWith(BankListResponse value, $Res Function(BankListResponse) _then) = _$BankListResponseCopyWithImpl;
@useResult
$Res call({
 List<Bank> list
});




}
/// @nodoc
class _$BankListResponseCopyWithImpl<$Res>
    implements $BankListResponseCopyWith<$Res> {
  _$BankListResponseCopyWithImpl(this._self, this._then);

  final BankListResponse _self;
  final $Res Function(BankListResponse) _then;

/// Create a copy of BankListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(BankListResponse(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<Bank>,
  ));
}

}


/// Adds pattern-matching-related methods to [BankListResponse].
extension BankListResponsePatterns on BankListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BankListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BankListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BankListResponse value)  $default,){
final _that = this;
switch (_that) {
case _BankListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BankListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BankListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Bank> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BankListResponse() when $default != null:
return $default(_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Bank> list)  $default,) {final _that = this;
switch (_that) {
case _BankListResponse():
return $default(_that.list);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Bank> list)?  $default,) {final _that = this;
switch (_that) {
case _BankListResponse() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BankListResponse implements BankListResponse {
  const _BankListResponse({ List<Bank> list = const <Bank>[]}): _list = list;
  factory _BankListResponse.fromJson(Map<String, dynamic> json) => _$BankListResponseFromJson(json);

 final  List<Bank> _list;
@override@JsonKey() List<Bank> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of BankListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankListResponseCopyWith<_BankListResponse> get copyWith => __$BankListResponseCopyWithImpl<_BankListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BankListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankListResponse&&const DeepCollectionEquality().equals(other.list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));
}

@override
String toString() {
    return 'BankListResponse(list: $list)';
}


}

/// @nodoc
abstract mixin class _$BankListResponseCopyWith<$Res> implements $BankListResponseCopyWith<$Res> {
  factory _$BankListResponseCopyWith(_BankListResponse value, $Res Function(_BankListResponse) _then) = __$BankListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Bank> list
});




}
/// @nodoc
class __$BankListResponseCopyWithImpl<$Res>
    implements _$BankListResponseCopyWith<$Res> {
  __$BankListResponseCopyWithImpl(this._self, this._then);

  final _BankListResponse _self;
  final $Res Function(_BankListResponse) _then;

/// Create a copy of BankListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_BankListResponse(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<Bank>,
  ));
}


}

/// @nodoc
mixin _$PaymentCheckResult {

 PaymentCheckStatus get status; String? get message; Object? get code;
/// Create a copy of PaymentCheckResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCheckResultCopyWith<PaymentCheckResult> get copyWith => _$PaymentCheckResultCopyWithImpl<PaymentCheckResult>(this as PaymentCheckResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PaymentCheckResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentCheckResult&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.code, _this.code));
}


@override
int get hashCode {
  final _this = this as PaymentCheckResult;
  return Object.hash(runtimeType,_this.status,_this.message,const DeepCollectionEquality().hash(_this.code));
}

@override
String toString() {
  final _this = this as PaymentCheckResult;
  return 'PaymentCheckResult(status: ${_this.status}, message: ${_this.message}, code: ${_this.code})';
}


}

/// @nodoc
abstract mixin class $PaymentCheckResultCopyWith<$Res>  {
  factory $PaymentCheckResultCopyWith(PaymentCheckResult value, $Res Function(PaymentCheckResult) _then) = _$PaymentCheckResultCopyWithImpl;
@useResult
$Res call({
 PaymentCheckStatus status, String? message, Object? code
});




}
/// @nodoc
class _$PaymentCheckResultCopyWithImpl<$Res>
    implements $PaymentCheckResultCopyWith<$Res> {
  _$PaymentCheckResultCopyWithImpl(this._self, this._then);

  final PaymentCheckResult _self;
  final $Res Function(PaymentCheckResult) _then;

/// Create a copy of PaymentCheckResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = freezed,Object? code = freezed,}) {
  return _then(PaymentCheckResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentCheckStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentCheckResult].
extension PaymentCheckResultPatterns on PaymentCheckResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentCheckResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentCheckResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentCheckResult value)  $default,){
final _that = this;
switch (_that) {
case _PaymentCheckResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentCheckResult value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentCheckResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentCheckStatus status,  String? message,  Object? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentCheckResult() when $default != null:
return $default(_that.status,_that.message,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentCheckStatus status,  String? message,  Object? code)  $default,) {final _that = this;
switch (_that) {
case _PaymentCheckResult():
return $default(_that.status,_that.message,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentCheckStatus status,  String? message,  Object? code)?  $default,) {final _that = this;
switch (_that) {
case _PaymentCheckResult() when $default != null:
return $default(_that.status,_that.message,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentCheckResult implements PaymentCheckResult {
  const _PaymentCheckResult({required this.status, this.message, this.code});
  

@override final  PaymentCheckStatus status;
@override final  String? message;
@override final  Object? code;

/// Create a copy of PaymentCheckResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCheckResultCopyWith<_PaymentCheckResult> get copyWith => __$PaymentCheckResultCopyWithImpl<_PaymentCheckResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentCheckResult&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.code, code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(code));
}

@override
String toString() {
    return 'PaymentCheckResult(status: $status, message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class _$PaymentCheckResultCopyWith<$Res> implements $PaymentCheckResultCopyWith<$Res> {
  factory _$PaymentCheckResultCopyWith(_PaymentCheckResult value, $Res Function(_PaymentCheckResult) _then) = __$PaymentCheckResultCopyWithImpl;
@override @useResult
$Res call({
 PaymentCheckStatus status, String? message, Object? code
});




}
/// @nodoc
class __$PaymentCheckResultCopyWithImpl<$Res>
    implements _$PaymentCheckResultCopyWith<$Res> {
  __$PaymentCheckResultCopyWithImpl(this._self, this._then);

  final _PaymentCheckResult _self;
  final $Res Function(_PaymentCheckResult) _then;

/// Create a copy of PaymentCheckResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = freezed,Object? code = freezed,}) {
  return _then(_PaymentCheckResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentCheckStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,
  ));
}


}


/// @nodoc
mixin _$ChangePaymentCardResponse {

/// tpay card-management page, e.g.
/// `https://secure.tpay.com/cards/?sale_auth=<token>`.
 String? get tPayRedirectUrl;
/// Create a copy of ChangePaymentCardResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePaymentCardResponseCopyWith<ChangePaymentCardResponse> get copyWith => _$ChangePaymentCardResponseCopyWithImpl<ChangePaymentCardResponse>(this as ChangePaymentCardResponse, _$identity);

  /// Serializes this ChangePaymentCardResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChangePaymentCardResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePaymentCardResponse&&(identical(other.tPayRedirectUrl, _this.tPayRedirectUrl) || other.tPayRedirectUrl == _this.tPayRedirectUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChangePaymentCardResponse;
  return Object.hash(runtimeType,_this.tPayRedirectUrl);
}

@override
String toString() {
  final _this = this as ChangePaymentCardResponse;
  return 'ChangePaymentCardResponse(tPayRedirectUrl: ${_this.tPayRedirectUrl})';
}


}

/// @nodoc
abstract mixin class $ChangePaymentCardResponseCopyWith<$Res>  {
  factory $ChangePaymentCardResponseCopyWith(ChangePaymentCardResponse value, $Res Function(ChangePaymentCardResponse) _then) = _$ChangePaymentCardResponseCopyWithImpl;
@useResult
$Res call({
 String? tPayRedirectUrl
});




}
/// @nodoc
class _$ChangePaymentCardResponseCopyWithImpl<$Res>
    implements $ChangePaymentCardResponseCopyWith<$Res> {
  _$ChangePaymentCardResponseCopyWithImpl(this._self, this._then);

  final ChangePaymentCardResponse _self;
  final $Res Function(ChangePaymentCardResponse) _then;

/// Create a copy of ChangePaymentCardResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tPayRedirectUrl = freezed,}) {
  return _then(ChangePaymentCardResponse(
tPayRedirectUrl: freezed == tPayRedirectUrl ? _self.tPayRedirectUrl : tPayRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePaymentCardResponse].
extension ChangePaymentCardResponsePatterns on ChangePaymentCardResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePaymentCardResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePaymentCardResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePaymentCardResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChangePaymentCardResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePaymentCardResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePaymentCardResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tPayRedirectUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePaymentCardResponse() when $default != null:
return $default(_that.tPayRedirectUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tPayRedirectUrl)  $default,) {final _that = this;
switch (_that) {
case _ChangePaymentCardResponse():
return $default(_that.tPayRedirectUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tPayRedirectUrl)?  $default,) {final _that = this;
switch (_that) {
case _ChangePaymentCardResponse() when $default != null:
return $default(_that.tPayRedirectUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangePaymentCardResponse implements ChangePaymentCardResponse {
  const _ChangePaymentCardResponse({this.tPayRedirectUrl});
  factory _ChangePaymentCardResponse.fromJson(Map<String, dynamic> json) => _$ChangePaymentCardResponseFromJson(json);

/// tpay card-management page, e.g.
/// `https://secure.tpay.com/cards/?sale_auth=<token>`.
@override final  String? tPayRedirectUrl;

/// Create a copy of ChangePaymentCardResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePaymentCardResponseCopyWith<_ChangePaymentCardResponse> get copyWith => __$ChangePaymentCardResponseCopyWithImpl<_ChangePaymentCardResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangePaymentCardResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePaymentCardResponse&&(identical(other.tPayRedirectUrl, tPayRedirectUrl) || other.tPayRedirectUrl == tPayRedirectUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tPayRedirectUrl);
}

@override
String toString() {
    return 'ChangePaymentCardResponse(tPayRedirectUrl: $tPayRedirectUrl)';
}


}

/// @nodoc
abstract mixin class _$ChangePaymentCardResponseCopyWith<$Res> implements $ChangePaymentCardResponseCopyWith<$Res> {
  factory _$ChangePaymentCardResponseCopyWith(_ChangePaymentCardResponse value, $Res Function(_ChangePaymentCardResponse) _then) = __$ChangePaymentCardResponseCopyWithImpl;
@override @useResult
$Res call({
 String? tPayRedirectUrl
});




}
/// @nodoc
class __$ChangePaymentCardResponseCopyWithImpl<$Res>
    implements _$ChangePaymentCardResponseCopyWith<$Res> {
  __$ChangePaymentCardResponseCopyWithImpl(this._self, this._then);

  final _ChangePaymentCardResponse _self;
  final $Res Function(_ChangePaymentCardResponse) _then;

/// Create a copy of ChangePaymentCardResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tPayRedirectUrl = freezed,}) {
  return _then(_ChangePaymentCardResponse(
tPayRedirectUrl: freezed == tPayRedirectUrl ? _self.tPayRedirectUrl : tPayRedirectUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
