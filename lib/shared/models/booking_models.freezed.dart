// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingRecord {

 String get id; String get shipmentId; String? get routeId; DateTime? get routeDepartureDate; String? get oneoffTripId; String get shipperId; String get carrierId; String get vehicleId; double get weightKg; double? get volumeM3; double get pricePerKgDzd; double get basePriceDzd; double get platformFeeDzd; double get carrierFeeDzd; double? get insuranceRate; double get insuranceFeeDzd; double get taxFeeDzd; double get shipperTotalDzd; double get carrierPayoutDzd; BookingStatus get bookingStatus; PaymentStatus get paymentStatus; String get trackingNumber; String get paymentReference; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of BookingRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRecordCopyWith<BookingRecord> get copyWith => _$BookingRecordCopyWithImpl<BookingRecord>(this as BookingRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.shipmentId, shipmentId) || other.shipmentId == shipmentId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeDepartureDate, routeDepartureDate) || other.routeDepartureDate == routeDepartureDate)&&(identical(other.oneoffTripId, oneoffTripId) || other.oneoffTripId == oneoffTripId)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.volumeM3, volumeM3) || other.volumeM3 == volumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.basePriceDzd, basePriceDzd) || other.basePriceDzd == basePriceDzd)&&(identical(other.platformFeeDzd, platformFeeDzd) || other.platformFeeDzd == platformFeeDzd)&&(identical(other.carrierFeeDzd, carrierFeeDzd) || other.carrierFeeDzd == carrierFeeDzd)&&(identical(other.insuranceRate, insuranceRate) || other.insuranceRate == insuranceRate)&&(identical(other.insuranceFeeDzd, insuranceFeeDzd) || other.insuranceFeeDzd == insuranceFeeDzd)&&(identical(other.taxFeeDzd, taxFeeDzd) || other.taxFeeDzd == taxFeeDzd)&&(identical(other.shipperTotalDzd, shipperTotalDzd) || other.shipperTotalDzd == shipperTotalDzd)&&(identical(other.carrierPayoutDzd, carrierPayoutDzd) || other.carrierPayoutDzd == carrierPayoutDzd)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.trackingNumber, trackingNumber) || other.trackingNumber == trackingNumber)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,shipmentId,routeId,routeDepartureDate,oneoffTripId,shipperId,carrierId,vehicleId,weightKg,volumeM3,pricePerKgDzd,basePriceDzd,platformFeeDzd,carrierFeeDzd,insuranceRate,insuranceFeeDzd,taxFeeDzd,shipperTotalDzd,carrierPayoutDzd,bookingStatus,paymentStatus,trackingNumber,paymentReference,createdAt,updatedAt]);

@override
String toString() {
  return 'BookingRecord(id: $id, shipmentId: $shipmentId, routeId: $routeId, routeDepartureDate: $routeDepartureDate, oneoffTripId: $oneoffTripId, shipperId: $shipperId, carrierId: $carrierId, vehicleId: $vehicleId, weightKg: $weightKg, volumeM3: $volumeM3, pricePerKgDzd: $pricePerKgDzd, basePriceDzd: $basePriceDzd, platformFeeDzd: $platformFeeDzd, carrierFeeDzd: $carrierFeeDzd, insuranceRate: $insuranceRate, insuranceFeeDzd: $insuranceFeeDzd, taxFeeDzd: $taxFeeDzd, shipperTotalDzd: $shipperTotalDzd, carrierPayoutDzd: $carrierPayoutDzd, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, trackingNumber: $trackingNumber, paymentReference: $paymentReference, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BookingRecordCopyWith<$Res>  {
  factory $BookingRecordCopyWith(BookingRecord value, $Res Function(BookingRecord) _then) = _$BookingRecordCopyWithImpl;
@useResult
$Res call({
 String id, String shipmentId, String? routeId, DateTime? routeDepartureDate, String? oneoffTripId, String shipperId, String carrierId, String vehicleId, double weightKg, double? volumeM3, double pricePerKgDzd, double basePriceDzd, double platformFeeDzd, double carrierFeeDzd, double? insuranceRate, double insuranceFeeDzd, double taxFeeDzd, double shipperTotalDzd, double carrierPayoutDzd, BookingStatus bookingStatus, PaymentStatus paymentStatus, String trackingNumber, String paymentReference, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$BookingRecordCopyWithImpl<$Res>
    implements $BookingRecordCopyWith<$Res> {
  _$BookingRecordCopyWithImpl(this._self, this._then);

  final BookingRecord _self;
  final $Res Function(BookingRecord) _then;

/// Create a copy of BookingRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shipmentId = null,Object? routeId = freezed,Object? routeDepartureDate = freezed,Object? oneoffTripId = freezed,Object? shipperId = null,Object? carrierId = null,Object? vehicleId = null,Object? weightKg = null,Object? volumeM3 = freezed,Object? pricePerKgDzd = null,Object? basePriceDzd = null,Object? platformFeeDzd = null,Object? carrierFeeDzd = null,Object? insuranceRate = freezed,Object? insuranceFeeDzd = null,Object? taxFeeDzd = null,Object? shipperTotalDzd = null,Object? carrierPayoutDzd = null,Object? bookingStatus = null,Object? paymentStatus = null,Object? trackingNumber = null,Object? paymentReference = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shipmentId: null == shipmentId ? _self.shipmentId : shipmentId // ignore: cast_nullable_to_non_nullable
as String,routeId: freezed == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String?,routeDepartureDate: freezed == routeDepartureDate ? _self.routeDepartureDate : routeDepartureDate // ignore: cast_nullable_to_non_nullable
as DateTime?,oneoffTripId: freezed == oneoffTripId ? _self.oneoffTripId : oneoffTripId // ignore: cast_nullable_to_non_nullable
as String?,shipperId: null == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,volumeM3: freezed == volumeM3 ? _self.volumeM3 : volumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,basePriceDzd: null == basePriceDzd ? _self.basePriceDzd : basePriceDzd // ignore: cast_nullable_to_non_nullable
as double,platformFeeDzd: null == platformFeeDzd ? _self.platformFeeDzd : platformFeeDzd // ignore: cast_nullable_to_non_nullable
as double,carrierFeeDzd: null == carrierFeeDzd ? _self.carrierFeeDzd : carrierFeeDzd // ignore: cast_nullable_to_non_nullable
as double,insuranceRate: freezed == insuranceRate ? _self.insuranceRate : insuranceRate // ignore: cast_nullable_to_non_nullable
as double?,insuranceFeeDzd: null == insuranceFeeDzd ? _self.insuranceFeeDzd : insuranceFeeDzd // ignore: cast_nullable_to_non_nullable
as double,taxFeeDzd: null == taxFeeDzd ? _self.taxFeeDzd : taxFeeDzd // ignore: cast_nullable_to_non_nullable
as double,shipperTotalDzd: null == shipperTotalDzd ? _self.shipperTotalDzd : shipperTotalDzd // ignore: cast_nullable_to_non_nullable
as double,carrierPayoutDzd: null == carrierPayoutDzd ? _self.carrierPayoutDzd : carrierPayoutDzd // ignore: cast_nullable_to_non_nullable
as double,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,trackingNumber: null == trackingNumber ? _self.trackingNumber : trackingNumber // ignore: cast_nullable_to_non_nullable
as String,paymentReference: null == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingRecord].
extension BookingRecordPatterns on BookingRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingRecord value)  $default,){
final _that = this;
switch (_that) {
case _BookingRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingRecord value)?  $default,){
final _that = this;
switch (_that) {
case _BookingRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String shipmentId,  String? routeId,  DateTime? routeDepartureDate,  String? oneoffTripId,  String shipperId,  String carrierId,  String vehicleId,  double weightKg,  double? volumeM3,  double pricePerKgDzd,  double basePriceDzd,  double platformFeeDzd,  double carrierFeeDzd,  double? insuranceRate,  double insuranceFeeDzd,  double taxFeeDzd,  double shipperTotalDzd,  double carrierPayoutDzd,  BookingStatus bookingStatus,  PaymentStatus paymentStatus,  String trackingNumber,  String paymentReference,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingRecord() when $default != null:
return $default(_that.id,_that.shipmentId,_that.routeId,_that.routeDepartureDate,_that.oneoffTripId,_that.shipperId,_that.carrierId,_that.vehicleId,_that.weightKg,_that.volumeM3,_that.pricePerKgDzd,_that.basePriceDzd,_that.platformFeeDzd,_that.carrierFeeDzd,_that.insuranceRate,_that.insuranceFeeDzd,_that.taxFeeDzd,_that.shipperTotalDzd,_that.carrierPayoutDzd,_that.bookingStatus,_that.paymentStatus,_that.trackingNumber,_that.paymentReference,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String shipmentId,  String? routeId,  DateTime? routeDepartureDate,  String? oneoffTripId,  String shipperId,  String carrierId,  String vehicleId,  double weightKg,  double? volumeM3,  double pricePerKgDzd,  double basePriceDzd,  double platformFeeDzd,  double carrierFeeDzd,  double? insuranceRate,  double insuranceFeeDzd,  double taxFeeDzd,  double shipperTotalDzd,  double carrierPayoutDzd,  BookingStatus bookingStatus,  PaymentStatus paymentStatus,  String trackingNumber,  String paymentReference,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BookingRecord():
return $default(_that.id,_that.shipmentId,_that.routeId,_that.routeDepartureDate,_that.oneoffTripId,_that.shipperId,_that.carrierId,_that.vehicleId,_that.weightKg,_that.volumeM3,_that.pricePerKgDzd,_that.basePriceDzd,_that.platformFeeDzd,_that.carrierFeeDzd,_that.insuranceRate,_that.insuranceFeeDzd,_that.taxFeeDzd,_that.shipperTotalDzd,_that.carrierPayoutDzd,_that.bookingStatus,_that.paymentStatus,_that.trackingNumber,_that.paymentReference,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String shipmentId,  String? routeId,  DateTime? routeDepartureDate,  String? oneoffTripId,  String shipperId,  String carrierId,  String vehicleId,  double weightKg,  double? volumeM3,  double pricePerKgDzd,  double basePriceDzd,  double platformFeeDzd,  double carrierFeeDzd,  double? insuranceRate,  double insuranceFeeDzd,  double taxFeeDzd,  double shipperTotalDzd,  double carrierPayoutDzd,  BookingStatus bookingStatus,  PaymentStatus paymentStatus,  String trackingNumber,  String paymentReference,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingRecord() when $default != null:
return $default(_that.id,_that.shipmentId,_that.routeId,_that.routeDepartureDate,_that.oneoffTripId,_that.shipperId,_that.carrierId,_that.vehicleId,_that.weightKg,_that.volumeM3,_that.pricePerKgDzd,_that.basePriceDzd,_that.platformFeeDzd,_that.carrierFeeDzd,_that.insuranceRate,_that.insuranceFeeDzd,_that.taxFeeDzd,_that.shipperTotalDzd,_that.carrierPayoutDzd,_that.bookingStatus,_that.paymentStatus,_that.trackingNumber,_that.paymentReference,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _BookingRecord extends BookingRecord {
  const _BookingRecord({required this.id, required this.shipmentId, required this.routeId, required this.routeDepartureDate, required this.oneoffTripId, required this.shipperId, required this.carrierId, required this.vehicleId, required this.weightKg, required this.volumeM3, required this.pricePerKgDzd, required this.basePriceDzd, required this.platformFeeDzd, required this.carrierFeeDzd, required this.insuranceRate, required this.insuranceFeeDzd, required this.taxFeeDzd, required this.shipperTotalDzd, required this.carrierPayoutDzd, required this.bookingStatus, required this.paymentStatus, required this.trackingNumber, required this.paymentReference, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String shipmentId;
@override final  String? routeId;
@override final  DateTime? routeDepartureDate;
@override final  String? oneoffTripId;
@override final  String shipperId;
@override final  String carrierId;
@override final  String vehicleId;
@override final  double weightKg;
@override final  double? volumeM3;
@override final  double pricePerKgDzd;
@override final  double basePriceDzd;
@override final  double platformFeeDzd;
@override final  double carrierFeeDzd;
@override final  double? insuranceRate;
@override final  double insuranceFeeDzd;
@override final  double taxFeeDzd;
@override final  double shipperTotalDzd;
@override final  double carrierPayoutDzd;
@override final  BookingStatus bookingStatus;
@override final  PaymentStatus paymentStatus;
@override final  String trackingNumber;
@override final  String paymentReference;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of BookingRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRecordCopyWith<_BookingRecord> get copyWith => __$BookingRecordCopyWithImpl<_BookingRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.shipmentId, shipmentId) || other.shipmentId == shipmentId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeDepartureDate, routeDepartureDate) || other.routeDepartureDate == routeDepartureDate)&&(identical(other.oneoffTripId, oneoffTripId) || other.oneoffTripId == oneoffTripId)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.volumeM3, volumeM3) || other.volumeM3 == volumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.basePriceDzd, basePriceDzd) || other.basePriceDzd == basePriceDzd)&&(identical(other.platformFeeDzd, platformFeeDzd) || other.platformFeeDzd == platformFeeDzd)&&(identical(other.carrierFeeDzd, carrierFeeDzd) || other.carrierFeeDzd == carrierFeeDzd)&&(identical(other.insuranceRate, insuranceRate) || other.insuranceRate == insuranceRate)&&(identical(other.insuranceFeeDzd, insuranceFeeDzd) || other.insuranceFeeDzd == insuranceFeeDzd)&&(identical(other.taxFeeDzd, taxFeeDzd) || other.taxFeeDzd == taxFeeDzd)&&(identical(other.shipperTotalDzd, shipperTotalDzd) || other.shipperTotalDzd == shipperTotalDzd)&&(identical(other.carrierPayoutDzd, carrierPayoutDzd) || other.carrierPayoutDzd == carrierPayoutDzd)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.trackingNumber, trackingNumber) || other.trackingNumber == trackingNumber)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,shipmentId,routeId,routeDepartureDate,oneoffTripId,shipperId,carrierId,vehicleId,weightKg,volumeM3,pricePerKgDzd,basePriceDzd,platformFeeDzd,carrierFeeDzd,insuranceRate,insuranceFeeDzd,taxFeeDzd,shipperTotalDzd,carrierPayoutDzd,bookingStatus,paymentStatus,trackingNumber,paymentReference,createdAt,updatedAt]);

