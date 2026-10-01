// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dictionary_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketKind {

 int? get code; String? get description; bool? get availableForSell; bool? get availableWhenCracovCardAuthorizationIsNotValid; bool? get availableWhenCracovCardAuthorizationIsValid; int? get groupId;
/// Create a copy of TicketKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketKindCopyWith<TicketKind> get copyWith => _$TicketKindCopyWithImpl<TicketKind>(this as TicketKind, _$identity);

  /// Serializes this TicketKind to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketKind;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketKind&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.availableForSell, _this.availableForSell) || other.availableForSell == _this.availableForSell)&&(identical(other.availableWhenCracovCardAuthorizationIsNotValid, _this.availableWhenCracovCardAuthorizationIsNotValid) || other.availableWhenCracovCardAuthorizationIsNotValid == _this.availableWhenCracovCardAuthorizationIsNotValid)&&(identical(other.availableWhenCracovCardAuthorizationIsValid, _this.availableWhenCracovCardAuthorizationIsValid) || other.availableWhenCracovCardAuthorizationIsValid == _this.availableWhenCracovCardAuthorizationIsValid)&&(identical(other.groupId, _this.groupId) || other.groupId == _this.groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketKind;
  return Object.hash(runtimeType,_this.code,_this.description,_this.availableForSell,_this.availableWhenCracovCardAuthorizationIsNotValid,_this.availableWhenCracovCardAuthorizationIsValid,_this.groupId);
}

@override
String toString() {
  final _this = this as TicketKind;
  return 'TicketKind(code: ${_this.code}, description: ${_this.description}, availableForSell: ${_this.availableForSell}, availableWhenCracovCardAuthorizationIsNotValid: ${_this.availableWhenCracovCardAuthorizationIsNotValid}, availableWhenCracovCardAuthorizationIsValid: ${_this.availableWhenCracovCardAuthorizationIsValid}, groupId: ${_this.groupId})';
}


}

