// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PasswordPolicy {

 int? get minLength; int? get requiredLowercase; int? get requiredUppercase; int? get requiredDigits;
/// Create a copy of PasswordPolicy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordPolicyCopyWith<PasswordPolicy> get copyWith => _$PasswordPolicyCopyWithImpl<PasswordPolicy>(this as PasswordPolicy, _$identity);

  /// Serializes this PasswordPolicy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PasswordPolicy;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordPolicy&&(identical(other.minLength, _this.minLength) || other.minLength == _this.minLength)&&(identical(other.requiredLowercase, _this.requiredLowercase) || other.requiredLowercase == _this.requiredLowercase)&&(identical(other.requiredUppercase, _this.requiredUppercase) || other.requiredUppercase == _this.requiredUppercase)&&(identical(other.requiredDigits, _this.requiredDigits) || other.requiredDigits == _this.requiredDigits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PasswordPolicy;
  return Object.hash(runtimeType,_this.minLength,_this.requiredLowercase,_this.requiredUppercase,_this.requiredDigits);
}

@override
String toString() {
  final _this = this as PasswordPolicy;
  return 'PasswordPolicy(minLength: ${_this.minLength}, requiredLowercase: ${_this.requiredLowercase}, requiredUppercase: ${_this.requiredUppercase}, requiredDigits: ${_this.requiredDigits})';
}


}