@override
String toString() {
  return 'BookingRecord(id: $id, shipmentId: $shipmentId, routeId: $routeId, routeDepartureDate: $routeDepartureDate, oneoffTripId: $oneoffTripId, shipperId: $shipperId, carrierId: $carrierId, vehicleId: $vehicleId, weightKg: $weightKg, volumeM3: $volumeM3, pricePerKgDzd: $pricePerKgDzd, basePriceDzd: $basePriceDzd, platformFeeDzd: $platformFeeDzd, carrierFeeDzd: $carrierFeeDzd, insuranceRate: $insuranceRate, insuranceFeeDzd: $insuranceFeeDzd, taxFeeDzd: $taxFeeDzd, shipperTotalDzd: $shipperTotalDzd, carrierPayoutDzd: $carrierPayoutDzd, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, trackingNumber: $trackingNumber, paymentReference: $paymentReference, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BookingRecordCopyWith<$Res> implements $BookingRecordCopyWith<$Res> {
  factory _$BookingRecordCopyWith(_BookingRecord value, $Res Function(_BookingRecord) _then) = __$BookingRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String shipmentId, String? routeId, DateTime? routeDepartureDate, String? oneoffTripId, String shipperId, String carrierId, String vehicleId, double weightKg, double? volumeM3, double pricePerKgDzd, double basePriceDzd, double platformFeeDzd, double carrierFeeDzd, double? insuranceRate, double insuranceFeeDzd, double taxFeeDzd, double shipperTotalDzd, double carrierPayoutDzd, BookingStatus bookingStatus, PaymentStatus paymentStatus, String trackingNumber, String paymentReference, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$BookingRecordCopyWithImpl<$Res>
    implements _$BookingRecordCopyWith<$Res> {
  __$BookingRecordCopyWithImpl(this._self, this._then);

  final _BookingRecord _self;
  final $Res Function(_BookingRecord) _then;

/// Create a copy of BookingRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shipmentId = null,Object? routeId = freezed,Object? routeDepartureDate = freezed,Object? oneoffTripId = freezed,Object? shipperId = null,Object? carrierId = null,Object? vehicleId = null,Object? weightKg = null,Object? volumeM3 = freezed,Object? pricePerKgDzd = null,Object? basePriceDzd = null,Object? platformFeeDzd = null,Object? carrierFeeDzd = null,Object? insuranceRate = freezed,Object? insuranceFeeDzd = null,Object? taxFeeDzd = null,Object? shipperTotalDzd = null,Object? carrierPayoutDzd = null,Object? bookingStatus = null,Object? paymentStatus = null,Object? trackingNumber = null,Object? paymentReference = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_BookingRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shipmentId: null == shipmentId ? _self.shipmentId : shipmentId // ignore: cast_nullable_to_non_nullable
as String,routeId: freezed == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String?,routeDepartureDate: freezed == routeDepartureDate ? _self.routeDepartureDate : routeDepartureDate // ignore: cast_nullable_to_non_nullable
as DateTime?,oneoffTripId: freezed == oneoffTripId ? _self.oneoffTripId : oneoffTripId // ignore: cast_nullable_to_non_nullable
as String?,shipperId: null == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,volumeM3: freezed == volumeM3 ? _self.volumeM3 : volumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,basePriceDzd: null == basePriceDzd ? _self.basePriceDzd : basePriceDzd // ignore: cast_nullable_to_non_nullable
as double,platformFeeDzd: null == platformFeeDzd ? _self.platformFeeDzd : platformFeeDzd // ignore: cast_nullable_to_non_nullable
as double,carrierFeeDzd: null == carrierFeeDzd ? _self.carrierFeeDzd : carrierFeeDzd // ignore: cast_nullable_to_non_nullable
as double,insuranceRate: freezed == insuranceRate ? _self.insuranceRate : insuranceRate // ignore: cast_nullable_to_non_nullable
as double?,insuranceFeeDzd: null == insuranceFeeDzd ? _self.insuranceFeeDzd : insuranceFeeDzd // ignore: cast_nullable_to_non_nullable
as double,taxFeeDzd: null == taxFeeDzd ? _self.taxFeeDzd : taxFeeDzd // ignore: cast_nullable_to_non_nullable
as double,shipperTotalDzd: null == shipperTotalDzd ? _self.shipperTotalDzd : shipperTotalDzd // ignore: cast_nullable_to_non_nullable
as double,carrierPayoutDzd: null == carrierPayoutDzd ? _self.carrierPayoutDzd : carrierPayoutDzd // ignore: cast_nullable_to_non_nullable
as double,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,trackingNumber: null == trackingNumber ? _self.trackingNumber : trackingNumber // ignore: cast_nullable_to_non_nullable
as String,paymentReference: null == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$BookingPricingQuote {

 double get pricePerKgDzd; double get basePriceDzd; double get platformFeeDzd; double get carrierFeeDzd; double? get insuranceRate; double get insuranceFeeDzd; double get taxFeeDzd; double get shipperTotalDzd; double get carrierPayoutDzd;
/// Create a copy of BookingPricingQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingPricingQuoteCopyWith<BookingPricingQuote> get copyWith => _$BookingPricingQuoteCopyWithImpl<BookingPricingQuote>(this as BookingPricingQuote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingPricingQuote&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.basePriceDzd, basePriceDzd) || other.basePriceDzd == basePriceDzd)&&(identical(other.platformFeeDzd, platformFeeDzd) || other.platformFeeDzd == platformFeeDzd)&&(identical(other.carrierFeeDzd, carrierFeeDzd) || other.carrierFeeDzd == carrierFeeDzd)&&(identical(other.insuranceRate, insuranceRate) || other.insuranceRate == insuranceRate)&&(identical(other.insuranceFeeDzd, insuranceFeeDzd) || other.insuranceFeeDzd == insuranceFeeDzd)&&(identical(other.taxFeeDzd, taxFeeDzd) || other.taxFeeDzd == taxFeeDzd)&&(identical(other.shipperTotalDzd, shipperTotalDzd) || other.shipperTotalDzd == shipperTotalDzd)&&(identical(other.carrierPayoutDzd, carrierPayoutDzd) || other.carrierPayoutDzd == carrierPayoutDzd));
}


@override
int get hashCode => Object.hash(runtimeType,pricePerKgDzd,basePriceDzd,platformFeeDzd,carrierFeeDzd,insuranceRate,insuranceFeeDzd,taxFeeDzd,shipperTotalDzd,carrierPayoutDzd);

@override
String toString() {
  return 'BookingPricingQuote(pricePerKgDzd: $pricePerKgDzd, basePriceDzd: $basePriceDzd, platformFeeDzd: $platformFeeDzd, carrierFeeDzd: $carrierFeeDzd, insuranceRate: $insuranceRate, insuranceFeeDzd: $insuranceFeeDzd, taxFeeDzd: $taxFeeDzd, shipperTotalDzd: $shipperTotalDzd, carrierPayoutDzd: $carrierPayoutDzd)';
}


}

/// @nodoc
abstract mixin class $BookingPricingQuoteCopyWith<$Res>  {
  factory $BookingPricingQuoteCopyWith(BookingPricingQuote value, $Res Function(BookingPricingQuote) _then) = _$BookingPricingQuoteCopyWithImpl;
@useResult
$Res call({
 double pricePerKgDzd, double basePriceDzd, double platformFeeDzd, double carrierFeeDzd, double? insuranceRate, double insuranceFeeDzd, double taxFeeDzd, double shipperTotalDzd, double carrierPayoutDzd
});




}
/// @nodoc
class _$BookingPricingQuoteCopyWithImpl<$Res>
    implements $BookingPricingQuoteCopyWith<$Res> {
  _$BookingPricingQuoteCopyWithImpl(this._self, this._then);

  final BookingPricingQuote _self;
  final $Res Function(BookingPricingQuote) _then;

/// Create a copy of BookingPricingQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pricePerKgDzd = null,Object? basePriceDzd = null,Object? platformFeeDzd = null,Object? carrierFeeDzd = null,Object? insuranceRate = freezed,Object? insuranceFeeDzd = null,Object? taxFeeDzd = null,Object? shipperTotalDzd = null,Object? carrierPayoutDzd = null,}) {
  return _then(_self.copyWith(
pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,basePriceDzd: null == basePriceDzd ? _self.basePriceDzd : basePriceDzd // ignore: cast_nullable_to_non_nullable
as double,platformFeeDzd: null == platformFeeDzd ? _self.platformFeeDzd : platformFeeDzd // ignore: cast_nullable_to_non_nullable
as double,carrierFeeDzd: null == carrierFeeDzd ? _self.carrierFeeDzd : carrierFeeDzd // ignore: cast_nullable_to_non_nullable
as double,insuranceRate: freezed == insuranceRate ? _self.insuranceRate : insuranceRate // ignore: cast_nullable_to_non_nullable
as double?,insuranceFeeDzd: null == insuranceFeeDzd ? _self.insuranceFeeDzd : insuranceFeeDzd // ignore: cast_nullable_to_non_nullable
as double,taxFeeDzd: null == taxFeeDzd ? _self.taxFeeDzd : taxFeeDzd // ignore: cast_nullable_to_non_nullable
as double,shipperTotalDzd: null == shipperTotalDzd ? _self.shipperTotalDzd : shipperTotalDzd // ignore: cast_nullable_to_non_nullable
as double,carrierPayoutDzd: null == carrierPayoutDzd ? _self.carrierPayoutDzd : carrierPayoutDzd // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingPricingQuote].
extension BookingPricingQuotePatterns on BookingPricingQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingPricingQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingPricingQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingPricingQuote value)  $default,){
final _that = this;
switch (_that) {
case _BookingPricingQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingPricingQuote value)?  $default,){
final _that = this;
switch (_that) {
case _BookingPricingQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double pricePerKgDzd,  double basePriceDzd,  double platformFeeDzd,  double carrierFeeDzd,  double? insuranceRate,  double insuranceFeeDzd,  double taxFeeDzd,  double shipperTotalDzd,  double carrierPayoutDzd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingPricingQuote() when $default != null:
return $default(_that.pricePerKgDzd,_that.basePriceDzd,_that.platformFeeDzd,_that.carrierFeeDzd,_that.insuranceRate,_that.insuranceFeeDzd,_that.taxFeeDzd,_that.shipperTotalDzd,_that.carrierPayoutDzd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double pricePerKgDzd,  double basePriceDzd,  double platformFeeDzd,  double carrierFeeDzd,  double? insuranceRate,  double insuranceFeeDzd,  double taxFeeDzd,  double shipperTotalDzd,  double carrierPayoutDzd)  $default,) {final _that = this;
switch (_that) {
case _BookingPricingQuote():
return $default(_that.pricePerKgDzd,_that.basePriceDzd,_that.platformFeeDzd,_that.carrierFeeDzd,_that.insuranceRate,_that.insuranceFeeDzd,_that.taxFeeDzd,_that.shipperTotalDzd,_that.carrierPayoutDzd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double pricePerKgDzd,  double basePriceDzd,  double platformFeeDzd,  double carrierFeeDzd,  double? insuranceRate,  double insuranceFeeDzd,  double taxFeeDzd,  double shipperTotalDzd,  double carrierPayoutDzd)?  $default,) {final _that = this;
switch (_that) {
case _BookingPricingQuote() when $default != null:
return $default(_that.pricePerKgDzd,_that.basePriceDzd,_that.platformFeeDzd,_that.carrierFeeDzd,_that.insuranceRate,_that.insuranceFeeDzd,_that.taxFeeDzd,_that.shipperTotalDzd,_that.carrierPayoutDzd);case _:
  return null;

}
}

}

/// @nodoc


class _BookingPricingQuote extends BookingPricingQuote {
  const _BookingPricingQuote({required this.pricePerKgDzd, required this.basePriceDzd, required this.platformFeeDzd, required this.carrierFeeDzd, required this.insuranceRate, required this.insuranceFeeDzd, required this.taxFeeDzd, required this.shipperTotalDzd, required this.carrierPayoutDzd}): super._();
  

@override final  double pricePerKgDzd;
@override final  double basePriceDzd;
@override final  double platformFeeDzd;
@override final  double carrierFeeDzd;
@override final  double? insuranceRate;
@override final  double insuranceFeeDzd;
@override final  double taxFeeDzd;
@override final  double shipperTotalDzd;
@override final  double carrierPayoutDzd;

/// Create a copy of BookingPricingQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingPricingQuoteCopyWith<_BookingPricingQuote> get copyWith => __$BookingPricingQuoteCopyWithImpl<_BookingPricingQuote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingPricingQuote&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.basePriceDzd, basePriceDzd) || other.basePriceDzd == basePriceDzd)&&(identical(other.platformFeeDzd, platformFeeDzd) || other.platformFeeDzd == platformFeeDzd)&&(identical(other.carrierFeeDzd, carrierFeeDzd) || other.carrierFeeDzd == carrierFeeDzd)&&(identical(other.insuranceRate, insuranceRate) || other.insuranceRate == insuranceRate)&&(identical(other.insuranceFeeDzd, insuranceFeeDzd) || other.insuranceFeeDzd == insuranceFeeDzd)&&(identical(other.taxFeeDzd, taxFeeDzd) || other.taxFeeDzd == taxFeeDzd)&&(identical(other.shipperTotalDzd, shipperTotalDzd) || other.shipperTotalDzd == shipperTotalDzd)&&(identical(other.carrierPayoutDzd, carrierPayoutDzd) || other.carrierPayoutDzd == carrierPayoutDzd));
}


@override
int get hashCode => Object.hash(runtimeType,pricePerKgDzd,basePriceDzd,platformFeeDzd,carrierFeeDzd,insuranceRate,insuranceFeeDzd,taxFeeDzd,shipperTotalDzd,carrierPayoutDzd);

@override
String toString() {
  return 'BookingPricingQuote(pricePerKgDzd: $pricePerKgDzd, basePriceDzd: $basePriceDzd, platformFeeDzd: $platformFeeDzd, carrierFeeDzd: $carrierFeeDzd, insuranceRate: $insuranceRate, insuranceFeeDzd: $insuranceFeeDzd, taxFeeDzd: $taxFeeDzd, shipperTotalDzd: $shipperTotalDzd, carrierPayoutDzd: $carrierPayoutDzd)';
}


}

/// @nodoc
abstract mixin class _$BookingPricingQuoteCopyWith<$Res> implements $BookingPricingQuoteCopyWith<$Res> {
  factory _$BookingPricingQuoteCopyWith(_BookingPricingQuote value, $Res Function(_BookingPricingQuote) _then) = __$BookingPricingQuoteCopyWithImpl;
@override @useResult
$Res call({
 double pricePerKgDzd, double basePriceDzd, double platformFeeDzd, double carrierFeeDzd, double? insuranceRate, double insuranceFeeDzd, double taxFeeDzd, double shipperTotalDzd, double carrierPayoutDzd
});




}
/// @nodoc
class __$BookingPricingQuoteCopyWithImpl<$Res>
    implements _$BookingPricingQuoteCopyWith<$Res> {
  __$BookingPricingQuoteCopyWithImpl(this._self, this._then);

  final _BookingPricingQuote _self;
  final $Res Function(_BookingPricingQuote) _then;

/// Create a copy of BookingPricingQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pricePerKgDzd = null,Object? basePriceDzd = null,Object? platformFeeDzd = null,Object? carrierFeeDzd = null,Object? insuranceRate = freezed,Object? insuranceFeeDzd = null,Object? taxFeeDzd = null,Object? shipperTotalDzd = null,Object? carrierPayoutDzd = null,}) {
  return _then(_BookingPricingQuote(
pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,basePriceDzd: null == basePriceDzd ? _self.basePriceDzd : basePriceDzd // ignore: cast_nullable_to_non_nullable
as double,platformFeeDzd: null == platformFeeDzd ? _self.platformFeeDzd : platformFeeDzd // ignore: cast_nullable_to_non_nullable
as double,carrierFeeDzd: null == carrierFeeDzd ? _self.carrierFeeDzd : carrierFeeDzd // ignore: cast_nullable_to_non_nullable
as double,insuranceRate: freezed == insuranceRate ? _self.insuranceRate : insuranceRate // ignore: cast_nullable_to_non_nullable
as double?,insuranceFeeDzd: null == insuranceFeeDzd ? _self.insuranceFeeDzd : insuranceFeeDzd // ignore: cast_nullable_to_non_nullable
as double,taxFeeDzd: null == taxFeeDzd ? _self.taxFeeDzd : taxFeeDzd // ignore: cast_nullable_to_non_nullable
as double,shipperTotalDzd: null == shipperTotalDzd ? _self.shipperTotalDzd : shipperTotalDzd // ignore: cast_nullable_to_non_nullable
as double,carrierPayoutDzd: null == carrierPayoutDzd ? _self.carrierPayoutDzd : carrierPayoutDzd // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$PaymentProofRecord {

 String get id; String get bookingId; String get storagePath; String get paymentRail; String? get submittedReference; double get submittedAmountDzd; double? get verifiedAmountDzd; String? get verifiedReference; String get status; String? get rejectionReason; String? get reviewedBy; DateTime get submittedAt; DateTime? get reviewedAt; String? get decisionNote; int get version;
/// Create a copy of PaymentProofRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentProofRecordCopyWith<PaymentProofRecord> get copyWith => _$PaymentProofRecordCopyWithImpl<PaymentProofRecord>(this as PaymentProofRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentProofRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.paymentRail, paymentRail) || other.paymentRail == paymentRail)&&(identical(other.submittedReference, submittedReference) || other.submittedReference == submittedReference)&&(identical(other.submittedAmountDzd, submittedAmountDzd) || other.submittedAmountDzd == submittedAmountDzd)&&(identical(other.verifiedAmountDzd, verifiedAmountDzd) || other.verifiedAmountDzd == verifiedAmountDzd)&&(identical(other.verifiedReference, verifiedReference) || other.verifiedReference == verifiedReference)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.decisionNote, decisionNote) || other.decisionNote == decisionNote)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,storagePath,paymentRail,submittedReference,submittedAmountDzd,verifiedAmountDzd,verifiedReference,status,rejectionReason,reviewedBy,submittedAt,reviewedAt,decisionNote,version);

@override
String toString() {
  return 'PaymentProofRecord(id: $id, bookingId: $bookingId, storagePath: $storagePath, paymentRail: $paymentRail, submittedReference: $submittedReference, submittedAmountDzd: $submittedAmountDzd, verifiedAmountDzd: $verifiedAmountDzd, verifiedReference: $verifiedReference, status: $status, rejectionReason: $rejectionReason, reviewedBy: $reviewedBy, submittedAt: $submittedAt, reviewedAt: $reviewedAt, decisionNote: $decisionNote, version: $version)';
}


}

/// @nodoc
abstract mixin class $PaymentProofRecordCopyWith<$Res>  {
  factory $PaymentProofRecordCopyWith(PaymentProofRecord value, $Res Function(PaymentProofRecord) _then) = _$PaymentProofRecordCopyWithImpl;
@useResult
$Res call({
 String id, String bookingId, String storagePath, String paymentRail, String? submittedReference, double submittedAmountDzd, double? verifiedAmountDzd, String? verifiedReference, String status, String? rejectionReason, String? reviewedBy, DateTime submittedAt, DateTime? reviewedAt, String? decisionNote, int version
});




}
/// @nodoc
class _$PaymentProofRecordCopyWithImpl<$Res>
    implements $PaymentProofRecordCopyWith<$Res> {
  _$PaymentProofRecordCopyWithImpl(this._self, this._then);

  final PaymentProofRecord _self;
  final $Res Function(PaymentProofRecord) _then;

/// Create a copy of PaymentProofRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? storagePath = null,Object? paymentRail = null,Object? submittedReference = freezed,Object? submittedAmountDzd = null,Object? verifiedAmountDzd = freezed,Object? verifiedReference = freezed,Object? status = null,Object? rejectionReason = freezed,Object? reviewedBy = freezed,Object? submittedAt = null,Object? reviewedAt = freezed,Object? decisionNote = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,paymentRail: null == paymentRail ? _self.paymentRail : paymentRail // ignore: cast_nullable_to_non_nullable
as String,submittedReference: freezed == submittedReference ? _self.submittedReference : submittedReference // ignore: cast_nullable_to_non_nullable
as String?,submittedAmountDzd: null == submittedAmountDzd ? _self.submittedAmountDzd : submittedAmountDzd // ignore: cast_nullable_to_non_nullable
as double,verifiedAmountDzd: freezed == verifiedAmountDzd ? _self.verifiedAmountDzd : verifiedAmountDzd // ignore: cast_nullable_to_non_nullable
as double?,verifiedReference: freezed == verifiedReference ? _self.verifiedReference : verifiedReference // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,decisionNote: freezed == decisionNote ? _self.decisionNote : decisionNote // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentProofRecord].
extension PaymentProofRecordPatterns on PaymentProofRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentProofRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentProofRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentProofRecord value)  $default,){
final _that = this;
switch (_that) {
case _PaymentProofRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentProofRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentProofRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookingId,  String storagePath,  String paymentRail,  String? submittedReference,  double submittedAmountDzd,  double? verifiedAmountDzd,  String? verifiedReference,  String status,  String? rejectionReason,  String? reviewedBy,  DateTime submittedAt,  DateTime? reviewedAt,  String? decisionNote,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentProofRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.storagePath,_that.paymentRail,_that.submittedReference,_that.submittedAmountDzd,_that.verifiedAmountDzd,_that.verifiedReference,_that.status,_that.rejectionReason,_that.reviewedBy,_that.submittedAt,_that.reviewedAt,_that.decisionNote,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookingId,  String storagePath,  String paymentRail,  String? submittedReference,  double submittedAmountDzd,  double? verifiedAmountDzd,  String? verifiedReference,  String status,  String? rejectionReason,  String? reviewedBy,  DateTime submittedAt,  DateTime? reviewedAt,  String? decisionNote,  int version)  $default,) {final _that = this;
switch (_that) {
case _PaymentProofRecord():
return $default(_that.id,_that.bookingId,_that.storagePath,_that.paymentRail,_that.submittedReference,_that.submittedAmountDzd,_that.verifiedAmountDzd,_that.verifiedReference,_that.status,_that.rejectionReason,_that.reviewedBy,_that.submittedAt,_that.reviewedAt,_that.decisionNote,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookingId,  String storagePath,  String paymentRail,  String? submittedReference,  double submittedAmountDzd,  double? verifiedAmountDzd,  String? verifiedReference,  String status,  String? rejectionReason,  String? reviewedBy,  DateTime submittedAt,  DateTime? reviewedAt,  String? decisionNote,  int version)?  $default,) {final _that = this;
switch (_that) {
case _PaymentProofRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.storagePath,_that.paymentRail,_that.submittedReference,_that.submittedAmountDzd,_that.verifiedAmountDzd,_that.verifiedReference,_that.status,_that.rejectionReason,_that.reviewedBy,_that.submittedAt,_that.reviewedAt,_that.decisionNote,_that.version);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentProofRecord extends PaymentProofRecord {
  const _PaymentProofRecord({required this.id, required this.bookingId, required this.storagePath, required this.paymentRail, required this.submittedReference, required this.submittedAmountDzd, required this.verifiedAmountDzd, required this.verifiedReference, required this.status, required this.rejectionReason, required this.reviewedBy, required this.submittedAt, required this.reviewedAt, required this.decisionNote, required this.version}): super._();
  

@override final  String id;
@override final  String bookingId;
@override final  String storagePath;
@override final  String paymentRail;
@override final  String? submittedReference;
@override final  double submittedAmountDzd;
@override final  double? verifiedAmountDzd;
@override final  String? verifiedReference;
@override final  String status;
@override final  String? rejectionReason;
@override final  String? reviewedBy;
@override final  DateTime submittedAt;
@override final  DateTime? reviewedAt;
@override final  String? decisionNote;
@override final  int version;

/// Create a copy of PaymentProofRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentProofRecordCopyWith<_PaymentProofRecord> get copyWith => __$PaymentProofRecordCopyWithImpl<_PaymentProofRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentProofRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.paymentRail, paymentRail) || other.paymentRail == paymentRail)&&(identical(other.submittedReference, submittedReference) || other.submittedReference == submittedReference)&&(identical(other.submittedAmountDzd, submittedAmountDzd) || other.submittedAmountDzd == submittedAmountDzd)&&(identical(other.verifiedAmountDzd, verifiedAmountDzd) || other.verifiedAmountDzd == verifiedAmountDzd)&&(identical(other.verifiedReference, verifiedReference) || other.verifiedReference == verifiedReference)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.decisionNote, decisionNote) || other.decisionNote == decisionNote)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,storagePath,paymentRail,submittedReference,submittedAmountDzd,verifiedAmountDzd,verifiedReference,status,rejectionReason,reviewedBy,submittedAt,reviewedAt,decisionNote,version);

@override
String toString() {
  return 'PaymentProofRecord(id: $id, bookingId: $bookingId, storagePath: $storagePath, paymentRail: $paymentRail, submittedReference: $submittedReference, submittedAmountDzd: $submittedAmountDzd, verifiedAmountDzd: $verifiedAmountDzd, verifiedReference: $verifiedReference, status: $status, rejectionReason: $rejectionReason, reviewedBy: $reviewedBy, submittedAt: $submittedAt, reviewedAt: $reviewedAt, decisionNote: $decisionNote, version: $version)';
}


}

/// @nodoc
abstract mixin class _$PaymentProofRecordCopyWith<$Res> implements $PaymentProofRecordCopyWith<$Res> {
  factory _$PaymentProofRecordCopyWith(_PaymentProofRecord value, $Res Function(_PaymentProofRecord) _then) = __$PaymentProofRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookingId, String storagePath, String paymentRail, String? submittedReference, double submittedAmountDzd, double? verifiedAmountDzd, String? verifiedReference, String status, String? rejectionReason, String? reviewedBy, DateTime submittedAt, DateTime? reviewedAt, String? decisionNote, int version
});




}
/// @nodoc
class __$PaymentProofRecordCopyWithImpl<$Res>
    implements _$PaymentProofRecordCopyWith<$Res> {
  __$PaymentProofRecordCopyWithImpl(this._self, this._then);

  final _PaymentProofRecord _self;
  final $Res Function(_PaymentProofRecord) _then;

/// Create a copy of PaymentProofRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? storagePath = null,Object? paymentRail = null,Object? submittedReference = freezed,Object? submittedAmountDzd = null,Object? verifiedAmountDzd = freezed,Object? verifiedReference = freezed,Object? status = null,Object? rejectionReason = freezed,Object? reviewedBy = freezed,Object? submittedAt = null,Object? reviewedAt = freezed,Object? decisionNote = freezed,Object? version = null,}) {
  return _then(_PaymentProofRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,paymentRail: null == paymentRail ? _self.paymentRail : paymentRail // ignore: cast_nullable_to_non_nullable
as String,submittedReference: freezed == submittedReference ? _self.submittedReference : submittedReference // ignore: cast_nullable_to_non_nullable
as String?,submittedAmountDzd: null == submittedAmountDzd ? _self.submittedAmountDzd : submittedAmountDzd // ignore: cast_nullable_to_non_nullable
as double,verifiedAmountDzd: freezed == verifiedAmountDzd ? _self.verifiedAmountDzd : verifiedAmountDzd // ignore: cast_nullable_to_non_nullable
as double?,verifiedReference: freezed == verifiedReference ? _self.verifiedReference : verifiedReference // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,decisionNote: freezed == decisionNote ? _self.decisionNote : decisionNote // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GeneratedDocumentRecord {

 String get id; String? get bookingId; String get documentType; String get storagePath; int get version; String? get generatedBy; GeneratedDocumentStatus get status; String? get contentType; int? get byteSize; DateTime? get availableAt; String? get failureReason; DateTime? get createdAt;
/// Create a copy of GeneratedDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratedDocumentRecordCopyWith<GeneratedDocumentRecord> get copyWith => _$GeneratedDocumentRecordCopyWithImpl<GeneratedDocumentRecord>(this as GeneratedDocumentRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratedDocumentRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedBy, generatedBy) || other.generatedBy == generatedBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&(identical(other.availableAt, availableAt) || other.availableAt == availableAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,documentType,storagePath,version,generatedBy,status,contentType,byteSize,availableAt,failureReason,createdAt);

@override
String toString() {
  return 'GeneratedDocumentRecord(id: $id, bookingId: $bookingId, documentType: $documentType, storagePath: $storagePath, version: $version, generatedBy: $generatedBy, status: $status, contentType: $contentType, byteSize: $byteSize, availableAt: $availableAt, failureReason: $failureReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GeneratedDocumentRecordCopyWith<$Res>  {
  factory $GeneratedDocumentRecordCopyWith(GeneratedDocumentRecord value, $Res Function(GeneratedDocumentRecord) _then) = _$GeneratedDocumentRecordCopyWithImpl;
@useResult
$Res call({
 String id, String? bookingId, String documentType, String storagePath, int version, String? generatedBy, GeneratedDocumentStatus status, String? contentType, int? byteSize, DateTime? availableAt, String? failureReason, DateTime? createdAt
});




}
/// @nodoc
class _$GeneratedDocumentRecordCopyWithImpl<$Res>
    implements $GeneratedDocumentRecordCopyWith<$Res> {
  _$GeneratedDocumentRecordCopyWithImpl(this._self, this._then);

  final GeneratedDocumentRecord _self;
  final $Res Function(GeneratedDocumentRecord) _then;

/// Create a copy of GeneratedDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = freezed,Object? documentType = null,Object? storagePath = null,Object? version = null,Object? generatedBy = freezed,Object? status = null,Object? contentType = freezed,Object? byteSize = freezed,Object? availableAt = freezed,Object? failureReason = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedBy: freezed == generatedBy ? _self.generatedBy : generatedBy // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GeneratedDocumentStatus,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,byteSize: freezed == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int?,availableAt: freezed == availableAt ? _self.availableAt : availableAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratedDocumentRecord].
extension GeneratedDocumentRecordPatterns on GeneratedDocumentRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratedDocumentRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratedDocumentRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratedDocumentRecord value)  $default,){
final _that = this;
switch (_that) {
case _GeneratedDocumentRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratedDocumentRecord value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratedDocumentRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? bookingId,  String documentType,  String storagePath,  int version,  String? generatedBy,  GeneratedDocumentStatus status,  String? contentType,  int? byteSize,  DateTime? availableAt,  String? failureReason,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratedDocumentRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.documentType,_that.storagePath,_that.version,_that.generatedBy,_that.status,_that.contentType,_that.byteSize,_that.availableAt,_that.failureReason,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? bookingId,  String documentType,  String storagePath,  int version,  String? generatedBy,  GeneratedDocumentStatus status,  String? contentType,  int? byteSize,  DateTime? availableAt,  String? failureReason,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _GeneratedDocumentRecord():
return $default(_that.id,_that.bookingId,_that.documentType,_that.storagePath,_that.version,_that.generatedBy,_that.status,_that.contentType,_that.byteSize,_that.availableAt,_that.failureReason,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? bookingId,  String documentType,  String storagePath,  int version,  String? generatedBy,  GeneratedDocumentStatus status,  String? contentType,  int? byteSize,  DateTime? availableAt,  String? failureReason,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GeneratedDocumentRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.documentType,_that.storagePath,_that.version,_that.generatedBy,_that.status,_that.contentType,_that.byteSize,_that.availableAt,_that.failureReason,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _GeneratedDocumentRecord extends GeneratedDocumentRecord {
  const _GeneratedDocumentRecord({required this.id, required this.bookingId, required this.documentType, required this.storagePath, required this.version, required this.generatedBy, required this.status, required this.contentType, required this.byteSize, required this.availableAt, required this.failureReason, required this.createdAt}): super._();
  

@override final  String id;
@override final  String? bookingId;
@override final  String documentType;
@override final  String storagePath;
@override final  int version;
@override final  String? generatedBy;
@override final  GeneratedDocumentStatus status;
@override final  String? contentType;
@override final  int? byteSize;
@override final  DateTime? availableAt;
@override final  String? failureReason;
@override final  DateTime? createdAt;

/// Create a copy of GeneratedDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedDocumentRecordCopyWith<_GeneratedDocumentRecord> get copyWith => __$GeneratedDocumentRecordCopyWithImpl<_GeneratedDocumentRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedDocumentRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedBy, generatedBy) || other.generatedBy == generatedBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&(identical(other.availableAt, availableAt) || other.availableAt == availableAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,documentType,storagePath,version,generatedBy,status,contentType,byteSize,availableAt,failureReason,createdAt);

@override
String toString() {
  return 'GeneratedDocumentRecord(id: $id, bookingId: $bookingId, documentType: $documentType, storagePath: $storagePath, version: $version, generatedBy: $generatedBy, status: $status, contentType: $contentType, byteSize: $byteSize, availableAt: $availableAt, failureReason: $failureReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GeneratedDocumentRecordCopyWith<$Res> implements $GeneratedDocumentRecordCopyWith<$Res> {
  factory _$GeneratedDocumentRecordCopyWith(_GeneratedDocumentRecord value, $Res Function(_GeneratedDocumentRecord) _then) = __$GeneratedDocumentRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String? bookingId, String documentType, String storagePath, int version, String? generatedBy, GeneratedDocumentStatus status, String? contentType, int? byteSize, DateTime? availableAt, String? failureReason, DateTime? createdAt
});




}
/// @nodoc
class __$GeneratedDocumentRecordCopyWithImpl<$Res>
    implements _$GeneratedDocumentRecordCopyWith<$Res> {
  __$GeneratedDocumentRecordCopyWithImpl(this._self, this._then);

  final _GeneratedDocumentRecord _self;
  final $Res Function(_GeneratedDocumentRecord) _then;

/// Create a copy of GeneratedDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = freezed,Object? documentType = null,Object? storagePath = null,Object? version = null,Object? generatedBy = freezed,Object? status = null,Object? contentType = freezed,Object? byteSize = freezed,Object? availableAt = freezed,Object? failureReason = freezed,Object? createdAt = freezed,}) {
  return _then(_GeneratedDocumentRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedBy: freezed == generatedBy ? _self.generatedBy : generatedBy // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GeneratedDocumentStatus,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,byteSize: freezed == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int?,availableAt: freezed == availableAt ? _self.availableAt : availableAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$TrackingEventRecord {

 String get id; String get bookingId; String get eventType; String get visibility; String? get note; String? get createdBy; DateTime get recordedAt; DateTime? get createdAt;
/// Create a copy of TrackingEventRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackingEventRecordCopyWith<TrackingEventRecord> get copyWith => _$TrackingEventRecordCopyWithImpl<TrackingEventRecord>(this as TrackingEventRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackingEventRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,eventType,visibility,note,createdBy,recordedAt,createdAt);

@override
String toString() {
  return 'TrackingEventRecord(id: $id, bookingId: $bookingId, eventType: $eventType, visibility: $visibility, note: $note, createdBy: $createdBy, recordedAt: $recordedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TrackingEventRecordCopyWith<$Res>  {
  factory $TrackingEventRecordCopyWith(TrackingEventRecord value, $Res Function(TrackingEventRecord) _then) = _$TrackingEventRecordCopyWithImpl;
@useResult
$Res call({
 String id, String bookingId, String eventType, String visibility, String? note, String? createdBy, DateTime recordedAt, DateTime? createdAt
});




}
/// @nodoc
class _$TrackingEventRecordCopyWithImpl<$Res>
    implements $TrackingEventRecordCopyWith<$Res> {
  _$TrackingEventRecordCopyWithImpl(this._self, this._then);

  final TrackingEventRecord _self;
  final $Res Function(TrackingEventRecord) _then;

/// Create a copy of TrackingEventRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? eventType = null,Object? visibility = null,Object? note = freezed,Object? createdBy = freezed,Object? recordedAt = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackingEventRecord].
extension TrackingEventRecordPatterns on TrackingEventRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackingEventRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackingEventRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackingEventRecord value)  $default,){
final _that = this;
switch (_that) {
case _TrackingEventRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackingEventRecord value)?  $default,){
final _that = this;
switch (_that) {
case _TrackingEventRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookingId,  String eventType,  String visibility,  String? note,  String? createdBy,  DateTime recordedAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackingEventRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.eventType,_that.visibility,_that.note,_that.createdBy,_that.recordedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookingId,  String eventType,  String visibility,  String? note,  String? createdBy,  DateTime recordedAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TrackingEventRecord():
return $default(_that.id,_that.bookingId,_that.eventType,_that.visibility,_that.note,_that.createdBy,_that.recordedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookingId,  String eventType,  String visibility,  String? note,  String? createdBy,  DateTime recordedAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TrackingEventRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.eventType,_that.visibility,_that.note,_that.createdBy,_that.recordedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _TrackingEventRecord extends TrackingEventRecord {
  const _TrackingEventRecord({required this.id, required this.bookingId, required this.eventType, required this.visibility, required this.note, required this.createdBy, required this.recordedAt, required this.createdAt}): super._();
  

@override final  String id;
@override final  String bookingId;
@override final  String eventType;
@override final  String visibility;
@override final  String? note;
@override final  String? createdBy;
@override final  DateTime recordedAt;
@override final  DateTime? createdAt;

/// Create a copy of TrackingEventRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackingEventRecordCopyWith<_TrackingEventRecord> get copyWith => __$TrackingEventRecordCopyWithImpl<_TrackingEventRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackingEventRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,eventType,visibility,note,createdBy,recordedAt,createdAt);

@override
String toString() {
  return 'TrackingEventRecord(id: $id, bookingId: $bookingId, eventType: $eventType, visibility: $visibility, note: $note, createdBy: $createdBy, recordedAt: $recordedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TrackingEventRecordCopyWith<$Res> implements $TrackingEventRecordCopyWith<$Res> {
  factory _$TrackingEventRecordCopyWith(_TrackingEventRecord value, $Res Function(_TrackingEventRecord) _then) = __$TrackingEventRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookingId, String eventType, String visibility, String? note, String? createdBy, DateTime recordedAt, DateTime? createdAt
});




}
/// @nodoc
class __$TrackingEventRecordCopyWithImpl<$Res>
    implements _$TrackingEventRecordCopyWith<$Res> {
  __$TrackingEventRecordCopyWithImpl(this._self, this._then);

  final _TrackingEventRecord _self;
  final $Res Function(_TrackingEventRecord) _then;

/// Create a copy of TrackingEventRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? eventType = null,Object? visibility = null,Object? note = freezed,Object? createdBy = freezed,Object? recordedAt = null,Object? createdAt = freezed,}) {
  return _then(_TrackingEventRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$DisputeRecord {

 String get id; String get bookingId; String get openedBy; String get reason; String? get description; String get status; String? get resolution; String? get resolutionNote; String? get resolvedBy; DateTime? get resolvedAt; int get evidenceCount; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of DisputeRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeRecordCopyWith<DisputeRecord> get copyWith => _$DisputeRecordCopyWithImpl<DisputeRecord>(this as DisputeRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.openedBy, openedBy) || other.openedBy == openedBy)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote)&&(identical(other.resolvedBy, resolvedBy) || other.resolvedBy == resolvedBy)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.evidenceCount, evidenceCount) || other.evidenceCount == evidenceCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,openedBy,reason,description,status,resolution,resolutionNote,resolvedBy,resolvedAt,evidenceCount,createdAt,updatedAt);

@override
String toString() {
  return 'DisputeRecord(id: $id, bookingId: $bookingId, openedBy: $openedBy, reason: $reason, description: $description, status: $status, resolution: $resolution, resolutionNote: $resolutionNote, resolvedBy: $resolvedBy, resolvedAt: $resolvedAt, evidenceCount: $evidenceCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DisputeRecordCopyWith<$Res>  {
  factory $DisputeRecordCopyWith(DisputeRecord value, $Res Function(DisputeRecord) _then) = _$DisputeRecordCopyWithImpl;
@useResult
$Res call({
 String id, String bookingId, String openedBy, String reason, String? description, String status, String? resolution, String? resolutionNote, String? resolvedBy, DateTime? resolvedAt, int evidenceCount, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$DisputeRecordCopyWithImpl<$Res>
    implements $DisputeRecordCopyWith<$Res> {
  _$DisputeRecordCopyWithImpl(this._self, this._then);

  final DisputeRecord _self;
  final $Res Function(DisputeRecord) _then;

/// Create a copy of DisputeRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? openedBy = null,Object? reason = null,Object? description = freezed,Object? status = null,Object? resolution = freezed,Object? resolutionNote = freezed,Object? resolvedBy = freezed,Object? resolvedAt = freezed,Object? evidenceCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,openedBy: null == openedBy ? _self.openedBy : openedBy // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,resolvedBy: freezed == resolvedBy ? _self.resolvedBy : resolvedBy // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,evidenceCount: null == evidenceCount ? _self.evidenceCount : evidenceCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DisputeRecord].
extension DisputeRecordPatterns on DisputeRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisputeRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisputeRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisputeRecord value)  $default,){
final _that = this;
switch (_that) {
case _DisputeRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisputeRecord value)?  $default,){
final _that = this;
switch (_that) {
case _DisputeRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookingId,  String openedBy,  String reason,  String? description,  String status,  String? resolution,  String? resolutionNote,  String? resolvedBy,  DateTime? resolvedAt,  int evidenceCount,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisputeRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.openedBy,_that.reason,_that.description,_that.status,_that.resolution,_that.resolutionNote,_that.resolvedBy,_that.resolvedAt,_that.evidenceCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookingId,  String openedBy,  String reason,  String? description,  String status,  String? resolution,  String? resolutionNote,  String? resolvedBy,  DateTime? resolvedAt,  int evidenceCount,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DisputeRecord():
return $default(_that.id,_that.bookingId,_that.openedBy,_that.reason,_that.description,_that.status,_that.resolution,_that.resolutionNote,_that.resolvedBy,_that.resolvedAt,_that.evidenceCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookingId,  String openedBy,  String reason,  String? description,  String status,  String? resolution,  String? resolutionNote,  String? resolvedBy,  DateTime? resolvedAt,  int evidenceCount,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DisputeRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.openedBy,_that.reason,_that.description,_that.status,_that.resolution,_that.resolutionNote,_that.resolvedBy,_that.resolvedAt,_that.evidenceCount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _DisputeRecord extends DisputeRecord {
  const _DisputeRecord({required this.id, required this.bookingId, required this.openedBy, required this.reason, required this.description, required this.status, required this.resolution, required this.resolutionNote, required this.resolvedBy, required this.resolvedAt, required this.evidenceCount, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String bookingId;
@override final  String openedBy;
@override final  String reason;
@override final  String? description;
@override final  String status;
@override final  String? resolution;
@override final  String? resolutionNote;
@override final  String? resolvedBy;
@override final  DateTime? resolvedAt;
@override final  int evidenceCount;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of DisputeRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeRecordCopyWith<_DisputeRecord> get copyWith => __$DisputeRecordCopyWithImpl<_DisputeRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.openedBy, openedBy) || other.openedBy == openedBy)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote)&&(identical(other.resolvedBy, resolvedBy) || other.resolvedBy == resolvedBy)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.evidenceCount, evidenceCount) || other.evidenceCount == evidenceCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,openedBy,reason,description,status,resolution,resolutionNote,resolvedBy,resolvedAt,evidenceCount,createdAt,updatedAt);

@override
String toString() {
  return 'DisputeRecord(id: $id, bookingId: $bookingId, openedBy: $openedBy, reason: $reason, description: $description, status: $status, resolution: $resolution, resolutionNote: $resolutionNote, resolvedBy: $resolvedBy, resolvedAt: $resolvedAt, evidenceCount: $evidenceCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DisputeRecordCopyWith<$Res> implements $DisputeRecordCopyWith<$Res> {
  factory _$DisputeRecordCopyWith(_DisputeRecord value, $Res Function(_DisputeRecord) _then) = __$DisputeRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookingId, String openedBy, String reason, String? description, String status, String? resolution, String? resolutionNote, String? resolvedBy, DateTime? resolvedAt, int evidenceCount, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$DisputeRecordCopyWithImpl<$Res>
    implements _$DisputeRecordCopyWith<$Res> {
  __$DisputeRecordCopyWithImpl(this._self, this._then);

  final _DisputeRecord _self;
  final $Res Function(_DisputeRecord) _then;

/// Create a copy of DisputeRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? openedBy = null,Object? reason = null,Object? description = freezed,Object? status = null,Object? resolution = freezed,Object? resolutionNote = freezed,Object? resolvedBy = freezed,Object? resolvedAt = freezed,Object? evidenceCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DisputeRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,openedBy: null == openedBy ? _self.openedBy : openedBy // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,resolvedBy: freezed == resolvedBy ? _self.resolvedBy : resolvedBy // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,evidenceCount: null == evidenceCount ? _self.evidenceCount : evidenceCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$DisputeEvidenceRecord {

 String get id; String get disputeId; String get storagePath; String? get note; String? get contentType; int? get byteSize; String? get uploadedBy; DateTime? get createdAt;
/// Create a copy of DisputeEvidenceRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeEvidenceRecordCopyWith<DisputeEvidenceRecord> get copyWith => _$DisputeEvidenceRecordCopyWithImpl<DisputeEvidenceRecord>(this as DisputeEvidenceRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeEvidenceRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.note, note) || other.note == note)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,disputeId,storagePath,note,contentType,byteSize,uploadedBy,createdAt);

@override
String toString() {
  return 'DisputeEvidenceRecord(id: $id, disputeId: $disputeId, storagePath: $storagePath, note: $note, contentType: $contentType, byteSize: $byteSize, uploadedBy: $uploadedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DisputeEvidenceRecordCopyWith<$Res>  {
  factory $DisputeEvidenceRecordCopyWith(DisputeEvidenceRecord value, $Res Function(DisputeEvidenceRecord) _then) = _$DisputeEvidenceRecordCopyWithImpl;
@useResult
$Res call({
 String id, String disputeId, String storagePath, String? note, String? contentType, int? byteSize, String? uploadedBy, DateTime? createdAt
});




}
/// @nodoc
class _$DisputeEvidenceRecordCopyWithImpl<$Res>
    implements $DisputeEvidenceRecordCopyWith<$Res> {
  _$DisputeEvidenceRecordCopyWithImpl(this._self, this._then);

  final DisputeEvidenceRecord _self;
  final $Res Function(DisputeEvidenceRecord) _then;

/// Create a copy of DisputeEvidenceRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? disputeId = null,Object? storagePath = null,Object? note = freezed,Object? contentType = freezed,Object? byteSize = freezed,Object? uploadedBy = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,byteSize: freezed == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int?,uploadedBy: freezed == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DisputeEvidenceRecord].
extension DisputeEvidenceRecordPatterns on DisputeEvidenceRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisputeEvidenceRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisputeEvidenceRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisputeEvidenceRecord value)  $default,){
final _that = this;
switch (_that) {
case _DisputeEvidenceRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisputeEvidenceRecord value)?  $default,){
final _that = this;
switch (_that) {
case _DisputeEvidenceRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String disputeId,  String storagePath,  String? note,  String? contentType,  int? byteSize,  String? uploadedBy,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisputeEvidenceRecord() when $default != null:
return $default(_that.id,_that.disputeId,_that.storagePath,_that.note,_that.contentType,_that.byteSize,_that.uploadedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String disputeId,  String storagePath,  String? note,  String? contentType,  int? byteSize,  String? uploadedBy,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DisputeEvidenceRecord():
return $default(_that.id,_that.disputeId,_that.storagePath,_that.note,_that.contentType,_that.byteSize,_that.uploadedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String disputeId,  String storagePath,  String? note,  String? contentType,  int? byteSize,  String? uploadedBy,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DisputeEvidenceRecord() when $default != null:
return $default(_that.id,_that.disputeId,_that.storagePath,_that.note,_that.contentType,_that.byteSize,_that.uploadedBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _DisputeEvidenceRecord extends DisputeEvidenceRecord {
  const _DisputeEvidenceRecord({required this.id, required this.disputeId, required this.storagePath, required this.note, required this.contentType, required this.byteSize, required this.uploadedBy, required this.createdAt}): super._();
  

@override final  String id;
@override final  String disputeId;
@override final  String storagePath;
@override final  String? note;
@override final  String? contentType;
@override final  int? byteSize;
@override final  String? uploadedBy;
@override final  DateTime? createdAt;

/// Create a copy of DisputeEvidenceRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeEvidenceRecordCopyWith<_DisputeEvidenceRecord> get copyWith => __$DisputeEvidenceRecordCopyWithImpl<_DisputeEvidenceRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeEvidenceRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.note, note) || other.note == note)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,disputeId,storagePath,note,contentType,byteSize,uploadedBy,createdAt);

@override
String toString() {
  return 'DisputeEvidenceRecord(id: $id, disputeId: $disputeId, storagePath: $storagePath, note: $note, contentType: $contentType, byteSize: $byteSize, uploadedBy: $uploadedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DisputeEvidenceRecordCopyWith<$Res> implements $DisputeEvidenceRecordCopyWith<$Res> {
  factory _$DisputeEvidenceRecordCopyWith(_DisputeEvidenceRecord value, $Res Function(_DisputeEvidenceRecord) _then) = __$DisputeEvidenceRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String disputeId, String storagePath, String? note, String? contentType, int? byteSize, String? uploadedBy, DateTime? createdAt
});




}
/// @nodoc
class __$DisputeEvidenceRecordCopyWithImpl<$Res>
    implements _$DisputeEvidenceRecordCopyWith<$Res> {
  __$DisputeEvidenceRecordCopyWithImpl(this._self, this._then);

  final _DisputeEvidenceRecord _self;
  final $Res Function(_DisputeEvidenceRecord) _then;

/// Create a copy of DisputeEvidenceRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? disputeId = null,Object? storagePath = null,Object? note = freezed,Object? contentType = freezed,Object? byteSize = freezed,Object? uploadedBy = freezed,Object? createdAt = freezed,}) {
  return _then(_DisputeEvidenceRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,disputeId: null == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,byteSize: freezed == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int?,uploadedBy: freezed == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$RefundRecord {

 String get id; String get bookingId; String? get disputeId; double get amountDzd; String get status; String get reason; String? get externalReference; String? get processedBy; DateTime? get processedAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of RefundRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundRecordCopyWith<RefundRecord> get copyWith => _$RefundRecordCopyWithImpl<RefundRecord>(this as RefundRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.amountDzd, amountDzd) || other.amountDzd == amountDzd)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.processedBy, processedBy) || other.processedBy == processedBy)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,disputeId,amountDzd,status,reason,externalReference,processedBy,processedAt,createdAt,updatedAt);

@override
String toString() {
  return 'RefundRecord(id: $id, bookingId: $bookingId, disputeId: $disputeId, amountDzd: $amountDzd, status: $status, reason: $reason, externalReference: $externalReference, processedBy: $processedBy, processedAt: $processedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RefundRecordCopyWith<$Res>  {
  factory $RefundRecordCopyWith(RefundRecord value, $Res Function(RefundRecord) _then) = _$RefundRecordCopyWithImpl;
@useResult
$Res call({
 String id, String bookingId, String? disputeId, double amountDzd, String status, String reason, String? externalReference, String? processedBy, DateTime? processedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$RefundRecordCopyWithImpl<$Res>
    implements $RefundRecordCopyWith<$Res> {
  _$RefundRecordCopyWithImpl(this._self, this._then);

  final RefundRecord _self;
  final $Res Function(RefundRecord) _then;

/// Create a copy of RefundRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? disputeId = freezed,Object? amountDzd = null,Object? status = null,Object? reason = null,Object? externalReference = freezed,Object? processedBy = freezed,Object? processedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,disputeId: freezed == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String?,amountDzd: null == amountDzd ? _self.amountDzd : amountDzd // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,processedBy: freezed == processedBy ? _self.processedBy : processedBy // ignore: cast_nullable_to_non_nullable
as String?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RefundRecord].
extension RefundRecordPatterns on RefundRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefundRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefundRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefundRecord value)  $default,){
final _that = this;
switch (_that) {
case _RefundRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefundRecord value)?  $default,){
final _that = this;
switch (_that) {
case _RefundRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookingId,  String? disputeId,  double amountDzd,  String status,  String reason,  String? externalReference,  String? processedBy,  DateTime? processedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefundRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.disputeId,_that.amountDzd,_that.status,_that.reason,_that.externalReference,_that.processedBy,_that.processedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookingId,  String? disputeId,  double amountDzd,  String status,  String reason,  String? externalReference,  String? processedBy,  DateTime? processedAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RefundRecord():
return $default(_that.id,_that.bookingId,_that.disputeId,_that.amountDzd,_that.status,_that.reason,_that.externalReference,_that.processedBy,_that.processedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookingId,  String? disputeId,  double amountDzd,  String status,  String reason,  String? externalReference,  String? processedBy,  DateTime? processedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RefundRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.disputeId,_that.amountDzd,_that.status,_that.reason,_that.externalReference,_that.processedBy,_that.processedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _RefundRecord extends RefundRecord {
  const _RefundRecord({required this.id, required this.bookingId, required this.disputeId, required this.amountDzd, required this.status, required this.reason, required this.externalReference, required this.processedBy, required this.processedAt, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String bookingId;
@override final  String? disputeId;
@override final  double amountDzd;
@override final  String status;
@override final  String reason;
@override final  String? externalReference;
@override final  String? processedBy;
@override final  DateTime? processedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of RefundRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundRecordCopyWith<_RefundRecord> get copyWith => __$RefundRecordCopyWithImpl<_RefundRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.amountDzd, amountDzd) || other.amountDzd == amountDzd)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.processedBy, processedBy) || other.processedBy == processedBy)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,disputeId,amountDzd,status,reason,externalReference,processedBy,processedAt,createdAt,updatedAt);

@override
String toString() {
  return 'RefundRecord(id: $id, bookingId: $bookingId, disputeId: $disputeId, amountDzd: $amountDzd, status: $status, reason: $reason, externalReference: $externalReference, processedBy: $processedBy, processedAt: $processedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RefundRecordCopyWith<$Res> implements $RefundRecordCopyWith<$Res> {
  factory _$RefundRecordCopyWith(_RefundRecord value, $Res Function(_RefundRecord) _then) = __$RefundRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookingId, String? disputeId, double amountDzd, String status, String reason, String? externalReference, String? processedBy, DateTime? processedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$RefundRecordCopyWithImpl<$Res>
    implements _$RefundRecordCopyWith<$Res> {
  __$RefundRecordCopyWithImpl(this._self, this._then);

  final _RefundRecord _self;
  final $Res Function(_RefundRecord) _then;

/// Create a copy of RefundRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? disputeId = freezed,Object? amountDzd = null,Object? status = null,Object? reason = null,Object? externalReference = freezed,Object? processedBy = freezed,Object? processedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_RefundRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,disputeId: freezed == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String?,amountDzd: null == amountDzd ? _self.amountDzd : amountDzd // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,processedBy: freezed == processedBy ? _self.processedBy : processedBy // ignore: cast_nullable_to_non_nullable
as String?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$PayoutRecord {

 String get id; String get bookingId; String get carrierId; String get payoutAccountId; Map<String, dynamic> get payoutAccountSnapshot; double get amountDzd; String get status; String? get externalReference; String? get processedBy; DateTime? get processedAt; String? get failureReason; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of PayoutRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutRecordCopyWith<PayoutRecord> get copyWith => _$PayoutRecordCopyWithImpl<PayoutRecord>(this as PayoutRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.payoutAccountId, payoutAccountId) || other.payoutAccountId == payoutAccountId)&&const DeepCollectionEquality().equals(other.payoutAccountSnapshot, payoutAccountSnapshot)&&(identical(other.amountDzd, amountDzd) || other.amountDzd == amountDzd)&&(identical(other.status, status) || other.status == status)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.processedBy, processedBy) || other.processedBy == processedBy)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,carrierId,payoutAccountId,const DeepCollectionEquality().hash(payoutAccountSnapshot),amountDzd,status,externalReference,processedBy,processedAt,failureReason,createdAt,updatedAt);

@override
String toString() {
  return 'PayoutRecord(id: $id, bookingId: $bookingId, carrierId: $carrierId, payoutAccountId: $payoutAccountId, payoutAccountSnapshot: $payoutAccountSnapshot, amountDzd: $amountDzd, status: $status, externalReference: $externalReference, processedBy: $processedBy, processedAt: $processedAt, failureReason: $failureReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PayoutRecordCopyWith<$Res>  {
  factory $PayoutRecordCopyWith(PayoutRecord value, $Res Function(PayoutRecord) _then) = _$PayoutRecordCopyWithImpl;
@useResult
$Res call({
 String id, String bookingId, String carrierId, String payoutAccountId, Map<String, dynamic> payoutAccountSnapshot, double amountDzd, String status, String? externalReference, String? processedBy, DateTime? processedAt, String? failureReason, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PayoutRecordCopyWithImpl<$Res>
    implements $PayoutRecordCopyWith<$Res> {
  _$PayoutRecordCopyWithImpl(this._self, this._then);

  final PayoutRecord _self;
  final $Res Function(PayoutRecord) _then;

/// Create a copy of PayoutRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? carrierId = null,Object? payoutAccountId = null,Object? payoutAccountSnapshot = null,Object? amountDzd = null,Object? status = null,Object? externalReference = freezed,Object? processedBy = freezed,Object? processedAt = freezed,Object? failureReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,payoutAccountId: null == payoutAccountId ? _self.payoutAccountId : payoutAccountId // ignore: cast_nullable_to_non_nullable
as String,payoutAccountSnapshot: null == payoutAccountSnapshot ? _self.payoutAccountSnapshot : payoutAccountSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,amountDzd: null == amountDzd ? _self.amountDzd : amountDzd // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,processedBy: freezed == processedBy ? _self.processedBy : processedBy // ignore: cast_nullable_to_non_nullable
as String?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PayoutRecord].
extension PayoutRecordPatterns on PayoutRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayoutRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayoutRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayoutRecord value)  $default,){
final _that = this;
switch (_that) {
case _PayoutRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayoutRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PayoutRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookingId,  String carrierId,  String payoutAccountId,  Map<String, dynamic> payoutAccountSnapshot,  double amountDzd,  String status,  String? externalReference,  String? processedBy,  DateTime? processedAt,  String? failureReason,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayoutRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.carrierId,_that.payoutAccountId,_that.payoutAccountSnapshot,_that.amountDzd,_that.status,_that.externalReference,_that.processedBy,_that.processedAt,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookingId,  String carrierId,  String payoutAccountId,  Map<String, dynamic> payoutAccountSnapshot,  double amountDzd,  String status,  String? externalReference,  String? processedBy,  DateTime? processedAt,  String? failureReason,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PayoutRecord():
return $default(_that.id,_that.bookingId,_that.carrierId,_that.payoutAccountId,_that.payoutAccountSnapshot,_that.amountDzd,_that.status,_that.externalReference,_that.processedBy,_that.processedAt,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookingId,  String carrierId,  String payoutAccountId,  Map<String, dynamic> payoutAccountSnapshot,  double amountDzd,  String status,  String? externalReference,  String? processedBy,  DateTime? processedAt,  String? failureReason,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PayoutRecord() when $default != null:
return $default(_that.id,_that.bookingId,_that.carrierId,_that.payoutAccountId,_that.payoutAccountSnapshot,_that.amountDzd,_that.status,_that.externalReference,_that.processedBy,_that.processedAt,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PayoutRecord extends PayoutRecord {
  const _PayoutRecord({required this.id, required this.bookingId, required this.carrierId, required this.payoutAccountId, required final  Map<String, dynamic> payoutAccountSnapshot, required this.amountDzd, required this.status, required this.externalReference, required this.processedBy, required this.processedAt, required this.failureReason, required this.createdAt, required this.updatedAt}): _payoutAccountSnapshot = payoutAccountSnapshot,super._();
  

@override final  String id;
@override final  String bookingId;
@override final  String carrierId;
@override final  String payoutAccountId;
 final  Map<String, dynamic> _payoutAccountSnapshot;
@override Map<String, dynamic> get payoutAccountSnapshot {
  if (_payoutAccountSnapshot is EqualUnmodifiableMapView) return _payoutAccountSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payoutAccountSnapshot);
}

@override final  double amountDzd;
@override final  String status;
@override final  String? externalReference;
@override final  String? processedBy;
@override final  DateTime? processedAt;
@override final  String? failureReason;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of PayoutRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutRecordCopyWith<_PayoutRecord> get copyWith => __$PayoutRecordCopyWithImpl<_PayoutRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.payoutAccountId, payoutAccountId) || other.payoutAccountId == payoutAccountId)&&const DeepCollectionEquality().equals(other._payoutAccountSnapshot, _payoutAccountSnapshot)&&(identical(other.amountDzd, amountDzd) || other.amountDzd == amountDzd)&&(identical(other.status, status) || other.status == status)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.processedBy, processedBy) || other.processedBy == processedBy)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,carrierId,payoutAccountId,const DeepCollectionEquality().hash(_payoutAccountSnapshot),amountDzd,status,externalReference,processedBy,processedAt,failureReason,createdAt,updatedAt);

@override
String toString() {
  return 'PayoutRecord(id: $id, bookingId: $bookingId, carrierId: $carrierId, payoutAccountId: $payoutAccountId, payoutAccountSnapshot: $payoutAccountSnapshot, amountDzd: $amountDzd, status: $status, externalReference: $externalReference, processedBy: $processedBy, processedAt: $processedAt, failureReason: $failureReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PayoutRecordCopyWith<$Res> implements $PayoutRecordCopyWith<$Res> {
  factory _$PayoutRecordCopyWith(_PayoutRecord value, $Res Function(_PayoutRecord) _then) = __$PayoutRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookingId, String carrierId, String payoutAccountId, Map<String, dynamic> payoutAccountSnapshot, double amountDzd, String status, String? externalReference, String? processedBy, DateTime? processedAt, String? failureReason, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PayoutRecordCopyWithImpl<$Res>
    implements _$PayoutRecordCopyWith<$Res> {
  __$PayoutRecordCopyWithImpl(this._self, this._then);

  final _PayoutRecord _self;
  final $Res Function(_PayoutRecord) _then;

/// Create a copy of PayoutRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? carrierId = null,Object? payoutAccountId = null,Object? payoutAccountSnapshot = null,Object? amountDzd = null,Object? status = null,Object? externalReference = freezed,Object? processedBy = freezed,Object? processedAt = freezed,Object? failureReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_PayoutRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,payoutAccountId: null == payoutAccountId ? _self.payoutAccountId : payoutAccountId // ignore: cast_nullable_to_non_nullable
as String,payoutAccountSnapshot: null == payoutAccountSnapshot ? _self._payoutAccountSnapshot : payoutAccountSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,amountDzd: null == amountDzd ? _self.amountDzd : amountDzd // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,processedBy: freezed == processedBy ? _self.processedBy : processedBy // ignore: cast_nullable_to_non_nullable
as String?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