/// @nodoc
abstract mixin class $TicketKindCopyWith<$Res>  {
  factory $TicketKindCopyWith(TicketKind value, $Res Function(TicketKind) _then) = _$TicketKindCopyWithImpl;
@useResult
$Res call({
 int? code, String? description, bool? availableForSell, bool? availableWhenCracovCardAuthorizationIsNotValid, bool? availableWhenCracovCardAuthorizationIsValid, int? groupId
});




}
/// @nodoc
class _$TicketKindCopyWithImpl<$Res>
    implements $TicketKindCopyWith<$Res> {
  _$TicketKindCopyWithImpl(this._self, this._then);

  final TicketKind _self;
  final $Res Function(TicketKind) _then;

/// Create a copy of TicketKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? description = freezed,Object? availableForSell = freezed,Object? availableWhenCracovCardAuthorizationIsNotValid = freezed,Object? availableWhenCracovCardAuthorizationIsValid = freezed,Object? groupId = freezed,}) {
  return _then(TicketKind(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,availableForSell: freezed == availableForSell ? _self.availableForSell : availableForSell // ignore: cast_nullable_to_non_nullable
as bool?,availableWhenCracovCardAuthorizationIsNotValid: freezed == availableWhenCracovCardAuthorizationIsNotValid ? _self.availableWhenCracovCardAuthorizationIsNotValid : availableWhenCracovCardAuthorizationIsNotValid // ignore: cast_nullable_to_non_nullable
as bool?,availableWhenCracovCardAuthorizationIsValid: freezed == availableWhenCracovCardAuthorizationIsValid ? _self.availableWhenCracovCardAuthorizationIsValid : availableWhenCracovCardAuthorizationIsValid // ignore: cast_nullable_to_non_nullable
as bool?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketKind].
extension TicketKindPatterns on TicketKind {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketKind value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketKind() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketKind value)  $default,){
final _that = this;
switch (_that) {
case _TicketKind():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketKind value)?  $default,){
final _that = this;
switch (_that) {
case _TicketKind() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? description,  bool? availableForSell,  bool? availableWhenCracovCardAuthorizationIsNotValid,  bool? availableWhenCracovCardAuthorizationIsValid,  int? groupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketKind() when $default != null:
return $default(_that.code,_that.description,_that.availableForSell,_that.availableWhenCracovCardAuthorizationIsNotValid,_that.availableWhenCracovCardAuthorizationIsValid,_that.groupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? description,  bool? availableForSell,  bool? availableWhenCracovCardAuthorizationIsNotValid,  bool? availableWhenCracovCardAuthorizationIsValid,  int? groupId)  $default,) {final _that = this;
switch (_that) {
case _TicketKind():
return $default(_that.code,_that.description,_that.availableForSell,_that.availableWhenCracovCardAuthorizationIsNotValid,_that.availableWhenCracovCardAuthorizationIsValid,_that.groupId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? description,  bool? availableForSell,  bool? availableWhenCracovCardAuthorizationIsNotValid,  bool? availableWhenCracovCardAuthorizationIsValid,  int? groupId)?  $default,) {final _that = this;
switch (_that) {
case _TicketKind() when $default != null:
return $default(_that.code,_that.description,_that.availableForSell,_that.availableWhenCracovCardAuthorizationIsNotValid,_that.availableWhenCracovCardAuthorizationIsValid,_that.groupId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketKind implements TicketKind {
  const _TicketKind({this.code, this.description, this.availableForSell, this.availableWhenCracovCardAuthorizationIsNotValid, this.availableWhenCracovCardAuthorizationIsValid, this.groupId});
  factory _TicketKind.fromJson(Map<String, dynamic> json) => _$TicketKindFromJson(json);

@override final  int? code;
@override final  String? description;
@override final  bool? availableForSell;
@override final  bool? availableWhenCracovCardAuthorizationIsNotValid;
@override final  bool? availableWhenCracovCardAuthorizationIsValid;
@override final  int? groupId;

/// Create a copy of TicketKind
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketKindCopyWith<_TicketKind> get copyWith => __$TicketKindCopyWithImpl<_TicketKind>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketKindToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketKind&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.availableForSell, availableForSell) || other.availableForSell == availableForSell)&&(identical(other.availableWhenCracovCardAuthorizationIsNotValid, availableWhenCracovCardAuthorizationIsNotValid) || other.availableWhenCracovCardAuthorizationIsNotValid == availableWhenCracovCardAuthorizationIsNotValid)&&(identical(other.availableWhenCracovCardAuthorizationIsValid, availableWhenCracovCardAuthorizationIsValid) || other.availableWhenCracovCardAuthorizationIsValid == availableWhenCracovCardAuthorizationIsValid)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,description,availableForSell,availableWhenCracovCardAuthorizationIsNotValid,availableWhenCracovCardAuthorizationIsValid,groupId);
}

@override
String toString() {
    return 'TicketKind(code: $code, description: $description, availableForSell: $availableForSell, availableWhenCracovCardAuthorizationIsNotValid: $availableWhenCracovCardAuthorizationIsNotValid, availableWhenCracovCardAuthorizationIsValid: $availableWhenCracovCardAuthorizationIsValid, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$TicketKindCopyWith<$Res> implements $TicketKindCopyWith<$Res> {
  factory _$TicketKindCopyWith(_TicketKind value, $Res Function(_TicketKind) _then) = __$TicketKindCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? description, bool? availableForSell, bool? availableWhenCracovCardAuthorizationIsNotValid, bool? availableWhenCracovCardAuthorizationIsValid, int? groupId
});




}
/// @nodoc
class __$TicketKindCopyWithImpl<$Res>
    implements _$TicketKindCopyWith<$Res> {
  __$TicketKindCopyWithImpl(this._self, this._then);

  final _TicketKind _self;
  final $Res Function(_TicketKind) _then;

/// Create a copy of TicketKind
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? description = freezed,Object? availableForSell = freezed,Object? availableWhenCracovCardAuthorizationIsNotValid = freezed,Object? availableWhenCracovCardAuthorizationIsValid = freezed,Object? groupId = freezed,}) {
  return _then(_TicketKind(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,availableForSell: freezed == availableForSell ? _self.availableForSell : availableForSell // ignore: cast_nullable_to_non_nullable
as bool?,availableWhenCracovCardAuthorizationIsNotValid: freezed == availableWhenCracovCardAuthorizationIsNotValid ? _self.availableWhenCracovCardAuthorizationIsNotValid : availableWhenCracovCardAuthorizationIsNotValid // ignore: cast_nullable_to_non_nullable
as bool?,availableWhenCracovCardAuthorizationIsValid: freezed == availableWhenCracovCardAuthorizationIsValid ? _self.availableWhenCracovCardAuthorizationIsValid : availableWhenCracovCardAuthorizationIsValid // ignore: cast_nullable_to_non_nullable
as bool?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TicketKindListResponse {

 List<TicketKind> get kinds;
/// Create a copy of TicketKindListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketKindListResponseCopyWith<TicketKindListResponse> get copyWith => _$TicketKindListResponseCopyWithImpl<TicketKindListResponse>(this as TicketKindListResponse, _$identity);

  /// Serializes this TicketKindListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketKindListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketKindListResponse&&const DeepCollectionEquality().equals(other.kinds, _this.kinds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketKindListResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.kinds));
}

@override
String toString() {
  final _this = this as TicketKindListResponse;
  return 'TicketKindListResponse(kinds: ${_this.kinds})';
}


}

/// @nodoc
abstract mixin class $TicketKindListResponseCopyWith<$Res>  {
  factory $TicketKindListResponseCopyWith(TicketKindListResponse value, $Res Function(TicketKindListResponse) _then) = _$TicketKindListResponseCopyWithImpl;
@useResult
$Res call({
 List<TicketKind> kinds
});




}
/// @nodoc
class _$TicketKindListResponseCopyWithImpl<$Res>
    implements $TicketKindListResponseCopyWith<$Res> {
  _$TicketKindListResponseCopyWithImpl(this._self, this._then);

  final TicketKindListResponse _self;
  final $Res Function(TicketKindListResponse) _then;

/// Create a copy of TicketKindListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kinds = null,}) {
  return _then(TicketKindListResponse(
kinds: null == kinds ? _self.kinds : kinds // ignore: cast_nullable_to_non_nullable
as List<TicketKind>,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketKindListResponse].
extension TicketKindListResponsePatterns on TicketKindListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketKindListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketKindListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketKindListResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketKindListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketKindListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketKindListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TicketKind> kinds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketKindListResponse() when $default != null:
return $default(_that.kinds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TicketKind> kinds)  $default,) {final _that = this;
switch (_that) {
case _TicketKindListResponse():
return $default(_that.kinds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TicketKind> kinds)?  $default,) {final _that = this;
switch (_that) {
case _TicketKindListResponse() when $default != null:
return $default(_that.kinds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketKindListResponse implements TicketKindListResponse {
  const _TicketKindListResponse({ List<TicketKind> kinds = const <TicketKind>[]}): _kinds = kinds;
  factory _TicketKindListResponse.fromJson(Map<String, dynamic> json) => _$TicketKindListResponseFromJson(json);

 final  List<TicketKind> _kinds;
@override@JsonKey() List<TicketKind> get kinds {
  if (_kinds is EqualUnmodifiableListView) return _kinds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kinds);
}


/// Create a copy of TicketKindListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketKindListResponseCopyWith<_TicketKindListResponse> get copyWith => __$TicketKindListResponseCopyWithImpl<_TicketKindListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketKindListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketKindListResponse&&const DeepCollectionEquality().equals(other.kinds, _kinds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_kinds));
}

@override
String toString() {
    return 'TicketKindListResponse(kinds: $kinds)';
}


}

/// @nodoc
abstract mixin class _$TicketKindListResponseCopyWith<$Res> implements $TicketKindListResponseCopyWith<$Res> {
  factory _$TicketKindListResponseCopyWith(_TicketKindListResponse value, $Res Function(_TicketKindListResponse) _then) = __$TicketKindListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TicketKind> kinds
});




}
/// @nodoc
class __$TicketKindListResponseCopyWithImpl<$Res>
    implements _$TicketKindListResponseCopyWith<$Res> {
  __$TicketKindListResponseCopyWithImpl(this._self, this._then);

  final _TicketKindListResponse _self;
  final $Res Function(_TicketKindListResponse) _then;

/// Create a copy of TicketKindListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kinds = null,}) {
  return _then(_TicketKindListResponse(
kinds: null == kinds ? _self._kinds : kinds // ignore: cast_nullable_to_non_nullable
as List<TicketKind>,
  ));
}


}


/// @nodoc
mixin _$TicketNumberOfLine {

 int? get code; String? get description; bool? get availableForSell; bool? get forAll; bool? get forKK; int? get urbanLineQty; int? get suburbanLineQty; int? get suburban2LineQty; bool? get selectableLines; int? get sumLinesToSelection;
/// Create a copy of TicketNumberOfLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketNumberOfLineCopyWith<TicketNumberOfLine> get copyWith => _$TicketNumberOfLineCopyWithImpl<TicketNumberOfLine>(this as TicketNumberOfLine, _$identity);

  /// Serializes this TicketNumberOfLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketNumberOfLine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketNumberOfLine&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.availableForSell, _this.availableForSell) || other.availableForSell == _this.availableForSell)&&(identical(other.forAll, _this.forAll) || other.forAll == _this.forAll)&&(identical(other.forKK, _this.forKK) || other.forKK == _this.forKK)&&(identical(other.urbanLineQty, _this.urbanLineQty) || other.urbanLineQty == _this.urbanLineQty)&&(identical(other.suburbanLineQty, _this.suburbanLineQty) || other.suburbanLineQty == _this.suburbanLineQty)&&(identical(other.suburban2LineQty, _this.suburban2LineQty) || other.suburban2LineQty == _this.suburban2LineQty)&&(identical(other.selectableLines, _this.selectableLines) || other.selectableLines == _this.selectableLines)&&(identical(other.sumLinesToSelection, _this.sumLinesToSelection) || other.sumLinesToSelection == _this.sumLinesToSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketNumberOfLine;
  return Object.hash(runtimeType,_this.code,_this.description,_this.availableForSell,_this.forAll,_this.forKK,_this.urbanLineQty,_this.suburbanLineQty,_this.suburban2LineQty,_this.selectableLines,_this.sumLinesToSelection);
}

@override
String toString() {
  final _this = this as TicketNumberOfLine;
  return 'TicketNumberOfLine(code: ${_this.code}, description: ${_this.description}, availableForSell: ${_this.availableForSell}, forAll: ${_this.forAll}, forKK: ${_this.forKK}, urbanLineQty: ${_this.urbanLineQty}, suburbanLineQty: ${_this.suburbanLineQty}, suburban2LineQty: ${_this.suburban2LineQty}, selectableLines: ${_this.selectableLines}, sumLinesToSelection: ${_this.sumLinesToSelection})';
}


}

/// @nodoc
abstract mixin class $TicketNumberOfLineCopyWith<$Res>  {
  factory $TicketNumberOfLineCopyWith(TicketNumberOfLine value, $Res Function(TicketNumberOfLine) _then) = _$TicketNumberOfLineCopyWithImpl;
@useResult
$Res call({
 int? code, String? description, bool? availableForSell, bool? forAll, bool? forKK, int? urbanLineQty, int? suburbanLineQty, int? suburban2LineQty, bool? selectableLines, int? sumLinesToSelection
});




}
/// @nodoc
class _$TicketNumberOfLineCopyWithImpl<$Res>
    implements $TicketNumberOfLineCopyWith<$Res> {
  _$TicketNumberOfLineCopyWithImpl(this._self, this._then);

  final TicketNumberOfLine _self;
  final $Res Function(TicketNumberOfLine) _then;

/// Create a copy of TicketNumberOfLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? description = freezed,Object? availableForSell = freezed,Object? forAll = freezed,Object? forKK = freezed,Object? urbanLineQty = freezed,Object? suburbanLineQty = freezed,Object? suburban2LineQty = freezed,Object? selectableLines = freezed,Object? sumLinesToSelection = freezed,}) {
  return _then(TicketNumberOfLine(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,availableForSell: freezed == availableForSell ? _self.availableForSell : availableForSell // ignore: cast_nullable_to_non_nullable
as bool?,forAll: freezed == forAll ? _self.forAll : forAll // ignore: cast_nullable_to_non_nullable
as bool?,forKK: freezed == forKK ? _self.forKK : forKK // ignore: cast_nullable_to_non_nullable
as bool?,urbanLineQty: freezed == urbanLineQty ? _self.urbanLineQty : urbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburbanLineQty: freezed == suburbanLineQty ? _self.suburbanLineQty : suburbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburban2LineQty: freezed == suburban2LineQty ? _self.suburban2LineQty : suburban2LineQty // ignore: cast_nullable_to_non_nullable
as int?,selectableLines: freezed == selectableLines ? _self.selectableLines : selectableLines // ignore: cast_nullable_to_non_nullable
as bool?,sumLinesToSelection: freezed == sumLinesToSelection ? _self.sumLinesToSelection : sumLinesToSelection // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketNumberOfLine].
extension TicketNumberOfLinePatterns on TicketNumberOfLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketNumberOfLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketNumberOfLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketNumberOfLine value)  $default,){
final _that = this;
switch (_that) {
case _TicketNumberOfLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketNumberOfLine value)?  $default,){
final _that = this;
switch (_that) {
case _TicketNumberOfLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? description,  bool? availableForSell,  bool? forAll,  bool? forKK,  int? urbanLineQty,  int? suburbanLineQty,  int? suburban2LineQty,  bool? selectableLines,  int? sumLinesToSelection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketNumberOfLine() when $default != null:
return $default(_that.code,_that.description,_that.availableForSell,_that.forAll,_that.forKK,_that.urbanLineQty,_that.suburbanLineQty,_that.suburban2LineQty,_that.selectableLines,_that.sumLinesToSelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? description,  bool? availableForSell,  bool? forAll,  bool? forKK,  int? urbanLineQty,  int? suburbanLineQty,  int? suburban2LineQty,  bool? selectableLines,  int? sumLinesToSelection)  $default,) {final _that = this;
switch (_that) {
case _TicketNumberOfLine():
return $default(_that.code,_that.description,_that.availableForSell,_that.forAll,_that.forKK,_that.urbanLineQty,_that.suburbanLineQty,_that.suburban2LineQty,_that.selectableLines,_that.sumLinesToSelection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? description,  bool? availableForSell,  bool? forAll,  bool? forKK,  int? urbanLineQty,  int? suburbanLineQty,  int? suburban2LineQty,  bool? selectableLines,  int? sumLinesToSelection)?  $default,) {final _that = this;
switch (_that) {
case _TicketNumberOfLine() when $default != null:
return $default(_that.code,_that.description,_that.availableForSell,_that.forAll,_that.forKK,_that.urbanLineQty,_that.suburbanLineQty,_that.suburban2LineQty,_that.selectableLines,_that.sumLinesToSelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketNumberOfLine implements TicketNumberOfLine {
  const _TicketNumberOfLine({this.code, this.description, this.availableForSell, this.forAll, this.forKK, this.urbanLineQty, this.suburbanLineQty, this.suburban2LineQty, this.selectableLines, this.sumLinesToSelection});
  factory _TicketNumberOfLine.fromJson(Map<String, dynamic> json) => _$TicketNumberOfLineFromJson(json);

@override final  int? code;
@override final  String? description;
@override final  bool? availableForSell;
@override final  bool? forAll;
@override final  bool? forKK;
@override final  int? urbanLineQty;
@override final  int? suburbanLineQty;
@override final  int? suburban2LineQty;
@override final  bool? selectableLines;
@override final  int? sumLinesToSelection;

/// Create a copy of TicketNumberOfLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketNumberOfLineCopyWith<_TicketNumberOfLine> get copyWith => __$TicketNumberOfLineCopyWithImpl<_TicketNumberOfLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketNumberOfLineToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketNumberOfLine&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.availableForSell, availableForSell) || other.availableForSell == availableForSell)&&(identical(other.forAll, forAll) || other.forAll == forAll)&&(identical(other.forKK, forKK) || other.forKK == forKK)&&(identical(other.urbanLineQty, urbanLineQty) || other.urbanLineQty == urbanLineQty)&&(identical(other.suburbanLineQty, suburbanLineQty) || other.suburbanLineQty == suburbanLineQty)&&(identical(other.suburban2LineQty, suburban2LineQty) || other.suburban2LineQty == suburban2LineQty)&&(identical(other.selectableLines, selectableLines) || other.selectableLines == selectableLines)&&(identical(other.sumLinesToSelection, sumLinesToSelection) || other.sumLinesToSelection == sumLinesToSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,description,availableForSell,forAll,forKK,urbanLineQty,suburbanLineQty,suburban2LineQty,selectableLines,sumLinesToSelection);
}

@override
String toString() {
    return 'TicketNumberOfLine(code: $code, description: $description, availableForSell: $availableForSell, forAll: $forAll, forKK: $forKK, urbanLineQty: $urbanLineQty, suburbanLineQty: $suburbanLineQty, suburban2LineQty: $suburban2LineQty, selectableLines: $selectableLines, sumLinesToSelection: $sumLinesToSelection)';
}


}

/// @nodoc
abstract mixin class _$TicketNumberOfLineCopyWith<$Res> implements $TicketNumberOfLineCopyWith<$Res> {
  factory _$TicketNumberOfLineCopyWith(_TicketNumberOfLine value, $Res Function(_TicketNumberOfLine) _then) = __$TicketNumberOfLineCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? description, bool? availableForSell, bool? forAll, bool? forKK, int? urbanLineQty, int? suburbanLineQty, int? suburban2LineQty, bool? selectableLines, int? sumLinesToSelection
});




}
/// @nodoc
class __$TicketNumberOfLineCopyWithImpl<$Res>
    implements _$TicketNumberOfLineCopyWith<$Res> {
  __$TicketNumberOfLineCopyWithImpl(this._self, this._then);

  final _TicketNumberOfLine _self;
  final $Res Function(_TicketNumberOfLine) _then;

/// Create a copy of TicketNumberOfLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? description = freezed,Object? availableForSell = freezed,Object? forAll = freezed,Object? forKK = freezed,Object? urbanLineQty = freezed,Object? suburbanLineQty = freezed,Object? suburban2LineQty = freezed,Object? selectableLines = freezed,Object? sumLinesToSelection = freezed,}) {
  return _then(_TicketNumberOfLine(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,availableForSell: freezed == availableForSell ? _self.availableForSell : availableForSell // ignore: cast_nullable_to_non_nullable
as bool?,forAll: freezed == forAll ? _self.forAll : forAll // ignore: cast_nullable_to_non_nullable
as bool?,forKK: freezed == forKK ? _self.forKK : forKK // ignore: cast_nullable_to_non_nullable
as bool?,urbanLineQty: freezed == urbanLineQty ? _self.urbanLineQty : urbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburbanLineQty: freezed == suburbanLineQty ? _self.suburbanLineQty : suburbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburban2LineQty: freezed == suburban2LineQty ? _self.suburban2LineQty : suburban2LineQty // ignore: cast_nullable_to_non_nullable
as int?,selectableLines: freezed == selectableLines ? _self.selectableLines : selectableLines // ignore: cast_nullable_to_non_nullable
as bool?,sumLinesToSelection: freezed == sumLinesToSelection ? _self.sumLinesToSelection : sumLinesToSelection // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TicketNumberOfLineListResponse {

 List<TicketNumberOfLine> get list;
/// Create a copy of TicketNumberOfLineListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketNumberOfLineListResponseCopyWith<TicketNumberOfLineListResponse> get copyWith => _$TicketNumberOfLineListResponseCopyWithImpl<TicketNumberOfLineListResponse>(this as TicketNumberOfLineListResponse, _$identity);

  /// Serializes this TicketNumberOfLineListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketNumberOfLineListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketNumberOfLineListResponse&&const DeepCollectionEquality().equals(other.list, _this.list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketNumberOfLineListResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.list));
}

@override
String toString() {
  final _this = this as TicketNumberOfLineListResponse;
  return 'TicketNumberOfLineListResponse(list: ${_this.list})';
}


}

/// @nodoc
abstract mixin class $TicketNumberOfLineListResponseCopyWith<$Res>  {
  factory $TicketNumberOfLineListResponseCopyWith(TicketNumberOfLineListResponse value, $Res Function(TicketNumberOfLineListResponse) _then) = _$TicketNumberOfLineListResponseCopyWithImpl;
@useResult
$Res call({
 List<TicketNumberOfLine> list
});




}
/// @nodoc
class _$TicketNumberOfLineListResponseCopyWithImpl<$Res>
    implements $TicketNumberOfLineListResponseCopyWith<$Res> {
  _$TicketNumberOfLineListResponseCopyWithImpl(this._self, this._then);

  final TicketNumberOfLineListResponse _self;
  final $Res Function(TicketNumberOfLineListResponse) _then;

/// Create a copy of TicketNumberOfLineListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(TicketNumberOfLineListResponse(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<TicketNumberOfLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketNumberOfLineListResponse].
extension TicketNumberOfLineListResponsePatterns on TicketNumberOfLineListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketNumberOfLineListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketNumberOfLineListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketNumberOfLineListResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketNumberOfLineListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketNumberOfLineListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketNumberOfLineListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TicketNumberOfLine> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketNumberOfLineListResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TicketNumberOfLine> list)  $default,) {final _that = this;
switch (_that) {
case _TicketNumberOfLineListResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TicketNumberOfLine> list)?  $default,) {final _that = this;
switch (_that) {
case _TicketNumberOfLineListResponse() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketNumberOfLineListResponse implements TicketNumberOfLineListResponse {
  const _TicketNumberOfLineListResponse({ List<TicketNumberOfLine> list = const <TicketNumberOfLine>[]}): _list = list;
  factory _TicketNumberOfLineListResponse.fromJson(Map<String, dynamic> json) => _$TicketNumberOfLineListResponseFromJson(json);

 final  List<TicketNumberOfLine> _list;
@override@JsonKey() List<TicketNumberOfLine> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of TicketNumberOfLineListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketNumberOfLineListResponseCopyWith<_TicketNumberOfLineListResponse> get copyWith => __$TicketNumberOfLineListResponseCopyWithImpl<_TicketNumberOfLineListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketNumberOfLineListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketNumberOfLineListResponse&&const DeepCollectionEquality().equals(other.list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));
}

@override
String toString() {
    return 'TicketNumberOfLineListResponse(list: $list)';
}


}

/// @nodoc
abstract mixin class _$TicketNumberOfLineListResponseCopyWith<$Res> implements $TicketNumberOfLineListResponseCopyWith<$Res> {
  factory _$TicketNumberOfLineListResponseCopyWith(_TicketNumberOfLineListResponse value, $Res Function(_TicketNumberOfLineListResponse) _then) = __$TicketNumberOfLineListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TicketNumberOfLine> list
});




}
/// @nodoc
class __$TicketNumberOfLineListResponseCopyWithImpl<$Res>
    implements _$TicketNumberOfLineListResponseCopyWith<$Res> {
  __$TicketNumberOfLineListResponseCopyWithImpl(this._self, this._then);

  final _TicketNumberOfLineListResponse _self;
  final $Res Function(_TicketNumberOfLineListResponse) _then;

/// Create a copy of TicketNumberOfLineListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_TicketNumberOfLineListResponse(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<TicketNumberOfLine>,
  ));
}


}


