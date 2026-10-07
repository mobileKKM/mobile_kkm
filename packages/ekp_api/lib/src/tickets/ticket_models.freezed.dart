// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MkkmTicket {

 String? get ticketGuid;/// Base64 transaction code — the id used by `GET /tickets/{id}`.
 String? get transactionCode; String? get status; DateTime? get datePurchase; DateTime? get startDate; DateTime? get endDate; int? get monthsPeriod; int? get daysPeriod; double? get price; bool? get isAnyAssigned; bool? get assigned; bool? get canAssign; bool? get forCitizen; int? get ticketKindCode; int? get ticketNumberOfLineCode; int? get ticketPeriodCode; String? get specialTransportLine; bool? get isNetwork; bool? get isMetropolitan;/// Selected transport lines for line-scoped tickets, as full
/// [TransportLine] objects (snake_case wire shape, same as the
/// `dictionary/transport-line` response).
 List<TransportLine> get lines; bool? get fivePlusOneTicket;/// Numeric customer code — only present in ticket detail responses.
 int? get customerId; int? get customerCode; int? get cityCardTypeCode; String? get productName; int? get paymentStateId; String? get paymentStateDescription; int? get paymentTypeCode; String? get paymentDescription; String? get promotionName; String? get cityCardTypeName;
/// Create a copy of MkkmTicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MkkmTicketCopyWith<MkkmTicket> get copyWith => _$MkkmTicketCopyWithImpl<MkkmTicket>(this as MkkmTicket, _$identity);

  /// Serializes this MkkmTicket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MkkmTicket;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MkkmTicket&&(identical(other.ticketGuid, _this.ticketGuid) || other.ticketGuid == _this.ticketGuid)&&(identical(other.transactionCode, _this.transactionCode) || other.transactionCode == _this.transactionCode)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.datePurchase, _this.datePurchase) || other.datePurchase == _this.datePurchase)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.monthsPeriod, _this.monthsPeriod) || other.monthsPeriod == _this.monthsPeriod)&&(identical(other.daysPeriod, _this.daysPeriod) || other.daysPeriod == _this.daysPeriod)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.isAnyAssigned, _this.isAnyAssigned) || other.isAnyAssigned == _this.isAnyAssigned)&&(identical(other.assigned, _this.assigned) || other.assigned == _this.assigned)&&(identical(other.canAssign, _this.canAssign) || other.canAssign == _this.canAssign)&&(identical(other.forCitizen, _this.forCitizen) || other.forCitizen == _this.forCitizen)&&(identical(other.ticketKindCode, _this.ticketKindCode) || other.ticketKindCode == _this.ticketKindCode)&&(identical(other.ticketNumberOfLineCode, _this.ticketNumberOfLineCode) || other.ticketNumberOfLineCode == _this.ticketNumberOfLineCode)&&(identical(other.ticketPeriodCode, _this.ticketPeriodCode) || other.ticketPeriodCode == _this.ticketPeriodCode)&&(identical(other.specialTransportLine, _this.specialTransportLine) || other.specialTransportLine == _this.specialTransportLine)&&(identical(other.isNetwork, _this.isNetwork) || other.isNetwork == _this.isNetwork)&&(identical(other.isMetropolitan, _this.isMetropolitan) || other.isMetropolitan == _this.isMetropolitan)&&const DeepCollectionEquality().equals(other.lines, _this.lines)&&(identical(other.fivePlusOneTicket, _this.fivePlusOneTicket) || other.fivePlusOneTicket == _this.fivePlusOneTicket)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.customerCode, _this.customerCode) || other.customerCode == _this.customerCode)&&(identical(other.cityCardTypeCode, _this.cityCardTypeCode) || other.cityCardTypeCode == _this.cityCardTypeCode)&&(identical(other.productName, _this.productName) || other.productName == _this.productName)&&(identical(other.paymentStateId, _this.paymentStateId) || other.paymentStateId == _this.paymentStateId)&&(identical(other.paymentStateDescription, _this.paymentStateDescription) || other.paymentStateDescription == _this.paymentStateDescription)&&(identical(other.paymentTypeCode, _this.paymentTypeCode) || other.paymentTypeCode == _this.paymentTypeCode)&&(identical(other.paymentDescription, _this.paymentDescription) || other.paymentDescription == _this.paymentDescription)&&(identical(other.promotionName, _this.promotionName) || other.promotionName == _this.promotionName)&&(identical(other.cityCardTypeName, _this.cityCardTypeName) || other.cityCardTypeName == _this.cityCardTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MkkmTicket;
  return Object.hashAll([runtimeType,_this.ticketGuid,_this.transactionCode,_this.status,_this.datePurchase,_this.startDate,_this.endDate,_this.monthsPeriod,_this.daysPeriod,_this.price,_this.isAnyAssigned,_this.assigned,_this.canAssign,_this.forCitizen,_this.ticketKindCode,_this.ticketNumberOfLineCode,_this.ticketPeriodCode,_this.specialTransportLine,_this.isNetwork,_this.isMetropolitan,const DeepCollectionEquality().hash(_this.lines),_this.fivePlusOneTicket,_this.customerId,_this.customerCode,_this.cityCardTypeCode,_this.productName,_this.paymentStateId,_this.paymentStateDescription,_this.paymentTypeCode,_this.paymentDescription,_this.promotionName,_this.cityCardTypeName]);
}

@override
String toString() {
  final _this = this as MkkmTicket;
  return 'MkkmTicket(ticketGuid: ${_this.ticketGuid}, transactionCode: ${_this.transactionCode}, status: ${_this.status}, datePurchase: ${_this.datePurchase}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, monthsPeriod: ${_this.monthsPeriod}, daysPeriod: ${_this.daysPeriod}, price: ${_this.price}, isAnyAssigned: ${_this.isAnyAssigned}, assigned: ${_this.assigned}, canAssign: ${_this.canAssign}, forCitizen: ${_this.forCitizen}, ticketKindCode: ${_this.ticketKindCode}, ticketNumberOfLineCode: ${_this.ticketNumberOfLineCode}, ticketPeriodCode: ${_this.ticketPeriodCode}, specialTransportLine: ${_this.specialTransportLine}, isNetwork: ${_this.isNetwork}, isMetropolitan: ${_this.isMetropolitan}, lines: ${_this.lines}, fivePlusOneTicket: ${_this.fivePlusOneTicket}, customerId: ${_this.customerId}, customerCode: ${_this.customerCode}, cityCardTypeCode: ${_this.cityCardTypeCode}, productName: ${_this.productName}, paymentStateId: ${_this.paymentStateId}, paymentStateDescription: ${_this.paymentStateDescription}, paymentTypeCode: ${_this.paymentTypeCode}, paymentDescription: ${_this.paymentDescription}, promotionName: ${_this.promotionName}, cityCardTypeName: ${_this.cityCardTypeName})';
}


}