/// @nodoc
abstract mixin class $PasswordPolicyCopyWith<$Res>  {
  factory $PasswordPolicyCopyWith(PasswordPolicy value, $Res Function(PasswordPolicy) _then) = _$PasswordPolicyCopyWithImpl;
@useResult
$Res call({
 int? minLength, int? requiredLowercase, int? requiredUppercase, int? requiredDigits
});




}
/// @nodoc
class _$PasswordPolicyCopyWithImpl<$Res>
    implements $PasswordPolicyCopyWith<$Res> {
  _$PasswordPolicyCopyWithImpl(this._self, this._then);

  final PasswordPolicy _self;
  final $Res Function(PasswordPolicy) _then;

/// Create a copy of PasswordPolicy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLength = freezed,Object? requiredLowercase = freezed,Object? requiredUppercase = freezed,Object? requiredDigits = freezed,}) {
  return _then(PasswordPolicy(
minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,requiredLowercase: freezed == requiredLowercase ? _self.requiredLowercase : requiredLowercase // ignore: cast_nullable_to_non_nullable
as int?,requiredUppercase: freezed == requiredUppercase ? _self.requiredUppercase : requiredUppercase // ignore: cast_nullable_to_non_nullable
as int?,requiredDigits: freezed == requiredDigits ? _self.requiredDigits : requiredDigits // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordPolicy].
extension PasswordPolicyPatterns on PasswordPolicy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordPolicy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordPolicy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordPolicy value)  $default,){
final _that = this;
switch (_that) {
case _PasswordPolicy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordPolicy value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordPolicy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? minLength,  int? requiredLowercase,  int? requiredUppercase,  int? requiredDigits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordPolicy() when $default != null:
return $default(_that.minLength,_that.requiredLowercase,_that.requiredUppercase,_that.requiredDigits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? minLength,  int? requiredLowercase,  int? requiredUppercase,  int? requiredDigits)  $default,) {final _that = this;
switch (_that) {
case _PasswordPolicy():
return $default(_that.minLength,_that.requiredLowercase,_that.requiredUppercase,_that.requiredDigits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? minLength,  int? requiredLowercase,  int? requiredUppercase,  int? requiredDigits)?  $default,) {final _that = this;
switch (_that) {
case _PasswordPolicy() when $default != null:
return $default(_that.minLength,_that.requiredLowercase,_that.requiredUppercase,_that.requiredDigits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PasswordPolicy implements PasswordPolicy {
  const _PasswordPolicy({this.minLength, this.requiredLowercase, this.requiredUppercase, this.requiredDigits});
  factory _PasswordPolicy.fromJson(Map<String, dynamic> json) => _$PasswordPolicyFromJson(json);

@override final  int? minLength;
@override final  int? requiredLowercase;
@override final  int? requiredUppercase;
@override final  int? requiredDigits;

/// Create a copy of PasswordPolicy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordPolicyCopyWith<_PasswordPolicy> get copyWith => __$PasswordPolicyCopyWithImpl<_PasswordPolicy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PasswordPolicyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordPolicy&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.requiredLowercase, requiredLowercase) || other.requiredLowercase == requiredLowercase)&&(identical(other.requiredUppercase, requiredUppercase) || other.requiredUppercase == requiredUppercase)&&(identical(other.requiredDigits, requiredDigits) || other.requiredDigits == requiredDigits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,minLength,requiredLowercase,requiredUppercase,requiredDigits);
}

@override
String toString() {
    return 'PasswordPolicy(minLength: $minLength, requiredLowercase: $requiredLowercase, requiredUppercase: $requiredUppercase, requiredDigits: $requiredDigits)';
}


}

/// @nodoc
abstract mixin class _$PasswordPolicyCopyWith<$Res> implements $PasswordPolicyCopyWith<$Res> {
  factory _$PasswordPolicyCopyWith(_PasswordPolicy value, $Res Function(_PasswordPolicy) _then) = __$PasswordPolicyCopyWithImpl;
@override @useResult
$Res call({
 int? minLength, int? requiredLowercase, int? requiredUppercase, int? requiredDigits
});




}
/// @nodoc
class __$PasswordPolicyCopyWithImpl<$Res>
    implements _$PasswordPolicyCopyWith<$Res> {
  __$PasswordPolicyCopyWithImpl(this._self, this._then);

  final _PasswordPolicy _self;
  final $Res Function(_PasswordPolicy) _then;

/// Create a copy of PasswordPolicy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLength = freezed,Object? requiredLowercase = freezed,Object? requiredUppercase = freezed,Object? requiredDigits = freezed,}) {
  return _then(_PasswordPolicy(
minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,requiredLowercase: freezed == requiredLowercase ? _self.requiredLowercase : requiredLowercase // ignore: cast_nullable_to_non_nullable
as int?,requiredUppercase: freezed == requiredUppercase ? _self.requiredUppercase : requiredUppercase // ignore: cast_nullable_to_non_nullable
as int?,requiredDigits: freezed == requiredDigits ? _self.requiredDigits : requiredDigits // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$MarketingConsent {

 int? get id; String? get content; bool? get isChecked;
/// Create a copy of MarketingConsent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketingConsentCopyWith<MarketingConsent> get copyWith => _$MarketingConsentCopyWithImpl<MarketingConsent>(this as MarketingConsent, _$identity);

  /// Serializes this MarketingConsent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MarketingConsent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketingConsent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.isChecked, _this.isChecked) || other.isChecked == _this.isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MarketingConsent;
  return Object.hash(runtimeType,_this.id,_this.content,_this.isChecked);
}

@override
String toString() {
  final _this = this as MarketingConsent;
  return 'MarketingConsent(id: ${_this.id}, content: ${_this.content}, isChecked: ${_this.isChecked})';
}


}

/// @nodoc
abstract mixin class $MarketingConsentCopyWith<$Res>  {
  factory $MarketingConsentCopyWith(MarketingConsent value, $Res Function(MarketingConsent) _then) = _$MarketingConsentCopyWithImpl;
@useResult
$Res call({
 int? id, String? content, bool? isChecked
});




}
/// @nodoc
class _$MarketingConsentCopyWithImpl<$Res>
    implements $MarketingConsentCopyWith<$Res> {
  _$MarketingConsentCopyWithImpl(this._self, this._then);

  final MarketingConsent _self;
  final $Res Function(MarketingConsent) _then;

/// Create a copy of MarketingConsent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? content = freezed,Object? isChecked = freezed,}) {
  return _then(MarketingConsent(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,isChecked: freezed == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketingConsent].
extension MarketingConsentPatterns on MarketingConsent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketingConsent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketingConsent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketingConsent value)  $default,){
final _that = this;
switch (_that) {
case _MarketingConsent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketingConsent value)?  $default,){
final _that = this;
switch (_that) {
case _MarketingConsent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? content,  bool? isChecked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketingConsent() when $default != null:
return $default(_that.id,_that.content,_that.isChecked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? content,  bool? isChecked)  $default,) {final _that = this;
switch (_that) {
case _MarketingConsent():
return $default(_that.id,_that.content,_that.isChecked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? content,  bool? isChecked)?  $default,) {final _that = this;
switch (_that) {
case _MarketingConsent() when $default != null:
return $default(_that.id,_that.content,_that.isChecked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketingConsent implements MarketingConsent {
  const _MarketingConsent({this.id, this.content, this.isChecked});
  factory _MarketingConsent.fromJson(Map<String, dynamic> json) => _$MarketingConsentFromJson(json);

@override final  int? id;
@override final  String? content;
@override final  bool? isChecked;

/// Create a copy of MarketingConsent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketingConsentCopyWith<_MarketingConsent> get copyWith => __$MarketingConsentCopyWithImpl<_MarketingConsent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketingConsentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketingConsent&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,content,isChecked);
}

@override
String toString() {
    return 'MarketingConsent(id: $id, content: $content, isChecked: $isChecked)';
}


}

/// @nodoc
abstract mixin class _$MarketingConsentCopyWith<$Res> implements $MarketingConsentCopyWith<$Res> {
  factory _$MarketingConsentCopyWith(_MarketingConsent value, $Res Function(_MarketingConsent) _then) = __$MarketingConsentCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? content, bool? isChecked
});




}
/// @nodoc
class __$MarketingConsentCopyWithImpl<$Res>
    implements _$MarketingConsentCopyWith<$Res> {
  __$MarketingConsentCopyWithImpl(this._self, this._then);

  final _MarketingConsent _self;
  final $Res Function(_MarketingConsent) _then;

/// Create a copy of MarketingConsent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? content = freezed,Object? isChecked = freezed,}) {
  return _then(_MarketingConsent(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,isChecked: freezed == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$MarketingConsentsResponse {

 List<MarketingConsent> get marketingConsents;
/// Create a copy of MarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketingConsentsResponseCopyWith<MarketingConsentsResponse> get copyWith => _$MarketingConsentsResponseCopyWithImpl<MarketingConsentsResponse>(this as MarketingConsentsResponse, _$identity);

  /// Serializes this MarketingConsentsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MarketingConsentsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketingConsentsResponse&&const DeepCollectionEquality().equals(other.marketingConsents, _this.marketingConsents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MarketingConsentsResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.marketingConsents));
}

@override
String toString() {
  final _this = this as MarketingConsentsResponse;
  return 'MarketingConsentsResponse(marketingConsents: ${_this.marketingConsents})';
}


}

/// @nodoc
abstract mixin class $MarketingConsentsResponseCopyWith<$Res>  {
  factory $MarketingConsentsResponseCopyWith(MarketingConsentsResponse value, $Res Function(MarketingConsentsResponse) _then) = _$MarketingConsentsResponseCopyWithImpl;
@useResult
$Res call({
 List<MarketingConsent> marketingConsents
});




}
/// @nodoc
class _$MarketingConsentsResponseCopyWithImpl<$Res>
    implements $MarketingConsentsResponseCopyWith<$Res> {
  _$MarketingConsentsResponseCopyWithImpl(this._self, this._then);

  final MarketingConsentsResponse _self;
  final $Res Function(MarketingConsentsResponse) _then;

/// Create a copy of MarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? marketingConsents = null,}) {
  return _then(MarketingConsentsResponse(
marketingConsents: null == marketingConsents ? _self.marketingConsents : marketingConsents // ignore: cast_nullable_to_non_nullable
as List<MarketingConsent>,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketingConsentsResponse].
extension MarketingConsentsResponsePatterns on MarketingConsentsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketingConsentsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketingConsentsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketingConsentsResponse value)  $default,){
final _that = this;
switch (_that) {
case _MarketingConsentsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketingConsentsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MarketingConsentsResponse() when $default != null:
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
case _MarketingConsentsResponse() when $default != null:
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
case _MarketingConsentsResponse():
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
case _MarketingConsentsResponse() when $default != null:
return $default(_that.marketingConsents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketingConsentsResponse implements MarketingConsentsResponse {
  const _MarketingConsentsResponse({ List<MarketingConsent> marketingConsents = const <MarketingConsent>[]}): _marketingConsents = marketingConsents;
  factory _MarketingConsentsResponse.fromJson(Map<String, dynamic> json) => _$MarketingConsentsResponseFromJson(json);

 final  List<MarketingConsent> _marketingConsents;
@override@JsonKey() List<MarketingConsent> get marketingConsents {
  if (_marketingConsents is EqualUnmodifiableListView) return _marketingConsents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marketingConsents);
}


/// Create a copy of MarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketingConsentsResponseCopyWith<_MarketingConsentsResponse> get copyWith => __$MarketingConsentsResponseCopyWithImpl<_MarketingConsentsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketingConsentsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketingConsentsResponse&&const DeepCollectionEquality().equals(other.marketingConsents, _marketingConsents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_marketingConsents));
}

@override
String toString() {
    return 'MarketingConsentsResponse(marketingConsents: $marketingConsents)';
}


}

/// @nodoc
abstract mixin class _$MarketingConsentsResponseCopyWith<$Res> implements $MarketingConsentsResponseCopyWith<$Res> {
  factory _$MarketingConsentsResponseCopyWith(_MarketingConsentsResponse value, $Res Function(_MarketingConsentsResponse) _then) = __$MarketingConsentsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<MarketingConsent> marketingConsents
});




}
/// @nodoc
class __$MarketingConsentsResponseCopyWithImpl<$Res>
    implements _$MarketingConsentsResponseCopyWith<$Res> {
  __$MarketingConsentsResponseCopyWithImpl(this._self, this._then);

  final _MarketingConsentsResponse _self;
  final $Res Function(_MarketingConsentsResponse) _then;

/// Create a copy of MarketingConsentsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? marketingConsents = null,}) {
  return _then(_MarketingConsentsResponse(
marketingConsents: null == marketingConsents ? _self._marketingConsents : marketingConsents // ignore: cast_nullable_to_non_nullable
as List<MarketingConsent>,
  ));
}


}


/// @nodoc
mixin _$CodeMessageResponse {

 Object? get code; String? get message;
/// Create a copy of CodeMessageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeMessageResponseCopyWith<CodeMessageResponse> get copyWith => _$CodeMessageResponseCopyWithImpl<CodeMessageResponse>(this as CodeMessageResponse, _$identity);

  /// Serializes this CodeMessageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CodeMessageResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeMessageResponse&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CodeMessageResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as CodeMessageResponse;
  return 'CodeMessageResponse(code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $CodeMessageResponseCopyWith<$Res>  {
  factory $CodeMessageResponseCopyWith(CodeMessageResponse value, $Res Function(CodeMessageResponse) _then) = _$CodeMessageResponseCopyWithImpl;
@useResult
$Res call({
 Object? code, String? message
});




}
/// @nodoc
class _$CodeMessageResponseCopyWithImpl<$Res>
    implements $CodeMessageResponseCopyWith<$Res> {
  _$CodeMessageResponseCopyWithImpl(this._self, this._then);

  final CodeMessageResponse _self;
  final $Res Function(CodeMessageResponse) _then;

/// Create a copy of CodeMessageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(CodeMessageResponse(
code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CodeMessageResponse].
extension CodeMessageResponsePatterns on CodeMessageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CodeMessageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CodeMessageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CodeMessageResponse value)  $default,){
final _that = this;
switch (_that) {
case _CodeMessageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CodeMessageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CodeMessageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CodeMessageResponse() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _CodeMessageResponse():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _CodeMessageResponse() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CodeMessageResponse extends CodeMessageResponse {
  const _CodeMessageResponse({this.code, this.message}): super._();
  factory _CodeMessageResponse.fromJson(Map<String, dynamic> json) => _$CodeMessageResponseFromJson(json);

@override final  Object? code;
@override final  String? message;

/// Create a copy of CodeMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeMessageResponseCopyWith<_CodeMessageResponse> get copyWith => __$CodeMessageResponseCopyWithImpl<_CodeMessageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CodeMessageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeMessageResponse&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'CodeMessageResponse(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CodeMessageResponseCopyWith<$Res> implements $CodeMessageResponseCopyWith<$Res> {
  factory _$CodeMessageResponseCopyWith(_CodeMessageResponse value, $Res Function(_CodeMessageResponse) _then) = __$CodeMessageResponseCopyWithImpl;
@override @useResult
$Res call({
 Object? code, String? message
});




}
/// @nodoc
class __$CodeMessageResponseCopyWithImpl<$Res>
    implements _$CodeMessageResponseCopyWith<$Res> {
  __$CodeMessageResponseCopyWithImpl(this._self, this._then);

  final _CodeMessageResponse _self;
  final $Res Function(_CodeMessageResponse) _then;

/// Create a copy of CodeMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(_CodeMessageResponse(
code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
