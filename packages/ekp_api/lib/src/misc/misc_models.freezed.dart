// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'misc_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceStatus {

 bool? get isAvailable; String? get customMessage;
/// Create a copy of ServiceStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceStatusCopyWith<ServiceStatus> get copyWith => _$ServiceStatusCopyWithImpl<ServiceStatus>(this as ServiceStatus, _$identity);

  /// Serializes this ServiceStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServiceStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceStatus&&(identical(other.isAvailable, _this.isAvailable) || other.isAvailable == _this.isAvailable)&&(identical(other.customMessage, _this.customMessage) || other.customMessage == _this.customMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServiceStatus;
  return Object.hash(runtimeType,_this.isAvailable,_this.customMessage);
}

@override
String toString() {
  final _this = this as ServiceStatus;
  return 'ServiceStatus(isAvailable: ${_this.isAvailable}, customMessage: ${_this.customMessage})';
}


}

/// @nodoc
abstract mixin class $ServiceStatusCopyWith<$Res>  {
  factory $ServiceStatusCopyWith(ServiceStatus value, $Res Function(ServiceStatus) _then) = _$ServiceStatusCopyWithImpl;
@useResult
$Res call({
 bool? isAvailable, String? customMessage
});




}
/// @nodoc
class _$ServiceStatusCopyWithImpl<$Res>
    implements $ServiceStatusCopyWith<$Res> {
  _$ServiceStatusCopyWithImpl(this._self, this._then);

  final ServiceStatus _self;
  final $Res Function(ServiceStatus) _then;

/// Create a copy of ServiceStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAvailable = freezed,Object? customMessage = freezed,}) {
  return _then(ServiceStatus(
isAvailable: freezed == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool?,customMessage: freezed == customMessage ? _self.customMessage : customMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceStatus].
extension ServiceStatusPatterns on ServiceStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceStatus value)  $default,){
final _that = this;
switch (_that) {
case _ServiceStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceStatus value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? isAvailable,  String? customMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceStatus() when $default != null:
return $default(_that.isAvailable,_that.customMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? isAvailable,  String? customMessage)  $default,) {final _that = this;
switch (_that) {
case _ServiceStatus():
return $default(_that.isAvailable,_that.customMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? isAvailable,  String? customMessage)?  $default,) {final _that = this;
switch (_that) {
case _ServiceStatus() when $default != null:
return $default(_that.isAvailable,_that.customMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceStatus implements ServiceStatus {
  const _ServiceStatus({this.isAvailable, this.customMessage});
  factory _ServiceStatus.fromJson(Map<String, dynamic> json) => _$ServiceStatusFromJson(json);

@override final  bool? isAvailable;
@override final  String? customMessage;

/// Create a copy of ServiceStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceStatusCopyWith<_ServiceStatus> get copyWith => __$ServiceStatusCopyWithImpl<_ServiceStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceStatusToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceStatus&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.customMessage, customMessage) || other.customMessage == customMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isAvailable,customMessage);
}

@override
String toString() {
    return 'ServiceStatus(isAvailable: $isAvailable, customMessage: $customMessage)';
}


}

/// @nodoc
abstract mixin class _$ServiceStatusCopyWith<$Res> implements $ServiceStatusCopyWith<$Res> {
  factory _$ServiceStatusCopyWith(_ServiceStatus value, $Res Function(_ServiceStatus) _then) = __$ServiceStatusCopyWithImpl;
@override @useResult
$Res call({
 bool? isAvailable, String? customMessage
});




}
/// @nodoc
class __$ServiceStatusCopyWithImpl<$Res>
    implements _$ServiceStatusCopyWith<$Res> {
  __$ServiceStatusCopyWithImpl(this._self, this._then);

  final _ServiceStatus _self;
  final $Res Function(_ServiceStatus) _then;

/// Create a copy of ServiceStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAvailable = freezed,Object? customMessage = freezed,}) {
  return _then(_ServiceStatus(
isAvailable: freezed == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool?,customMessage: freezed == customMessage ? _self.customMessage : customMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SalesAnnouncement {

 String? get text; DateTime? get startDate; DateTime? get endDate;
/// Create a copy of SalesAnnouncement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesAnnouncementCopyWith<SalesAnnouncement> get copyWith => _$SalesAnnouncementCopyWithImpl<SalesAnnouncement>(this as SalesAnnouncement, _$identity);

  /// Serializes this SalesAnnouncement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SalesAnnouncement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesAnnouncement&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SalesAnnouncement;
  return Object.hash(runtimeType,_this.text,_this.startDate,_this.endDate);
}

@override
String toString() {
  final _this = this as SalesAnnouncement;
  return 'SalesAnnouncement(text: ${_this.text}, startDate: ${_this.startDate}, endDate: ${_this.endDate})';
}


}

/// @nodoc
abstract mixin class $SalesAnnouncementCopyWith<$Res>  {
  factory $SalesAnnouncementCopyWith(SalesAnnouncement value, $Res Function(SalesAnnouncement) _then) = _$SalesAnnouncementCopyWithImpl;
@useResult
$Res call({
 String? text, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class _$SalesAnnouncementCopyWithImpl<$Res>
    implements $SalesAnnouncementCopyWith<$Res> {
  _$SalesAnnouncementCopyWithImpl(this._self, this._then);

  final SalesAnnouncement _self;
  final $Res Function(SalesAnnouncement) _then;

/// Create a copy of SalesAnnouncement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(SalesAnnouncement(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesAnnouncement].
extension SalesAnnouncementPatterns on SalesAnnouncement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesAnnouncement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesAnnouncement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesAnnouncement value)  $default,){
final _that = this;
switch (_that) {
case _SalesAnnouncement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesAnnouncement value)?  $default,){
final _that = this;
switch (_that) {
case _SalesAnnouncement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text,  DateTime? startDate,  DateTime? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesAnnouncement() when $default != null:
return $default(_that.text,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text,  DateTime? startDate,  DateTime? endDate)  $default,) {final _that = this;
switch (_that) {
case _SalesAnnouncement():
return $default(_that.text,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text,  DateTime? startDate,  DateTime? endDate)?  $default,) {final _that = this;
switch (_that) {
case _SalesAnnouncement() when $default != null:
return $default(_that.text,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SalesAnnouncement implements SalesAnnouncement {
  const _SalesAnnouncement({this.text, this.startDate, this.endDate});
  factory _SalesAnnouncement.fromJson(Map<String, dynamic> json) => _$SalesAnnouncementFromJson(json);

@override final  String? text;
@override final  DateTime? startDate;
@override final  DateTime? endDate;

/// Create a copy of SalesAnnouncement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesAnnouncementCopyWith<_SalesAnnouncement> get copyWith => __$SalesAnnouncementCopyWithImpl<_SalesAnnouncement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalesAnnouncementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesAnnouncement&&(identical(other.text, text) || other.text == text)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,text,startDate,endDate);
}

@override
String toString() {
    return 'SalesAnnouncement(text: $text, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$SalesAnnouncementCopyWith<$Res> implements $SalesAnnouncementCopyWith<$Res> {
  factory _$SalesAnnouncementCopyWith(_SalesAnnouncement value, $Res Function(_SalesAnnouncement) _then) = __$SalesAnnouncementCopyWithImpl;
@override @useResult
$Res call({
 String? text, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class __$SalesAnnouncementCopyWithImpl<$Res>
    implements _$SalesAnnouncementCopyWith<$Res> {
  __$SalesAnnouncementCopyWithImpl(this._self, this._then);

  final _SalesAnnouncement _self;
  final $Res Function(_SalesAnnouncement) _then;

/// Create a copy of SalesAnnouncement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_SalesAnnouncement(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$MobileAppConfig {

 String? get minAppVersion; String? get customerPageUrl; String? get regulationsUrl; String? get declarationOfAccessibilityUrl; String? get regulations5plus1Url; String? get regulationsPurchaseUrl; String? get informationObligationUrl; String? get returnPaymentSuccessUrl; String? get returnPaymentErrorUrl; String? get busTimetableUrl; bool? get busTimetableEnabled; String? get tramTimetableUrl; bool? get tramTimetableEnabled; SalesAnnouncement? get salesViewAnnouncement; Object? get code; String? get message;
/// Create a copy of MobileAppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MobileAppConfigCopyWith<MobileAppConfig> get copyWith => _$MobileAppConfigCopyWithImpl<MobileAppConfig>(this as MobileAppConfig, _$identity);

  /// Serializes this MobileAppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MobileAppConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MobileAppConfig&&(identical(other.minAppVersion, _this.minAppVersion) || other.minAppVersion == _this.minAppVersion)&&(identical(other.customerPageUrl, _this.customerPageUrl) || other.customerPageUrl == _this.customerPageUrl)&&(identical(other.regulationsUrl, _this.regulationsUrl) || other.regulationsUrl == _this.regulationsUrl)&&(identical(other.declarationOfAccessibilityUrl, _this.declarationOfAccessibilityUrl) || other.declarationOfAccessibilityUrl == _this.declarationOfAccessibilityUrl)&&(identical(other.regulations5plus1Url, _this.regulations5plus1Url) || other.regulations5plus1Url == _this.regulations5plus1Url)&&(identical(other.regulationsPurchaseUrl, _this.regulationsPurchaseUrl) || other.regulationsPurchaseUrl == _this.regulationsPurchaseUrl)&&(identical(other.informationObligationUrl, _this.informationObligationUrl) || other.informationObligationUrl == _this.informationObligationUrl)&&(identical(other.returnPaymentSuccessUrl, _this.returnPaymentSuccessUrl) || other.returnPaymentSuccessUrl == _this.returnPaymentSuccessUrl)&&(identical(other.returnPaymentErrorUrl, _this.returnPaymentErrorUrl) || other.returnPaymentErrorUrl == _this.returnPaymentErrorUrl)&&(identical(other.busTimetableUrl, _this.busTimetableUrl) || other.busTimetableUrl == _this.busTimetableUrl)&&(identical(other.busTimetableEnabled, _this.busTimetableEnabled) || other.busTimetableEnabled == _this.busTimetableEnabled)&&(identical(other.tramTimetableUrl, _this.tramTimetableUrl) || other.tramTimetableUrl == _this.tramTimetableUrl)&&(identical(other.tramTimetableEnabled, _this.tramTimetableEnabled) || other.tramTimetableEnabled == _this.tramTimetableEnabled)&&(identical(other.salesViewAnnouncement, _this.salesViewAnnouncement) || other.salesViewAnnouncement == _this.salesViewAnnouncement)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MobileAppConfig;
  return Object.hash(runtimeType,_this.minAppVersion,_this.customerPageUrl,_this.regulationsUrl,_this.declarationOfAccessibilityUrl,_this.regulations5plus1Url,_this.regulationsPurchaseUrl,_this.informationObligationUrl,_this.returnPaymentSuccessUrl,_this.returnPaymentErrorUrl,_this.busTimetableUrl,_this.busTimetableEnabled,_this.tramTimetableUrl,_this.tramTimetableEnabled,_this.salesViewAnnouncement,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as MobileAppConfig;
  return 'MobileAppConfig(minAppVersion: ${_this.minAppVersion}, customerPageUrl: ${_this.customerPageUrl}, regulationsUrl: ${_this.regulationsUrl}, declarationOfAccessibilityUrl: ${_this.declarationOfAccessibilityUrl}, regulations5plus1Url: ${_this.regulations5plus1Url}, regulationsPurchaseUrl: ${_this.regulationsPurchaseUrl}, informationObligationUrl: ${_this.informationObligationUrl}, returnPaymentSuccessUrl: ${_this.returnPaymentSuccessUrl}, returnPaymentErrorUrl: ${_this.returnPaymentErrorUrl}, busTimetableUrl: ${_this.busTimetableUrl}, busTimetableEnabled: ${_this.busTimetableEnabled}, tramTimetableUrl: ${_this.tramTimetableUrl}, tramTimetableEnabled: ${_this.tramTimetableEnabled}, salesViewAnnouncement: ${_this.salesViewAnnouncement}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $MobileAppConfigCopyWith<$Res>  {
  factory $MobileAppConfigCopyWith(MobileAppConfig value, $Res Function(MobileAppConfig) _then) = _$MobileAppConfigCopyWithImpl;
@useResult
$Res call({
 String? minAppVersion, String? customerPageUrl, String? regulationsUrl, String? declarationOfAccessibilityUrl, String? regulations5plus1Url, String? regulationsPurchaseUrl, String? informationObligationUrl, String? returnPaymentSuccessUrl, String? returnPaymentErrorUrl, String? busTimetableUrl, bool? busTimetableEnabled, String? tramTimetableUrl, bool? tramTimetableEnabled, SalesAnnouncement? salesViewAnnouncement, Object? code, String? message
});


$SalesAnnouncementCopyWith<$Res>? get salesViewAnnouncement;

}
/// @nodoc
class _$MobileAppConfigCopyWithImpl<$Res>
    implements $MobileAppConfigCopyWith<$Res> {
  _$MobileAppConfigCopyWithImpl(this._self, this._then);

  final MobileAppConfig _self;
  final $Res Function(MobileAppConfig) _then;

/// Create a copy of MobileAppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minAppVersion = freezed,Object? customerPageUrl = freezed,Object? regulationsUrl = freezed,Object? declarationOfAccessibilityUrl = freezed,Object? regulations5plus1Url = freezed,Object? regulationsPurchaseUrl = freezed,Object? informationObligationUrl = freezed,Object? returnPaymentSuccessUrl = freezed,Object? returnPaymentErrorUrl = freezed,Object? busTimetableUrl = freezed,Object? busTimetableEnabled = freezed,Object? tramTimetableUrl = freezed,Object? tramTimetableEnabled = freezed,Object? salesViewAnnouncement = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(MobileAppConfig(
minAppVersion: freezed == minAppVersion ? _self.minAppVersion : minAppVersion // ignore: cast_nullable_to_non_nullable
as String?,customerPageUrl: freezed == customerPageUrl ? _self.customerPageUrl : customerPageUrl // ignore: cast_nullable_to_non_nullable
as String?,regulationsUrl: freezed == regulationsUrl ? _self.regulationsUrl : regulationsUrl // ignore: cast_nullable_to_non_nullable
as String?,declarationOfAccessibilityUrl: freezed == declarationOfAccessibilityUrl ? _self.declarationOfAccessibilityUrl : declarationOfAccessibilityUrl // ignore: cast_nullable_to_non_nullable
as String?,regulations5plus1Url: freezed == regulations5plus1Url ? _self.regulations5plus1Url : regulations5plus1Url // ignore: cast_nullable_to_non_nullable
as String?,regulationsPurchaseUrl: freezed == regulationsPurchaseUrl ? _self.regulationsPurchaseUrl : regulationsPurchaseUrl // ignore: cast_nullable_to_non_nullable
as String?,informationObligationUrl: freezed == informationObligationUrl ? _self.informationObligationUrl : informationObligationUrl // ignore: cast_nullable_to_non_nullable
as String?,returnPaymentSuccessUrl: freezed == returnPaymentSuccessUrl ? _self.returnPaymentSuccessUrl : returnPaymentSuccessUrl // ignore: cast_nullable_to_non_nullable
as String?,returnPaymentErrorUrl: freezed == returnPaymentErrorUrl ? _self.returnPaymentErrorUrl : returnPaymentErrorUrl // ignore: cast_nullable_to_non_nullable
as String?,busTimetableUrl: freezed == busTimetableUrl ? _self.busTimetableUrl : busTimetableUrl // ignore: cast_nullable_to_non_nullable
as String?,busTimetableEnabled: freezed == busTimetableEnabled ? _self.busTimetableEnabled : busTimetableEnabled // ignore: cast_nullable_to_non_nullable
as bool?,tramTimetableUrl: freezed == tramTimetableUrl ? _self.tramTimetableUrl : tramTimetableUrl // ignore: cast_nullable_to_non_nullable
as String?,tramTimetableEnabled: freezed == tramTimetableEnabled ? _self.tramTimetableEnabled : tramTimetableEnabled // ignore: cast_nullable_to_non_nullable
as bool?,salesViewAnnouncement: freezed == salesViewAnnouncement ? _self.salesViewAnnouncement : salesViewAnnouncement // ignore: cast_nullable_to_non_nullable
as SalesAnnouncement?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MobileAppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesAnnouncementCopyWith<$Res>? get salesViewAnnouncement {
    if (_self.salesViewAnnouncement == null) {
    return null;
  }

  return $SalesAnnouncementCopyWith<$Res>(_self.salesViewAnnouncement!, (value) {
    return _then(_self.copyWith(salesViewAnnouncement: value));
  });
}
}


/// Adds pattern-matching-related methods to [MobileAppConfig].
extension MobileAppConfigPatterns on MobileAppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MobileAppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MobileAppConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MobileAppConfig value)  $default,){
final _that = this;
switch (_that) {
case _MobileAppConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MobileAppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _MobileAppConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? minAppVersion,  String? customerPageUrl,  String? regulationsUrl,  String? declarationOfAccessibilityUrl,  String? regulations5plus1Url,  String? regulationsPurchaseUrl,  String? informationObligationUrl,  String? returnPaymentSuccessUrl,  String? returnPaymentErrorUrl,  String? busTimetableUrl,  bool? busTimetableEnabled,  String? tramTimetableUrl,  bool? tramTimetableEnabled,  SalesAnnouncement? salesViewAnnouncement,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MobileAppConfig() when $default != null:
return $default(_that.minAppVersion,_that.customerPageUrl,_that.regulationsUrl,_that.declarationOfAccessibilityUrl,_that.regulations5plus1Url,_that.regulationsPurchaseUrl,_that.informationObligationUrl,_that.returnPaymentSuccessUrl,_that.returnPaymentErrorUrl,_that.busTimetableUrl,_that.busTimetableEnabled,_that.tramTimetableUrl,_that.tramTimetableEnabled,_that.salesViewAnnouncement,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? minAppVersion,  String? customerPageUrl,  String? regulationsUrl,  String? declarationOfAccessibilityUrl,  String? regulations5plus1Url,  String? regulationsPurchaseUrl,  String? informationObligationUrl,  String? returnPaymentSuccessUrl,  String? returnPaymentErrorUrl,  String? busTimetableUrl,  bool? busTimetableEnabled,  String? tramTimetableUrl,  bool? tramTimetableEnabled,  SalesAnnouncement? salesViewAnnouncement,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _MobileAppConfig():
return $default(_that.minAppVersion,_that.customerPageUrl,_that.regulationsUrl,_that.declarationOfAccessibilityUrl,_that.regulations5plus1Url,_that.regulationsPurchaseUrl,_that.informationObligationUrl,_that.returnPaymentSuccessUrl,_that.returnPaymentErrorUrl,_that.busTimetableUrl,_that.busTimetableEnabled,_that.tramTimetableUrl,_that.tramTimetableEnabled,_that.salesViewAnnouncement,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? minAppVersion,  String? customerPageUrl,  String? regulationsUrl,  String? declarationOfAccessibilityUrl,  String? regulations5plus1Url,  String? regulationsPurchaseUrl,  String? informationObligationUrl,  String? returnPaymentSuccessUrl,  String? returnPaymentErrorUrl,  String? busTimetableUrl,  bool? busTimetableEnabled,  String? tramTimetableUrl,  bool? tramTimetableEnabled,  SalesAnnouncement? salesViewAnnouncement,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _MobileAppConfig() when $default != null:
return $default(_that.minAppVersion,_that.customerPageUrl,_that.regulationsUrl,_that.declarationOfAccessibilityUrl,_that.regulations5plus1Url,_that.regulationsPurchaseUrl,_that.informationObligationUrl,_that.returnPaymentSuccessUrl,_that.returnPaymentErrorUrl,_that.busTimetableUrl,_that.busTimetableEnabled,_that.tramTimetableUrl,_that.tramTimetableEnabled,_that.salesViewAnnouncement,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MobileAppConfig extends MobileAppConfig {
  const _MobileAppConfig({this.minAppVersion, this.customerPageUrl, this.regulationsUrl, this.declarationOfAccessibilityUrl, this.regulations5plus1Url, this.regulationsPurchaseUrl, this.informationObligationUrl, this.returnPaymentSuccessUrl, this.returnPaymentErrorUrl, this.busTimetableUrl, this.busTimetableEnabled, this.tramTimetableUrl, this.tramTimetableEnabled, this.salesViewAnnouncement, this.code, this.message}): super._();
  factory _MobileAppConfig.fromJson(Map<String, dynamic> json) => _$MobileAppConfigFromJson(json);

@override final  String? minAppVersion;
@override final  String? customerPageUrl;
@override final  String? regulationsUrl;
@override final  String? declarationOfAccessibilityUrl;
@override final  String? regulations5plus1Url;
@override final  String? regulationsPurchaseUrl;
@override final  String? informationObligationUrl;
@override final  String? returnPaymentSuccessUrl;
@override final  String? returnPaymentErrorUrl;
@override final  String? busTimetableUrl;
@override final  bool? busTimetableEnabled;
@override final  String? tramTimetableUrl;
@override final  bool? tramTimetableEnabled;
@override final  SalesAnnouncement? salesViewAnnouncement;
@override final  Object? code;
@override final  String? message;

/// Create a copy of MobileAppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MobileAppConfigCopyWith<_MobileAppConfig> get copyWith => __$MobileAppConfigCopyWithImpl<_MobileAppConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MobileAppConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MobileAppConfig&&(identical(other.minAppVersion, minAppVersion) || other.minAppVersion == minAppVersion)&&(identical(other.customerPageUrl, customerPageUrl) || other.customerPageUrl == customerPageUrl)&&(identical(other.regulationsUrl, regulationsUrl) || other.regulationsUrl == regulationsUrl)&&(identical(other.declarationOfAccessibilityUrl, declarationOfAccessibilityUrl) || other.declarationOfAccessibilityUrl == declarationOfAccessibilityUrl)&&(identical(other.regulations5plus1Url, regulations5plus1Url) || other.regulations5plus1Url == regulations5plus1Url)&&(identical(other.regulationsPurchaseUrl, regulationsPurchaseUrl) || other.regulationsPurchaseUrl == regulationsPurchaseUrl)&&(identical(other.informationObligationUrl, informationObligationUrl) || other.informationObligationUrl == informationObligationUrl)&&(identical(other.returnPaymentSuccessUrl, returnPaymentSuccessUrl) || other.returnPaymentSuccessUrl == returnPaymentSuccessUrl)&&(identical(other.returnPaymentErrorUrl, returnPaymentErrorUrl) || other.returnPaymentErrorUrl == returnPaymentErrorUrl)&&(identical(other.busTimetableUrl, busTimetableUrl) || other.busTimetableUrl == busTimetableUrl)&&(identical(other.busTimetableEnabled, busTimetableEnabled) || other.busTimetableEnabled == busTimetableEnabled)&&(identical(other.tramTimetableUrl, tramTimetableUrl) || other.tramTimetableUrl == tramTimetableUrl)&&(identical(other.tramTimetableEnabled, tramTimetableEnabled) || other.tramTimetableEnabled == tramTimetableEnabled)&&(identical(other.salesViewAnnouncement, salesViewAnnouncement) || other.salesViewAnnouncement == salesViewAnnouncement)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,minAppVersion,customerPageUrl,regulationsUrl,declarationOfAccessibilityUrl,regulations5plus1Url,regulationsPurchaseUrl,informationObligationUrl,returnPaymentSuccessUrl,returnPaymentErrorUrl,busTimetableUrl,busTimetableEnabled,tramTimetableUrl,tramTimetableEnabled,salesViewAnnouncement,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'MobileAppConfig(minAppVersion: $minAppVersion, customerPageUrl: $customerPageUrl, regulationsUrl: $regulationsUrl, declarationOfAccessibilityUrl: $declarationOfAccessibilityUrl, regulations5plus1Url: $regulations5plus1Url, regulationsPurchaseUrl: $regulationsPurchaseUrl, informationObligationUrl: $informationObligationUrl, returnPaymentSuccessUrl: $returnPaymentSuccessUrl, returnPaymentErrorUrl: $returnPaymentErrorUrl, busTimetableUrl: $busTimetableUrl, busTimetableEnabled: $busTimetableEnabled, tramTimetableUrl: $tramTimetableUrl, tramTimetableEnabled: $tramTimetableEnabled, salesViewAnnouncement: $salesViewAnnouncement, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$MobileAppConfigCopyWith<$Res> implements $MobileAppConfigCopyWith<$Res> {
  factory _$MobileAppConfigCopyWith(_MobileAppConfig value, $Res Function(_MobileAppConfig) _then) = __$MobileAppConfigCopyWithImpl;
@override @useResult
$Res call({
 String? minAppVersion, String? customerPageUrl, String? regulationsUrl, String? declarationOfAccessibilityUrl, String? regulations5plus1Url, String? regulationsPurchaseUrl, String? informationObligationUrl, String? returnPaymentSuccessUrl, String? returnPaymentErrorUrl, String? busTimetableUrl, bool? busTimetableEnabled, String? tramTimetableUrl, bool? tramTimetableEnabled, SalesAnnouncement? salesViewAnnouncement, Object? code, String? message
});


@override $SalesAnnouncementCopyWith<$Res>? get salesViewAnnouncement;

}
/// @nodoc
class __$MobileAppConfigCopyWithImpl<$Res>
    implements _$MobileAppConfigCopyWith<$Res> {
  __$MobileAppConfigCopyWithImpl(this._self, this._then);

  final _MobileAppConfig _self;
  final $Res Function(_MobileAppConfig) _then;

/// Create a copy of MobileAppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minAppVersion = freezed,Object? customerPageUrl = freezed,Object? regulationsUrl = freezed,Object? declarationOfAccessibilityUrl = freezed,Object? regulations5plus1Url = freezed,Object? regulationsPurchaseUrl = freezed,Object? informationObligationUrl = freezed,Object? returnPaymentSuccessUrl = freezed,Object? returnPaymentErrorUrl = freezed,Object? busTimetableUrl = freezed,Object? busTimetableEnabled = freezed,Object? tramTimetableUrl = freezed,Object? tramTimetableEnabled = freezed,Object? salesViewAnnouncement = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_MobileAppConfig(
minAppVersion: freezed == minAppVersion ? _self.minAppVersion : minAppVersion // ignore: cast_nullable_to_non_nullable
as String?,customerPageUrl: freezed == customerPageUrl ? _self.customerPageUrl : customerPageUrl // ignore: cast_nullable_to_non_nullable
as String?,regulationsUrl: freezed == regulationsUrl ? _self.regulationsUrl : regulationsUrl // ignore: cast_nullable_to_non_nullable
as String?,declarationOfAccessibilityUrl: freezed == declarationOfAccessibilityUrl ? _self.declarationOfAccessibilityUrl : declarationOfAccessibilityUrl // ignore: cast_nullable_to_non_nullable
as String?,regulations5plus1Url: freezed == regulations5plus1Url ? _self.regulations5plus1Url : regulations5plus1Url // ignore: cast_nullable_to_non_nullable
as String?,regulationsPurchaseUrl: freezed == regulationsPurchaseUrl ? _self.regulationsPurchaseUrl : regulationsPurchaseUrl // ignore: cast_nullable_to_non_nullable
as String?,informationObligationUrl: freezed == informationObligationUrl ? _self.informationObligationUrl : informationObligationUrl // ignore: cast_nullable_to_non_nullable
as String?,returnPaymentSuccessUrl: freezed == returnPaymentSuccessUrl ? _self.returnPaymentSuccessUrl : returnPaymentSuccessUrl // ignore: cast_nullable_to_non_nullable
as String?,returnPaymentErrorUrl: freezed == returnPaymentErrorUrl ? _self.returnPaymentErrorUrl : returnPaymentErrorUrl // ignore: cast_nullable_to_non_nullable
as String?,busTimetableUrl: freezed == busTimetableUrl ? _self.busTimetableUrl : busTimetableUrl // ignore: cast_nullable_to_non_nullable
as String?,busTimetableEnabled: freezed == busTimetableEnabled ? _self.busTimetableEnabled : busTimetableEnabled // ignore: cast_nullable_to_non_nullable
as bool?,tramTimetableUrl: freezed == tramTimetableUrl ? _self.tramTimetableUrl : tramTimetableUrl // ignore: cast_nullable_to_non_nullable
as String?,tramTimetableEnabled: freezed == tramTimetableEnabled ? _self.tramTimetableEnabled : tramTimetableEnabled // ignore: cast_nullable_to_non_nullable
as bool?,salesViewAnnouncement: freezed == salesViewAnnouncement ? _self.salesViewAnnouncement : salesViewAnnouncement // ignore: cast_nullable_to_non_nullable
as SalesAnnouncement?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MobileAppConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesAnnouncementCopyWith<$Res>? get salesViewAnnouncement {
    if (_self.salesViewAnnouncement == null) {
    return null;
  }

  return $SalesAnnouncementCopyWith<$Res>(_self.salesViewAnnouncement!, (value) {
    return _then(_self.copyWith(salesViewAnnouncement: value));
  });
}
}

// dart format on