/// @nodoc
mixin _$TicketPeriod {

 int? get code; String? get description; bool? get availableForSell; bool? get forAll; bool? get forKK; int? get value; int? get unit;
/// Create a copy of TicketPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketPeriodCopyWith<TicketPeriod> get copyWith => _$TicketPeriodCopyWithImpl<TicketPeriod>(this as TicketPeriod, _$identity);

  /// Serializes this TicketPeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketPeriod;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketPeriod&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.availableForSell, _this.availableForSell) || other.availableForSell == _this.availableForSell)&&(identical(other.forAll, _this.forAll) || other.forAll == _this.forAll)&&(identical(other.forKK, _this.forKK) || other.forKK == _this.forKK)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.unit, _this.unit) || other.unit == _this.unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketPeriod;
  return Object.hash(runtimeType,_this.code,_this.description,_this.availableForSell,_this.forAll,_this.forKK,_this.value,_this.unit);
}

@override
String toString() {
  final _this = this as TicketPeriod;
  return 'TicketPeriod(code: ${_this.code}, description: ${_this.description}, availableForSell: ${_this.availableForSell}, forAll: ${_this.forAll}, forKK: ${_this.forKK}, value: ${_this.value}, unit: ${_this.unit})';
}


}

/// @nodoc
abstract mixin class $TicketPeriodCopyWith<$Res>  {
  factory $TicketPeriodCopyWith(TicketPeriod value, $Res Function(TicketPeriod) _then) = _$TicketPeriodCopyWithImpl;
@useResult
$Res call({
 int? code, String? description, bool? availableForSell, bool? forAll, bool? forKK, int? value, int? unit
});




}
/// @nodoc
class _$TicketPeriodCopyWithImpl<$Res>
    implements $TicketPeriodCopyWith<$Res> {
  _$TicketPeriodCopyWithImpl(this._self, this._then);

  final TicketPeriod _self;
  final $Res Function(TicketPeriod) _then;

/// Create a copy of TicketPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? description = freezed,Object? availableForSell = freezed,Object? forAll = freezed,Object? forKK = freezed,Object? value = freezed,Object? unit = freezed,}) {
  return _then(TicketPeriod(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,availableForSell: freezed == availableForSell ? _self.availableForSell : availableForSell // ignore: cast_nullable_to_non_nullable
as bool?,forAll: freezed == forAll ? _self.forAll : forAll // ignore: cast_nullable_to_non_nullable
as bool?,forKK: freezed == forKK ? _self.forKK : forKK // ignore: cast_nullable_to_non_nullable
as bool?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketPeriod].
extension TicketPeriodPatterns on TicketPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketPeriod value)  $default,){
final _that = this;
switch (_that) {
case _TicketPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _TicketPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? description,  bool? availableForSell,  bool? forAll,  bool? forKK,  int? value,  int? unit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketPeriod() when $default != null:
return $default(_that.code,_that.description,_that.availableForSell,_that.forAll,_that.forKK,_that.value,_that.unit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? description,  bool? availableForSell,  bool? forAll,  bool? forKK,  int? value,  int? unit)  $default,) {final _that = this;
switch (_that) {
case _TicketPeriod():
return $default(_that.code,_that.description,_that.availableForSell,_that.forAll,_that.forKK,_that.value,_that.unit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? description,  bool? availableForSell,  bool? forAll,  bool? forKK,  int? value,  int? unit)?  $default,) {final _that = this;
switch (_that) {
case _TicketPeriod() when $default != null:
return $default(_that.code,_that.description,_that.availableForSell,_that.forAll,_that.forKK,_that.value,_that.unit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketPeriod implements TicketPeriod {
  const _TicketPeriod({this.code, this.description, this.availableForSell, this.forAll, this.forKK, this.value, this.unit});
  factory _TicketPeriod.fromJson(Map<String, dynamic> json) => _$TicketPeriodFromJson(json);

@override final  int? code;
@override final  String? description;
@override final  bool? availableForSell;
@override final  bool? forAll;
@override final  bool? forKK;
@override final  int? value;
@override final  int? unit;

/// Create a copy of TicketPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketPeriodCopyWith<_TicketPeriod> get copyWith => __$TicketPeriodCopyWithImpl<_TicketPeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketPeriodToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketPeriod&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.availableForSell, availableForSell) || other.availableForSell == availableForSell)&&(identical(other.forAll, forAll) || other.forAll == forAll)&&(identical(other.forKK, forKK) || other.forKK == forKK)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,description,availableForSell,forAll,forKK,value,unit);
}

@override
String toString() {
    return 'TicketPeriod(code: $code, description: $description, availableForSell: $availableForSell, forAll: $forAll, forKK: $forKK, value: $value, unit: $unit)';
}


}

/// @nodoc
abstract mixin class _$TicketPeriodCopyWith<$Res> implements $TicketPeriodCopyWith<$Res> {
  factory _$TicketPeriodCopyWith(_TicketPeriod value, $Res Function(_TicketPeriod) _then) = __$TicketPeriodCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? description, bool? availableForSell, bool? forAll, bool? forKK, int? value, int? unit
});




}
/// @nodoc
class __$TicketPeriodCopyWithImpl<$Res>
    implements _$TicketPeriodCopyWith<$Res> {
  __$TicketPeriodCopyWithImpl(this._self, this._then);

  final _TicketPeriod _self;
  final $Res Function(_TicketPeriod) _then;

/// Create a copy of TicketPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? description = freezed,Object? availableForSell = freezed,Object? forAll = freezed,Object? forKK = freezed,Object? value = freezed,Object? unit = freezed,}) {
  return _then(_TicketPeriod(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,availableForSell: freezed == availableForSell ? _self.availableForSell : availableForSell // ignore: cast_nullable_to_non_nullable
as bool?,forAll: freezed == forAll ? _self.forAll : forAll // ignore: cast_nullable_to_non_nullable
as bool?,forKK: freezed == forKK ? _self.forKK : forKK // ignore: cast_nullable_to_non_nullable
as bool?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TicketPeriodListResponse {

 List<TicketPeriod> get list;
/// Create a copy of TicketPeriodListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketPeriodListResponseCopyWith<TicketPeriodListResponse> get copyWith => _$TicketPeriodListResponseCopyWithImpl<TicketPeriodListResponse>(this as TicketPeriodListResponse, _$identity);

  /// Serializes this TicketPeriodListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketPeriodListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketPeriodListResponse&&const DeepCollectionEquality().equals(other.list, _this.list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketPeriodListResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.list));
}

@override
String toString() {
  final _this = this as TicketPeriodListResponse;
  return 'TicketPeriodListResponse(list: ${_this.list})';
}


}

/// @nodoc
abstract mixin class $TicketPeriodListResponseCopyWith<$Res>  {
  factory $TicketPeriodListResponseCopyWith(TicketPeriodListResponse value, $Res Function(TicketPeriodListResponse) _then) = _$TicketPeriodListResponseCopyWithImpl;
@useResult
$Res call({
 List<TicketPeriod> list
});




}
/// @nodoc
class _$TicketPeriodListResponseCopyWithImpl<$Res>
    implements $TicketPeriodListResponseCopyWith<$Res> {
  _$TicketPeriodListResponseCopyWithImpl(this._self, this._then);

  final TicketPeriodListResponse _self;
  final $Res Function(TicketPeriodListResponse) _then;

/// Create a copy of TicketPeriodListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(TicketPeriodListResponse(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<TicketPeriod>,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketPeriodListResponse].
extension TicketPeriodListResponsePatterns on TicketPeriodListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketPeriodListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketPeriodListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketPeriodListResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketPeriodListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketPeriodListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketPeriodListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TicketPeriod> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketPeriodListResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TicketPeriod> list)  $default,) {final _that = this;
switch (_that) {
case _TicketPeriodListResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TicketPeriod> list)?  $default,) {final _that = this;
switch (_that) {
case _TicketPeriodListResponse() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketPeriodListResponse implements TicketPeriodListResponse {
  const _TicketPeriodListResponse({ List<TicketPeriod> list = const <TicketPeriod>[]}): _list = list;
  factory _TicketPeriodListResponse.fromJson(Map<String, dynamic> json) => _$TicketPeriodListResponseFromJson(json);

 final  List<TicketPeriod> _list;
@override@JsonKey() List<TicketPeriod> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of TicketPeriodListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketPeriodListResponseCopyWith<_TicketPeriodListResponse> get copyWith => __$TicketPeriodListResponseCopyWithImpl<_TicketPeriodListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketPeriodListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketPeriodListResponse&&const DeepCollectionEquality().equals(other.list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));
}

@override
String toString() {
    return 'TicketPeriodListResponse(list: $list)';
}


}

/// @nodoc
abstract mixin class _$TicketPeriodListResponseCopyWith<$Res> implements $TicketPeriodListResponseCopyWith<$Res> {
  factory _$TicketPeriodListResponseCopyWith(_TicketPeriodListResponse value, $Res Function(_TicketPeriodListResponse) _then) = __$TicketPeriodListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TicketPeriod> list
});




}
/// @nodoc
class __$TicketPeriodListResponseCopyWithImpl<$Res>
    implements _$TicketPeriodListResponseCopyWith<$Res> {
  __$TicketPeriodListResponseCopyWithImpl(this._self, this._then);

  final _TicketPeriodListResponse _self;
  final $Res Function(_TicketPeriodListResponse) _then;

/// Create a copy of TicketPeriodListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_TicketPeriodListResponse(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<TicketPeriod>,
  ));
}


}


