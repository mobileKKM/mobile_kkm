// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvoiceListResponse {

 List<dynamic> get list; int? get rowCount;
/// Create a copy of InvoiceListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceListResponseCopyWith<InvoiceListResponse> get copyWith => _$InvoiceListResponseCopyWithImpl<InvoiceListResponse>(this as InvoiceListResponse, _$identity);

  /// Serializes this InvoiceListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InvoiceListResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceListResponse&&const DeepCollectionEquality().equals(other.list, _this.list)&&(identical(other.rowCount, _this.rowCount) || other.rowCount == _this.rowCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InvoiceListResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.list),_this.rowCount);
}

@override
String toString() {
  final _this = this as InvoiceListResponse;
  return 'InvoiceListResponse(list: ${_this.list}, rowCount: ${_this.rowCount})';
}


}

/// @nodoc
abstract mixin class $InvoiceListResponseCopyWith<$Res>  {
  factory $InvoiceListResponseCopyWith(InvoiceListResponse value, $Res Function(InvoiceListResponse) _then) = _$InvoiceListResponseCopyWithImpl;
@useResult
$Res call({
 List<dynamic> list, int? rowCount
});




}
/// @nodoc
class _$InvoiceListResponseCopyWithImpl<$Res>
    implements $InvoiceListResponseCopyWith<$Res> {
  _$InvoiceListResponseCopyWithImpl(this._self, this._then);

  final InvoiceListResponse _self;
  final $Res Function(InvoiceListResponse) _then;

/// Create a copy of InvoiceListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,Object? rowCount = freezed,}) {
  return _then(InvoiceListResponse(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<dynamic>,rowCount: freezed == rowCount ? _self.rowCount : rowCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceListResponse].
extension InvoiceListResponsePatterns on InvoiceListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceListResponse value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<dynamic> list,  int? rowCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceListResponse() when $default != null:
return $default(_that.list,_that.rowCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<dynamic> list,  int? rowCount)  $default,) {final _that = this;
switch (_that) {
case _InvoiceListResponse():
return $default(_that.list,_that.rowCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<dynamic> list,  int? rowCount)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceListResponse() when $default != null:
return $default(_that.list,_that.rowCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceListResponse implements InvoiceListResponse {
  const _InvoiceListResponse({ List<dynamic> list = const <dynamic>[], this.rowCount}): _list = list;
  factory _InvoiceListResponse.fromJson(Map<String, dynamic> json) => _$InvoiceListResponseFromJson(json);

 final  List<dynamic> _list;
@override@JsonKey() List<dynamic> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

@override final  int? rowCount;

/// Create a copy of InvoiceListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceListResponseCopyWith<_InvoiceListResponse> get copyWith => __$InvoiceListResponseCopyWithImpl<_InvoiceListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceListResponse&&const DeepCollectionEquality().equals(other.list, _list)&&(identical(other.rowCount, rowCount) || other.rowCount == rowCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_list),rowCount);
}

@override
String toString() {
    return 'InvoiceListResponse(list: $list, rowCount: $rowCount)';
}


}

/// @nodoc
abstract mixin class _$InvoiceListResponseCopyWith<$Res> implements $InvoiceListResponseCopyWith<$Res> {
  factory _$InvoiceListResponseCopyWith(_InvoiceListResponse value, $Res Function(_InvoiceListResponse) _then) = __$InvoiceListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic> list, int? rowCount
});




}
/// @nodoc
class __$InvoiceListResponseCopyWithImpl<$Res>
    implements _$InvoiceListResponseCopyWith<$Res> {
  __$InvoiceListResponseCopyWithImpl(this._self, this._then);

  final _InvoiceListResponse _self;
  final $Res Function(_InvoiceListResponse) _then;

/// Create a copy of InvoiceListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,Object? rowCount = freezed,}) {
  return _then(_InvoiceListResponse(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<dynamic>,rowCount: freezed == rowCount ? _self.rowCount : rowCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