/// @nodoc
abstract mixin class $MkkmTicketCopyWith<$Res>  {
  factory $MkkmTicketCopyWith(MkkmTicket value, $Res Function(MkkmTicket) _then) = _$MkkmTicketCopyWithImpl;
@useResult
$Res call({
 String? ticketGuid, String? transactionCode, String? status, DateTime? datePurchase, DateTime? startDate, DateTime? endDate, int? monthsPeriod, int? daysPeriod, double? price, bool? isAnyAssigned, bool? assigned, bool? canAssign, bool? forCitizen, int? ticketKindCode, int? ticketNumberOfLineCode, int? ticketPeriodCode, String? specialTransportLine, bool? isNetwork, bool? isMetropolitan, List<TransportLine> lines, bool? fivePlusOneTicket, int? customerId, int? customerCode, int? cityCardTypeCode, String? productName, int? paymentStateId, String? paymentStateDescription, int? paymentTypeCode, String? paymentDescription, String? promotionName, String? cityCardTypeName
});




}
/// @nodoc
class _$MkkmTicketCopyWithImpl<$Res>
    implements $MkkmTicketCopyWith<$Res> {
  _$MkkmTicketCopyWithImpl(this._self, this._then);

  final MkkmTicket _self;
  final $Res Function(MkkmTicket) _then;

/// Create a copy of MkkmTicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticketGuid = freezed,Object? transactionCode = freezed,Object? status = freezed,Object? datePurchase = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? monthsPeriod = freezed,Object? daysPeriod = freezed,Object? price = freezed,Object? isAnyAssigned = freezed,Object? assigned = freezed,Object? canAssign = freezed,Object? forCitizen = freezed,Object? ticketKindCode = freezed,Object? ticketNumberOfLineCode = freezed,Object? ticketPeriodCode = freezed,Object? specialTransportLine = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,Object? lines = null,Object? fivePlusOneTicket = freezed,Object? customerId = freezed,Object? customerCode = freezed,Object? cityCardTypeCode = freezed,Object? productName = freezed,Object? paymentStateId = freezed,Object? paymentStateDescription = freezed,Object? paymentTypeCode = freezed,Object? paymentDescription = freezed,Object? promotionName = freezed,Object? cityCardTypeName = freezed,}) {
  return _then(MkkmTicket(
ticketGuid: freezed == ticketGuid ? _self.ticketGuid : ticketGuid // ignore: cast_nullable_to_non_nullable
as String?,transactionCode: freezed == transactionCode ? _self.transactionCode : transactionCode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,datePurchase: freezed == datePurchase ? _self.datePurchase : datePurchase // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,monthsPeriod: freezed == monthsPeriod ? _self.monthsPeriod : monthsPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysPeriod: freezed == daysPeriod ? _self.daysPeriod : daysPeriod // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isAnyAssigned: freezed == isAnyAssigned ? _self.isAnyAssigned : isAnyAssigned // ignore: cast_nullable_to_non_nullable
as bool?,assigned: freezed == assigned ? _self.assigned : assigned // ignore: cast_nullable_to_non_nullable
as bool?,canAssign: freezed == canAssign ? _self.canAssign : canAssign // ignore: cast_nullable_to_non_nullable
as bool?,forCitizen: freezed == forCitizen ? _self.forCitizen : forCitizen // ignore: cast_nullable_to_non_nullable
as bool?,ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<TransportLine>,fivePlusOneTicket: freezed == fivePlusOneTicket ? _self.fivePlusOneTicket : fivePlusOneTicket // ignore: cast_nullable_to_non_nullable
as bool?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as int?,cityCardTypeCode: freezed == cityCardTypeCode ? _self.cityCardTypeCode : cityCardTypeCode // ignore: cast_nullable_to_non_nullable
as int?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,paymentStateId: freezed == paymentStateId ? _self.paymentStateId : paymentStateId // ignore: cast_nullable_to_non_nullable
as int?,paymentStateDescription: freezed == paymentStateDescription ? _self.paymentStateDescription : paymentStateDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentTypeCode: freezed == paymentTypeCode ? _self.paymentTypeCode : paymentTypeCode // ignore: cast_nullable_to_non_nullable
as int?,paymentDescription: freezed == paymentDescription ? _self.paymentDescription : paymentDescription // ignore: cast_nullable_to_non_nullable
as String?,promotionName: freezed == promotionName ? _self.promotionName : promotionName // ignore: cast_nullable_to_non_nullable
as String?,cityCardTypeName: freezed == cityCardTypeName ? _self.cityCardTypeName : cityCardTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MkkmTicket].
extension MkkmTicketPatterns on MkkmTicket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MkkmTicket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MkkmTicket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MkkmTicket value)  $default,){
final _that = this;
switch (_that) {
case _MkkmTicket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MkkmTicket value)?  $default,){
final _that = this;
switch (_that) {
case _MkkmTicket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? ticketGuid,  String? transactionCode,  String? status,  DateTime? datePurchase,  DateTime? startDate,  DateTime? endDate,  int? monthsPeriod,  int? daysPeriod,  double? price,  bool? isAnyAssigned,  bool? assigned,  bool? canAssign,  bool? forCitizen,  int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  List<TransportLine> lines,  bool? fivePlusOneTicket,  int? customerId,  int? customerCode,  int? cityCardTypeCode,  String? productName,  int? paymentStateId,  String? paymentStateDescription,  int? paymentTypeCode,  String? paymentDescription,  String? promotionName,  String? cityCardTypeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MkkmTicket() when $default != null:
return $default(_that.ticketGuid,_that.transactionCode,_that.status,_that.datePurchase,_that.startDate,_that.endDate,_that.monthsPeriod,_that.daysPeriod,_that.price,_that.isAnyAssigned,_that.assigned,_that.canAssign,_that.forCitizen,_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.lines,_that.fivePlusOneTicket,_that.customerId,_that.customerCode,_that.cityCardTypeCode,_that.productName,_that.paymentStateId,_that.paymentStateDescription,_that.paymentTypeCode,_that.paymentDescription,_that.promotionName,_that.cityCardTypeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? ticketGuid,  String? transactionCode,  String? status,  DateTime? datePurchase,  DateTime? startDate,  DateTime? endDate,  int? monthsPeriod,  int? daysPeriod,  double? price,  bool? isAnyAssigned,  bool? assigned,  bool? canAssign,  bool? forCitizen,  int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  List<TransportLine> lines,  bool? fivePlusOneTicket,  int? customerId,  int? customerCode,  int? cityCardTypeCode,  String? productName,  int? paymentStateId,  String? paymentStateDescription,  int? paymentTypeCode,  String? paymentDescription,  String? promotionName,  String? cityCardTypeName)  $default,) {final _that = this;
switch (_that) {
case _MkkmTicket():
return $default(_that.ticketGuid,_that.transactionCode,_that.status,_that.datePurchase,_that.startDate,_that.endDate,_that.monthsPeriod,_that.daysPeriod,_that.price,_that.isAnyAssigned,_that.assigned,_that.canAssign,_that.forCitizen,_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.lines,_that.fivePlusOneTicket,_that.customerId,_that.customerCode,_that.cityCardTypeCode,_that.productName,_that.paymentStateId,_that.paymentStateDescription,_that.paymentTypeCode,_that.paymentDescription,_that.promotionName,_that.cityCardTypeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? ticketGuid,  String? transactionCode,  String? status,  DateTime? datePurchase,  DateTime? startDate,  DateTime? endDate,  int? monthsPeriod,  int? daysPeriod,  double? price,  bool? isAnyAssigned,  bool? assigned,  bool? canAssign,  bool? forCitizen,  int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  List<TransportLine> lines,  bool? fivePlusOneTicket,  int? customerId,  int? customerCode,  int? cityCardTypeCode,  String? productName,  int? paymentStateId,  String? paymentStateDescription,  int? paymentTypeCode,  String? paymentDescription,  String? promotionName,  String? cityCardTypeName)?  $default,) {final _that = this;
switch (_that) {
case _MkkmTicket() when $default != null:
return $default(_that.ticketGuid,_that.transactionCode,_that.status,_that.datePurchase,_that.startDate,_that.endDate,_that.monthsPeriod,_that.daysPeriod,_that.price,_that.isAnyAssigned,_that.assigned,_that.canAssign,_that.forCitizen,_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.lines,_that.fivePlusOneTicket,_that.customerId,_that.customerCode,_that.cityCardTypeCode,_that.productName,_that.paymentStateId,_that.paymentStateDescription,_that.paymentTypeCode,_that.paymentDescription,_that.promotionName,_that.cityCardTypeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MkkmTicket extends MkkmTicket {
  const _MkkmTicket({this.ticketGuid, this.transactionCode, this.status, this.datePurchase, this.startDate, this.endDate, this.monthsPeriod, this.daysPeriod, this.price, this.isAnyAssigned, this.assigned, this.canAssign, this.forCitizen, this.ticketKindCode, this.ticketNumberOfLineCode, this.ticketPeriodCode, this.specialTransportLine, this.isNetwork, this.isMetropolitan,  List<TransportLine> lines = const <TransportLine>[], this.fivePlusOneTicket, this.customerId, this.customerCode, this.cityCardTypeCode, this.productName, this.paymentStateId, this.paymentStateDescription, this.paymentTypeCode, this.paymentDescription, this.promotionName, this.cityCardTypeName}): _lines = lines,super._();
  factory _MkkmTicket.fromJson(Map<String, dynamic> json) => _$MkkmTicketFromJson(json);

@override final  String? ticketGuid;
/// Base64 transaction code — the id used by `GET /tickets/{id}`.
@override final  String? transactionCode;
@override final  String? status;
@override final  DateTime? datePurchase;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  int? monthsPeriod;
@override final  int? daysPeriod;
@override final  double? price;
@override final  bool? isAnyAssigned;
@override final  bool? assigned;
@override final  bool? canAssign;
@override final  bool? forCitizen;
@override final  int? ticketKindCode;
@override final  int? ticketNumberOfLineCode;
@override final  int? ticketPeriodCode;
@override final  String? specialTransportLine;
@override final  bool? isNetwork;
@override final  bool? isMetropolitan;
/// Selected transport lines for line-scoped tickets, as full
/// [TransportLine] objects (snake_case wire shape, same as the
/// `dictionary/transport-line` response).
 final  List<TransportLine> _lines;
/// Selected transport lines for line-scoped tickets, as full
/// [TransportLine] objects (snake_case wire shape, same as the
/// `dictionary/transport-line` response).
@override@JsonKey() List<TransportLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  bool? fivePlusOneTicket;
/// Numeric customer code — only present in ticket detail responses.
@override final  int? customerId;
@override final  int? customerCode;
@override final  int? cityCardTypeCode;
@override final  String? productName;
@override final  int? paymentStateId;
@override final  String? paymentStateDescription;
@override final  int? paymentTypeCode;
@override final  String? paymentDescription;
@override final  String? promotionName;
@override final  String? cityCardTypeName;

/// Create a copy of MkkmTicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MkkmTicketCopyWith<_MkkmTicket> get copyWith => __$MkkmTicketCopyWithImpl<_MkkmTicket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MkkmTicketToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MkkmTicket&&(identical(other.ticketGuid, ticketGuid) || other.ticketGuid == ticketGuid)&&(identical(other.transactionCode, transactionCode) || other.transactionCode == transactionCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.datePurchase, datePurchase) || other.datePurchase == datePurchase)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.monthsPeriod, monthsPeriod) || other.monthsPeriod == monthsPeriod)&&(identical(other.daysPeriod, daysPeriod) || other.daysPeriod == daysPeriod)&&(identical(other.price, price) || other.price == price)&&(identical(other.isAnyAssigned, isAnyAssigned) || other.isAnyAssigned == isAnyAssigned)&&(identical(other.assigned, assigned) || other.assigned == assigned)&&(identical(other.canAssign, canAssign) || other.canAssign == canAssign)&&(identical(other.forCitizen, forCitizen) || other.forCitizen == forCitizen)&&(identical(other.ticketKindCode, ticketKindCode) || other.ticketKindCode == ticketKindCode)&&(identical(other.ticketNumberOfLineCode, ticketNumberOfLineCode) || other.ticketNumberOfLineCode == ticketNumberOfLineCode)&&(identical(other.ticketPeriodCode, ticketPeriodCode) || other.ticketPeriodCode == ticketPeriodCode)&&(identical(other.specialTransportLine, specialTransportLine) || other.specialTransportLine == specialTransportLine)&&(identical(other.isNetwork, isNetwork) || other.isNetwork == isNetwork)&&(identical(other.isMetropolitan, isMetropolitan) || other.isMetropolitan == isMetropolitan)&&const DeepCollectionEquality().equals(other.lines, _lines)&&(identical(other.fivePlusOneTicket, fivePlusOneTicket) || other.fivePlusOneTicket == fivePlusOneTicket)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerCode, customerCode) || other.customerCode == customerCode)&&(identical(other.cityCardTypeCode, cityCardTypeCode) || other.cityCardTypeCode == cityCardTypeCode)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.paymentStateId, paymentStateId) || other.paymentStateId == paymentStateId)&&(identical(other.paymentStateDescription, paymentStateDescription) || other.paymentStateDescription == paymentStateDescription)&&(identical(other.paymentTypeCode, paymentTypeCode) || other.paymentTypeCode == paymentTypeCode)&&(identical(other.paymentDescription, paymentDescription) || other.paymentDescription == paymentDescription)&&(identical(other.promotionName, promotionName) || other.promotionName == promotionName)&&(identical(other.cityCardTypeName, cityCardTypeName) || other.cityCardTypeName == cityCardTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,ticketGuid,transactionCode,status,datePurchase,startDate,endDate,monthsPeriod,daysPeriod,price,isAnyAssigned,assigned,canAssign,forCitizen,ticketKindCode,ticketNumberOfLineCode,ticketPeriodCode,specialTransportLine,isNetwork,isMetropolitan,const DeepCollectionEquality().hash(_lines),fivePlusOneTicket,customerId,customerCode,cityCardTypeCode,productName,paymentStateId,paymentStateDescription,paymentTypeCode,paymentDescription,promotionName,cityCardTypeName]);
}

@override
String toString() {
    return 'MkkmTicket(ticketGuid: $ticketGuid, transactionCode: $transactionCode, status: $status, datePurchase: $datePurchase, startDate: $startDate, endDate: $endDate, monthsPeriod: $monthsPeriod, daysPeriod: $daysPeriod, price: $price, isAnyAssigned: $isAnyAssigned, assigned: $assigned, canAssign: $canAssign, forCitizen: $forCitizen, ticketKindCode: $ticketKindCode, ticketNumberOfLineCode: $ticketNumberOfLineCode, ticketPeriodCode: $ticketPeriodCode, specialTransportLine: $specialTransportLine, isNetwork: $isNetwork, isMetropolitan: $isMetropolitan, lines: $lines, fivePlusOneTicket: $fivePlusOneTicket, customerId: $customerId, customerCode: $customerCode, cityCardTypeCode: $cityCardTypeCode, productName: $productName, paymentStateId: $paymentStateId, paymentStateDescription: $paymentStateDescription, paymentTypeCode: $paymentTypeCode, paymentDescription: $paymentDescription, promotionName: $promotionName, cityCardTypeName: $cityCardTypeName)';
}


}

/// @nodoc
abstract mixin class _$MkkmTicketCopyWith<$Res> implements $MkkmTicketCopyWith<$Res> {
  factory _$MkkmTicketCopyWith(_MkkmTicket value, $Res Function(_MkkmTicket) _then) = __$MkkmTicketCopyWithImpl;
@override @useResult
$Res call({
 String? ticketGuid, String? transactionCode, String? status, DateTime? datePurchase, DateTime? startDate, DateTime? endDate, int? monthsPeriod, int? daysPeriod, double? price, bool? isAnyAssigned, bool? assigned, bool? canAssign, bool? forCitizen, int? ticketKindCode, int? ticketNumberOfLineCode, int? ticketPeriodCode, String? specialTransportLine, bool? isNetwork, bool? isMetropolitan, List<TransportLine> lines, bool? fivePlusOneTicket, int? customerId, int? customerCode, int? cityCardTypeCode, String? productName, int? paymentStateId, String? paymentStateDescription, int? paymentTypeCode, String? paymentDescription, String? promotionName, String? cityCardTypeName
});




}
/// @nodoc
class __$MkkmTicketCopyWithImpl<$Res>
    implements _$MkkmTicketCopyWith<$Res> {
  __$MkkmTicketCopyWithImpl(this._self, this._then);

  final _MkkmTicket _self;
  final $Res Function(_MkkmTicket) _then;

/// Create a copy of MkkmTicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticketGuid = freezed,Object? transactionCode = freezed,Object? status = freezed,Object? datePurchase = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? monthsPeriod = freezed,Object? daysPeriod = freezed,Object? price = freezed,Object? isAnyAssigned = freezed,Object? assigned = freezed,Object? canAssign = freezed,Object? forCitizen = freezed,Object? ticketKindCode = freezed,Object? ticketNumberOfLineCode = freezed,Object? ticketPeriodCode = freezed,Object? specialTransportLine = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,Object? lines = null,Object? fivePlusOneTicket = freezed,Object? customerId = freezed,Object? customerCode = freezed,Object? cityCardTypeCode = freezed,Object? productName = freezed,Object? paymentStateId = freezed,Object? paymentStateDescription = freezed,Object? paymentTypeCode = freezed,Object? paymentDescription = freezed,Object? promotionName = freezed,Object? cityCardTypeName = freezed,}) {
  return _then(_MkkmTicket(
ticketGuid: freezed == ticketGuid ? _self.ticketGuid : ticketGuid // ignore: cast_nullable_to_non_nullable
as String?,transactionCode: freezed == transactionCode ? _self.transactionCode : transactionCode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,datePurchase: freezed == datePurchase ? _self.datePurchase : datePurchase // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,monthsPeriod: freezed == monthsPeriod ? _self.monthsPeriod : monthsPeriod // ignore: cast_nullable_to_non_nullable
as int?,daysPeriod: freezed == daysPeriod ? _self.daysPeriod : daysPeriod // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isAnyAssigned: freezed == isAnyAssigned ? _self.isAnyAssigned : isAnyAssigned // ignore: cast_nullable_to_non_nullable
as bool?,assigned: freezed == assigned ? _self.assigned : assigned // ignore: cast_nullable_to_non_nullable
as bool?,canAssign: freezed == canAssign ? _self.canAssign : canAssign // ignore: cast_nullable_to_non_nullable
as bool?,forCitizen: freezed == forCitizen ? _self.forCitizen : forCitizen // ignore: cast_nullable_to_non_nullable
as bool?,ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<TransportLine>,fivePlusOneTicket: freezed == fivePlusOneTicket ? _self.fivePlusOneTicket : fivePlusOneTicket // ignore: cast_nullable_to_non_nullable
as bool?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as int?,cityCardTypeCode: freezed == cityCardTypeCode ? _self.cityCardTypeCode : cityCardTypeCode // ignore: cast_nullable_to_non_nullable
as int?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,paymentStateId: freezed == paymentStateId ? _self.paymentStateId : paymentStateId // ignore: cast_nullable_to_non_nullable
as int?,paymentStateDescription: freezed == paymentStateDescription ? _self.paymentStateDescription : paymentStateDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentTypeCode: freezed == paymentTypeCode ? _self.paymentTypeCode : paymentTypeCode // ignore: cast_nullable_to_non_nullable
as int?,paymentDescription: freezed == paymentDescription ? _self.paymentDescription : paymentDescription // ignore: cast_nullable_to_non_nullable
as String?,promotionName: freezed == promotionName ? _self.promotionName : promotionName // ignore: cast_nullable_to_non_nullable
as String?,cityCardTypeName: freezed == cityCardTypeName ? _self.cityCardTypeName : cityCardTypeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MkkmTicketsResponse {

 List<MkkmTicket> get tickets; Object? get code; String? get message;
/// Create a copy of MkkmTicketsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MkkmTicketsResponseCopyWith<MkkmTicketsResponse> get copyWith => _$MkkmTicketsResponseCopyWithImpl<MkkmTicketsResponse>(this as MkkmTicketsResponse, _$identity);

  /// Serializes this MkkmTicketsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MkkmTicketsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MkkmTicketsResponse&&const DeepCollectionEquality().equals(other.tickets, _this.tickets)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MkkmTicketsResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.tickets),const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as MkkmTicketsResponse;
  return 'MkkmTicketsResponse(tickets: ${_this.tickets}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $MkkmTicketsResponseCopyWith<$Res>  {
  factory $MkkmTicketsResponseCopyWith(MkkmTicketsResponse value, $Res Function(MkkmTicketsResponse) _then) = _$MkkmTicketsResponseCopyWithImpl;
@useResult
$Res call({
 List<MkkmTicket> tickets, Object? code, String? message
});




}
/// @nodoc
class _$MkkmTicketsResponseCopyWithImpl<$Res>
    implements $MkkmTicketsResponseCopyWith<$Res> {
  _$MkkmTicketsResponseCopyWithImpl(this._self, this._then);

  final MkkmTicketsResponse _self;
  final $Res Function(MkkmTicketsResponse) _then;

/// Create a copy of MkkmTicketsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tickets = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(MkkmTicketsResponse(
tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<MkkmTicket>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MkkmTicketsResponse].
extension MkkmTicketsResponsePatterns on MkkmTicketsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MkkmTicketsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MkkmTicketsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MkkmTicketsResponse value)  $default,){
final _that = this;
switch (_that) {
case _MkkmTicketsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MkkmTicketsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MkkmTicketsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MkkmTicket> tickets,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MkkmTicketsResponse() when $default != null:
return $default(_that.tickets,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MkkmTicket> tickets,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _MkkmTicketsResponse():
return $default(_that.tickets,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MkkmTicket> tickets,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _MkkmTicketsResponse() when $default != null:
return $default(_that.tickets,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MkkmTicketsResponse extends MkkmTicketsResponse {
  const _MkkmTicketsResponse({ List<MkkmTicket> tickets = const <MkkmTicket>[], this.code, this.message}): _tickets = tickets,super._();
  factory _MkkmTicketsResponse.fromJson(Map<String, dynamic> json) => _$MkkmTicketsResponseFromJson(json);

 final  List<MkkmTicket> _tickets;
@override@JsonKey() List<MkkmTicket> get tickets {
  if (_tickets is EqualUnmodifiableListView) return _tickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickets);
}

@override final  Object? code;
@override final  String? message;

/// Create a copy of MkkmTicketsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MkkmTicketsResponseCopyWith<_MkkmTicketsResponse> get copyWith => __$MkkmTicketsResponseCopyWithImpl<_MkkmTicketsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MkkmTicketsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MkkmTicketsResponse&&const DeepCollectionEquality().equals(other.tickets, _tickets)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_tickets),const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'MkkmTicketsResponse(tickets: $tickets, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$MkkmTicketsResponseCopyWith<$Res> implements $MkkmTicketsResponseCopyWith<$Res> {
  factory _$MkkmTicketsResponseCopyWith(_MkkmTicketsResponse value, $Res Function(_MkkmTicketsResponse) _then) = __$MkkmTicketsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<MkkmTicket> tickets, Object? code, String? message
});




}
/// @nodoc
class __$MkkmTicketsResponseCopyWithImpl<$Res>
    implements _$MkkmTicketsResponseCopyWith<$Res> {
  __$MkkmTicketsResponseCopyWithImpl(this._self, this._then);

  final _MkkmTicketsResponse _self;
  final $Res Function(_MkkmTicketsResponse) _then;

/// Create a copy of MkkmTicketsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tickets = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(_MkkmTicketsResponse(
tickets: null == tickets ? _self._tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<MkkmTicket>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketHistoryEntry {

 int? get transactionId; String? get transactionCode; bool? get imported; DateTime? get transactionDate; DateTime? get ticketStartDate; DateTime? get ticketExpiryDate; String? get specialTransportLine; bool? get isNetwork; bool? get isMetropolitan; int? get cityLine1; int? get zoneLine1; int? get cityLine2; int? get zoneLine2; double? get price; int? get transactionStateId; String? get transactionStateDescription; int? get paymentTypeCode; String? get paymentDescription; int? get paymentStateId; String? get paymentStateDescription; DateTime? get paymentAccepted; String? get productIndex; String? get productName; int? get productType; String? get productTypeName; String? get promotionName; bool? get isPayed; int? get ticketKindCode; int? get ticketPeriodCode; int? get ticketNumberOfLineCode;
/// Create a copy of TicketHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketHistoryEntryCopyWith<TicketHistoryEntry> get copyWith => _$TicketHistoryEntryCopyWithImpl<TicketHistoryEntry>(this as TicketHistoryEntry, _$identity);

  /// Serializes this TicketHistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketHistoryEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketHistoryEntry&&(identical(other.transactionId, _this.transactionId) || other.transactionId == _this.transactionId)&&(identical(other.transactionCode, _this.transactionCode) || other.transactionCode == _this.transactionCode)&&(identical(other.imported, _this.imported) || other.imported == _this.imported)&&(identical(other.transactionDate, _this.transactionDate) || other.transactionDate == _this.transactionDate)&&(identical(other.ticketStartDate, _this.ticketStartDate) || other.ticketStartDate == _this.ticketStartDate)&&(identical(other.ticketExpiryDate, _this.ticketExpiryDate) || other.ticketExpiryDate == _this.ticketExpiryDate)&&(identical(other.specialTransportLine, _this.specialTransportLine) || other.specialTransportLine == _this.specialTransportLine)&&(identical(other.isNetwork, _this.isNetwork) || other.isNetwork == _this.isNetwork)&&(identical(other.isMetropolitan, _this.isMetropolitan) || other.isMetropolitan == _this.isMetropolitan)&&(identical(other.cityLine1, _this.cityLine1) || other.cityLine1 == _this.cityLine1)&&(identical(other.zoneLine1, _this.zoneLine1) || other.zoneLine1 == _this.zoneLine1)&&(identical(other.cityLine2, _this.cityLine2) || other.cityLine2 == _this.cityLine2)&&(identical(other.zoneLine2, _this.zoneLine2) || other.zoneLine2 == _this.zoneLine2)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.transactionStateId, _this.transactionStateId) || other.transactionStateId == _this.transactionStateId)&&(identical(other.transactionStateDescription, _this.transactionStateDescription) || other.transactionStateDescription == _this.transactionStateDescription)&&(identical(other.paymentTypeCode, _this.paymentTypeCode) || other.paymentTypeCode == _this.paymentTypeCode)&&(identical(other.paymentDescription, _this.paymentDescription) || other.paymentDescription == _this.paymentDescription)&&(identical(other.paymentStateId, _this.paymentStateId) || other.paymentStateId == _this.paymentStateId)&&(identical(other.paymentStateDescription, _this.paymentStateDescription) || other.paymentStateDescription == _this.paymentStateDescription)&&(identical(other.paymentAccepted, _this.paymentAccepted) || other.paymentAccepted == _this.paymentAccepted)&&(identical(other.productIndex, _this.productIndex) || other.productIndex == _this.productIndex)&&(identical(other.productName, _this.productName) || other.productName == _this.productName)&&(identical(other.productType, _this.productType) || other.productType == _this.productType)&&(identical(other.productTypeName, _this.productTypeName) || other.productTypeName == _this.productTypeName)&&(identical(other.promotionName, _this.promotionName) || other.promotionName == _this.promotionName)&&(identical(other.isPayed, _this.isPayed) || other.isPayed == _this.isPayed)&&(identical(other.ticketKindCode, _this.ticketKindCode) || other.ticketKindCode == _this.ticketKindCode)&&(identical(other.ticketPeriodCode, _this.ticketPeriodCode) || other.ticketPeriodCode == _this.ticketPeriodCode)&&(identical(other.ticketNumberOfLineCode, _this.ticketNumberOfLineCode) || other.ticketNumberOfLineCode == _this.ticketNumberOfLineCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketHistoryEntry;
  return Object.hashAll([runtimeType,_this.transactionId,_this.transactionCode,_this.imported,_this.transactionDate,_this.ticketStartDate,_this.ticketExpiryDate,_this.specialTransportLine,_this.isNetwork,_this.isMetropolitan,_this.cityLine1,_this.zoneLine1,_this.cityLine2,_this.zoneLine2,_this.price,_this.transactionStateId,_this.transactionStateDescription,_this.paymentTypeCode,_this.paymentDescription,_this.paymentStateId,_this.paymentStateDescription,_this.paymentAccepted,_this.productIndex,_this.productName,_this.productType,_this.productTypeName,_this.promotionName,_this.isPayed,_this.ticketKindCode,_this.ticketPeriodCode,_this.ticketNumberOfLineCode]);
}

@override
String toString() {
  final _this = this as TicketHistoryEntry;
  return 'TicketHistoryEntry(transactionId: ${_this.transactionId}, transactionCode: ${_this.transactionCode}, imported: ${_this.imported}, transactionDate: ${_this.transactionDate}, ticketStartDate: ${_this.ticketStartDate}, ticketExpiryDate: ${_this.ticketExpiryDate}, specialTransportLine: ${_this.specialTransportLine}, isNetwork: ${_this.isNetwork}, isMetropolitan: ${_this.isMetropolitan}, cityLine1: ${_this.cityLine1}, zoneLine1: ${_this.zoneLine1}, cityLine2: ${_this.cityLine2}, zoneLine2: ${_this.zoneLine2}, price: ${_this.price}, transactionStateId: ${_this.transactionStateId}, transactionStateDescription: ${_this.transactionStateDescription}, paymentTypeCode: ${_this.paymentTypeCode}, paymentDescription: ${_this.paymentDescription}, paymentStateId: ${_this.paymentStateId}, paymentStateDescription: ${_this.paymentStateDescription}, paymentAccepted: ${_this.paymentAccepted}, productIndex: ${_this.productIndex}, productName: ${_this.productName}, productType: ${_this.productType}, productTypeName: ${_this.productTypeName}, promotionName: ${_this.promotionName}, isPayed: ${_this.isPayed}, ticketKindCode: ${_this.ticketKindCode}, ticketPeriodCode: ${_this.ticketPeriodCode}, ticketNumberOfLineCode: ${_this.ticketNumberOfLineCode})';
}


}

/// @nodoc
abstract mixin class $TicketHistoryEntryCopyWith<$Res>  {
  factory $TicketHistoryEntryCopyWith(TicketHistoryEntry value, $Res Function(TicketHistoryEntry) _then) = _$TicketHistoryEntryCopyWithImpl;
@useResult
$Res call({
 int? transactionId, String? transactionCode, bool? imported, DateTime? transactionDate, DateTime? ticketStartDate, DateTime? ticketExpiryDate, String? specialTransportLine, bool? isNetwork, bool? isMetropolitan, int? cityLine1, int? zoneLine1, int? cityLine2, int? zoneLine2, double? price, int? transactionStateId, String? transactionStateDescription, int? paymentTypeCode, String? paymentDescription, int? paymentStateId, String? paymentStateDescription, DateTime? paymentAccepted, String? productIndex, String? productName, int? productType, String? productTypeName, String? promotionName, bool? isPayed, int? ticketKindCode, int? ticketPeriodCode, int? ticketNumberOfLineCode
});




}
/// @nodoc
class _$TicketHistoryEntryCopyWithImpl<$Res>
    implements $TicketHistoryEntryCopyWith<$Res> {
  _$TicketHistoryEntryCopyWithImpl(this._self, this._then);

  final TicketHistoryEntry _self;
  final $Res Function(TicketHistoryEntry) _then;

/// Create a copy of TicketHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = freezed,Object? transactionCode = freezed,Object? imported = freezed,Object? transactionDate = freezed,Object? ticketStartDate = freezed,Object? ticketExpiryDate = freezed,Object? specialTransportLine = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,Object? cityLine1 = freezed,Object? zoneLine1 = freezed,Object? cityLine2 = freezed,Object? zoneLine2 = freezed,Object? price = freezed,Object? transactionStateId = freezed,Object? transactionStateDescription = freezed,Object? paymentTypeCode = freezed,Object? paymentDescription = freezed,Object? paymentStateId = freezed,Object? paymentStateDescription = freezed,Object? paymentAccepted = freezed,Object? productIndex = freezed,Object? productName = freezed,Object? productType = freezed,Object? productTypeName = freezed,Object? promotionName = freezed,Object? isPayed = freezed,Object? ticketKindCode = freezed,Object? ticketPeriodCode = freezed,Object? ticketNumberOfLineCode = freezed,}) {
  return _then(TicketHistoryEntry(
transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int?,transactionCode: freezed == transactionCode ? _self.transactionCode : transactionCode // ignore: cast_nullable_to_non_nullable
as String?,imported: freezed == imported ? _self.imported : imported // ignore: cast_nullable_to_non_nullable
as bool?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketStartDate: freezed == ticketStartDate ? _self.ticketStartDate : ticketStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketExpiryDate: freezed == ticketExpiryDate ? _self.ticketExpiryDate : ticketExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,cityLine1: freezed == cityLine1 ? _self.cityLine1 : cityLine1 // ignore: cast_nullable_to_non_nullable
as int?,zoneLine1: freezed == zoneLine1 ? _self.zoneLine1 : zoneLine1 // ignore: cast_nullable_to_non_nullable
as int?,cityLine2: freezed == cityLine2 ? _self.cityLine2 : cityLine2 // ignore: cast_nullable_to_non_nullable
as int?,zoneLine2: freezed == zoneLine2 ? _self.zoneLine2 : zoneLine2 // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,transactionStateId: freezed == transactionStateId ? _self.transactionStateId : transactionStateId // ignore: cast_nullable_to_non_nullable
as int?,transactionStateDescription: freezed == transactionStateDescription ? _self.transactionStateDescription : transactionStateDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentTypeCode: freezed == paymentTypeCode ? _self.paymentTypeCode : paymentTypeCode // ignore: cast_nullable_to_non_nullable
as int?,paymentDescription: freezed == paymentDescription ? _self.paymentDescription : paymentDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentStateId: freezed == paymentStateId ? _self.paymentStateId : paymentStateId // ignore: cast_nullable_to_non_nullable
as int?,paymentStateDescription: freezed == paymentStateDescription ? _self.paymentStateDescription : paymentStateDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentAccepted: freezed == paymentAccepted ? _self.paymentAccepted : paymentAccepted // ignore: cast_nullable_to_non_nullable
as DateTime?,productIndex: freezed == productIndex ? _self.productIndex : productIndex // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,productType: freezed == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as int?,productTypeName: freezed == productTypeName ? _self.productTypeName : productTypeName // ignore: cast_nullable_to_non_nullable
as String?,promotionName: freezed == promotionName ? _self.promotionName : promotionName // ignore: cast_nullable_to_non_nullable
as String?,isPayed: freezed == isPayed ? _self.isPayed : isPayed // ignore: cast_nullable_to_non_nullable
as bool?,ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketHistoryEntry].
extension TicketHistoryEntryPatterns on TicketHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _TicketHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TicketHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? transactionId,  String? transactionCode,  bool? imported,  DateTime? transactionDate,  DateTime? ticketStartDate,  DateTime? ticketExpiryDate,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  int? cityLine1,  int? zoneLine1,  int? cityLine2,  int? zoneLine2,  double? price,  int? transactionStateId,  String? transactionStateDescription,  int? paymentTypeCode,  String? paymentDescription,  int? paymentStateId,  String? paymentStateDescription,  DateTime? paymentAccepted,  String? productIndex,  String? productName,  int? productType,  String? productTypeName,  String? promotionName,  bool? isPayed,  int? ticketKindCode,  int? ticketPeriodCode,  int? ticketNumberOfLineCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketHistoryEntry() when $default != null:
return $default(_that.transactionId,_that.transactionCode,_that.imported,_that.transactionDate,_that.ticketStartDate,_that.ticketExpiryDate,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.cityLine1,_that.zoneLine1,_that.cityLine2,_that.zoneLine2,_that.price,_that.transactionStateId,_that.transactionStateDescription,_that.paymentTypeCode,_that.paymentDescription,_that.paymentStateId,_that.paymentStateDescription,_that.paymentAccepted,_that.productIndex,_that.productName,_that.productType,_that.productTypeName,_that.promotionName,_that.isPayed,_that.ticketKindCode,_that.ticketPeriodCode,_that.ticketNumberOfLineCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? transactionId,  String? transactionCode,  bool? imported,  DateTime? transactionDate,  DateTime? ticketStartDate,  DateTime? ticketExpiryDate,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  int? cityLine1,  int? zoneLine1,  int? cityLine2,  int? zoneLine2,  double? price,  int? transactionStateId,  String? transactionStateDescription,  int? paymentTypeCode,  String? paymentDescription,  int? paymentStateId,  String? paymentStateDescription,  DateTime? paymentAccepted,  String? productIndex,  String? productName,  int? productType,  String? productTypeName,  String? promotionName,  bool? isPayed,  int? ticketKindCode,  int? ticketPeriodCode,  int? ticketNumberOfLineCode)  $default,) {final _that = this;
switch (_that) {
case _TicketHistoryEntry():
return $default(_that.transactionId,_that.transactionCode,_that.imported,_that.transactionDate,_that.ticketStartDate,_that.ticketExpiryDate,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.cityLine1,_that.zoneLine1,_that.cityLine2,_that.zoneLine2,_that.price,_that.transactionStateId,_that.transactionStateDescription,_that.paymentTypeCode,_that.paymentDescription,_that.paymentStateId,_that.paymentStateDescription,_that.paymentAccepted,_that.productIndex,_that.productName,_that.productType,_that.productTypeName,_that.promotionName,_that.isPayed,_that.ticketKindCode,_that.ticketPeriodCode,_that.ticketNumberOfLineCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? transactionId,  String? transactionCode,  bool? imported,  DateTime? transactionDate,  DateTime? ticketStartDate,  DateTime? ticketExpiryDate,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  int? cityLine1,  int? zoneLine1,  int? cityLine2,  int? zoneLine2,  double? price,  int? transactionStateId,  String? transactionStateDescription,  int? paymentTypeCode,  String? paymentDescription,  int? paymentStateId,  String? paymentStateDescription,  DateTime? paymentAccepted,  String? productIndex,  String? productName,  int? productType,  String? productTypeName,  String? promotionName,  bool? isPayed,  int? ticketKindCode,  int? ticketPeriodCode,  int? ticketNumberOfLineCode)?  $default,) {final _that = this;
switch (_that) {
case _TicketHistoryEntry() when $default != null:
return $default(_that.transactionId,_that.transactionCode,_that.imported,_that.transactionDate,_that.ticketStartDate,_that.ticketExpiryDate,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.cityLine1,_that.zoneLine1,_that.cityLine2,_that.zoneLine2,_that.price,_that.transactionStateId,_that.transactionStateDescription,_that.paymentTypeCode,_that.paymentDescription,_that.paymentStateId,_that.paymentStateDescription,_that.paymentAccepted,_that.productIndex,_that.productName,_that.productType,_that.productTypeName,_that.promotionName,_that.isPayed,_that.ticketKindCode,_that.ticketPeriodCode,_that.ticketNumberOfLineCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketHistoryEntry implements TicketHistoryEntry {
  const _TicketHistoryEntry({this.transactionId, this.transactionCode, this.imported, this.transactionDate, this.ticketStartDate, this.ticketExpiryDate, this.specialTransportLine, this.isNetwork, this.isMetropolitan, this.cityLine1, this.zoneLine1, this.cityLine2, this.zoneLine2, this.price, this.transactionStateId, this.transactionStateDescription, this.paymentTypeCode, this.paymentDescription, this.paymentStateId, this.paymentStateDescription, this.paymentAccepted, this.productIndex, this.productName, this.productType, this.productTypeName, this.promotionName, this.isPayed, this.ticketKindCode, this.ticketPeriodCode, this.ticketNumberOfLineCode});
  factory _TicketHistoryEntry.fromJson(Map<String, dynamic> json) => _$TicketHistoryEntryFromJson(json);

@override final  int? transactionId;
@override final  String? transactionCode;
@override final  bool? imported;
@override final  DateTime? transactionDate;
@override final  DateTime? ticketStartDate;
@override final  DateTime? ticketExpiryDate;
@override final  String? specialTransportLine;
@override final  bool? isNetwork;
@override final  bool? isMetropolitan;
@override final  int? cityLine1;
@override final  int? zoneLine1;
@override final  int? cityLine2;
@override final  int? zoneLine2;
@override final  double? price;
@override final  int? transactionStateId;
@override final  String? transactionStateDescription;
@override final  int? paymentTypeCode;
@override final  String? paymentDescription;
@override final  int? paymentStateId;
@override final  String? paymentStateDescription;
@override final  DateTime? paymentAccepted;
@override final  String? productIndex;
@override final  String? productName;
@override final  int? productType;
@override final  String? productTypeName;
@override final  String? promotionName;
@override final  bool? isPayed;
@override final  int? ticketKindCode;
@override final  int? ticketPeriodCode;
@override final  int? ticketNumberOfLineCode;

/// Create a copy of TicketHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketHistoryEntryCopyWith<_TicketHistoryEntry> get copyWith => __$TicketHistoryEntryCopyWithImpl<_TicketHistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketHistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketHistoryEntry&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.transactionCode, transactionCode) || other.transactionCode == transactionCode)&&(identical(other.imported, imported) || other.imported == imported)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.ticketStartDate, ticketStartDate) || other.ticketStartDate == ticketStartDate)&&(identical(other.ticketExpiryDate, ticketExpiryDate) || other.ticketExpiryDate == ticketExpiryDate)&&(identical(other.specialTransportLine, specialTransportLine) || other.specialTransportLine == specialTransportLine)&&(identical(other.isNetwork, isNetwork) || other.isNetwork == isNetwork)&&(identical(other.isMetropolitan, isMetropolitan) || other.isMetropolitan == isMetropolitan)&&(identical(other.cityLine1, cityLine1) || other.cityLine1 == cityLine1)&&(identical(other.zoneLine1, zoneLine1) || other.zoneLine1 == zoneLine1)&&(identical(other.cityLine2, cityLine2) || other.cityLine2 == cityLine2)&&(identical(other.zoneLine2, zoneLine2) || other.zoneLine2 == zoneLine2)&&(identical(other.price, price) || other.price == price)&&(identical(other.transactionStateId, transactionStateId) || other.transactionStateId == transactionStateId)&&(identical(other.transactionStateDescription, transactionStateDescription) || other.transactionStateDescription == transactionStateDescription)&&(identical(other.paymentTypeCode, paymentTypeCode) || other.paymentTypeCode == paymentTypeCode)&&(identical(other.paymentDescription, paymentDescription) || other.paymentDescription == paymentDescription)&&(identical(other.paymentStateId, paymentStateId) || other.paymentStateId == paymentStateId)&&(identical(other.paymentStateDescription, paymentStateDescription) || other.paymentStateDescription == paymentStateDescription)&&(identical(other.paymentAccepted, paymentAccepted) || other.paymentAccepted == paymentAccepted)&&(identical(other.productIndex, productIndex) || other.productIndex == productIndex)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.productTypeName, productTypeName) || other.productTypeName == productTypeName)&&(identical(other.promotionName, promotionName) || other.promotionName == promotionName)&&(identical(other.isPayed, isPayed) || other.isPayed == isPayed)&&(identical(other.ticketKindCode, ticketKindCode) || other.ticketKindCode == ticketKindCode)&&(identical(other.ticketPeriodCode, ticketPeriodCode) || other.ticketPeriodCode == ticketPeriodCode)&&(identical(other.ticketNumberOfLineCode, ticketNumberOfLineCode) || other.ticketNumberOfLineCode == ticketNumberOfLineCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,transactionId,transactionCode,imported,transactionDate,ticketStartDate,ticketExpiryDate,specialTransportLine,isNetwork,isMetropolitan,cityLine1,zoneLine1,cityLine2,zoneLine2,price,transactionStateId,transactionStateDescription,paymentTypeCode,paymentDescription,paymentStateId,paymentStateDescription,paymentAccepted,productIndex,productName,productType,productTypeName,promotionName,isPayed,ticketKindCode,ticketPeriodCode,ticketNumberOfLineCode]);
}

@override
String toString() {
    return 'TicketHistoryEntry(transactionId: $transactionId, transactionCode: $transactionCode, imported: $imported, transactionDate: $transactionDate, ticketStartDate: $ticketStartDate, ticketExpiryDate: $ticketExpiryDate, specialTransportLine: $specialTransportLine, isNetwork: $isNetwork, isMetropolitan: $isMetropolitan, cityLine1: $cityLine1, zoneLine1: $zoneLine1, cityLine2: $cityLine2, zoneLine2: $zoneLine2, price: $price, transactionStateId: $transactionStateId, transactionStateDescription: $transactionStateDescription, paymentTypeCode: $paymentTypeCode, paymentDescription: $paymentDescription, paymentStateId: $paymentStateId, paymentStateDescription: $paymentStateDescription, paymentAccepted: $paymentAccepted, productIndex: $productIndex, productName: $productName, productType: $productType, productTypeName: $productTypeName, promotionName: $promotionName, isPayed: $isPayed, ticketKindCode: $ticketKindCode, ticketPeriodCode: $ticketPeriodCode, ticketNumberOfLineCode: $ticketNumberOfLineCode)';
}


}

/// @nodoc
abstract mixin class _$TicketHistoryEntryCopyWith<$Res> implements $TicketHistoryEntryCopyWith<$Res> {
  factory _$TicketHistoryEntryCopyWith(_TicketHistoryEntry value, $Res Function(_TicketHistoryEntry) _then) = __$TicketHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 int? transactionId, String? transactionCode, bool? imported, DateTime? transactionDate, DateTime? ticketStartDate, DateTime? ticketExpiryDate, String? specialTransportLine, bool? isNetwork, bool? isMetropolitan, int? cityLine1, int? zoneLine1, int? cityLine2, int? zoneLine2, double? price, int? transactionStateId, String? transactionStateDescription, int? paymentTypeCode, String? paymentDescription, int? paymentStateId, String? paymentStateDescription, DateTime? paymentAccepted, String? productIndex, String? productName, int? productType, String? productTypeName, String? promotionName, bool? isPayed, int? ticketKindCode, int? ticketPeriodCode, int? ticketNumberOfLineCode
});




}
/// @nodoc
class __$TicketHistoryEntryCopyWithImpl<$Res>
    implements _$TicketHistoryEntryCopyWith<$Res> {
  __$TicketHistoryEntryCopyWithImpl(this._self, this._then);

  final _TicketHistoryEntry _self;
  final $Res Function(_TicketHistoryEntry) _then;

/// Create a copy of TicketHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = freezed,Object? transactionCode = freezed,Object? imported = freezed,Object? transactionDate = freezed,Object? ticketStartDate = freezed,Object? ticketExpiryDate = freezed,Object? specialTransportLine = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,Object? cityLine1 = freezed,Object? zoneLine1 = freezed,Object? cityLine2 = freezed,Object? zoneLine2 = freezed,Object? price = freezed,Object? transactionStateId = freezed,Object? transactionStateDescription = freezed,Object? paymentTypeCode = freezed,Object? paymentDescription = freezed,Object? paymentStateId = freezed,Object? paymentStateDescription = freezed,Object? paymentAccepted = freezed,Object? productIndex = freezed,Object? productName = freezed,Object? productType = freezed,Object? productTypeName = freezed,Object? promotionName = freezed,Object? isPayed = freezed,Object? ticketKindCode = freezed,Object? ticketPeriodCode = freezed,Object? ticketNumberOfLineCode = freezed,}) {
  return _then(_TicketHistoryEntry(
transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int?,transactionCode: freezed == transactionCode ? _self.transactionCode : transactionCode // ignore: cast_nullable_to_non_nullable
as String?,imported: freezed == imported ? _self.imported : imported // ignore: cast_nullable_to_non_nullable
as bool?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketStartDate: freezed == ticketStartDate ? _self.ticketStartDate : ticketStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketExpiryDate: freezed == ticketExpiryDate ? _self.ticketExpiryDate : ticketExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,cityLine1: freezed == cityLine1 ? _self.cityLine1 : cityLine1 // ignore: cast_nullable_to_non_nullable
as int?,zoneLine1: freezed == zoneLine1 ? _self.zoneLine1 : zoneLine1 // ignore: cast_nullable_to_non_nullable
as int?,cityLine2: freezed == cityLine2 ? _self.cityLine2 : cityLine2 // ignore: cast_nullable_to_non_nullable
as int?,zoneLine2: freezed == zoneLine2 ? _self.zoneLine2 : zoneLine2 // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,transactionStateId: freezed == transactionStateId ? _self.transactionStateId : transactionStateId // ignore: cast_nullable_to_non_nullable
as int?,transactionStateDescription: freezed == transactionStateDescription ? _self.transactionStateDescription : transactionStateDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentTypeCode: freezed == paymentTypeCode ? _self.paymentTypeCode : paymentTypeCode // ignore: cast_nullable_to_non_nullable
as int?,paymentDescription: freezed == paymentDescription ? _self.paymentDescription : paymentDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentStateId: freezed == paymentStateId ? _self.paymentStateId : paymentStateId // ignore: cast_nullable_to_non_nullable
as int?,paymentStateDescription: freezed == paymentStateDescription ? _self.paymentStateDescription : paymentStateDescription // ignore: cast_nullable_to_non_nullable
as String?,paymentAccepted: freezed == paymentAccepted ? _self.paymentAccepted : paymentAccepted // ignore: cast_nullable_to_non_nullable
as DateTime?,productIndex: freezed == productIndex ? _self.productIndex : productIndex // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,productType: freezed == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as int?,productTypeName: freezed == productTypeName ? _self.productTypeName : productTypeName // ignore: cast_nullable_to_non_nullable
as String?,promotionName: freezed == promotionName ? _self.promotionName : promotionName // ignore: cast_nullable_to_non_nullable
as String?,isPayed: freezed == isPayed ? _self.isPayed : isPayed // ignore: cast_nullable_to_non_nullable
as bool?,ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TicketStateChange {

 int? get nextNumber; DateTime? get createDate; String? get stateDescription;
/// Create a copy of TicketStateChange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketStateChangeCopyWith<TicketStateChange> get copyWith => _$TicketStateChangeCopyWithImpl<TicketStateChange>(this as TicketStateChange, _$identity);

  /// Serializes this TicketStateChange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketStateChange;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketStateChange&&(identical(other.nextNumber, _this.nextNumber) || other.nextNumber == _this.nextNumber)&&(identical(other.createDate, _this.createDate) || other.createDate == _this.createDate)&&(identical(other.stateDescription, _this.stateDescription) || other.stateDescription == _this.stateDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketStateChange;
  return Object.hash(runtimeType,_this.nextNumber,_this.createDate,_this.stateDescription);
}

@override
String toString() {
  final _this = this as TicketStateChange;
  return 'TicketStateChange(nextNumber: ${_this.nextNumber}, createDate: ${_this.createDate}, stateDescription: ${_this.stateDescription})';
}


}

/// @nodoc
abstract mixin class $TicketStateChangeCopyWith<$Res>  {
  factory $TicketStateChangeCopyWith(TicketStateChange value, $Res Function(TicketStateChange) _then) = _$TicketStateChangeCopyWithImpl;
@useResult
$Res call({
 int? nextNumber, DateTime? createDate, String? stateDescription
});




}
/// @nodoc
class _$TicketStateChangeCopyWithImpl<$Res>
    implements $TicketStateChangeCopyWith<$Res> {
  _$TicketStateChangeCopyWithImpl(this._self, this._then);

  final TicketStateChange _self;
  final $Res Function(TicketStateChange) _then;

/// Create a copy of TicketStateChange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextNumber = freezed,Object? createDate = freezed,Object? stateDescription = freezed,}) {
  return _then(TicketStateChange(
nextNumber: freezed == nextNumber ? _self.nextNumber : nextNumber // ignore: cast_nullable_to_non_nullable
as int?,createDate: freezed == createDate ? _self.createDate : createDate // ignore: cast_nullable_to_non_nullable
as DateTime?,stateDescription: freezed == stateDescription ? _self.stateDescription : stateDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketStateChange].
extension TicketStateChangePatterns on TicketStateChange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketStateChange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketStateChange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketStateChange value)  $default,){
final _that = this;
switch (_that) {
case _TicketStateChange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketStateChange value)?  $default,){
final _that = this;
switch (_that) {
case _TicketStateChange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? nextNumber,  DateTime? createDate,  String? stateDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketStateChange() when $default != null:
return $default(_that.nextNumber,_that.createDate,_that.stateDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? nextNumber,  DateTime? createDate,  String? stateDescription)  $default,) {final _that = this;
switch (_that) {
case _TicketStateChange():
return $default(_that.nextNumber,_that.createDate,_that.stateDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? nextNumber,  DateTime? createDate,  String? stateDescription)?  $default,) {final _that = this;
switch (_that) {
case _TicketStateChange() when $default != null:
return $default(_that.nextNumber,_that.createDate,_that.stateDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketStateChange implements TicketStateChange {
  const _TicketStateChange({this.nextNumber, this.createDate, this.stateDescription});
  factory _TicketStateChange.fromJson(Map<String, dynamic> json) => _$TicketStateChangeFromJson(json);

@override final  int? nextNumber;
@override final  DateTime? createDate;
@override final  String? stateDescription;

/// Create a copy of TicketStateChange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketStateChangeCopyWith<_TicketStateChange> get copyWith => __$TicketStateChangeCopyWithImpl<_TicketStateChange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketStateChangeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketStateChange&&(identical(other.nextNumber, nextNumber) || other.nextNumber == nextNumber)&&(identical(other.createDate, createDate) || other.createDate == createDate)&&(identical(other.stateDescription, stateDescription) || other.stateDescription == stateDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nextNumber,createDate,stateDescription);
}

@override
String toString() {
    return 'TicketStateChange(nextNumber: $nextNumber, createDate: $createDate, stateDescription: $stateDescription)';
}


}

/// @nodoc
abstract mixin class _$TicketStateChangeCopyWith<$Res> implements $TicketStateChangeCopyWith<$Res> {
  factory _$TicketStateChangeCopyWith(_TicketStateChange value, $Res Function(_TicketStateChange) _then) = __$TicketStateChangeCopyWithImpl;
@override @useResult
$Res call({
 int? nextNumber, DateTime? createDate, String? stateDescription
});




}
/// @nodoc
class __$TicketStateChangeCopyWithImpl<$Res>
    implements _$TicketStateChangeCopyWith<$Res> {
  __$TicketStateChangeCopyWithImpl(this._self, this._then);

  final _TicketStateChange _self;
  final $Res Function(_TicketStateChange) _then;

/// Create a copy of TicketStateChange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextNumber = freezed,Object? createDate = freezed,Object? stateDescription = freezed,}) {
  return _then(_TicketStateChange(
nextNumber: freezed == nextNumber ? _self.nextNumber : nextNumber // ignore: cast_nullable_to_non_nullable
as int?,createDate: freezed == createDate ? _self.createDate : createDate // ignore: cast_nullable_to_non_nullable
as DateTime?,stateDescription: freezed == stateDescription ? _self.stateDescription : stateDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketReturn {

 DateTime? get returnDate; int? get returnQty; double? get unitPriceReturn; String? get paymentTypeDescription;
/// Create a copy of TicketReturn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketReturnCopyWith<TicketReturn> get copyWith => _$TicketReturnCopyWithImpl<TicketReturn>(this as TicketReturn, _$identity);

  /// Serializes this TicketReturn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketReturn;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketReturn&&(identical(other.returnDate, _this.returnDate) || other.returnDate == _this.returnDate)&&(identical(other.returnQty, _this.returnQty) || other.returnQty == _this.returnQty)&&(identical(other.unitPriceReturn, _this.unitPriceReturn) || other.unitPriceReturn == _this.unitPriceReturn)&&(identical(other.paymentTypeDescription, _this.paymentTypeDescription) || other.paymentTypeDescription == _this.paymentTypeDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketReturn;
  return Object.hash(runtimeType,_this.returnDate,_this.returnQty,_this.unitPriceReturn,_this.paymentTypeDescription);
}

@override
String toString() {
  final _this = this as TicketReturn;
  return 'TicketReturn(returnDate: ${_this.returnDate}, returnQty: ${_this.returnQty}, unitPriceReturn: ${_this.unitPriceReturn}, paymentTypeDescription: ${_this.paymentTypeDescription})';
}


}

/// @nodoc
abstract mixin class $TicketReturnCopyWith<$Res>  {
  factory $TicketReturnCopyWith(TicketReturn value, $Res Function(TicketReturn) _then) = _$TicketReturnCopyWithImpl;
@useResult
$Res call({
 DateTime? returnDate, int? returnQty, double? unitPriceReturn, String? paymentTypeDescription
});




}
/// @nodoc
class _$TicketReturnCopyWithImpl<$Res>
    implements $TicketReturnCopyWith<$Res> {
  _$TicketReturnCopyWithImpl(this._self, this._then);

  final TicketReturn _self;
  final $Res Function(TicketReturn) _then;

/// Create a copy of TicketReturn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? returnDate = freezed,Object? returnQty = freezed,Object? unitPriceReturn = freezed,Object? paymentTypeDescription = freezed,}) {
  return _then(TicketReturn(
returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as DateTime?,returnQty: freezed == returnQty ? _self.returnQty : returnQty // ignore: cast_nullable_to_non_nullable
as int?,unitPriceReturn: freezed == unitPriceReturn ? _self.unitPriceReturn : unitPriceReturn // ignore: cast_nullable_to_non_nullable
as double?,paymentTypeDescription: freezed == paymentTypeDescription ? _self.paymentTypeDescription : paymentTypeDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketReturn].
extension TicketReturnPatterns on TicketReturn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketReturn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketReturn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketReturn value)  $default,){
final _that = this;
switch (_that) {
case _TicketReturn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketReturn value)?  $default,){
final _that = this;
switch (_that) {
case _TicketReturn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? returnDate,  int? returnQty,  double? unitPriceReturn,  String? paymentTypeDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketReturn() when $default != null:
return $default(_that.returnDate,_that.returnQty,_that.unitPriceReturn,_that.paymentTypeDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? returnDate,  int? returnQty,  double? unitPriceReturn,  String? paymentTypeDescription)  $default,) {final _that = this;
switch (_that) {
case _TicketReturn():
return $default(_that.returnDate,_that.returnQty,_that.unitPriceReturn,_that.paymentTypeDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? returnDate,  int? returnQty,  double? unitPriceReturn,  String? paymentTypeDescription)?  $default,) {final _that = this;
switch (_that) {
case _TicketReturn() when $default != null:
return $default(_that.returnDate,_that.returnQty,_that.unitPriceReturn,_that.paymentTypeDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketReturn implements TicketReturn {
  const _TicketReturn({this.returnDate, this.returnQty, this.unitPriceReturn, this.paymentTypeDescription});
  factory _TicketReturn.fromJson(Map<String, dynamic> json) => _$TicketReturnFromJson(json);

@override final  DateTime? returnDate;
@override final  int? returnQty;
@override final  double? unitPriceReturn;
@override final  String? paymentTypeDescription;

/// Create a copy of TicketReturn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketReturnCopyWith<_TicketReturn> get copyWith => __$TicketReturnCopyWithImpl<_TicketReturn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketReturnToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketReturn&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.returnQty, returnQty) || other.returnQty == returnQty)&&(identical(other.unitPriceReturn, unitPriceReturn) || other.unitPriceReturn == unitPriceReturn)&&(identical(other.paymentTypeDescription, paymentTypeDescription) || other.paymentTypeDescription == paymentTypeDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,returnDate,returnQty,unitPriceReturn,paymentTypeDescription);
}

@override
String toString() {
    return 'TicketReturn(returnDate: $returnDate, returnQty: $returnQty, unitPriceReturn: $unitPriceReturn, paymentTypeDescription: $paymentTypeDescription)';
}


}

/// @nodoc
abstract mixin class _$TicketReturnCopyWith<$Res> implements $TicketReturnCopyWith<$Res> {
  factory _$TicketReturnCopyWith(_TicketReturn value, $Res Function(_TicketReturn) _then) = __$TicketReturnCopyWithImpl;
@override @useResult
$Res call({
 DateTime? returnDate, int? returnQty, double? unitPriceReturn, String? paymentTypeDescription
});




}
/// @nodoc
class __$TicketReturnCopyWithImpl<$Res>
    implements _$TicketReturnCopyWith<$Res> {
  __$TicketReturnCopyWithImpl(this._self, this._then);

  final _TicketReturn _self;
  final $Res Function(_TicketReturn) _then;

/// Create a copy of TicketReturn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? returnDate = freezed,Object? returnQty = freezed,Object? unitPriceReturn = freezed,Object? paymentTypeDescription = freezed,}) {
  return _then(_TicketReturn(
returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as DateTime?,returnQty: freezed == returnQty ? _self.returnQty : returnQty // ignore: cast_nullable_to_non_nullable
as int?,unitPriceReturn: freezed == unitPriceReturn ? _self.unitPriceReturn : unitPriceReturn // ignore: cast_nullable_to_non_nullable
as double?,paymentTypeDescription: freezed == paymentTypeDescription ? _self.paymentTypeDescription : paymentTypeDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketDetailResponse {

 int? get customerId; TicketHistoryEntry? get ticket; MkkmTicket? get ticketEkp; bool? get canChangeLine; bool? get canReturn; bool? get canEditByInternet; bool? get canChangeStorageMedium; bool? get canGenerateInvoice; bool? get canBuyTheSame; bool? get possibleRefundViaTpay; DateTime? get minExpireReturnDate; int? get invoiceHeaderId; List<TicketStateChange>? get transactionStateList; List<TicketStateChange>? get paymentStateList; List<TicketStateChange>? get refundStateList; List<TicketStateChange>? get changeLineList;/// Null unless the ticket was returned; one entry in every capture.
 List<TicketReturn>? get ticketReturns;/// Shapes never observed (always null in captures) — kept raw.
 dynamic get storageMediumChanges; dynamic get downloads;
/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailResponseCopyWith<TicketDetailResponse> get copyWith => _$TicketDetailResponseCopyWithImpl<TicketDetailResponse>(this as TicketDetailResponse, _$identity);

  /// Serializes this TicketDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketDetailResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailResponse&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.ticket, _this.ticket) || other.ticket == _this.ticket)&&(identical(other.ticketEkp, _this.ticketEkp) || other.ticketEkp == _this.ticketEkp)&&(identical(other.canChangeLine, _this.canChangeLine) || other.canChangeLine == _this.canChangeLine)&&(identical(other.canReturn, _this.canReturn) || other.canReturn == _this.canReturn)&&(identical(other.canEditByInternet, _this.canEditByInternet) || other.canEditByInternet == _this.canEditByInternet)&&(identical(other.canChangeStorageMedium, _this.canChangeStorageMedium) || other.canChangeStorageMedium == _this.canChangeStorageMedium)&&(identical(other.canGenerateInvoice, _this.canGenerateInvoice) || other.canGenerateInvoice == _this.canGenerateInvoice)&&(identical(other.canBuyTheSame, _this.canBuyTheSame) || other.canBuyTheSame == _this.canBuyTheSame)&&(identical(other.possibleRefundViaTpay, _this.possibleRefundViaTpay) || other.possibleRefundViaTpay == _this.possibleRefundViaTpay)&&(identical(other.minExpireReturnDate, _this.minExpireReturnDate) || other.minExpireReturnDate == _this.minExpireReturnDate)&&(identical(other.invoiceHeaderId, _this.invoiceHeaderId) || other.invoiceHeaderId == _this.invoiceHeaderId)&&const DeepCollectionEquality().equals(other.transactionStateList, _this.transactionStateList)&&const DeepCollectionEquality().equals(other.paymentStateList, _this.paymentStateList)&&const DeepCollectionEquality().equals(other.refundStateList, _this.refundStateList)&&const DeepCollectionEquality().equals(other.changeLineList, _this.changeLineList)&&const DeepCollectionEquality().equals(other.ticketReturns, _this.ticketReturns)&&const DeepCollectionEquality().equals(other.storageMediumChanges, _this.storageMediumChanges)&&const DeepCollectionEquality().equals(other.downloads, _this.downloads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketDetailResponse;
  return Object.hashAll([runtimeType,_this.customerId,_this.ticket,_this.ticketEkp,_this.canChangeLine,_this.canReturn,_this.canEditByInternet,_this.canChangeStorageMedium,_this.canGenerateInvoice,_this.canBuyTheSame,_this.possibleRefundViaTpay,_this.minExpireReturnDate,_this.invoiceHeaderId,const DeepCollectionEquality().hash(_this.transactionStateList),const DeepCollectionEquality().hash(_this.paymentStateList),const DeepCollectionEquality().hash(_this.refundStateList),const DeepCollectionEquality().hash(_this.changeLineList),const DeepCollectionEquality().hash(_this.ticketReturns),const DeepCollectionEquality().hash(_this.storageMediumChanges),const DeepCollectionEquality().hash(_this.downloads)]);
}

@override
String toString() {
  final _this = this as TicketDetailResponse;
  return 'TicketDetailResponse(customerId: ${_this.customerId}, ticket: ${_this.ticket}, ticketEkp: ${_this.ticketEkp}, canChangeLine: ${_this.canChangeLine}, canReturn: ${_this.canReturn}, canEditByInternet: ${_this.canEditByInternet}, canChangeStorageMedium: ${_this.canChangeStorageMedium}, canGenerateInvoice: ${_this.canGenerateInvoice}, canBuyTheSame: ${_this.canBuyTheSame}, possibleRefundViaTpay: ${_this.possibleRefundViaTpay}, minExpireReturnDate: ${_this.minExpireReturnDate}, invoiceHeaderId: ${_this.invoiceHeaderId}, transactionStateList: ${_this.transactionStateList}, paymentStateList: ${_this.paymentStateList}, refundStateList: ${_this.refundStateList}, changeLineList: ${_this.changeLineList}, ticketReturns: ${_this.ticketReturns}, storageMediumChanges: ${_this.storageMediumChanges}, downloads: ${_this.downloads})';
}


}

/// @nodoc
abstract mixin class $TicketDetailResponseCopyWith<$Res>  {
  factory $TicketDetailResponseCopyWith(TicketDetailResponse value, $Res Function(TicketDetailResponse) _then) = _$TicketDetailResponseCopyWithImpl;
@useResult
$Res call({
 int? customerId, TicketHistoryEntry? ticket, MkkmTicket? ticketEkp, bool? canChangeLine, bool? canReturn, bool? canEditByInternet, bool? canChangeStorageMedium, bool? canGenerateInvoice, bool? canBuyTheSame, bool? possibleRefundViaTpay, DateTime? minExpireReturnDate, int? invoiceHeaderId, List<TicketStateChange>? transactionStateList, List<TicketStateChange>? paymentStateList, List<TicketStateChange>? refundStateList, List<TicketStateChange>? changeLineList, List<TicketReturn>? ticketReturns, dynamic storageMediumChanges, dynamic downloads
});


$TicketHistoryEntryCopyWith<$Res>? get ticket;$MkkmTicketCopyWith<$Res>? get ticketEkp;

}
/// @nodoc
class _$TicketDetailResponseCopyWithImpl<$Res>
    implements $TicketDetailResponseCopyWith<$Res> {
  _$TicketDetailResponseCopyWithImpl(this._self, this._then);

  final TicketDetailResponse _self;
  final $Res Function(TicketDetailResponse) _then;

/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerId = freezed,Object? ticket = freezed,Object? ticketEkp = freezed,Object? canChangeLine = freezed,Object? canReturn = freezed,Object? canEditByInternet = freezed,Object? canChangeStorageMedium = freezed,Object? canGenerateInvoice = freezed,Object? canBuyTheSame = freezed,Object? possibleRefundViaTpay = freezed,Object? minExpireReturnDate = freezed,Object? invoiceHeaderId = freezed,Object? transactionStateList = freezed,Object? paymentStateList = freezed,Object? refundStateList = freezed,Object? changeLineList = freezed,Object? ticketReturns = freezed,Object? storageMediumChanges = freezed,Object? downloads = freezed,}) {
  return _then(TicketDetailResponse(
customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as TicketHistoryEntry?,ticketEkp: freezed == ticketEkp ? _self.ticketEkp : ticketEkp // ignore: cast_nullable_to_non_nullable
as MkkmTicket?,canChangeLine: freezed == canChangeLine ? _self.canChangeLine : canChangeLine // ignore: cast_nullable_to_non_nullable
as bool?,canReturn: freezed == canReturn ? _self.canReturn : canReturn // ignore: cast_nullable_to_non_nullable
as bool?,canEditByInternet: freezed == canEditByInternet ? _self.canEditByInternet : canEditByInternet // ignore: cast_nullable_to_non_nullable
as bool?,canChangeStorageMedium: freezed == canChangeStorageMedium ? _self.canChangeStorageMedium : canChangeStorageMedium // ignore: cast_nullable_to_non_nullable
as bool?,canGenerateInvoice: freezed == canGenerateInvoice ? _self.canGenerateInvoice : canGenerateInvoice // ignore: cast_nullable_to_non_nullable
as bool?,canBuyTheSame: freezed == canBuyTheSame ? _self.canBuyTheSame : canBuyTheSame // ignore: cast_nullable_to_non_nullable
as bool?,possibleRefundViaTpay: freezed == possibleRefundViaTpay ? _self.possibleRefundViaTpay : possibleRefundViaTpay // ignore: cast_nullable_to_non_nullable
as bool?,minExpireReturnDate: freezed == minExpireReturnDate ? _self.minExpireReturnDate : minExpireReturnDate // ignore: cast_nullable_to_non_nullable
as DateTime?,invoiceHeaderId: freezed == invoiceHeaderId ? _self.invoiceHeaderId : invoiceHeaderId // ignore: cast_nullable_to_non_nullable
as int?,transactionStateList: freezed == transactionStateList ? _self.transactionStateList : transactionStateList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,paymentStateList: freezed == paymentStateList ? _self.paymentStateList : paymentStateList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,refundStateList: freezed == refundStateList ? _self.refundStateList : refundStateList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,changeLineList: freezed == changeLineList ? _self.changeLineList : changeLineList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,ticketReturns: freezed == ticketReturns ? _self.ticketReturns : ticketReturns // ignore: cast_nullable_to_non_nullable
as List<TicketReturn>?,storageMediumChanges: freezed == storageMediumChanges ? _self.storageMediumChanges : storageMediumChanges // ignore: cast_nullable_to_non_nullable
as dynamic,downloads: freezed == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketHistoryEntryCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $TicketHistoryEntryCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MkkmTicketCopyWith<$Res>? get ticketEkp {
    if (_self.ticketEkp == null) {
    return null;
  }

  return $MkkmTicketCopyWith<$Res>(_self.ticketEkp!, (value) {
    return _then(_self.copyWith(ticketEkp: value));
  });
}
}


/// Adds pattern-matching-related methods to [TicketDetailResponse].
extension TicketDetailResponsePatterns on TicketDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? customerId,  TicketHistoryEntry? ticket,  MkkmTicket? ticketEkp,  bool? canChangeLine,  bool? canReturn,  bool? canEditByInternet,  bool? canChangeStorageMedium,  bool? canGenerateInvoice,  bool? canBuyTheSame,  bool? possibleRefundViaTpay,  DateTime? minExpireReturnDate,  int? invoiceHeaderId,  List<TicketStateChange>? transactionStateList,  List<TicketStateChange>? paymentStateList,  List<TicketStateChange>? refundStateList,  List<TicketStateChange>? changeLineList,  List<TicketReturn>? ticketReturns,  dynamic storageMediumChanges,  dynamic downloads)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketDetailResponse() when $default != null:
return $default(_that.customerId,_that.ticket,_that.ticketEkp,_that.canChangeLine,_that.canReturn,_that.canEditByInternet,_that.canChangeStorageMedium,_that.canGenerateInvoice,_that.canBuyTheSame,_that.possibleRefundViaTpay,_that.minExpireReturnDate,_that.invoiceHeaderId,_that.transactionStateList,_that.paymentStateList,_that.refundStateList,_that.changeLineList,_that.ticketReturns,_that.storageMediumChanges,_that.downloads);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? customerId,  TicketHistoryEntry? ticket,  MkkmTicket? ticketEkp,  bool? canChangeLine,  bool? canReturn,  bool? canEditByInternet,  bool? canChangeStorageMedium,  bool? canGenerateInvoice,  bool? canBuyTheSame,  bool? possibleRefundViaTpay,  DateTime? minExpireReturnDate,  int? invoiceHeaderId,  List<TicketStateChange>? transactionStateList,  List<TicketStateChange>? paymentStateList,  List<TicketStateChange>? refundStateList,  List<TicketStateChange>? changeLineList,  List<TicketReturn>? ticketReturns,  dynamic storageMediumChanges,  dynamic downloads)  $default,) {final _that = this;
switch (_that) {
case _TicketDetailResponse():
return $default(_that.customerId,_that.ticket,_that.ticketEkp,_that.canChangeLine,_that.canReturn,_that.canEditByInternet,_that.canChangeStorageMedium,_that.canGenerateInvoice,_that.canBuyTheSame,_that.possibleRefundViaTpay,_that.minExpireReturnDate,_that.invoiceHeaderId,_that.transactionStateList,_that.paymentStateList,_that.refundStateList,_that.changeLineList,_that.ticketReturns,_that.storageMediumChanges,_that.downloads);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? customerId,  TicketHistoryEntry? ticket,  MkkmTicket? ticketEkp,  bool? canChangeLine,  bool? canReturn,  bool? canEditByInternet,  bool? canChangeStorageMedium,  bool? canGenerateInvoice,  bool? canBuyTheSame,  bool? possibleRefundViaTpay,  DateTime? minExpireReturnDate,  int? invoiceHeaderId,  List<TicketStateChange>? transactionStateList,  List<TicketStateChange>? paymentStateList,  List<TicketStateChange>? refundStateList,  List<TicketStateChange>? changeLineList,  List<TicketReturn>? ticketReturns,  dynamic storageMediumChanges,  dynamic downloads)?  $default,) {final _that = this;
switch (_that) {
case _TicketDetailResponse() when $default != null:
return $default(_that.customerId,_that.ticket,_that.ticketEkp,_that.canChangeLine,_that.canReturn,_that.canEditByInternet,_that.canChangeStorageMedium,_that.canGenerateInvoice,_that.canBuyTheSame,_that.possibleRefundViaTpay,_that.minExpireReturnDate,_that.invoiceHeaderId,_that.transactionStateList,_that.paymentStateList,_that.refundStateList,_that.changeLineList,_that.ticketReturns,_that.storageMediumChanges,_that.downloads);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketDetailResponse implements TicketDetailResponse {
  const _TicketDetailResponse({this.customerId, this.ticket, this.ticketEkp, this.canChangeLine, this.canReturn, this.canEditByInternet, this.canChangeStorageMedium, this.canGenerateInvoice, this.canBuyTheSame, this.possibleRefundViaTpay, this.minExpireReturnDate, this.invoiceHeaderId,  List<TicketStateChange>? transactionStateList,  List<TicketStateChange>? paymentStateList,  List<TicketStateChange>? refundStateList,  List<TicketStateChange>? changeLineList,  List<TicketReturn>? ticketReturns, this.storageMediumChanges, this.downloads}): _transactionStateList = transactionStateList,_paymentStateList = paymentStateList,_refundStateList = refundStateList,_changeLineList = changeLineList,_ticketReturns = ticketReturns;
  factory _TicketDetailResponse.fromJson(Map<String, dynamic> json) => _$TicketDetailResponseFromJson(json);

@override final  int? customerId;
@override final  TicketHistoryEntry? ticket;
@override final  MkkmTicket? ticketEkp;
@override final  bool? canChangeLine;
@override final  bool? canReturn;
@override final  bool? canEditByInternet;
@override final  bool? canChangeStorageMedium;
@override final  bool? canGenerateInvoice;
@override final  bool? canBuyTheSame;
@override final  bool? possibleRefundViaTpay;
@override final  DateTime? minExpireReturnDate;
@override final  int? invoiceHeaderId;
 final  List<TicketStateChange>? _transactionStateList;
@override List<TicketStateChange>? get transactionStateList {
  final value = _transactionStateList;
  if (value == null) return null;
  if (_transactionStateList is EqualUnmodifiableListView) return _transactionStateList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TicketStateChange>? _paymentStateList;
@override List<TicketStateChange>? get paymentStateList {
  final value = _paymentStateList;
  if (value == null) return null;
  if (_paymentStateList is EqualUnmodifiableListView) return _paymentStateList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TicketStateChange>? _refundStateList;
@override List<TicketStateChange>? get refundStateList {
  final value = _refundStateList;
  if (value == null) return null;
  if (_refundStateList is EqualUnmodifiableListView) return _refundStateList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TicketStateChange>? _changeLineList;
@override List<TicketStateChange>? get changeLineList {
  final value = _changeLineList;
  if (value == null) return null;
  if (_changeLineList is EqualUnmodifiableListView) return _changeLineList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Null unless the ticket was returned; one entry in every capture.
 final  List<TicketReturn>? _ticketReturns;
/// Null unless the ticket was returned; one entry in every capture.
@override List<TicketReturn>? get ticketReturns {
  final value = _ticketReturns;
  if (value == null) return null;
  if (_ticketReturns is EqualUnmodifiableListView) return _ticketReturns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Shapes never observed (always null in captures) — kept raw.
@override final  dynamic storageMediumChanges;
@override final  dynamic downloads;

/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketDetailResponseCopyWith<_TicketDetailResponse> get copyWith => __$TicketDetailResponseCopyWithImpl<_TicketDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketDetailResponse&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.ticketEkp, ticketEkp) || other.ticketEkp == ticketEkp)&&(identical(other.canChangeLine, canChangeLine) || other.canChangeLine == canChangeLine)&&(identical(other.canReturn, canReturn) || other.canReturn == canReturn)&&(identical(other.canEditByInternet, canEditByInternet) || other.canEditByInternet == canEditByInternet)&&(identical(other.canChangeStorageMedium, canChangeStorageMedium) || other.canChangeStorageMedium == canChangeStorageMedium)&&(identical(other.canGenerateInvoice, canGenerateInvoice) || other.canGenerateInvoice == canGenerateInvoice)&&(identical(other.canBuyTheSame, canBuyTheSame) || other.canBuyTheSame == canBuyTheSame)&&(identical(other.possibleRefundViaTpay, possibleRefundViaTpay) || other.possibleRefundViaTpay == possibleRefundViaTpay)&&(identical(other.minExpireReturnDate, minExpireReturnDate) || other.minExpireReturnDate == minExpireReturnDate)&&(identical(other.invoiceHeaderId, invoiceHeaderId) || other.invoiceHeaderId == invoiceHeaderId)&&const DeepCollectionEquality().equals(other.transactionStateList, _transactionStateList)&&const DeepCollectionEquality().equals(other.paymentStateList, _paymentStateList)&&const DeepCollectionEquality().equals(other.refundStateList, _refundStateList)&&const DeepCollectionEquality().equals(other.changeLineList, _changeLineList)&&const DeepCollectionEquality().equals(other.ticketReturns, _ticketReturns)&&const DeepCollectionEquality().equals(other.storageMediumChanges, storageMediumChanges)&&const DeepCollectionEquality().equals(other.downloads, downloads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,customerId,ticket,ticketEkp,canChangeLine,canReturn,canEditByInternet,canChangeStorageMedium,canGenerateInvoice,canBuyTheSame,possibleRefundViaTpay,minExpireReturnDate,invoiceHeaderId,const DeepCollectionEquality().hash(_transactionStateList),const DeepCollectionEquality().hash(_paymentStateList),const DeepCollectionEquality().hash(_refundStateList),const DeepCollectionEquality().hash(_changeLineList),const DeepCollectionEquality().hash(_ticketReturns),const DeepCollectionEquality().hash(storageMediumChanges),const DeepCollectionEquality().hash(downloads)]);
}

@override
String toString() {
    return 'TicketDetailResponse(customerId: $customerId, ticket: $ticket, ticketEkp: $ticketEkp, canChangeLine: $canChangeLine, canReturn: $canReturn, canEditByInternet: $canEditByInternet, canChangeStorageMedium: $canChangeStorageMedium, canGenerateInvoice: $canGenerateInvoice, canBuyTheSame: $canBuyTheSame, possibleRefundViaTpay: $possibleRefundViaTpay, minExpireReturnDate: $minExpireReturnDate, invoiceHeaderId: $invoiceHeaderId, transactionStateList: $transactionStateList, paymentStateList: $paymentStateList, refundStateList: $refundStateList, changeLineList: $changeLineList, ticketReturns: $ticketReturns, storageMediumChanges: $storageMediumChanges, downloads: $downloads)';
}


}

/// @nodoc
abstract mixin class _$TicketDetailResponseCopyWith<$Res> implements $TicketDetailResponseCopyWith<$Res> {
  factory _$TicketDetailResponseCopyWith(_TicketDetailResponse value, $Res Function(_TicketDetailResponse) _then) = __$TicketDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 int? customerId, TicketHistoryEntry? ticket, MkkmTicket? ticketEkp, bool? canChangeLine, bool? canReturn, bool? canEditByInternet, bool? canChangeStorageMedium, bool? canGenerateInvoice, bool? canBuyTheSame, bool? possibleRefundViaTpay, DateTime? minExpireReturnDate, int? invoiceHeaderId, List<TicketStateChange>? transactionStateList, List<TicketStateChange>? paymentStateList, List<TicketStateChange>? refundStateList, List<TicketStateChange>? changeLineList, List<TicketReturn>? ticketReturns, dynamic storageMediumChanges, dynamic downloads
});


@override $TicketHistoryEntryCopyWith<$Res>? get ticket;@override $MkkmTicketCopyWith<$Res>? get ticketEkp;

}
/// @nodoc
class __$TicketDetailResponseCopyWithImpl<$Res>
    implements _$TicketDetailResponseCopyWith<$Res> {
  __$TicketDetailResponseCopyWithImpl(this._self, this._then);

  final _TicketDetailResponse _self;
  final $Res Function(_TicketDetailResponse) _then;

/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerId = freezed,Object? ticket = freezed,Object? ticketEkp = freezed,Object? canChangeLine = freezed,Object? canReturn = freezed,Object? canEditByInternet = freezed,Object? canChangeStorageMedium = freezed,Object? canGenerateInvoice = freezed,Object? canBuyTheSame = freezed,Object? possibleRefundViaTpay = freezed,Object? minExpireReturnDate = freezed,Object? invoiceHeaderId = freezed,Object? transactionStateList = freezed,Object? paymentStateList = freezed,Object? refundStateList = freezed,Object? changeLineList = freezed,Object? ticketReturns = freezed,Object? storageMediumChanges = freezed,Object? downloads = freezed,}) {
  return _then(_TicketDetailResponse(
customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as TicketHistoryEntry?,ticketEkp: freezed == ticketEkp ? _self.ticketEkp : ticketEkp // ignore: cast_nullable_to_non_nullable
as MkkmTicket?,canChangeLine: freezed == canChangeLine ? _self.canChangeLine : canChangeLine // ignore: cast_nullable_to_non_nullable
as bool?,canReturn: freezed == canReturn ? _self.canReturn : canReturn // ignore: cast_nullable_to_non_nullable
as bool?,canEditByInternet: freezed == canEditByInternet ? _self.canEditByInternet : canEditByInternet // ignore: cast_nullable_to_non_nullable
as bool?,canChangeStorageMedium: freezed == canChangeStorageMedium ? _self.canChangeStorageMedium : canChangeStorageMedium // ignore: cast_nullable_to_non_nullable
as bool?,canGenerateInvoice: freezed == canGenerateInvoice ? _self.canGenerateInvoice : canGenerateInvoice // ignore: cast_nullable_to_non_nullable
as bool?,canBuyTheSame: freezed == canBuyTheSame ? _self.canBuyTheSame : canBuyTheSame // ignore: cast_nullable_to_non_nullable
as bool?,possibleRefundViaTpay: freezed == possibleRefundViaTpay ? _self.possibleRefundViaTpay : possibleRefundViaTpay // ignore: cast_nullable_to_non_nullable
as bool?,minExpireReturnDate: freezed == minExpireReturnDate ? _self.minExpireReturnDate : minExpireReturnDate // ignore: cast_nullable_to_non_nullable
as DateTime?,invoiceHeaderId: freezed == invoiceHeaderId ? _self.invoiceHeaderId : invoiceHeaderId // ignore: cast_nullable_to_non_nullable
as int?,transactionStateList: freezed == transactionStateList ? _self._transactionStateList : transactionStateList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,paymentStateList: freezed == paymentStateList ? _self._paymentStateList : paymentStateList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,refundStateList: freezed == refundStateList ? _self._refundStateList : refundStateList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,changeLineList: freezed == changeLineList ? _self._changeLineList : changeLineList // ignore: cast_nullable_to_non_nullable
as List<TicketStateChange>?,ticketReturns: freezed == ticketReturns ? _self._ticketReturns : ticketReturns // ignore: cast_nullable_to_non_nullable
as List<TicketReturn>?,storageMediumChanges: freezed == storageMediumChanges ? _self.storageMediumChanges : storageMediumChanges // ignore: cast_nullable_to_non_nullable
as dynamic,downloads: freezed == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketHistoryEntryCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $TicketHistoryEntryCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}/// Create a copy of TicketDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MkkmTicketCopyWith<$Res>? get ticketEkp {
    if (_self.ticketEkp == null) {
    return null;
  }

  return $MkkmTicketCopyWith<$Res>(_self.ticketEkp!, (value) {
    return _then(_self.copyWith(ticketEkp: value));
  });
}
}


/// @nodoc
mixin _$SalesLineOption {

 int? get code; String? get description; int? get urbanLineQty; int? get suburbanLineQty; int? get suburban2LineQty; bool? get isMetropolitan; bool? get isNetwork; bool? get selectableLines; int? get sumLinesToSelection;
/// Create a copy of SalesLineOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesLineOptionCopyWith<SalesLineOption> get copyWith => _$SalesLineOptionCopyWithImpl<SalesLineOption>(this as SalesLineOption, _$identity);

  /// Serializes this SalesLineOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SalesLineOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLineOption&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.urbanLineQty, _this.urbanLineQty) || other.urbanLineQty == _this.urbanLineQty)&&(identical(other.suburbanLineQty, _this.suburbanLineQty) || other.suburbanLineQty == _this.suburbanLineQty)&&(identical(other.suburban2LineQty, _this.suburban2LineQty) || other.suburban2LineQty == _this.suburban2LineQty)&&(identical(other.isMetropolitan, _this.isMetropolitan) || other.isMetropolitan == _this.isMetropolitan)&&(identical(other.isNetwork, _this.isNetwork) || other.isNetwork == _this.isNetwork)&&(identical(other.selectableLines, _this.selectableLines) || other.selectableLines == _this.selectableLines)&&(identical(other.sumLinesToSelection, _this.sumLinesToSelection) || other.sumLinesToSelection == _this.sumLinesToSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SalesLineOption;
  return Object.hash(runtimeType,_this.code,_this.description,_this.urbanLineQty,_this.suburbanLineQty,_this.suburban2LineQty,_this.isMetropolitan,_this.isNetwork,_this.selectableLines,_this.sumLinesToSelection);
}

@override
String toString() {
  final _this = this as SalesLineOption;
  return 'SalesLineOption(code: ${_this.code}, description: ${_this.description}, urbanLineQty: ${_this.urbanLineQty}, suburbanLineQty: ${_this.suburbanLineQty}, suburban2LineQty: ${_this.suburban2LineQty}, isMetropolitan: ${_this.isMetropolitan}, isNetwork: ${_this.isNetwork}, selectableLines: ${_this.selectableLines}, sumLinesToSelection: ${_this.sumLinesToSelection})';
}


}

/// @nodoc
abstract mixin class $SalesLineOptionCopyWith<$Res>  {
  factory $SalesLineOptionCopyWith(SalesLineOption value, $Res Function(SalesLineOption) _then) = _$SalesLineOptionCopyWithImpl;
@useResult
$Res call({
 int? code, String? description, int? urbanLineQty, int? suburbanLineQty, int? suburban2LineQty, bool? isMetropolitan, bool? isNetwork, bool? selectableLines, int? sumLinesToSelection
});




}
/// @nodoc
class _$SalesLineOptionCopyWithImpl<$Res>
    implements $SalesLineOptionCopyWith<$Res> {
  _$SalesLineOptionCopyWithImpl(this._self, this._then);

  final SalesLineOption _self;
  final $Res Function(SalesLineOption) _then;

/// Create a copy of SalesLineOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? description = freezed,Object? urbanLineQty = freezed,Object? suburbanLineQty = freezed,Object? suburban2LineQty = freezed,Object? isMetropolitan = freezed,Object? isNetwork = freezed,Object? selectableLines = freezed,Object? sumLinesToSelection = freezed,}) {
  return _then(SalesLineOption(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,urbanLineQty: freezed == urbanLineQty ? _self.urbanLineQty : urbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburbanLineQty: freezed == suburbanLineQty ? _self.suburbanLineQty : suburbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburban2LineQty: freezed == suburban2LineQty ? _self.suburban2LineQty : suburban2LineQty // ignore: cast_nullable_to_non_nullable
as int?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,selectableLines: freezed == selectableLines ? _self.selectableLines : selectableLines // ignore: cast_nullable_to_non_nullable
as bool?,sumLinesToSelection: freezed == sumLinesToSelection ? _self.sumLinesToSelection : sumLinesToSelection // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesLineOption].
extension SalesLineOptionPatterns on SalesLineOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesLineOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesLineOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesLineOption value)  $default,){
final _that = this;
switch (_that) {
case _SalesLineOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesLineOption value)?  $default,){
final _that = this;
switch (_that) {
case _SalesLineOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? description,  int? urbanLineQty,  int? suburbanLineQty,  int? suburban2LineQty,  bool? isMetropolitan,  bool? isNetwork,  bool? selectableLines,  int? sumLinesToSelection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesLineOption() when $default != null:
return $default(_that.code,_that.description,_that.urbanLineQty,_that.suburbanLineQty,_that.suburban2LineQty,_that.isMetropolitan,_that.isNetwork,_that.selectableLines,_that.sumLinesToSelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? description,  int? urbanLineQty,  int? suburbanLineQty,  int? suburban2LineQty,  bool? isMetropolitan,  bool? isNetwork,  bool? selectableLines,  int? sumLinesToSelection)  $default,) {final _that = this;
switch (_that) {
case _SalesLineOption():
return $default(_that.code,_that.description,_that.urbanLineQty,_that.suburbanLineQty,_that.suburban2LineQty,_that.isMetropolitan,_that.isNetwork,_that.selectableLines,_that.sumLinesToSelection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? description,  int? urbanLineQty,  int? suburbanLineQty,  int? suburban2LineQty,  bool? isMetropolitan,  bool? isNetwork,  bool? selectableLines,  int? sumLinesToSelection)?  $default,) {final _that = this;
switch (_that) {
case _SalesLineOption() when $default != null:
return $default(_that.code,_that.description,_that.urbanLineQty,_that.suburbanLineQty,_that.suburban2LineQty,_that.isMetropolitan,_that.isNetwork,_that.selectableLines,_that.sumLinesToSelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SalesLineOption implements SalesLineOption {
  const _SalesLineOption({this.code, this.description, this.urbanLineQty, this.suburbanLineQty, this.suburban2LineQty, this.isMetropolitan, this.isNetwork, this.selectableLines, this.sumLinesToSelection});
  factory _SalesLineOption.fromJson(Map<String, dynamic> json) => _$SalesLineOptionFromJson(json);

@override final  int? code;
@override final  String? description;
@override final  int? urbanLineQty;
@override final  int? suburbanLineQty;
@override final  int? suburban2LineQty;
@override final  bool? isMetropolitan;
@override final  bool? isNetwork;
@override final  bool? selectableLines;
@override final  int? sumLinesToSelection;

/// Create a copy of SalesLineOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesLineOptionCopyWith<_SalesLineOption> get copyWith => __$SalesLineOptionCopyWithImpl<_SalesLineOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalesLineOptionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesLineOption&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.urbanLineQty, urbanLineQty) || other.urbanLineQty == urbanLineQty)&&(identical(other.suburbanLineQty, suburbanLineQty) || other.suburbanLineQty == suburbanLineQty)&&(identical(other.suburban2LineQty, suburban2LineQty) || other.suburban2LineQty == suburban2LineQty)&&(identical(other.isMetropolitan, isMetropolitan) || other.isMetropolitan == isMetropolitan)&&(identical(other.isNetwork, isNetwork) || other.isNetwork == isNetwork)&&(identical(other.selectableLines, selectableLines) || other.selectableLines == selectableLines)&&(identical(other.sumLinesToSelection, sumLinesToSelection) || other.sumLinesToSelection == sumLinesToSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,description,urbanLineQty,suburbanLineQty,suburban2LineQty,isMetropolitan,isNetwork,selectableLines,sumLinesToSelection);
}

@override
String toString() {
    return 'SalesLineOption(code: $code, description: $description, urbanLineQty: $urbanLineQty, suburbanLineQty: $suburbanLineQty, suburban2LineQty: $suburban2LineQty, isMetropolitan: $isMetropolitan, isNetwork: $isNetwork, selectableLines: $selectableLines, sumLinesToSelection: $sumLinesToSelection)';
}


}

/// @nodoc
abstract mixin class _$SalesLineOptionCopyWith<$Res> implements $SalesLineOptionCopyWith<$Res> {
  factory _$SalesLineOptionCopyWith(_SalesLineOption value, $Res Function(_SalesLineOption) _then) = __$SalesLineOptionCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? description, int? urbanLineQty, int? suburbanLineQty, int? suburban2LineQty, bool? isMetropolitan, bool? isNetwork, bool? selectableLines, int? sumLinesToSelection
});




}
/// @nodoc
class __$SalesLineOptionCopyWithImpl<$Res>
    implements _$SalesLineOptionCopyWith<$Res> {
  __$SalesLineOptionCopyWithImpl(this._self, this._then);

  final _SalesLineOption _self;
  final $Res Function(_SalesLineOption) _then;

/// Create a copy of SalesLineOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? description = freezed,Object? urbanLineQty = freezed,Object? suburbanLineQty = freezed,Object? suburban2LineQty = freezed,Object? isMetropolitan = freezed,Object? isNetwork = freezed,Object? selectableLines = freezed,Object? sumLinesToSelection = freezed,}) {
  return _then(_SalesLineOption(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,urbanLineQty: freezed == urbanLineQty ? _self.urbanLineQty : urbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburbanLineQty: freezed == suburbanLineQty ? _self.suburbanLineQty : suburbanLineQty // ignore: cast_nullable_to_non_nullable
as int?,suburban2LineQty: freezed == suburban2LineQty ? _self.suburban2LineQty : suburban2LineQty // ignore: cast_nullable_to_non_nullable
as int?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,selectableLines: freezed == selectableLines ? _self.selectableLines : selectableLines // ignore: cast_nullable_to_non_nullable
as bool?,sumLinesToSelection: freezed == sumLinesToSelection ? _self.sumLinesToSelection : sumLinesToSelection // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SalesPeriodOption {

 int? get code; String? get description; int? get value;/// 2 = months, 3 = days.
 int? get unit; bool? get isMetropolitan; bool? get isNetwork; bool? get useDescription;
/// Create a copy of SalesPeriodOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesPeriodOptionCopyWith<SalesPeriodOption> get copyWith => _$SalesPeriodOptionCopyWithImpl<SalesPeriodOption>(this as SalesPeriodOption, _$identity);

  /// Serializes this SalesPeriodOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SalesPeriodOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesPeriodOption&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.isMetropolitan, _this.isMetropolitan) || other.isMetropolitan == _this.isMetropolitan)&&(identical(other.isNetwork, _this.isNetwork) || other.isNetwork == _this.isNetwork)&&(identical(other.useDescription, _this.useDescription) || other.useDescription == _this.useDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SalesPeriodOption;
  return Object.hash(runtimeType,_this.code,_this.description,_this.value,_this.unit,_this.isMetropolitan,_this.isNetwork,_this.useDescription);
}

@override
String toString() {
  final _this = this as SalesPeriodOption;
  return 'SalesPeriodOption(code: ${_this.code}, description: ${_this.description}, value: ${_this.value}, unit: ${_this.unit}, isMetropolitan: ${_this.isMetropolitan}, isNetwork: ${_this.isNetwork}, useDescription: ${_this.useDescription})';
}


}

/// @nodoc
abstract mixin class $SalesPeriodOptionCopyWith<$Res>  {
  factory $SalesPeriodOptionCopyWith(SalesPeriodOption value, $Res Function(SalesPeriodOption) _then) = _$SalesPeriodOptionCopyWithImpl;
@useResult
$Res call({
 int? code, String? description, int? value, int? unit, bool? isMetropolitan, bool? isNetwork, bool? useDescription
});




}
/// @nodoc
class _$SalesPeriodOptionCopyWithImpl<$Res>
    implements $SalesPeriodOptionCopyWith<$Res> {
  _$SalesPeriodOptionCopyWithImpl(this._self, this._then);

  final SalesPeriodOption _self;
  final $Res Function(SalesPeriodOption) _then;

/// Create a copy of SalesPeriodOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? description = freezed,Object? value = freezed,Object? unit = freezed,Object? isMetropolitan = freezed,Object? isNetwork = freezed,Object? useDescription = freezed,}) {
  return _then(SalesPeriodOption(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,useDescription: freezed == useDescription ? _self.useDescription : useDescription // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesPeriodOption].
extension SalesPeriodOptionPatterns on SalesPeriodOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesPeriodOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesPeriodOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesPeriodOption value)  $default,){
final _that = this;
switch (_that) {
case _SalesPeriodOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesPeriodOption value)?  $default,){
final _that = this;
switch (_that) {
case _SalesPeriodOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? description,  int? value,  int? unit,  bool? isMetropolitan,  bool? isNetwork,  bool? useDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesPeriodOption() when $default != null:
return $default(_that.code,_that.description,_that.value,_that.unit,_that.isMetropolitan,_that.isNetwork,_that.useDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? description,  int? value,  int? unit,  bool? isMetropolitan,  bool? isNetwork,  bool? useDescription)  $default,) {final _that = this;
switch (_that) {
case _SalesPeriodOption():
return $default(_that.code,_that.description,_that.value,_that.unit,_that.isMetropolitan,_that.isNetwork,_that.useDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? description,  int? value,  int? unit,  bool? isMetropolitan,  bool? isNetwork,  bool? useDescription)?  $default,) {final _that = this;
switch (_that) {
case _SalesPeriodOption() when $default != null:
return $default(_that.code,_that.description,_that.value,_that.unit,_that.isMetropolitan,_that.isNetwork,_that.useDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SalesPeriodOption implements SalesPeriodOption {
  const _SalesPeriodOption({this.code, this.description, this.value, this.unit, this.isMetropolitan, this.isNetwork, this.useDescription});
  factory _SalesPeriodOption.fromJson(Map<String, dynamic> json) => _$SalesPeriodOptionFromJson(json);

@override final  int? code;
@override final  String? description;
@override final  int? value;
/// 2 = months, 3 = days.
@override final  int? unit;
@override final  bool? isMetropolitan;
@override final  bool? isNetwork;
@override final  bool? useDescription;

/// Create a copy of SalesPeriodOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesPeriodOptionCopyWith<_SalesPeriodOption> get copyWith => __$SalesPeriodOptionCopyWithImpl<_SalesPeriodOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalesPeriodOptionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesPeriodOption&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.isMetropolitan, isMetropolitan) || other.isMetropolitan == isMetropolitan)&&(identical(other.isNetwork, isNetwork) || other.isNetwork == isNetwork)&&(identical(other.useDescription, useDescription) || other.useDescription == useDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,description,value,unit,isMetropolitan,isNetwork,useDescription);
}

@override
String toString() {
    return 'SalesPeriodOption(code: $code, description: $description, value: $value, unit: $unit, isMetropolitan: $isMetropolitan, isNetwork: $isNetwork, useDescription: $useDescription)';
}


}

/// @nodoc
abstract mixin class _$SalesPeriodOptionCopyWith<$Res> implements $SalesPeriodOptionCopyWith<$Res> {
  factory _$SalesPeriodOptionCopyWith(_SalesPeriodOption value, $Res Function(_SalesPeriodOption) _then) = __$SalesPeriodOptionCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? description, int? value, int? unit, bool? isMetropolitan, bool? isNetwork, bool? useDescription
});




}
/// @nodoc
class __$SalesPeriodOptionCopyWithImpl<$Res>
    implements _$SalesPeriodOptionCopyWith<$Res> {
  __$SalesPeriodOptionCopyWithImpl(this._self, this._then);

  final _SalesPeriodOption _self;
  final $Res Function(_SalesPeriodOption) _then;

/// Create a copy of SalesPeriodOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? description = freezed,Object? value = freezed,Object? unit = freezed,Object? isMetropolitan = freezed,Object? isNetwork = freezed,Object? useDescription = freezed,}) {
  return _then(_SalesPeriodOption(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,useDescription: freezed == useDescription ? _self.useDescription : useDescription // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$SalesKindOption {

 int? get code; String? get description;
/// Create a copy of SalesKindOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesKindOptionCopyWith<SalesKindOption> get copyWith => _$SalesKindOptionCopyWithImpl<SalesKindOption>(this as SalesKindOption, _$identity);

  /// Serializes this SalesKindOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SalesKindOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesKindOption&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SalesKindOption;
  return Object.hash(runtimeType,_this.code,_this.description);
}

@override
String toString() {
  final _this = this as SalesKindOption;
  return 'SalesKindOption(code: ${_this.code}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $SalesKindOptionCopyWith<$Res>  {
  factory $SalesKindOptionCopyWith(SalesKindOption value, $Res Function(SalesKindOption) _then) = _$SalesKindOptionCopyWithImpl;
@useResult
$Res call({
 int? code, String? description
});




}
/// @nodoc
class _$SalesKindOptionCopyWithImpl<$Res>
    implements $SalesKindOptionCopyWith<$Res> {
  _$SalesKindOptionCopyWithImpl(this._self, this._then);

  final SalesKindOption _self;
  final $Res Function(SalesKindOption) _then;

/// Create a copy of SalesKindOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? description = freezed,}) {
  return _then(SalesKindOption(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesKindOption].
extension SalesKindOptionPatterns on SalesKindOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesKindOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesKindOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesKindOption value)  $default,){
final _that = this;
switch (_that) {
case _SalesKindOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesKindOption value)?  $default,){
final _that = this;
switch (_that) {
case _SalesKindOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesKindOption() when $default != null:
return $default(_that.code,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? description)  $default,) {final _that = this;
switch (_that) {
case _SalesKindOption():
return $default(_that.code,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _SalesKindOption() when $default != null:
return $default(_that.code,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SalesKindOption implements SalesKindOption {
  const _SalesKindOption({this.code, this.description});
  factory _SalesKindOption.fromJson(Map<String, dynamic> json) => _$SalesKindOptionFromJson(json);

@override final  int? code;
@override final  String? description;

/// Create a copy of SalesKindOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesKindOptionCopyWith<_SalesKindOption> get copyWith => __$SalesKindOptionCopyWithImpl<_SalesKindOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalesKindOptionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesKindOption&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,description);
}

@override
String toString() {
    return 'SalesKindOption(code: $code, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SalesKindOptionCopyWith<$Res> implements $SalesKindOptionCopyWith<$Res> {
  factory _$SalesKindOptionCopyWith(_SalesKindOption value, $Res Function(_SalesKindOption) _then) = __$SalesKindOptionCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? description
});




}
/// @nodoc
class __$SalesKindOptionCopyWithImpl<$Res>
    implements _$SalesKindOptionCopyWith<$Res> {
  __$SalesKindOptionCopyWithImpl(this._self, this._then);

  final _SalesKindOption _self;
  final $Res Function(_SalesKindOption) _then;

/// Create a copy of SalesKindOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? description = freezed,}) {
  return _then(_SalesKindOption(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SpecialTransportLine {

 String? get specialTransportLine; String? get name; String? get description; String? get buttonName; bool? get isNetwork; bool? get isMetropolitan;
/// Create a copy of SpecialTransportLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpecialTransportLineCopyWith<SpecialTransportLine> get copyWith => _$SpecialTransportLineCopyWithImpl<SpecialTransportLine>(this as SpecialTransportLine, _$identity);

  /// Serializes this SpecialTransportLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpecialTransportLine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpecialTransportLine&&(identical(other.specialTransportLine, _this.specialTransportLine) || other.specialTransportLine == _this.specialTransportLine)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.buttonName, _this.buttonName) || other.buttonName == _this.buttonName)&&(identical(other.isNetwork, _this.isNetwork) || other.isNetwork == _this.isNetwork)&&(identical(other.isMetropolitan, _this.isMetropolitan) || other.isMetropolitan == _this.isMetropolitan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpecialTransportLine;
  return Object.hash(runtimeType,_this.specialTransportLine,_this.name,_this.description,_this.buttonName,_this.isNetwork,_this.isMetropolitan);
}

@override
String toString() {
  final _this = this as SpecialTransportLine;
  return 'SpecialTransportLine(specialTransportLine: ${_this.specialTransportLine}, name: ${_this.name}, description: ${_this.description}, buttonName: ${_this.buttonName}, isNetwork: ${_this.isNetwork}, isMetropolitan: ${_this.isMetropolitan})';
}


}

/// @nodoc
abstract mixin class $SpecialTransportLineCopyWith<$Res>  {
  factory $SpecialTransportLineCopyWith(SpecialTransportLine value, $Res Function(SpecialTransportLine) _then) = _$SpecialTransportLineCopyWithImpl;
@useResult
$Res call({
 String? specialTransportLine, String? name, String? description, String? buttonName, bool? isNetwork, bool? isMetropolitan
});




}
/// @nodoc
class _$SpecialTransportLineCopyWithImpl<$Res>
    implements $SpecialTransportLineCopyWith<$Res> {
  _$SpecialTransportLineCopyWithImpl(this._self, this._then);

  final SpecialTransportLine _self;
  final $Res Function(SpecialTransportLine) _then;

/// Create a copy of SpecialTransportLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? specialTransportLine = freezed,Object? name = freezed,Object? description = freezed,Object? buttonName = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,}) {
  return _then(SpecialTransportLine(
specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,buttonName: freezed == buttonName ? _self.buttonName : buttonName // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpecialTransportLine].
extension SpecialTransportLinePatterns on SpecialTransportLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpecialTransportLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpecialTransportLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpecialTransportLine value)  $default,){
final _that = this;
switch (_that) {
case _SpecialTransportLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpecialTransportLine value)?  $default,){
final _that = this;
switch (_that) {
case _SpecialTransportLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? specialTransportLine,  String? name,  String? description,  String? buttonName,  bool? isNetwork,  bool? isMetropolitan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpecialTransportLine() when $default != null:
return $default(_that.specialTransportLine,_that.name,_that.description,_that.buttonName,_that.isNetwork,_that.isMetropolitan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? specialTransportLine,  String? name,  String? description,  String? buttonName,  bool? isNetwork,  bool? isMetropolitan)  $default,) {final _that = this;
switch (_that) {
case _SpecialTransportLine():
return $default(_that.specialTransportLine,_that.name,_that.description,_that.buttonName,_that.isNetwork,_that.isMetropolitan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? specialTransportLine,  String? name,  String? description,  String? buttonName,  bool? isNetwork,  bool? isMetropolitan)?  $default,) {final _that = this;
switch (_that) {
case _SpecialTransportLine() when $default != null:
return $default(_that.specialTransportLine,_that.name,_that.description,_that.buttonName,_that.isNetwork,_that.isMetropolitan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpecialTransportLine implements SpecialTransportLine {
  const _SpecialTransportLine({this.specialTransportLine, this.name, this.description, this.buttonName, this.isNetwork, this.isMetropolitan});
  factory _SpecialTransportLine.fromJson(Map<String, dynamic> json) => _$SpecialTransportLineFromJson(json);

@override final  String? specialTransportLine;
@override final  String? name;
@override final  String? description;
@override final  String? buttonName;
@override final  bool? isNetwork;
@override final  bool? isMetropolitan;

/// Create a copy of SpecialTransportLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpecialTransportLineCopyWith<_SpecialTransportLine> get copyWith => __$SpecialTransportLineCopyWithImpl<_SpecialTransportLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpecialTransportLineToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpecialTransportLine&&(identical(other.specialTransportLine, specialTransportLine) || other.specialTransportLine == specialTransportLine)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.buttonName, buttonName) || other.buttonName == buttonName)&&(identical(other.isNetwork, isNetwork) || other.isNetwork == isNetwork)&&(identical(other.isMetropolitan, isMetropolitan) || other.isMetropolitan == isMetropolitan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,specialTransportLine,name,description,buttonName,isNetwork,isMetropolitan);
}

@override
String toString() {
    return 'SpecialTransportLine(specialTransportLine: $specialTransportLine, name: $name, description: $description, buttonName: $buttonName, isNetwork: $isNetwork, isMetropolitan: $isMetropolitan)';
}


}

/// @nodoc
abstract mixin class _$SpecialTransportLineCopyWith<$Res> implements $SpecialTransportLineCopyWith<$Res> {
  factory _$SpecialTransportLineCopyWith(_SpecialTransportLine value, $Res Function(_SpecialTransportLine) _then) = __$SpecialTransportLineCopyWithImpl;
@override @useResult
$Res call({
 String? specialTransportLine, String? name, String? description, String? buttonName, bool? isNetwork, bool? isMetropolitan
});




}
/// @nodoc
class __$SpecialTransportLineCopyWithImpl<$Res>
    implements _$SpecialTransportLineCopyWith<$Res> {
  __$SpecialTransportLineCopyWithImpl(this._self, this._then);

  final _SpecialTransportLine _self;
  final $Res Function(_SpecialTransportLine) _then;

/// Create a copy of SpecialTransportLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? specialTransportLine = freezed,Object? name = freezed,Object? description = freezed,Object? buttonName = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,}) {
  return _then(_SpecialTransportLine(
specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,buttonName: freezed == buttonName ? _self.buttonName : buttonName // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$PriceListConfiguration {

 int? get ticketKindCode; int? get ticketNumberOfLineCode; int? get ticketPeriodCode;
/// Create a copy of PriceListConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceListConfigurationCopyWith<PriceListConfiguration> get copyWith => _$PriceListConfigurationCopyWithImpl<PriceListConfiguration>(this as PriceListConfiguration, _$identity);

  /// Serializes this PriceListConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PriceListConfiguration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceListConfiguration&&(identical(other.ticketKindCode, _this.ticketKindCode) || other.ticketKindCode == _this.ticketKindCode)&&(identical(other.ticketNumberOfLineCode, _this.ticketNumberOfLineCode) || other.ticketNumberOfLineCode == _this.ticketNumberOfLineCode)&&(identical(other.ticketPeriodCode, _this.ticketPeriodCode) || other.ticketPeriodCode == _this.ticketPeriodCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PriceListConfiguration;
  return Object.hash(runtimeType,_this.ticketKindCode,_this.ticketNumberOfLineCode,_this.ticketPeriodCode);
}

@override
String toString() {
  final _this = this as PriceListConfiguration;
  return 'PriceListConfiguration(ticketKindCode: ${_this.ticketKindCode}, ticketNumberOfLineCode: ${_this.ticketNumberOfLineCode}, ticketPeriodCode: ${_this.ticketPeriodCode})';
}


}

/// @nodoc
abstract mixin class $PriceListConfigurationCopyWith<$Res>  {
  factory $PriceListConfigurationCopyWith(PriceListConfiguration value, $Res Function(PriceListConfiguration) _then) = _$PriceListConfigurationCopyWithImpl;
@useResult
$Res call({
 int? ticketKindCode, int? ticketNumberOfLineCode, int? ticketPeriodCode
});




}
/// @nodoc
class _$PriceListConfigurationCopyWithImpl<$Res>
    implements $PriceListConfigurationCopyWith<$Res> {
  _$PriceListConfigurationCopyWithImpl(this._self, this._then);

  final PriceListConfiguration _self;
  final $Res Function(PriceListConfiguration) _then;

/// Create a copy of PriceListConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticketKindCode = freezed,Object? ticketNumberOfLineCode = freezed,Object? ticketPeriodCode = freezed,}) {
  return _then(PriceListConfiguration(
ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceListConfiguration].
extension PriceListConfigurationPatterns on PriceListConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceListConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceListConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceListConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _PriceListConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceListConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _PriceListConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceListConfiguration() when $default != null:
return $default(_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode)  $default,) {final _that = this;
switch (_that) {
case _PriceListConfiguration():
return $default(_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode)?  $default,) {final _that = this;
switch (_that) {
case _PriceListConfiguration() when $default != null:
return $default(_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceListConfiguration implements PriceListConfiguration {
  const _PriceListConfiguration({this.ticketKindCode, this.ticketNumberOfLineCode, this.ticketPeriodCode});
  factory _PriceListConfiguration.fromJson(Map<String, dynamic> json) => _$PriceListConfigurationFromJson(json);

@override final  int? ticketKindCode;
@override final  int? ticketNumberOfLineCode;
@override final  int? ticketPeriodCode;

/// Create a copy of PriceListConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceListConfigurationCopyWith<_PriceListConfiguration> get copyWith => __$PriceListConfigurationCopyWithImpl<_PriceListConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceListConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceListConfiguration&&(identical(other.ticketKindCode, ticketKindCode) || other.ticketKindCode == ticketKindCode)&&(identical(other.ticketNumberOfLineCode, ticketNumberOfLineCode) || other.ticketNumberOfLineCode == ticketNumberOfLineCode)&&(identical(other.ticketPeriodCode, ticketPeriodCode) || other.ticketPeriodCode == ticketPeriodCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,ticketKindCode,ticketNumberOfLineCode,ticketPeriodCode);
}

@override
String toString() {
    return 'PriceListConfiguration(ticketKindCode: $ticketKindCode, ticketNumberOfLineCode: $ticketNumberOfLineCode, ticketPeriodCode: $ticketPeriodCode)';
}


}

/// @nodoc
abstract mixin class _$PriceListConfigurationCopyWith<$Res> implements $PriceListConfigurationCopyWith<$Res> {
  factory _$PriceListConfigurationCopyWith(_PriceListConfiguration value, $Res Function(_PriceListConfiguration) _then) = __$PriceListConfigurationCopyWithImpl;
@override @useResult
$Res call({
 int? ticketKindCode, int? ticketNumberOfLineCode, int? ticketPeriodCode
});




}
/// @nodoc
class __$PriceListConfigurationCopyWithImpl<$Res>
    implements _$PriceListConfigurationCopyWith<$Res> {
  __$PriceListConfigurationCopyWithImpl(this._self, this._then);

  final _PriceListConfiguration _self;
  final $Res Function(_PriceListConfiguration) _then;

/// Create a copy of PriceListConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticketKindCode = freezed,Object? ticketNumberOfLineCode = freezed,Object? ticketPeriodCode = freezed,}) {
  return _then(_PriceListConfiguration(
ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TicketSalesConfiguration {

 bool? get hasCracovCardPrivilege; DateTime? get firstDayOfValidity; DateTime? get lastDayOfValidity; List<SalesLineOption> get ticketNumberOfLines; List<SalesPeriodOption> get ticketPeriods; List<SalesKindOption> get ticketKinds; List<SpecialTransportLine> get specialTransportLines; List<PriceListConfiguration> get priceListConfigurations; Object? get code; String? get message;
/// Create a copy of TicketSalesConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketSalesConfigurationCopyWith<TicketSalesConfiguration> get copyWith => _$TicketSalesConfigurationCopyWithImpl<TicketSalesConfiguration>(this as TicketSalesConfiguration, _$identity);

  /// Serializes this TicketSalesConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketSalesConfiguration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketSalesConfiguration&&(identical(other.hasCracovCardPrivilege, _this.hasCracovCardPrivilege) || other.hasCracovCardPrivilege == _this.hasCracovCardPrivilege)&&(identical(other.firstDayOfValidity, _this.firstDayOfValidity) || other.firstDayOfValidity == _this.firstDayOfValidity)&&(identical(other.lastDayOfValidity, _this.lastDayOfValidity) || other.lastDayOfValidity == _this.lastDayOfValidity)&&const DeepCollectionEquality().equals(other.ticketNumberOfLines, _this.ticketNumberOfLines)&&const DeepCollectionEquality().equals(other.ticketPeriods, _this.ticketPeriods)&&const DeepCollectionEquality().equals(other.ticketKinds, _this.ticketKinds)&&const DeepCollectionEquality().equals(other.specialTransportLines, _this.specialTransportLines)&&const DeepCollectionEquality().equals(other.priceListConfigurations, _this.priceListConfigurations)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketSalesConfiguration;
  return Object.hash(runtimeType,_this.hasCracovCardPrivilege,_this.firstDayOfValidity,_this.lastDayOfValidity,const DeepCollectionEquality().hash(_this.ticketNumberOfLines),const DeepCollectionEquality().hash(_this.ticketPeriods),const DeepCollectionEquality().hash(_this.ticketKinds),const DeepCollectionEquality().hash(_this.specialTransportLines),const DeepCollectionEquality().hash(_this.priceListConfigurations),const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as TicketSalesConfiguration;
  return 'TicketSalesConfiguration(hasCracovCardPrivilege: ${_this.hasCracovCardPrivilege}, firstDayOfValidity: ${_this.firstDayOfValidity}, lastDayOfValidity: ${_this.lastDayOfValidity}, ticketNumberOfLines: ${_this.ticketNumberOfLines}, ticketPeriods: ${_this.ticketPeriods}, ticketKinds: ${_this.ticketKinds}, specialTransportLines: ${_this.specialTransportLines}, priceListConfigurations: ${_this.priceListConfigurations}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $TicketSalesConfigurationCopyWith<$Res>  {
  factory $TicketSalesConfigurationCopyWith(TicketSalesConfiguration value, $Res Function(TicketSalesConfiguration) _then) = _$TicketSalesConfigurationCopyWithImpl;
@useResult
$Res call({
 bool? hasCracovCardPrivilege, DateTime? firstDayOfValidity, DateTime? lastDayOfValidity, List<SalesLineOption> ticketNumberOfLines, List<SalesPeriodOption> ticketPeriods, List<SalesKindOption> ticketKinds, List<SpecialTransportLine> specialTransportLines, List<PriceListConfiguration> priceListConfigurations, Object? code, String? message
});




}
/// @nodoc
class _$TicketSalesConfigurationCopyWithImpl<$Res>
    implements $TicketSalesConfigurationCopyWith<$Res> {
  _$TicketSalesConfigurationCopyWithImpl(this._self, this._then);

  final TicketSalesConfiguration _self;
  final $Res Function(TicketSalesConfiguration) _then;

/// Create a copy of TicketSalesConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasCracovCardPrivilege = freezed,Object? firstDayOfValidity = freezed,Object? lastDayOfValidity = freezed,Object? ticketNumberOfLines = null,Object? ticketPeriods = null,Object? ticketKinds = null,Object? specialTransportLines = null,Object? priceListConfigurations = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(TicketSalesConfiguration(
hasCracovCardPrivilege: freezed == hasCracovCardPrivilege ? _self.hasCracovCardPrivilege : hasCracovCardPrivilege // ignore: cast_nullable_to_non_nullable
as bool?,firstDayOfValidity: freezed == firstDayOfValidity ? _self.firstDayOfValidity : firstDayOfValidity // ignore: cast_nullable_to_non_nullable
as DateTime?,lastDayOfValidity: freezed == lastDayOfValidity ? _self.lastDayOfValidity : lastDayOfValidity // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketNumberOfLines: null == ticketNumberOfLines ? _self.ticketNumberOfLines : ticketNumberOfLines // ignore: cast_nullable_to_non_nullable
as List<SalesLineOption>,ticketPeriods: null == ticketPeriods ? _self.ticketPeriods : ticketPeriods // ignore: cast_nullable_to_non_nullable
as List<SalesPeriodOption>,ticketKinds: null == ticketKinds ? _self.ticketKinds : ticketKinds // ignore: cast_nullable_to_non_nullable
as List<SalesKindOption>,specialTransportLines: null == specialTransportLines ? _self.specialTransportLines : specialTransportLines // ignore: cast_nullable_to_non_nullable
as List<SpecialTransportLine>,priceListConfigurations: null == priceListConfigurations ? _self.priceListConfigurations : priceListConfigurations // ignore: cast_nullable_to_non_nullable
as List<PriceListConfiguration>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketSalesConfiguration].
extension TicketSalesConfigurationPatterns on TicketSalesConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketSalesConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketSalesConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketSalesConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _TicketSalesConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketSalesConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _TicketSalesConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? hasCracovCardPrivilege,  DateTime? firstDayOfValidity,  DateTime? lastDayOfValidity,  List<SalesLineOption> ticketNumberOfLines,  List<SalesPeriodOption> ticketPeriods,  List<SalesKindOption> ticketKinds,  List<SpecialTransportLine> specialTransportLines,  List<PriceListConfiguration> priceListConfigurations,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketSalesConfiguration() when $default != null:
return $default(_that.hasCracovCardPrivilege,_that.firstDayOfValidity,_that.lastDayOfValidity,_that.ticketNumberOfLines,_that.ticketPeriods,_that.ticketKinds,_that.specialTransportLines,_that.priceListConfigurations,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? hasCracovCardPrivilege,  DateTime? firstDayOfValidity,  DateTime? lastDayOfValidity,  List<SalesLineOption> ticketNumberOfLines,  List<SalesPeriodOption> ticketPeriods,  List<SalesKindOption> ticketKinds,  List<SpecialTransportLine> specialTransportLines,  List<PriceListConfiguration> priceListConfigurations,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _TicketSalesConfiguration():
return $default(_that.hasCracovCardPrivilege,_that.firstDayOfValidity,_that.lastDayOfValidity,_that.ticketNumberOfLines,_that.ticketPeriods,_that.ticketKinds,_that.specialTransportLines,_that.priceListConfigurations,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? hasCracovCardPrivilege,  DateTime? firstDayOfValidity,  DateTime? lastDayOfValidity,  List<SalesLineOption> ticketNumberOfLines,  List<SalesPeriodOption> ticketPeriods,  List<SalesKindOption> ticketKinds,  List<SpecialTransportLine> specialTransportLines,  List<PriceListConfiguration> priceListConfigurations,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _TicketSalesConfiguration() when $default != null:
return $default(_that.hasCracovCardPrivilege,_that.firstDayOfValidity,_that.lastDayOfValidity,_that.ticketNumberOfLines,_that.ticketPeriods,_that.ticketKinds,_that.specialTransportLines,_that.priceListConfigurations,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketSalesConfiguration extends TicketSalesConfiguration {
  const _TicketSalesConfiguration({this.hasCracovCardPrivilege, this.firstDayOfValidity, this.lastDayOfValidity,  List<SalesLineOption> ticketNumberOfLines = const <SalesLineOption>[],  List<SalesPeriodOption> ticketPeriods = const <SalesPeriodOption>[],  List<SalesKindOption> ticketKinds = const <SalesKindOption>[],  List<SpecialTransportLine> specialTransportLines = const <SpecialTransportLine>[],  List<PriceListConfiguration> priceListConfigurations = const <PriceListConfiguration>[], this.code, this.message}): _ticketNumberOfLines = ticketNumberOfLines,_ticketPeriods = ticketPeriods,_ticketKinds = ticketKinds,_specialTransportLines = specialTransportLines,_priceListConfigurations = priceListConfigurations,super._();
  factory _TicketSalesConfiguration.fromJson(Map<String, dynamic> json) => _$TicketSalesConfigurationFromJson(json);

@override final  bool? hasCracovCardPrivilege;
@override final  DateTime? firstDayOfValidity;
@override final  DateTime? lastDayOfValidity;
 final  List<SalesLineOption> _ticketNumberOfLines;
@override@JsonKey() List<SalesLineOption> get ticketNumberOfLines {
  if (_ticketNumberOfLines is EqualUnmodifiableListView) return _ticketNumberOfLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ticketNumberOfLines);
}

 final  List<SalesPeriodOption> _ticketPeriods;
@override@JsonKey() List<SalesPeriodOption> get ticketPeriods {
  if (_ticketPeriods is EqualUnmodifiableListView) return _ticketPeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ticketPeriods);
}

 final  List<SalesKindOption> _ticketKinds;
@override@JsonKey() List<SalesKindOption> get ticketKinds {
  if (_ticketKinds is EqualUnmodifiableListView) return _ticketKinds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ticketKinds);
}

 final  List<SpecialTransportLine> _specialTransportLines;
@override@JsonKey() List<SpecialTransportLine> get specialTransportLines {
  if (_specialTransportLines is EqualUnmodifiableListView) return _specialTransportLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specialTransportLines);
}

 final  List<PriceListConfiguration> _priceListConfigurations;
@override@JsonKey() List<PriceListConfiguration> get priceListConfigurations {
  if (_priceListConfigurations is EqualUnmodifiableListView) return _priceListConfigurations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_priceListConfigurations);
}

@override final  Object? code;
@override final  String? message;

/// Create a copy of TicketSalesConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketSalesConfigurationCopyWith<_TicketSalesConfiguration> get copyWith => __$TicketSalesConfigurationCopyWithImpl<_TicketSalesConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketSalesConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketSalesConfiguration&&(identical(other.hasCracovCardPrivilege, hasCracovCardPrivilege) || other.hasCracovCardPrivilege == hasCracovCardPrivilege)&&(identical(other.firstDayOfValidity, firstDayOfValidity) || other.firstDayOfValidity == firstDayOfValidity)&&(identical(other.lastDayOfValidity, lastDayOfValidity) || other.lastDayOfValidity == lastDayOfValidity)&&const DeepCollectionEquality().equals(other.ticketNumberOfLines, _ticketNumberOfLines)&&const DeepCollectionEquality().equals(other.ticketPeriods, _ticketPeriods)&&const DeepCollectionEquality().equals(other.ticketKinds, _ticketKinds)&&const DeepCollectionEquality().equals(other.specialTransportLines, _specialTransportLines)&&const DeepCollectionEquality().equals(other.priceListConfigurations, _priceListConfigurations)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,hasCracovCardPrivilege,firstDayOfValidity,lastDayOfValidity,const DeepCollectionEquality().hash(_ticketNumberOfLines),const DeepCollectionEquality().hash(_ticketPeriods),const DeepCollectionEquality().hash(_ticketKinds),const DeepCollectionEquality().hash(_specialTransportLines),const DeepCollectionEquality().hash(_priceListConfigurations),const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'TicketSalesConfiguration(hasCracovCardPrivilege: $hasCracovCardPrivilege, firstDayOfValidity: $firstDayOfValidity, lastDayOfValidity: $lastDayOfValidity, ticketNumberOfLines: $ticketNumberOfLines, ticketPeriods: $ticketPeriods, ticketKinds: $ticketKinds, specialTransportLines: $specialTransportLines, priceListConfigurations: $priceListConfigurations, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TicketSalesConfigurationCopyWith<$Res> implements $TicketSalesConfigurationCopyWith<$Res> {
  factory _$TicketSalesConfigurationCopyWith(_TicketSalesConfiguration value, $Res Function(_TicketSalesConfiguration) _then) = __$TicketSalesConfigurationCopyWithImpl;
@override @useResult
$Res call({
 bool? hasCracovCardPrivilege, DateTime? firstDayOfValidity, DateTime? lastDayOfValidity, List<SalesLineOption> ticketNumberOfLines, List<SalesPeriodOption> ticketPeriods, List<SalesKindOption> ticketKinds, List<SpecialTransportLine> specialTransportLines, List<PriceListConfiguration> priceListConfigurations, Object? code, String? message
});




}
/// @nodoc
class __$TicketSalesConfigurationCopyWithImpl<$Res>
    implements _$TicketSalesConfigurationCopyWith<$Res> {
  __$TicketSalesConfigurationCopyWithImpl(this._self, this._then);

  final _TicketSalesConfiguration _self;
  final $Res Function(_TicketSalesConfiguration) _then;

/// Create a copy of TicketSalesConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasCracovCardPrivilege = freezed,Object? firstDayOfValidity = freezed,Object? lastDayOfValidity = freezed,Object? ticketNumberOfLines = null,Object? ticketPeriods = null,Object? ticketKinds = null,Object? specialTransportLines = null,Object? priceListConfigurations = null,Object? code = freezed,Object? message = freezed,}) {
  return _then(_TicketSalesConfiguration(
hasCracovCardPrivilege: freezed == hasCracovCardPrivilege ? _self.hasCracovCardPrivilege : hasCracovCardPrivilege // ignore: cast_nullable_to_non_nullable
as bool?,firstDayOfValidity: freezed == firstDayOfValidity ? _self.firstDayOfValidity : firstDayOfValidity // ignore: cast_nullable_to_non_nullable
as DateTime?,lastDayOfValidity: freezed == lastDayOfValidity ? _self.lastDayOfValidity : lastDayOfValidity // ignore: cast_nullable_to_non_nullable
as DateTime?,ticketNumberOfLines: null == ticketNumberOfLines ? _self._ticketNumberOfLines : ticketNumberOfLines // ignore: cast_nullable_to_non_nullable
as List<SalesLineOption>,ticketPeriods: null == ticketPeriods ? _self._ticketPeriods : ticketPeriods // ignore: cast_nullable_to_non_nullable
as List<SalesPeriodOption>,ticketKinds: null == ticketKinds ? _self._ticketKinds : ticketKinds // ignore: cast_nullable_to_non_nullable
as List<SalesKindOption>,specialTransportLines: null == specialTransportLines ? _self._specialTransportLines : specialTransportLines // ignore: cast_nullable_to_non_nullable
as List<SpecialTransportLine>,priceListConfigurations: null == priceListConfigurations ? _self._priceListConfigurations : priceListConfigurations // ignore: cast_nullable_to_non_nullable
as List<PriceListConfiguration>,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketCalculation {

 String? get commodityIndex; String? get commodityName; String? get symbol; double? get price; DateTime? get validFrom; DateTime? get validTo; int? get daysPeriod; bool? get forCitizen; int? get ticketKindCode; int? get ticketNumberOfLineCode; int? get ticketPeriodCode; String? get specialTransportLine; bool? get isNetwork; bool? get isMetropolitan; List<dynamic> get lines; bool? get hasSimilarTicket; int? get commodityId; int? get priceListPeriodId; int? get customerCode;/// Element shape unverified (always `[]` in captures) — kept raw.
 List<dynamic> get similarTickets;
/// Create a copy of TicketCalculation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCalculationCopyWith<TicketCalculation> get copyWith => _$TicketCalculationCopyWithImpl<TicketCalculation>(this as TicketCalculation, _$identity);

  /// Serializes this TicketCalculation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketCalculation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketCalculation&&(identical(other.commodityIndex, _this.commodityIndex) || other.commodityIndex == _this.commodityIndex)&&(identical(other.commodityName, _this.commodityName) || other.commodityName == _this.commodityName)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.validFrom, _this.validFrom) || other.validFrom == _this.validFrom)&&(identical(other.validTo, _this.validTo) || other.validTo == _this.validTo)&&(identical(other.daysPeriod, _this.daysPeriod) || other.daysPeriod == _this.daysPeriod)&&(identical(other.forCitizen, _this.forCitizen) || other.forCitizen == _this.forCitizen)&&(identical(other.ticketKindCode, _this.ticketKindCode) || other.ticketKindCode == _this.ticketKindCode)&&(identical(other.ticketNumberOfLineCode, _this.ticketNumberOfLineCode) || other.ticketNumberOfLineCode == _this.ticketNumberOfLineCode)&&(identical(other.ticketPeriodCode, _this.ticketPeriodCode) || other.ticketPeriodCode == _this.ticketPeriodCode)&&(identical(other.specialTransportLine, _this.specialTransportLine) || other.specialTransportLine == _this.specialTransportLine)&&(identical(other.isNetwork, _this.isNetwork) || other.isNetwork == _this.isNetwork)&&(identical(other.isMetropolitan, _this.isMetropolitan) || other.isMetropolitan == _this.isMetropolitan)&&const DeepCollectionEquality().equals(other.lines, _this.lines)&&(identical(other.hasSimilarTicket, _this.hasSimilarTicket) || other.hasSimilarTicket == _this.hasSimilarTicket)&&(identical(other.commodityId, _this.commodityId) || other.commodityId == _this.commodityId)&&(identical(other.priceListPeriodId, _this.priceListPeriodId) || other.priceListPeriodId == _this.priceListPeriodId)&&(identical(other.customerCode, _this.customerCode) || other.customerCode == _this.customerCode)&&const DeepCollectionEquality().equals(other.similarTickets, _this.similarTickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketCalculation;
  return Object.hashAll([runtimeType,_this.commodityIndex,_this.commodityName,_this.symbol,_this.price,_this.validFrom,_this.validTo,_this.daysPeriod,_this.forCitizen,_this.ticketKindCode,_this.ticketNumberOfLineCode,_this.ticketPeriodCode,_this.specialTransportLine,_this.isNetwork,_this.isMetropolitan,const DeepCollectionEquality().hash(_this.lines),_this.hasSimilarTicket,_this.commodityId,_this.priceListPeriodId,_this.customerCode,const DeepCollectionEquality().hash(_this.similarTickets)]);
}

@override
String toString() {
  final _this = this as TicketCalculation;
  return 'TicketCalculation(commodityIndex: ${_this.commodityIndex}, commodityName: ${_this.commodityName}, symbol: ${_this.symbol}, price: ${_this.price}, validFrom: ${_this.validFrom}, validTo: ${_this.validTo}, daysPeriod: ${_this.daysPeriod}, forCitizen: ${_this.forCitizen}, ticketKindCode: ${_this.ticketKindCode}, ticketNumberOfLineCode: ${_this.ticketNumberOfLineCode}, ticketPeriodCode: ${_this.ticketPeriodCode}, specialTransportLine: ${_this.specialTransportLine}, isNetwork: ${_this.isNetwork}, isMetropolitan: ${_this.isMetropolitan}, lines: ${_this.lines}, hasSimilarTicket: ${_this.hasSimilarTicket}, commodityId: ${_this.commodityId}, priceListPeriodId: ${_this.priceListPeriodId}, customerCode: ${_this.customerCode}, similarTickets: ${_this.similarTickets})';
}


}

/// @nodoc
abstract mixin class $TicketCalculationCopyWith<$Res>  {
  factory $TicketCalculationCopyWith(TicketCalculation value, $Res Function(TicketCalculation) _then) = _$TicketCalculationCopyWithImpl;
@useResult
$Res call({
 String? commodityIndex, String? commodityName, String? symbol, double? price, DateTime? validFrom, DateTime? validTo, int? daysPeriod, bool? forCitizen, int? ticketKindCode, int? ticketNumberOfLineCode, int? ticketPeriodCode, String? specialTransportLine, bool? isNetwork, bool? isMetropolitan, List<dynamic> lines, bool? hasSimilarTicket, int? commodityId, int? priceListPeriodId, int? customerCode, List<dynamic> similarTickets
});




}
/// @nodoc
class _$TicketCalculationCopyWithImpl<$Res>
    implements $TicketCalculationCopyWith<$Res> {
  _$TicketCalculationCopyWithImpl(this._self, this._then);

  final TicketCalculation _self;
  final $Res Function(TicketCalculation) _then;

/// Create a copy of TicketCalculation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commodityIndex = freezed,Object? commodityName = freezed,Object? symbol = freezed,Object? price = freezed,Object? validFrom = freezed,Object? validTo = freezed,Object? daysPeriod = freezed,Object? forCitizen = freezed,Object? ticketKindCode = freezed,Object? ticketNumberOfLineCode = freezed,Object? ticketPeriodCode = freezed,Object? specialTransportLine = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,Object? lines = null,Object? hasSimilarTicket = freezed,Object? commodityId = freezed,Object? priceListPeriodId = freezed,Object? customerCode = freezed,Object? similarTickets = null,}) {
  return _then(TicketCalculation(
commodityIndex: freezed == commodityIndex ? _self.commodityIndex : commodityIndex // ignore: cast_nullable_to_non_nullable
as String?,commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,validFrom: freezed == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,validTo: freezed == validTo ? _self.validTo : validTo // ignore: cast_nullable_to_non_nullable
as DateTime?,daysPeriod: freezed == daysPeriod ? _self.daysPeriod : daysPeriod // ignore: cast_nullable_to_non_nullable
as int?,forCitizen: freezed == forCitizen ? _self.forCitizen : forCitizen // ignore: cast_nullable_to_non_nullable
as bool?,ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<dynamic>,hasSimilarTicket: freezed == hasSimilarTicket ? _self.hasSimilarTicket : hasSimilarTicket // ignore: cast_nullable_to_non_nullable
as bool?,commodityId: freezed == commodityId ? _self.commodityId : commodityId // ignore: cast_nullable_to_non_nullable
as int?,priceListPeriodId: freezed == priceListPeriodId ? _self.priceListPeriodId : priceListPeriodId // ignore: cast_nullable_to_non_nullable
as int?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as int?,similarTickets: null == similarTickets ? _self.similarTickets : similarTickets // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketCalculation].
extension TicketCalculationPatterns on TicketCalculation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketCalculation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketCalculation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketCalculation value)  $default,){
final _that = this;
switch (_that) {
case _TicketCalculation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketCalculation value)?  $default,){
final _that = this;
switch (_that) {
case _TicketCalculation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? commodityIndex,  String? commodityName,  String? symbol,  double? price,  DateTime? validFrom,  DateTime? validTo,  int? daysPeriod,  bool? forCitizen,  int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  List<dynamic> lines,  bool? hasSimilarTicket,  int? commodityId,  int? priceListPeriodId,  int? customerCode,  List<dynamic> similarTickets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketCalculation() when $default != null:
return $default(_that.commodityIndex,_that.commodityName,_that.symbol,_that.price,_that.validFrom,_that.validTo,_that.daysPeriod,_that.forCitizen,_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.lines,_that.hasSimilarTicket,_that.commodityId,_that.priceListPeriodId,_that.customerCode,_that.similarTickets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? commodityIndex,  String? commodityName,  String? symbol,  double? price,  DateTime? validFrom,  DateTime? validTo,  int? daysPeriod,  bool? forCitizen,  int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  List<dynamic> lines,  bool? hasSimilarTicket,  int? commodityId,  int? priceListPeriodId,  int? customerCode,  List<dynamic> similarTickets)  $default,) {final _that = this;
switch (_that) {
case _TicketCalculation():
return $default(_that.commodityIndex,_that.commodityName,_that.symbol,_that.price,_that.validFrom,_that.validTo,_that.daysPeriod,_that.forCitizen,_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.lines,_that.hasSimilarTicket,_that.commodityId,_that.priceListPeriodId,_that.customerCode,_that.similarTickets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? commodityIndex,  String? commodityName,  String? symbol,  double? price,  DateTime? validFrom,  DateTime? validTo,  int? daysPeriod,  bool? forCitizen,  int? ticketKindCode,  int? ticketNumberOfLineCode,  int? ticketPeriodCode,  String? specialTransportLine,  bool? isNetwork,  bool? isMetropolitan,  List<dynamic> lines,  bool? hasSimilarTicket,  int? commodityId,  int? priceListPeriodId,  int? customerCode,  List<dynamic> similarTickets)?  $default,) {final _that = this;
switch (_that) {
case _TicketCalculation() when $default != null:
return $default(_that.commodityIndex,_that.commodityName,_that.symbol,_that.price,_that.validFrom,_that.validTo,_that.daysPeriod,_that.forCitizen,_that.ticketKindCode,_that.ticketNumberOfLineCode,_that.ticketPeriodCode,_that.specialTransportLine,_that.isNetwork,_that.isMetropolitan,_that.lines,_that.hasSimilarTicket,_that.commodityId,_that.priceListPeriodId,_that.customerCode,_that.similarTickets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketCalculation implements TicketCalculation {
  const _TicketCalculation({this.commodityIndex, this.commodityName, this.symbol, this.price, this.validFrom, this.validTo, this.daysPeriod, this.forCitizen, this.ticketKindCode, this.ticketNumberOfLineCode, this.ticketPeriodCode, this.specialTransportLine, this.isNetwork, this.isMetropolitan,  List<dynamic> lines = const <dynamic>[], this.hasSimilarTicket, this.commodityId, this.priceListPeriodId, this.customerCode,  List<dynamic> similarTickets = const <dynamic>[]}): _lines = lines,_similarTickets = similarTickets;
  factory _TicketCalculation.fromJson(Map<String, dynamic> json) => _$TicketCalculationFromJson(json);

@override final  String? commodityIndex;
@override final  String? commodityName;
@override final  String? symbol;
@override final  double? price;
@override final  DateTime? validFrom;
@override final  DateTime? validTo;
@override final  int? daysPeriod;
@override final  bool? forCitizen;
@override final  int? ticketKindCode;
@override final  int? ticketNumberOfLineCode;
@override final  int? ticketPeriodCode;
@override final  String? specialTransportLine;
@override final  bool? isNetwork;
@override final  bool? isMetropolitan;
 final  List<dynamic> _lines;
@override@JsonKey() List<dynamic> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  bool? hasSimilarTicket;
@override final  int? commodityId;
@override final  int? priceListPeriodId;
@override final  int? customerCode;
/// Element shape unverified (always `[]` in captures) — kept raw.
 final  List<dynamic> _similarTickets;
/// Element shape unverified (always `[]` in captures) — kept raw.
@override@JsonKey() List<dynamic> get similarTickets {
  if (_similarTickets is EqualUnmodifiableListView) return _similarTickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_similarTickets);
}


/// Create a copy of TicketCalculation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCalculationCopyWith<_TicketCalculation> get copyWith => __$TicketCalculationCopyWithImpl<_TicketCalculation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketCalculationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketCalculation&&(identical(other.commodityIndex, commodityIndex) || other.commodityIndex == commodityIndex)&&(identical(other.commodityName, commodityName) || other.commodityName == commodityName)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.validTo, validTo) || other.validTo == validTo)&&(identical(other.daysPeriod, daysPeriod) || other.daysPeriod == daysPeriod)&&(identical(other.forCitizen, forCitizen) || other.forCitizen == forCitizen)&&(identical(other.ticketKindCode, ticketKindCode) || other.ticketKindCode == ticketKindCode)&&(identical(other.ticketNumberOfLineCode, ticketNumberOfLineCode) || other.ticketNumberOfLineCode == ticketNumberOfLineCode)&&(identical(other.ticketPeriodCode, ticketPeriodCode) || other.ticketPeriodCode == ticketPeriodCode)&&(identical(other.specialTransportLine, specialTransportLine) || other.specialTransportLine == specialTransportLine)&&(identical(other.isNetwork, isNetwork) || other.isNetwork == isNetwork)&&(identical(other.isMetropolitan, isMetropolitan) || other.isMetropolitan == isMetropolitan)&&const DeepCollectionEquality().equals(other.lines, _lines)&&(identical(other.hasSimilarTicket, hasSimilarTicket) || other.hasSimilarTicket == hasSimilarTicket)&&(identical(other.commodityId, commodityId) || other.commodityId == commodityId)&&(identical(other.priceListPeriodId, priceListPeriodId) || other.priceListPeriodId == priceListPeriodId)&&(identical(other.customerCode, customerCode) || other.customerCode == customerCode)&&const DeepCollectionEquality().equals(other.similarTickets, _similarTickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,commodityIndex,commodityName,symbol,price,validFrom,validTo,daysPeriod,forCitizen,ticketKindCode,ticketNumberOfLineCode,ticketPeriodCode,specialTransportLine,isNetwork,isMetropolitan,const DeepCollectionEquality().hash(_lines),hasSimilarTicket,commodityId,priceListPeriodId,customerCode,const DeepCollectionEquality().hash(_similarTickets)]);
}

@override
String toString() {
    return 'TicketCalculation(commodityIndex: $commodityIndex, commodityName: $commodityName, symbol: $symbol, price: $price, validFrom: $validFrom, validTo: $validTo, daysPeriod: $daysPeriod, forCitizen: $forCitizen, ticketKindCode: $ticketKindCode, ticketNumberOfLineCode: $ticketNumberOfLineCode, ticketPeriodCode: $ticketPeriodCode, specialTransportLine: $specialTransportLine, isNetwork: $isNetwork, isMetropolitan: $isMetropolitan, lines: $lines, hasSimilarTicket: $hasSimilarTicket, commodityId: $commodityId, priceListPeriodId: $priceListPeriodId, customerCode: $customerCode, similarTickets: $similarTickets)';
}


}

/// @nodoc
abstract mixin class _$TicketCalculationCopyWith<$Res> implements $TicketCalculationCopyWith<$Res> {
  factory _$TicketCalculationCopyWith(_TicketCalculation value, $Res Function(_TicketCalculation) _then) = __$TicketCalculationCopyWithImpl;
@override @useResult
$Res call({
 String? commodityIndex, String? commodityName, String? symbol, double? price, DateTime? validFrom, DateTime? validTo, int? daysPeriod, bool? forCitizen, int? ticketKindCode, int? ticketNumberOfLineCode, int? ticketPeriodCode, String? specialTransportLine, bool? isNetwork, bool? isMetropolitan, List<dynamic> lines, bool? hasSimilarTicket, int? commodityId, int? priceListPeriodId, int? customerCode, List<dynamic> similarTickets
});




}
/// @nodoc
class __$TicketCalculationCopyWithImpl<$Res>
    implements _$TicketCalculationCopyWith<$Res> {
  __$TicketCalculationCopyWithImpl(this._self, this._then);

  final _TicketCalculation _self;
  final $Res Function(_TicketCalculation) _then;

/// Create a copy of TicketCalculation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commodityIndex = freezed,Object? commodityName = freezed,Object? symbol = freezed,Object? price = freezed,Object? validFrom = freezed,Object? validTo = freezed,Object? daysPeriod = freezed,Object? forCitizen = freezed,Object? ticketKindCode = freezed,Object? ticketNumberOfLineCode = freezed,Object? ticketPeriodCode = freezed,Object? specialTransportLine = freezed,Object? isNetwork = freezed,Object? isMetropolitan = freezed,Object? lines = null,Object? hasSimilarTicket = freezed,Object? commodityId = freezed,Object? priceListPeriodId = freezed,Object? customerCode = freezed,Object? similarTickets = null,}) {
  return _then(_TicketCalculation(
commodityIndex: freezed == commodityIndex ? _self.commodityIndex : commodityIndex // ignore: cast_nullable_to_non_nullable
as String?,commodityName: freezed == commodityName ? _self.commodityName : commodityName // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,validFrom: freezed == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,validTo: freezed == validTo ? _self.validTo : validTo // ignore: cast_nullable_to_non_nullable
as DateTime?,daysPeriod: freezed == daysPeriod ? _self.daysPeriod : daysPeriod // ignore: cast_nullable_to_non_nullable
as int?,forCitizen: freezed == forCitizen ? _self.forCitizen : forCitizen // ignore: cast_nullable_to_non_nullable
as bool?,ticketKindCode: freezed == ticketKindCode ? _self.ticketKindCode : ticketKindCode // ignore: cast_nullable_to_non_nullable
as int?,ticketNumberOfLineCode: freezed == ticketNumberOfLineCode ? _self.ticketNumberOfLineCode : ticketNumberOfLineCode // ignore: cast_nullable_to_non_nullable
as int?,ticketPeriodCode: freezed == ticketPeriodCode ? _self.ticketPeriodCode : ticketPeriodCode // ignore: cast_nullable_to_non_nullable
as int?,specialTransportLine: freezed == specialTransportLine ? _self.specialTransportLine : specialTransportLine // ignore: cast_nullable_to_non_nullable
as String?,isNetwork: freezed == isNetwork ? _self.isNetwork : isNetwork // ignore: cast_nullable_to_non_nullable
as bool?,isMetropolitan: freezed == isMetropolitan ? _self.isMetropolitan : isMetropolitan // ignore: cast_nullable_to_non_nullable
as bool?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<dynamic>,hasSimilarTicket: freezed == hasSimilarTicket ? _self.hasSimilarTicket : hasSimilarTicket // ignore: cast_nullable_to_non_nullable
as bool?,commodityId: freezed == commodityId ? _self.commodityId : commodityId // ignore: cast_nullable_to_non_nullable
as int?,priceListPeriodId: freezed == priceListPeriodId ? _self.priceListPeriodId : priceListPeriodId // ignore: cast_nullable_to_non_nullable
as int?,customerCode: freezed == customerCode ? _self.customerCode : customerCode // ignore: cast_nullable_to_non_nullable
as int?,similarTickets: null == similarTickets ? _self._similarTickets : similarTickets // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}


/// @nodoc
mixin _$PurchaseUrls {

/// tpay hosted payment page — open in a browser/webview.
 String? get paymentUrl;/// Landing pages the payment provider redirects to afterwards.
 String? get returnUrl; String? get returnErrorUrl;
/// Create a copy of PurchaseUrls
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseUrlsCopyWith<PurchaseUrls> get copyWith => _$PurchaseUrlsCopyWithImpl<PurchaseUrls>(this as PurchaseUrls, _$identity);

  /// Serializes this PurchaseUrls to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PurchaseUrls;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseUrls&&(identical(other.paymentUrl, _this.paymentUrl) || other.paymentUrl == _this.paymentUrl)&&(identical(other.returnUrl, _this.returnUrl) || other.returnUrl == _this.returnUrl)&&(identical(other.returnErrorUrl, _this.returnErrorUrl) || other.returnErrorUrl == _this.returnErrorUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PurchaseUrls;
  return Object.hash(runtimeType,_this.paymentUrl,_this.returnUrl,_this.returnErrorUrl);
}

@override
String toString() {
  final _this = this as PurchaseUrls;
  return 'PurchaseUrls(paymentUrl: ${_this.paymentUrl}, returnUrl: ${_this.returnUrl}, returnErrorUrl: ${_this.returnErrorUrl})';
}


}

/// @nodoc
abstract mixin class $PurchaseUrlsCopyWith<$Res>  {
  factory $PurchaseUrlsCopyWith(PurchaseUrls value, $Res Function(PurchaseUrls) _then) = _$PurchaseUrlsCopyWithImpl;
@useResult
$Res call({
 String? paymentUrl, String? returnUrl, String? returnErrorUrl
});




}
/// @nodoc
class _$PurchaseUrlsCopyWithImpl<$Res>
    implements $PurchaseUrlsCopyWith<$Res> {
  _$PurchaseUrlsCopyWithImpl(this._self, this._then);

  final PurchaseUrls _self;
  final $Res Function(PurchaseUrls) _then;

/// Create a copy of PurchaseUrls
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentUrl = freezed,Object? returnUrl = freezed,Object? returnErrorUrl = freezed,}) {
  return _then(PurchaseUrls(
paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,returnErrorUrl: freezed == returnErrorUrl ? _self.returnErrorUrl : returnErrorUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseUrls].
extension PurchaseUrlsPatterns on PurchaseUrls {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseUrls value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseUrls() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseUrls value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseUrls():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseUrls value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseUrls() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? paymentUrl,  String? returnUrl,  String? returnErrorUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseUrls() when $default != null:
return $default(_that.paymentUrl,_that.returnUrl,_that.returnErrorUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? paymentUrl,  String? returnUrl,  String? returnErrorUrl)  $default,) {final _that = this;
switch (_that) {
case _PurchaseUrls():
return $default(_that.paymentUrl,_that.returnUrl,_that.returnErrorUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? paymentUrl,  String? returnUrl,  String? returnErrorUrl)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseUrls() when $default != null:
return $default(_that.paymentUrl,_that.returnUrl,_that.returnErrorUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseUrls implements PurchaseUrls {
  const _PurchaseUrls({this.paymentUrl, this.returnUrl, this.returnErrorUrl});
  factory _PurchaseUrls.fromJson(Map<String, dynamic> json) => _$PurchaseUrlsFromJson(json);

/// tpay hosted payment page — open in a browser/webview.
@override final  String? paymentUrl;
/// Landing pages the payment provider redirects to afterwards.
@override final  String? returnUrl;
@override final  String? returnErrorUrl;

/// Create a copy of PurchaseUrls
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseUrlsCopyWith<_PurchaseUrls> get copyWith => __$PurchaseUrlsCopyWithImpl<_PurchaseUrls>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseUrlsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseUrls&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.returnErrorUrl, returnErrorUrl) || other.returnErrorUrl == returnErrorUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,paymentUrl,returnUrl,returnErrorUrl);
}

@override
String toString() {
    return 'PurchaseUrls(paymentUrl: $paymentUrl, returnUrl: $returnUrl, returnErrorUrl: $returnErrorUrl)';
}


}

/// @nodoc
abstract mixin class _$PurchaseUrlsCopyWith<$Res> implements $PurchaseUrlsCopyWith<$Res> {
  factory _$PurchaseUrlsCopyWith(_PurchaseUrls value, $Res Function(_PurchaseUrls) _then) = __$PurchaseUrlsCopyWithImpl;
@override @useResult
$Res call({
 String? paymentUrl, String? returnUrl, String? returnErrorUrl
});




}
/// @nodoc
class __$PurchaseUrlsCopyWithImpl<$Res>
    implements _$PurchaseUrlsCopyWith<$Res> {
  __$PurchaseUrlsCopyWithImpl(this._self, this._then);

  final _PurchaseUrls _self;
  final $Res Function(_PurchaseUrls) _then;

/// Create a copy of PurchaseUrls
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentUrl = freezed,Object? returnUrl = freezed,Object? returnErrorUrl = freezed,}) {
  return _then(_PurchaseUrls(
paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,returnErrorUrl: freezed == returnErrorUrl ? _self.returnErrorUrl : returnErrorUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketPurchaseResponse {

 MkkmTicket? get ticket; PurchaseUrls? get urls; Object? get code; String? get message;
/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketPurchaseResponseCopyWith<TicketPurchaseResponse> get copyWith => _$TicketPurchaseResponseCopyWithImpl<TicketPurchaseResponse>(this as TicketPurchaseResponse, _$identity);

  /// Serializes this TicketPurchaseResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketPurchaseResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketPurchaseResponse&&(identical(other.ticket, _this.ticket) || other.ticket == _this.ticket)&&(identical(other.urls, _this.urls) || other.urls == _this.urls)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketPurchaseResponse;
  return Object.hash(runtimeType,_this.ticket,_this.urls,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as TicketPurchaseResponse;
  return 'TicketPurchaseResponse(ticket: ${_this.ticket}, urls: ${_this.urls}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $TicketPurchaseResponseCopyWith<$Res>  {
  factory $TicketPurchaseResponseCopyWith(TicketPurchaseResponse value, $Res Function(TicketPurchaseResponse) _then) = _$TicketPurchaseResponseCopyWithImpl;
@useResult
$Res call({
 MkkmTicket? ticket, PurchaseUrls? urls, Object? code, String? message
});


$MkkmTicketCopyWith<$Res>? get ticket;$PurchaseUrlsCopyWith<$Res>? get urls;

}
/// @nodoc
class _$TicketPurchaseResponseCopyWithImpl<$Res>
    implements $TicketPurchaseResponseCopyWith<$Res> {
  _$TicketPurchaseResponseCopyWithImpl(this._self, this._then);

  final TicketPurchaseResponse _self;
  final $Res Function(TicketPurchaseResponse) _then;

/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticket = freezed,Object? urls = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(TicketPurchaseResponse(
ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as MkkmTicket?,urls: freezed == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as PurchaseUrls?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MkkmTicketCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $MkkmTicketCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseUrlsCopyWith<$Res>? get urls {
    if (_self.urls == null) {
    return null;
  }

  return $PurchaseUrlsCopyWith<$Res>(_self.urls!, (value) {
    return _then(_self.copyWith(urls: value));
  });
}
}


/// Adds pattern-matching-related methods to [TicketPurchaseResponse].
extension TicketPurchaseResponsePatterns on TicketPurchaseResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketPurchaseResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketPurchaseResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketPurchaseResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketPurchaseResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketPurchaseResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketPurchaseResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MkkmTicket? ticket,  PurchaseUrls? urls,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketPurchaseResponse() when $default != null:
return $default(_that.ticket,_that.urls,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MkkmTicket? ticket,  PurchaseUrls? urls,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _TicketPurchaseResponse():
return $default(_that.ticket,_that.urls,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MkkmTicket? ticket,  PurchaseUrls? urls,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _TicketPurchaseResponse() when $default != null:
return $default(_that.ticket,_that.urls,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketPurchaseResponse extends TicketPurchaseResponse {
  const _TicketPurchaseResponse({this.ticket, this.urls, this.code, this.message}): super._();
  factory _TicketPurchaseResponse.fromJson(Map<String, dynamic> json) => _$TicketPurchaseResponseFromJson(json);

@override final  MkkmTicket? ticket;
@override final  PurchaseUrls? urls;
@override final  Object? code;
@override final  String? message;

/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketPurchaseResponseCopyWith<_TicketPurchaseResponse> get copyWith => __$TicketPurchaseResponseCopyWithImpl<_TicketPurchaseResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketPurchaseResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketPurchaseResponse&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.urls, urls) || other.urls == urls)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,ticket,urls,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'TicketPurchaseResponse(ticket: $ticket, urls: $urls, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TicketPurchaseResponseCopyWith<$Res> implements $TicketPurchaseResponseCopyWith<$Res> {
  factory _$TicketPurchaseResponseCopyWith(_TicketPurchaseResponse value, $Res Function(_TicketPurchaseResponse) _then) = __$TicketPurchaseResponseCopyWithImpl;
@override @useResult
$Res call({
 MkkmTicket? ticket, PurchaseUrls? urls, Object? code, String? message
});


@override $MkkmTicketCopyWith<$Res>? get ticket;@override $PurchaseUrlsCopyWith<$Res>? get urls;

}
/// @nodoc
class __$TicketPurchaseResponseCopyWithImpl<$Res>
    implements _$TicketPurchaseResponseCopyWith<$Res> {
  __$TicketPurchaseResponseCopyWithImpl(this._self, this._then);

  final _TicketPurchaseResponse _self;
  final $Res Function(_TicketPurchaseResponse) _then;

/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticket = freezed,Object? urls = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_TicketPurchaseResponse(
ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as MkkmTicket?,urls: freezed == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as PurchaseUrls?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MkkmTicketCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $MkkmTicketCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}/// Create a copy of TicketPurchaseResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PurchaseUrlsCopyWith<$Res>? get urls {
    if (_self.urls == null) {
    return null;
  }

  return $PurchaseUrlsCopyWith<$Res>(_self.urls!, (value) {
    return _then(_self.copyWith(urls: value));
  });
}
}


/// @nodoc
mixin _$TicketReturnCalculation {

 double? get returnPrice; DateTime? get ticketStartDate; DateTime? get newTicketExpiryDate; Object? get code; String? get message;
/// Create a copy of TicketReturnCalculation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketReturnCalculationCopyWith<TicketReturnCalculation> get copyWith => _$TicketReturnCalculationCopyWithImpl<TicketReturnCalculation>(this as TicketReturnCalculation, _$identity);

  /// Serializes this TicketReturnCalculation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketReturnCalculation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketReturnCalculation&&(identical(other.returnPrice, _this.returnPrice) || other.returnPrice == _this.returnPrice)&&(identical(other.ticketStartDate, _this.ticketStartDate) || other.ticketStartDate == _this.ticketStartDate)&&(identical(other.newTicketExpiryDate, _this.newTicketExpiryDate) || other.newTicketExpiryDate == _this.newTicketExpiryDate)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketReturnCalculation;
  return Object.hash(runtimeType,_this.returnPrice,_this.ticketStartDate,_this.newTicketExpiryDate,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as TicketReturnCalculation;
  return 'TicketReturnCalculation(returnPrice: ${_this.returnPrice}, ticketStartDate: ${_this.ticketStartDate}, newTicketExpiryDate: ${_this.newTicketExpiryDate}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $TicketReturnCalculationCopyWith<$Res>  {
  factory $TicketReturnCalculationCopyWith(TicketReturnCalculation value, $Res Function(TicketReturnCalculation) _then) = _$TicketReturnCalculationCopyWithImpl;
@useResult
$Res call({
 double? returnPrice, DateTime? ticketStartDate, DateTime? newTicketExpiryDate, Object? code, String? message
});




}
/// @nodoc
class _$TicketReturnCalculationCopyWithImpl<$Res>
    implements $TicketReturnCalculationCopyWith<$Res> {
  _$TicketReturnCalculationCopyWithImpl(this._self, this._then);

  final TicketReturnCalculation _self;
  final $Res Function(TicketReturnCalculation) _then;

/// Create a copy of TicketReturnCalculation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? returnPrice = freezed,Object? ticketStartDate = freezed,Object? newTicketExpiryDate = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(TicketReturnCalculation(
returnPrice: freezed == returnPrice ? _self.returnPrice : returnPrice // ignore: cast_nullable_to_non_nullable
as double?,ticketStartDate: freezed == ticketStartDate ? _self.ticketStartDate : ticketStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,newTicketExpiryDate: freezed == newTicketExpiryDate ? _self.newTicketExpiryDate : newTicketExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketReturnCalculation].
extension TicketReturnCalculationPatterns on TicketReturnCalculation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketReturnCalculation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketReturnCalculation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketReturnCalculation value)  $default,){
final _that = this;
switch (_that) {
case _TicketReturnCalculation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketReturnCalculation value)?  $default,){
final _that = this;
switch (_that) {
case _TicketReturnCalculation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? returnPrice,  DateTime? ticketStartDate,  DateTime? newTicketExpiryDate,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketReturnCalculation() when $default != null:
return $default(_that.returnPrice,_that.ticketStartDate,_that.newTicketExpiryDate,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? returnPrice,  DateTime? ticketStartDate,  DateTime? newTicketExpiryDate,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _TicketReturnCalculation():
return $default(_that.returnPrice,_that.ticketStartDate,_that.newTicketExpiryDate,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? returnPrice,  DateTime? ticketStartDate,  DateTime? newTicketExpiryDate,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _TicketReturnCalculation() when $default != null:
return $default(_that.returnPrice,_that.ticketStartDate,_that.newTicketExpiryDate,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketReturnCalculation extends TicketReturnCalculation {
  const _TicketReturnCalculation({this.returnPrice, this.ticketStartDate, this.newTicketExpiryDate, this.code, this.message}): super._();
  factory _TicketReturnCalculation.fromJson(Map<String, dynamic> json) => _$TicketReturnCalculationFromJson(json);

@override final  double? returnPrice;
@override final  DateTime? ticketStartDate;
@override final  DateTime? newTicketExpiryDate;
@override final  Object? code;
@override final  String? message;

/// Create a copy of TicketReturnCalculation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketReturnCalculationCopyWith<_TicketReturnCalculation> get copyWith => __$TicketReturnCalculationCopyWithImpl<_TicketReturnCalculation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketReturnCalculationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketReturnCalculation&&(identical(other.returnPrice, returnPrice) || other.returnPrice == returnPrice)&&(identical(other.ticketStartDate, ticketStartDate) || other.ticketStartDate == ticketStartDate)&&(identical(other.newTicketExpiryDate, newTicketExpiryDate) || other.newTicketExpiryDate == newTicketExpiryDate)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,returnPrice,ticketStartDate,newTicketExpiryDate,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'TicketReturnCalculation(returnPrice: $returnPrice, ticketStartDate: $ticketStartDate, newTicketExpiryDate: $newTicketExpiryDate, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TicketReturnCalculationCopyWith<$Res> implements $TicketReturnCalculationCopyWith<$Res> {
  factory _$TicketReturnCalculationCopyWith(_TicketReturnCalculation value, $Res Function(_TicketReturnCalculation) _then) = __$TicketReturnCalculationCopyWithImpl;
@override @useResult
$Res call({
 double? returnPrice, DateTime? ticketStartDate, DateTime? newTicketExpiryDate, Object? code, String? message
});




}
/// @nodoc
class __$TicketReturnCalculationCopyWithImpl<$Res>
    implements _$TicketReturnCalculationCopyWith<$Res> {
  __$TicketReturnCalculationCopyWithImpl(this._self, this._then);

  final _TicketReturnCalculation _self;
  final $Res Function(_TicketReturnCalculation) _then;

/// Create a copy of TicketReturnCalculation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? returnPrice = freezed,Object? ticketStartDate = freezed,Object? newTicketExpiryDate = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_TicketReturnCalculation(
returnPrice: freezed == returnPrice ? _self.returnPrice : returnPrice // ignore: cast_nullable_to_non_nullable
as double?,ticketStartDate: freezed == ticketStartDate ? _self.ticketStartDate : ticketStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,newTicketExpiryDate: freezed == newTicketExpiryDate ? _self.newTicketExpiryDate : newTicketExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketReturnResult {

 bool? get createdCorrectionInvoice; bool? get success;
/// Create a copy of TicketReturnResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketReturnResultCopyWith<TicketReturnResult> get copyWith => _$TicketReturnResultCopyWithImpl<TicketReturnResult>(this as TicketReturnResult, _$identity);

  /// Serializes this TicketReturnResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketReturnResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketReturnResult&&(identical(other.createdCorrectionInvoice, _this.createdCorrectionInvoice) || other.createdCorrectionInvoice == _this.createdCorrectionInvoice)&&(identical(other.success, _this.success) || other.success == _this.success));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketReturnResult;
  return Object.hash(runtimeType,_this.createdCorrectionInvoice,_this.success);
}

@override
String toString() {
  final _this = this as TicketReturnResult;
  return 'TicketReturnResult(createdCorrectionInvoice: ${_this.createdCorrectionInvoice}, success: ${_this.success})';
}


}

/// @nodoc
abstract mixin class $TicketReturnResultCopyWith<$Res>  {
  factory $TicketReturnResultCopyWith(TicketReturnResult value, $Res Function(TicketReturnResult) _then) = _$TicketReturnResultCopyWithImpl;
@useResult
$Res call({
 bool? createdCorrectionInvoice, bool? success
});




}
/// @nodoc
class _$TicketReturnResultCopyWithImpl<$Res>
    implements $TicketReturnResultCopyWith<$Res> {
  _$TicketReturnResultCopyWithImpl(this._self, this._then);

  final TicketReturnResult _self;
  final $Res Function(TicketReturnResult) _then;

/// Create a copy of TicketReturnResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdCorrectionInvoice = freezed,Object? success = freezed,}) {
  return _then(TicketReturnResult(
createdCorrectionInvoice: freezed == createdCorrectionInvoice ? _self.createdCorrectionInvoice : createdCorrectionInvoice // ignore: cast_nullable_to_non_nullable
as bool?,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketReturnResult].
extension TicketReturnResultPatterns on TicketReturnResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketReturnResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketReturnResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketReturnResult value)  $default,){
final _that = this;
switch (_that) {
case _TicketReturnResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketReturnResult value)?  $default,){
final _that = this;
switch (_that) {
case _TicketReturnResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? createdCorrectionInvoice,  bool? success)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketReturnResult() when $default != null:
return $default(_that.createdCorrectionInvoice,_that.success);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? createdCorrectionInvoice,  bool? success)  $default,) {final _that = this;
switch (_that) {
case _TicketReturnResult():
return $default(_that.createdCorrectionInvoice,_that.success);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? createdCorrectionInvoice,  bool? success)?  $default,) {final _that = this;
switch (_that) {
case _TicketReturnResult() when $default != null:
return $default(_that.createdCorrectionInvoice,_that.success);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketReturnResult implements TicketReturnResult {
  const _TicketReturnResult({this.createdCorrectionInvoice, this.success});
  factory _TicketReturnResult.fromJson(Map<String, dynamic> json) => _$TicketReturnResultFromJson(json);

@override final  bool? createdCorrectionInvoice;
@override final  bool? success;

/// Create a copy of TicketReturnResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketReturnResultCopyWith<_TicketReturnResult> get copyWith => __$TicketReturnResultCopyWithImpl<_TicketReturnResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketReturnResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketReturnResult&&(identical(other.createdCorrectionInvoice, createdCorrectionInvoice) || other.createdCorrectionInvoice == createdCorrectionInvoice)&&(identical(other.success, success) || other.success == success));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,createdCorrectionInvoice,success);
}

@override
String toString() {
    return 'TicketReturnResult(createdCorrectionInvoice: $createdCorrectionInvoice, success: $success)';
}


}

/// @nodoc
abstract mixin class _$TicketReturnResultCopyWith<$Res> implements $TicketReturnResultCopyWith<$Res> {
  factory _$TicketReturnResultCopyWith(_TicketReturnResult value, $Res Function(_TicketReturnResult) _then) = __$TicketReturnResultCopyWithImpl;
@override @useResult
$Res call({
 bool? createdCorrectionInvoice, bool? success
});




}
/// @nodoc
class __$TicketReturnResultCopyWithImpl<$Res>
    implements _$TicketReturnResultCopyWith<$Res> {
  __$TicketReturnResultCopyWithImpl(this._self, this._then);

  final _TicketReturnResult _self;
  final $Res Function(_TicketReturnResult) _then;

/// Create a copy of TicketReturnResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdCorrectionInvoice = freezed,Object? success = freezed,}) {
  return _then(_TicketReturnResult(
createdCorrectionInvoice: freezed == createdCorrectionInvoice ? _self.createdCorrectionInvoice : createdCorrectionInvoice // ignore: cast_nullable_to_non_nullable
as bool?,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$TicketAssignResponse {

 bool? get assigned; Object? get code; String? get message;
/// Create a copy of TicketAssignResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketAssignResponseCopyWith<TicketAssignResponse> get copyWith => _$TicketAssignResponseCopyWithImpl<TicketAssignResponse>(this as TicketAssignResponse, _$identity);

  /// Serializes this TicketAssignResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketAssignResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketAssignResponse&&(identical(other.assigned, _this.assigned) || other.assigned == _this.assigned)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketAssignResponse;
  return Object.hash(runtimeType,_this.assigned,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as TicketAssignResponse;
  return 'TicketAssignResponse(assigned: ${_this.assigned}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $TicketAssignResponseCopyWith<$Res>  {
  factory $TicketAssignResponseCopyWith(TicketAssignResponse value, $Res Function(TicketAssignResponse) _then) = _$TicketAssignResponseCopyWithImpl;
@useResult
$Res call({
 bool? assigned, Object? code, String? message
});




}
/// @nodoc
class _$TicketAssignResponseCopyWithImpl<$Res>
    implements $TicketAssignResponseCopyWith<$Res> {
  _$TicketAssignResponseCopyWithImpl(this._self, this._then);

  final TicketAssignResponse _self;
  final $Res Function(TicketAssignResponse) _then;

/// Create a copy of TicketAssignResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assigned = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(TicketAssignResponse(
assigned: freezed == assigned ? _self.assigned : assigned // ignore: cast_nullable_to_non_nullable
as bool?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketAssignResponse].
extension TicketAssignResponsePatterns on TicketAssignResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketAssignResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketAssignResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketAssignResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketAssignResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketAssignResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketAssignResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? assigned,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketAssignResponse() when $default != null:
return $default(_that.assigned,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? assigned,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _TicketAssignResponse():
return $default(_that.assigned,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? assigned,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _TicketAssignResponse() when $default != null:
return $default(_that.assigned,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketAssignResponse extends TicketAssignResponse {
  const _TicketAssignResponse({this.assigned, this.code, this.message}): super._();
  factory _TicketAssignResponse.fromJson(Map<String, dynamic> json) => _$TicketAssignResponseFromJson(json);

@override final  bool? assigned;
@override final  Object? code;
@override final  String? message;

/// Create a copy of TicketAssignResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketAssignResponseCopyWith<_TicketAssignResponse> get copyWith => __$TicketAssignResponseCopyWithImpl<_TicketAssignResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketAssignResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketAssignResponse&&(identical(other.assigned, assigned) || other.assigned == assigned)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,assigned,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'TicketAssignResponse(assigned: $assigned, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TicketAssignResponseCopyWith<$Res> implements $TicketAssignResponseCopyWith<$Res> {
  factory _$TicketAssignResponseCopyWith(_TicketAssignResponse value, $Res Function(_TicketAssignResponse) _then) = __$TicketAssignResponseCopyWithImpl;
@override @useResult
$Res call({
 bool? assigned, Object? code, String? message
});




}
/// @nodoc
class __$TicketAssignResponseCopyWithImpl<$Res>
    implements _$TicketAssignResponseCopyWith<$Res> {
  __$TicketAssignResponseCopyWithImpl(this._self, this._then);

  final _TicketAssignResponse _self;
  final $Res Function(_TicketAssignResponse) _then;

/// Create a copy of TicketAssignResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assigned = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_TicketAssignResponse(
assigned: freezed == assigned ? _self.assigned : assigned // ignore: cast_nullable_to_non_nullable
as bool?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketContractResponse {

 String? get contract; Object? get code; String? get message;
/// Create a copy of TicketContractResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketContractResponseCopyWith<TicketContractResponse> get copyWith => _$TicketContractResponseCopyWithImpl<TicketContractResponse>(this as TicketContractResponse, _$identity);

  /// Serializes this TicketContractResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketContractResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketContractResponse&&(identical(other.contract, _this.contract) || other.contract == _this.contract)&&const DeepCollectionEquality().equals(other.code, _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketContractResponse;
  return Object.hash(runtimeType,_this.contract,const DeepCollectionEquality().hash(_this.code),_this.message);
}

@override
String toString() {
  final _this = this as TicketContractResponse;
  return 'TicketContractResponse(contract: ${_this.contract}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $TicketContractResponseCopyWith<$Res>  {
  factory $TicketContractResponseCopyWith(TicketContractResponse value, $Res Function(TicketContractResponse) _then) = _$TicketContractResponseCopyWithImpl;
@useResult
$Res call({
 String? contract, Object? code, String? message
});




}
/// @nodoc
class _$TicketContractResponseCopyWithImpl<$Res>
    implements $TicketContractResponseCopyWith<$Res> {
  _$TicketContractResponseCopyWithImpl(this._self, this._then);

  final TicketContractResponse _self;
  final $Res Function(TicketContractResponse) _then;

/// Create a copy of TicketContractResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contract = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(TicketContractResponse(
contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketContractResponse].
extension TicketContractResponsePatterns on TicketContractResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketContractResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketContractResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketContractResponse value)  $default,){
final _that = this;
switch (_that) {
case _TicketContractResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketContractResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TicketContractResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? contract,  Object? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketContractResponse() when $default != null:
return $default(_that.contract,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? contract,  Object? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _TicketContractResponse():
return $default(_that.contract,_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? contract,  Object? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _TicketContractResponse() when $default != null:
return $default(_that.contract,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketContractResponse extends TicketContractResponse {
  const _TicketContractResponse({this.contract, this.code, this.message}): super._();
  factory _TicketContractResponse.fromJson(Map<String, dynamic> json) => _$TicketContractResponseFromJson(json);

@override final  String? contract;
@override final  Object? code;
@override final  String? message;

/// Create a copy of TicketContractResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketContractResponseCopyWith<_TicketContractResponse> get copyWith => __$TicketContractResponseCopyWithImpl<_TicketContractResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketContractResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketContractResponse&&(identical(other.contract, contract) || other.contract == contract)&&const DeepCollectionEquality().equals(other.code, code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,contract,const DeepCollectionEquality().hash(code),message);
}

@override
String toString() {
    return 'TicketContractResponse(contract: $contract, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TicketContractResponseCopyWith<$Res> implements $TicketContractResponseCopyWith<$Res> {
  factory _$TicketContractResponseCopyWith(_TicketContractResponse value, $Res Function(_TicketContractResponse) _then) = __$TicketContractResponseCopyWithImpl;
@override @useResult
$Res call({
 String? contract, Object? code, String? message
});




}
/// @nodoc
class __$TicketContractResponseCopyWithImpl<$Res>
    implements _$TicketContractResponseCopyWith<$Res> {
  __$TicketContractResponseCopyWithImpl(this._self, this._then);

  final _TicketContractResponse _self;
  final $Res Function(_TicketContractResponse) _then;

/// Create a copy of TicketContractResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contract = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_TicketContractResponse(
contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code ,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