/// @nodoc
mixin _$TransportLine {

 int? get line;@JsonKey(name: 'second_zone') bool? get secondZone;@JsonKey(name: 'has_second_zone') bool? get hasSecondZone;@JsonKey(name: 'is_tram') bool? get isTram;@JsonKey(name: 'is_bus') bool? get isBus;
/// Create a copy of TransportLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransportLineCopyWith<TransportLine> get copyWith => _$TransportLineCopyWithImpl<TransportLine>(this as TransportLine, _$identity);

  /// Serializes this TransportLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransportLine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportLine&&(identical(other.line, _this.line) || other.line == _this.line)&&(identical(other.secondZone, _this.secondZone) || other.secondZone == _this.secondZone)&&(identical(other.hasSecondZone, _this.hasSecondZone) || other.hasSecondZone == _this.hasSecondZone)&&(identical(other.isTram, _this.isTram) || other.isTram == _this.isTram)&&(identical(other.isBus, _this.isBus) || other.isBus == _this.isBus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransportLine;
  return Object.hash(runtimeType,_this.line,_this.secondZone,_this.hasSecondZone,_this.isTram,_this.isBus);
}

@override
String toString() {
  final _this = this as TransportLine;
  return 'TransportLine(line: ${_this.line}, secondZone: ${_this.secondZone}, hasSecondZone: ${_this.hasSecondZone}, isTram: ${_this.isTram}, isBus: ${_this.isBus})';
}


}

/// @nodoc
abstract mixin class $TransportLineCopyWith<$Res>  {
  factory $TransportLineCopyWith(TransportLine value, $Res Function(TransportLine) _then) = _$TransportLineCopyWithImpl;
@useResult
$Res call({
 int? line,@JsonKey(name: 'second_zone') bool? secondZone,@JsonKey(name: 'has_second_zone') bool? hasSecondZone,@JsonKey(name: 'is_tram') bool? isTram,@JsonKey(name: 'is_bus') bool? isBus
});




}
/// @nodoc
class _$TransportLineCopyWithImpl<$Res>
    implements $TransportLineCopyWith<$Res> {
  _$TransportLineCopyWithImpl(this._self, this._then);

  final TransportLine _self;
  final $Res Function(TransportLine) _then;

/// Create a copy of TransportLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line = freezed,Object? secondZone = freezed,Object? hasSecondZone = freezed,Object? isTram = freezed,Object? isBus = freezed,}) {
  return _then(TransportLine(
line: freezed == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int?,secondZone: freezed == secondZone ? _self.secondZone : secondZone // ignore: cast_nullable_to_non_nullable
as bool?,hasSecondZone: freezed == hasSecondZone ? _self.hasSecondZone : hasSecondZone // ignore: cast_nullable_to_non_nullable
as bool?,isTram: freezed == isTram ? _self.isTram : isTram // ignore: cast_nullable_to_non_nullable
as bool?,isBus: freezed == isBus ? _self.isBus : isBus // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransportLine].
extension TransportLinePatterns on TransportLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransportLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransportLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransportLine value)  $default,){
final _that = this;
switch (_that) {
case _TransportLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransportLine value)?  $default,){
final _that = this;
switch (_that) {
case _TransportLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? line, @JsonKey(name: 'second_zone')  bool? secondZone, @JsonKey(name: 'has_second_zone')  bool? hasSecondZone, @JsonKey(name: 'is_tram')  bool? isTram, @JsonKey(name: 'is_bus')  bool? isBus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransportLine() when $default != null:
return $default(_that.line,_that.secondZone,_that.hasSecondZone,_that.isTram,_that.isBus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? line, @JsonKey(name: 'second_zone')  bool? secondZone, @JsonKey(name: 'has_second_zone')  bool? hasSecondZone, @JsonKey(name: 'is_tram')  bool? isTram, @JsonKey(name: 'is_bus')  bool? isBus)  $default,) {final _that = this;
switch (_that) {
case _TransportLine():
return $default(_that.line,_that.secondZone,_that.hasSecondZone,_that.isTram,_that.isBus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? line, @JsonKey(name: 'second_zone')  bool? secondZone, @JsonKey(name: 'has_second_zone')  bool? hasSecondZone, @JsonKey(name: 'is_tram')  bool? isTram, @JsonKey(name: 'is_bus')  bool? isBus)?  $default,) {final _that = this;
switch (_that) {
case _TransportLine() when $default != null:
return $default(_that.line,_that.secondZone,_that.hasSecondZone,_that.isTram,_that.isBus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransportLine implements TransportLine {
  const _TransportLine({this.line, @JsonKey(name: 'second_zone') this.secondZone, @JsonKey(name: 'has_second_zone') this.hasSecondZone, @JsonKey(name: 'is_tram') this.isTram, @JsonKey(name: 'is_bus') this.isBus});
  factory _TransportLine.fromJson(Map<String, dynamic> json) => _$TransportLineFromJson(json);

@override final  int? line;
@override@JsonKey(name: 'second_zone') final  bool? secondZone;
@override@JsonKey(name: 'has_second_zone') final  bool? hasSecondZone;
@override@JsonKey(name: 'is_tram') final  bool? isTram;
@override@JsonKey(name: 'is_bus') final  bool? isBus;

/// Create a copy of TransportLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransportLineCopyWith<_TransportLine> get copyWith => __$TransportLineCopyWithImpl<_TransportLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransportLineToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransportLine&&(identical(other.line, line) || other.line == line)&&(identical(other.secondZone, secondZone) || other.secondZone == secondZone)&&(identical(other.hasSecondZone, hasSecondZone) || other.hasSecondZone == hasSecondZone)&&(identical(other.isTram, isTram) || other.isTram == isTram)&&(identical(other.isBus, isBus) || other.isBus == isBus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,line,secondZone,hasSecondZone,isTram,isBus);
}

@override
String toString() {
    return 'TransportLine(line: $line, secondZone: $secondZone, hasSecondZone: $hasSecondZone, isTram: $isTram, isBus: $isBus)';
}


}

/// @nodoc
abstract mixin class _$TransportLineCopyWith<$Res> implements $TransportLineCopyWith<$Res> {
  factory _$TransportLineCopyWith(_TransportLine value, $Res Function(_TransportLine) _then) = __$TransportLineCopyWithImpl;
@override @useResult
$Res call({
 int? line,@JsonKey(name: 'second_zone') bool? secondZone,@JsonKey(name: 'has_second_zone') bool? hasSecondZone,@JsonKey(name: 'is_tram') bool? isTram,@JsonKey(name: 'is_bus') bool? isBus
});




}
/// @nodoc
class __$TransportLineCopyWithImpl<$Res>
    implements _$TransportLineCopyWith<$Res> {
  __$TransportLineCopyWithImpl(this._self, this._then);

  final _TransportLine _self;
  final $Res Function(_TransportLine) _then;

/// Create a copy of TransportLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line = freezed,Object? secondZone = freezed,Object? hasSecondZone = freezed,Object? isTram = freezed,Object? isBus = freezed,}) {
  return _then(_TransportLine(
line: freezed == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int?,secondZone: freezed == secondZone ? _self.secondZone : secondZone // ignore: cast_nullable_to_non_nullable
as bool?,hasSecondZone: freezed == hasSecondZone ? _self.hasSecondZone : hasSecondZone // ignore: cast_nullable_to_non_nullable
as bool?,isTram: freezed == isTram ? _self.isTram : isTram // ignore: cast_nullable_to_non_nullable
as bool?,isBus: freezed == isBus ? _self.isBus : isBus // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$TransportLineResponse {

 List<TransportLine> get lines; Object? get code; String? get message;
/// Create a copy of TransportLineResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransportLineResponseCopyWith<TransportLineResponse> get copyWith => _$TransportLineResponseCopyWithImpl<TransportLineResponse>(this as TransportLineResponse, _$identity);

  /// Serializes this TransportLineResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TransportLineResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportLineResponse&&const DeepCollectionEquality().equals(other.lines, _this.lines)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TransportLineResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.lines),const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as TransportLineResponse;
  return 'TransportLineResponse(lines: ${_this.lines}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $TransportLineResponseCopyWith<$Res>  {
  factory $TransportLineResponseCopyWith(TransportLineResponse value, $Res Function(TransportLineResponse) _then) = _$TransportLineResponseCopyWithImpl;
@useResult
$Res call({
 List<TransportLine> lines, Object? code, String? message
});




}
/// @nodoc
class _$TransportLineResponseCopyWithImpl<$Res>
    implements $TransportLineResponseCopyWith<$Res> {
  _$TransportLineResponseCopyWithImpl(this._self, this._then);

  final TransportLineResponse _self;
  final $Res Function(TransportLineResponse) _then;

/// Create a copy of TransportLineResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lines = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(TransportLineResponse(
lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<TransportLine>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransportLineResponse].
extension TransportLineResponsePatterns on TransportLineResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransportLineResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransportLineResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransportLineResponse value)  $default,){
final _that = this;
switch (_that) {
case _TransportLineResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransportLineResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TransportLineResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TransportLine> lines,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransportLineResponse() when $default != null:
return $default(_that.lines,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TransportLine> lines,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _TransportLineResponse():
return $default(_that.lines,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TransportLine> lines,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _TransportLineResponse() when $default != null:
return $default(_that.lines,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransportLineResponse extends TransportLineResponse {
  const _TransportLineResponse({ List<TransportLine> lines = const <TransportLine>[], this.code, this.message}): _lines = lines,super._();
  factory _TransportLineResponse.fromJson(Map<String, dynamic> json) => _$TransportLineResponseFromJson(json);

 final  List<TransportLine> _lines;
@override@JsonKey() List<TransportLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  Object? code;
@override final  String? message;

/// Create a copy of TransportLineResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransportLineResponseCopyWith<_TransportLineResponse> get copyWith => __$TransportLineResponseCopyWithImpl<_TransportLineResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransportLineResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransportLineResponse&&const DeepCollectionEquality().equals(other.lines, _lines)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_lines),const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'TransportLineResponse(lines: $lines, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TransportLineResponseCopyWith<$Res> implements $TransportLineResponseCopyWith<$Res> {
  factory _$TransportLineResponseCopyWith(_TransportLineResponse value, $Res Function(_TransportLineResponse) _then) = __$TransportLineResponseCopyWithImpl;
@override @useResult
$Res call({
 List<TransportLine> lines, Object? code, String? message
});




}
/// @nodoc
class __$TransportLineResponseCopyWithImpl<$Res>
    implements _$TransportLineResponseCopyWith<$Res> {
  __$TransportLineResponseCopyWithImpl(this._self, this._then);

  final _TransportLineResponse _self;
  final $Res Function(_TransportLineResponse) _then;

/// Create a copy of TransportLineResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lines = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(_TransportLineResponse(
lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<TransportLine>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CityCardTypesResponse {

 Map<String, String> get types;
/// Create a copy of CityCardTypesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCardTypesResponseCopyWith<CityCardTypesResponse> get copyWith => _$CityCardTypesResponseCopyWithImpl<CityCardTypesResponse>(this as CityCardTypesResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CityCardTypesResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityCardTypesResponse&&const DeepCollectionEquality().equals(other.types, _this.types));
}


@override
int get hashCode {
  final _this = this as CityCardTypesResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.types));
}

@override
String toString() {
  final _this = this as CityCardTypesResponse;
  return 'CityCardTypesResponse(types: ${_this.types})';
}


}

/// @nodoc
abstract mixin class $CityCardTypesResponseCopyWith<$Res>  {
  factory $CityCardTypesResponseCopyWith(CityCardTypesResponse value, $Res Function(CityCardTypesResponse) _then) = _$CityCardTypesResponseCopyWithImpl;
@useResult
$Res call({
 Map<String, String> types
});




}
/// @nodoc
class _$CityCardTypesResponseCopyWithImpl<$Res>
    implements $CityCardTypesResponseCopyWith<$Res> {
  _$CityCardTypesResponseCopyWithImpl(this._self, this._then);

  final CityCardTypesResponse _self;
  final $Res Function(CityCardTypesResponse) _then;

/// Create a copy of CityCardTypesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? types = null,}) {
  return _then(CityCardTypesResponse(
types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CityCardTypesResponse].
extension CityCardTypesResponsePatterns on CityCardTypesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityCardTypesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityCardTypesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityCardTypesResponse value)  $default,){
final _that = this;
switch (_that) {
case _CityCardTypesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityCardTypesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CityCardTypesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String> types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityCardTypesResponse() when $default != null:
return $default(_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String> types)  $default,) {final _that = this;
switch (_that) {
case _CityCardTypesResponse():
return $default(_that.types);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String> types)?  $default,) {final _that = this;
switch (_that) {
case _CityCardTypesResponse() when $default != null:
return $default(_that.types);case _:
  return null;

}
}

}

/// @nodoc


class _CityCardTypesResponse extends CityCardTypesResponse {
  const _CityCardTypesResponse({ Map<String, String> types = const <String, String>{}}): _types = types,super._();
  

 final  Map<String, String> _types;
@override@JsonKey() Map<String, String> get types {
  if (_types is EqualUnmodifiableMapView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_types);
}


/// Create a copy of CityCardTypesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityCardTypesResponseCopyWith<_CityCardTypesResponse> get copyWith => __$CityCardTypesResponseCopyWithImpl<_CityCardTypesResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityCardTypesResponse&&const DeepCollectionEquality().equals(other.types, _types));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_types));
}

@override
String toString() {
    return 'CityCardTypesResponse(types: $types)';
}


}

/// @nodoc
abstract mixin class _$CityCardTypesResponseCopyWith<$Res> implements $CityCardTypesResponseCopyWith<$Res> {
  factory _$CityCardTypesResponseCopyWith(_CityCardTypesResponse value, $Res Function(_CityCardTypesResponse) _then) = __$CityCardTypesResponseCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> types
});




}
/// @nodoc
class __$CityCardTypesResponseCopyWithImpl<$Res>
    implements _$CityCardTypesResponseCopyWith<$Res> {
  __$CityCardTypesResponseCopyWithImpl(this._self, this._then);

  final _CityCardTypesResponse _self;
  final $Res Function(_CityCardTypesResponse) _then;

/// Create a copy of CityCardTypesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? types = null,}) {
  return _then(_CityCardTypesResponse(
types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
