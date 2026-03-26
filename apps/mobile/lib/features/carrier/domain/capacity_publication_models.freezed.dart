// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capacity_publication_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CarrierRoute {

 String get id; String get carrierId; String get vehicleId; int get originCommuneId; int get destinationCommuneId; double get totalCapacityKg; double? get totalCapacityVolumeM3; double get pricePerKgDzd; String get defaultDepartureTime; List<int> get recurringDaysOfWeek; DateTime get effectiveFrom; bool get isActive; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CarrierRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarrierRouteCopyWith<CarrierRoute> get copyWith => _$CarrierRouteCopyWithImpl<CarrierRoute>(this as CarrierRoute, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarrierRoute&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.defaultDepartureTime, defaultDepartureTime) || other.defaultDepartureTime == defaultDepartureTime)&&const DeepCollectionEquality().equals(other.recurringDaysOfWeek, recurringDaysOfWeek)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,vehicleId,originCommuneId,destinationCommuneId,totalCapacityKg,totalCapacityVolumeM3,pricePerKgDzd,defaultDepartureTime,const DeepCollectionEquality().hash(recurringDaysOfWeek),effectiveFrom,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierRoute(id: $id, carrierId: $carrierId, vehicleId: $vehicleId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, pricePerKgDzd: $pricePerKgDzd, defaultDepartureTime: $defaultDepartureTime, recurringDaysOfWeek: $recurringDaysOfWeek, effectiveFrom: $effectiveFrom, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CarrierRouteCopyWith<$Res>  {
  factory $CarrierRouteCopyWith(CarrierRoute value, $Res Function(CarrierRoute) _then) = _$CarrierRouteCopyWithImpl;
@useResult
$Res call({
 String id, String carrierId, String vehicleId, int originCommuneId, int destinationCommuneId, double totalCapacityKg, double? totalCapacityVolumeM3, double pricePerKgDzd, String defaultDepartureTime, List<int> recurringDaysOfWeek, DateTime effectiveFrom, bool isActive, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CarrierRouteCopyWithImpl<$Res>
    implements $CarrierRouteCopyWith<$Res> {
  _$CarrierRouteCopyWithImpl(this._self, this._then);

  final CarrierRoute _self;
  final $Res Function(CarrierRoute) _then;

/// Create a copy of CarrierRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? carrierId = null,Object? vehicleId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? defaultDepartureTime = null,Object? recurringDaysOfWeek = null,Object? effectiveFrom = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,defaultDepartureTime: null == defaultDepartureTime ? _self.defaultDepartureTime : defaultDepartureTime // ignore: cast_nullable_to_non_nullable
as String,recurringDaysOfWeek: null == recurringDaysOfWeek ? _self.recurringDaysOfWeek : recurringDaysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,effectiveFrom: null == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CarrierRoute].
extension CarrierRoutePatterns on CarrierRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarrierRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarrierRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarrierRoute value)  $default,){
final _that = this;
switch (_that) {
case _CarrierRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarrierRoute value)?  $default,){
final _that = this;
switch (_that) {
case _CarrierRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String carrierId,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  String defaultDepartureTime,  List<int> recurringDaysOfWeek,  DateTime effectiveFrom,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarrierRoute() when $default != null:
return $default(_that.id,_that.carrierId,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.defaultDepartureTime,_that.recurringDaysOfWeek,_that.effectiveFrom,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String carrierId,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  String defaultDepartureTime,  List<int> recurringDaysOfWeek,  DateTime effectiveFrom,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CarrierRoute():
return $default(_that.id,_that.carrierId,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.defaultDepartureTime,_that.recurringDaysOfWeek,_that.effectiveFrom,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String carrierId,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  String defaultDepartureTime,  List<int> recurringDaysOfWeek,  DateTime effectiveFrom,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CarrierRoute() when $default != null:
return $default(_that.id,_that.carrierId,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.defaultDepartureTime,_that.recurringDaysOfWeek,_that.effectiveFrom,_that.isActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CarrierRoute extends CarrierRoute {
  const _CarrierRoute({required this.id, required this.carrierId, required this.vehicleId, required this.originCommuneId, required this.destinationCommuneId, required this.totalCapacityKg, required this.totalCapacityVolumeM3, required this.pricePerKgDzd, required this.defaultDepartureTime, required final  List<int> recurringDaysOfWeek, required this.effectiveFrom, required this.isActive, required this.createdAt, required this.updatedAt}): _recurringDaysOfWeek = recurringDaysOfWeek,super._();
  

@override final  String id;
@override final  String carrierId;
@override final  String vehicleId;
@override final  int originCommuneId;
@override final  int destinationCommuneId;
@override final  double totalCapacityKg;
@override final  double? totalCapacityVolumeM3;
@override final  double pricePerKgDzd;
@override final  String defaultDepartureTime;
 final  List<int> _recurringDaysOfWeek;
@override List<int> get recurringDaysOfWeek {
  if (_recurringDaysOfWeek is EqualUnmodifiableListView) return _recurringDaysOfWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recurringDaysOfWeek);
}

@override final  DateTime effectiveFrom;
@override final  bool isActive;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CarrierRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarrierRouteCopyWith<_CarrierRoute> get copyWith => __$CarrierRouteCopyWithImpl<_CarrierRoute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarrierRoute&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.defaultDepartureTime, defaultDepartureTime) || other.defaultDepartureTime == defaultDepartureTime)&&const DeepCollectionEquality().equals(other._recurringDaysOfWeek, _recurringDaysOfWeek)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,vehicleId,originCommuneId,destinationCommuneId,totalCapacityKg,totalCapacityVolumeM3,pricePerKgDzd,defaultDepartureTime,const DeepCollectionEquality().hash(_recurringDaysOfWeek),effectiveFrom,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierRoute(id: $id, carrierId: $carrierId, vehicleId: $vehicleId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, pricePerKgDzd: $pricePerKgDzd, defaultDepartureTime: $defaultDepartureTime, recurringDaysOfWeek: $recurringDaysOfWeek, effectiveFrom: $effectiveFrom, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CarrierRouteCopyWith<$Res> implements $CarrierRouteCopyWith<$Res> {
  factory _$CarrierRouteCopyWith(_CarrierRoute value, $Res Function(_CarrierRoute) _then) = __$CarrierRouteCopyWithImpl;
@override @useResult
$Res call({
 String id, String carrierId, String vehicleId, int originCommuneId, int destinationCommuneId, double totalCapacityKg, double? totalCapacityVolumeM3, double pricePerKgDzd, String defaultDepartureTime, List<int> recurringDaysOfWeek, DateTime effectiveFrom, bool isActive, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CarrierRouteCopyWithImpl<$Res>
    implements _$CarrierRouteCopyWith<$Res> {
  __$CarrierRouteCopyWithImpl(this._self, this._then);

  final _CarrierRoute _self;
  final $Res Function(_CarrierRoute) _then;

/// Create a copy of CarrierRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? carrierId = null,Object? vehicleId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? defaultDepartureTime = null,Object? recurringDaysOfWeek = null,Object? effectiveFrom = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CarrierRoute(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,defaultDepartureTime: null == defaultDepartureTime ? _self.defaultDepartureTime : defaultDepartureTime // ignore: cast_nullable_to_non_nullable
as String,recurringDaysOfWeek: null == recurringDaysOfWeek ? _self._recurringDaysOfWeek : recurringDaysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,effectiveFrom: null == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$CarrierOneOffTrip {

 String get id; String get carrierId; String get vehicleId; int get originCommuneId; int get destinationCommuneId; DateTime get departureAt; double get totalCapacityKg; double? get totalCapacityVolumeM3; double get pricePerKgDzd; bool get isActive; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CarrierOneOffTrip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarrierOneOffTripCopyWith<CarrierOneOffTrip> get copyWith => _$CarrierOneOffTripCopyWithImpl<CarrierOneOffTrip>(this as CarrierOneOffTrip, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarrierOneOffTrip&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.departureAt, departureAt) || other.departureAt == departureAt)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,vehicleId,originCommuneId,destinationCommuneId,departureAt,totalCapacityKg,totalCapacityVolumeM3,pricePerKgDzd,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierOneOffTrip(id: $id, carrierId: $carrierId, vehicleId: $vehicleId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, departureAt: $departureAt, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, pricePerKgDzd: $pricePerKgDzd, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CarrierOneOffTripCopyWith<$Res>  {
  factory $CarrierOneOffTripCopyWith(CarrierOneOffTrip value, $Res Function(CarrierOneOffTrip) _then) = _$CarrierOneOffTripCopyWithImpl;
@useResult
$Res call({
 String id, String carrierId, String vehicleId, int originCommuneId, int destinationCommuneId, DateTime departureAt, double totalCapacityKg, double? totalCapacityVolumeM3, double pricePerKgDzd, bool isActive, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CarrierOneOffTripCopyWithImpl<$Res>
    implements $CarrierOneOffTripCopyWith<$Res> {
  _$CarrierOneOffTripCopyWithImpl(this._self, this._then);

  final CarrierOneOffTrip _self;
  final $Res Function(CarrierOneOffTrip) _then;

/// Create a copy of CarrierOneOffTrip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? carrierId = null,Object? vehicleId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? departureAt = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,departureAt: null == departureAt ? _self.departureAt : departureAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CarrierOneOffTrip].
extension CarrierOneOffTripPatterns on CarrierOneOffTrip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarrierOneOffTrip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarrierOneOffTrip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarrierOneOffTrip value)  $default,){
final _that = this;
switch (_that) {
case _CarrierOneOffTrip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarrierOneOffTrip value)?  $default,){
final _that = this;
switch (_that) {
case _CarrierOneOffTrip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String carrierId,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  DateTime departureAt,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarrierOneOffTrip() when $default != null:
return $default(_that.id,_that.carrierId,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.departureAt,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String carrierId,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  DateTime departureAt,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CarrierOneOffTrip():
return $default(_that.id,_that.carrierId,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.departureAt,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String carrierId,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  DateTime departureAt,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  bool isActive,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CarrierOneOffTrip() when $default != null:
return $default(_that.id,_that.carrierId,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.departureAt,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.isActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CarrierOneOffTrip extends CarrierOneOffTrip {
  const _CarrierOneOffTrip({required this.id, required this.carrierId, required this.vehicleId, required this.originCommuneId, required this.destinationCommuneId, required this.departureAt, required this.totalCapacityKg, required this.totalCapacityVolumeM3, required this.pricePerKgDzd, required this.isActive, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String carrierId;
@override final  String vehicleId;
@override final  int originCommuneId;
@override final  int destinationCommuneId;
@override final  DateTime departureAt;
@override final  double totalCapacityKg;
@override final  double? totalCapacityVolumeM3;
@override final  double pricePerKgDzd;
@override final  bool isActive;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CarrierOneOffTrip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarrierOneOffTripCopyWith<_CarrierOneOffTrip> get copyWith => __$CarrierOneOffTripCopyWithImpl<_CarrierOneOffTrip>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarrierOneOffTrip&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.departureAt, departureAt) || other.departureAt == departureAt)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,vehicleId,originCommuneId,destinationCommuneId,departureAt,totalCapacityKg,totalCapacityVolumeM3,pricePerKgDzd,isActive,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierOneOffTrip(id: $id, carrierId: $carrierId, vehicleId: $vehicleId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, departureAt: $departureAt, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, pricePerKgDzd: $pricePerKgDzd, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CarrierOneOffTripCopyWith<$Res> implements $CarrierOneOffTripCopyWith<$Res> {
  factory _$CarrierOneOffTripCopyWith(_CarrierOneOffTrip value, $Res Function(_CarrierOneOffTrip) _then) = __$CarrierOneOffTripCopyWithImpl;
@override @useResult
$Res call({
 String id, String carrierId, String vehicleId, int originCommuneId, int destinationCommuneId, DateTime departureAt, double totalCapacityKg, double? totalCapacityVolumeM3, double pricePerKgDzd, bool isActive, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CarrierOneOffTripCopyWithImpl<$Res>
    implements _$CarrierOneOffTripCopyWith<$Res> {
  __$CarrierOneOffTripCopyWithImpl(this._self, this._then);

  final _CarrierOneOffTrip _self;
  final $Res Function(_CarrierOneOffTrip) _then;

/// Create a copy of CarrierOneOffTrip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? carrierId = null,Object? vehicleId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? departureAt = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CarrierOneOffTrip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,departureAt: null == departureAt ? _self.departureAt : departureAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$RouteRevisionRecord {

 String get id; String get routeId; String get vehicleId; double get totalCapacityKg; double? get totalCapacityVolumeM3; double get pricePerKgDzd; String get defaultDepartureTime; List<int> get recurringDaysOfWeek; DateTime get effectiveFrom; String? get createdBy; DateTime? get createdAt;
/// Create a copy of RouteRevisionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteRevisionRecordCopyWith<RouteRevisionRecord> get copyWith => _$RouteRevisionRecordCopyWithImpl<RouteRevisionRecord>(this as RouteRevisionRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteRevisionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.defaultDepartureTime, defaultDepartureTime) || other.defaultDepartureTime == defaultDepartureTime)&&const DeepCollectionEquality().equals(other.recurringDaysOfWeek, recurringDaysOfWeek)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,routeId,vehicleId,totalCapacityKg,totalCapacityVolumeM3,pricePerKgDzd,defaultDepartureTime,const DeepCollectionEquality().hash(recurringDaysOfWeek),effectiveFrom,createdBy,createdAt);

@override
String toString() {
  return 'RouteRevisionRecord(id: $id, routeId: $routeId, vehicleId: $vehicleId, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, pricePerKgDzd: $pricePerKgDzd, defaultDepartureTime: $defaultDepartureTime, recurringDaysOfWeek: $recurringDaysOfWeek, effectiveFrom: $effectiveFrom, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RouteRevisionRecordCopyWith<$Res>  {
  factory $RouteRevisionRecordCopyWith(RouteRevisionRecord value, $Res Function(RouteRevisionRecord) _then) = _$RouteRevisionRecordCopyWithImpl;
@useResult
$Res call({
 String id, String routeId, String vehicleId, double totalCapacityKg, double? totalCapacityVolumeM3, double pricePerKgDzd, String defaultDepartureTime, List<int> recurringDaysOfWeek, DateTime effectiveFrom, String? createdBy, DateTime? createdAt
});




}
/// @nodoc
class _$RouteRevisionRecordCopyWithImpl<$Res>
    implements $RouteRevisionRecordCopyWith<$Res> {
  _$RouteRevisionRecordCopyWithImpl(this._self, this._then);

  final RouteRevisionRecord _self;
  final $Res Function(RouteRevisionRecord) _then;

/// Create a copy of RouteRevisionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routeId = null,Object? vehicleId = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? defaultDepartureTime = null,Object? recurringDaysOfWeek = null,Object? effectiveFrom = null,Object? createdBy = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,defaultDepartureTime: null == defaultDepartureTime ? _self.defaultDepartureTime : defaultDepartureTime // ignore: cast_nullable_to_non_nullable
as String,recurringDaysOfWeek: null == recurringDaysOfWeek ? _self.recurringDaysOfWeek : recurringDaysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,effectiveFrom: null == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteRevisionRecord].
extension RouteRevisionRecordPatterns on RouteRevisionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteRevisionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteRevisionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteRevisionRecord value)  $default,){
final _that = this;
switch (_that) {
case _RouteRevisionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteRevisionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _RouteRevisionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String routeId,  String vehicleId,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  String defaultDepartureTime,  List<int> recurringDaysOfWeek,  DateTime effectiveFrom,  String? createdBy,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteRevisionRecord() when $default != null:
return $default(_that.id,_that.routeId,_that.vehicleId,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.defaultDepartureTime,_that.recurringDaysOfWeek,_that.effectiveFrom,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String routeId,  String vehicleId,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  String defaultDepartureTime,  List<int> recurringDaysOfWeek,  DateTime effectiveFrom,  String? createdBy,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _RouteRevisionRecord():
return $default(_that.id,_that.routeId,_that.vehicleId,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.defaultDepartureTime,_that.recurringDaysOfWeek,_that.effectiveFrom,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String routeId,  String vehicleId,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double pricePerKgDzd,  String defaultDepartureTime,  List<int> recurringDaysOfWeek,  DateTime effectiveFrom,  String? createdBy,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RouteRevisionRecord() when $default != null:
return $default(_that.id,_that.routeId,_that.vehicleId,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.pricePerKgDzd,_that.defaultDepartureTime,_that.recurringDaysOfWeek,_that.effectiveFrom,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _RouteRevisionRecord extends RouteRevisionRecord {
  const _RouteRevisionRecord({required this.id, required this.routeId, required this.vehicleId, required this.totalCapacityKg, required this.totalCapacityVolumeM3, required this.pricePerKgDzd, required this.defaultDepartureTime, required final  List<int> recurringDaysOfWeek, required this.effectiveFrom, required this.createdBy, required this.createdAt}): _recurringDaysOfWeek = recurringDaysOfWeek,super._();
  

@override final  String id;
@override final  String routeId;
@override final  String vehicleId;
@override final  double totalCapacityKg;
@override final  double? totalCapacityVolumeM3;
@override final  double pricePerKgDzd;
@override final  String defaultDepartureTime;
 final  List<int> _recurringDaysOfWeek;
@override List<int> get recurringDaysOfWeek {
  if (_recurringDaysOfWeek is EqualUnmodifiableListView) return _recurringDaysOfWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recurringDaysOfWeek);
}

@override final  DateTime effectiveFrom;
@override final  String? createdBy;
@override final  DateTime? createdAt;

/// Create a copy of RouteRevisionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteRevisionRecordCopyWith<_RouteRevisionRecord> get copyWith => __$RouteRevisionRecordCopyWithImpl<_RouteRevisionRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteRevisionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.defaultDepartureTime, defaultDepartureTime) || other.defaultDepartureTime == defaultDepartureTime)&&const DeepCollectionEquality().equals(other._recurringDaysOfWeek, _recurringDaysOfWeek)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,routeId,vehicleId,totalCapacityKg,totalCapacityVolumeM3,pricePerKgDzd,defaultDepartureTime,const DeepCollectionEquality().hash(_recurringDaysOfWeek),effectiveFrom,createdBy,createdAt);

@override
String toString() {
  return 'RouteRevisionRecord(id: $id, routeId: $routeId, vehicleId: $vehicleId, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, pricePerKgDzd: $pricePerKgDzd, defaultDepartureTime: $defaultDepartureTime, recurringDaysOfWeek: $recurringDaysOfWeek, effectiveFrom: $effectiveFrom, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RouteRevisionRecordCopyWith<$Res> implements $RouteRevisionRecordCopyWith<$Res> {
  factory _$RouteRevisionRecordCopyWith(_RouteRevisionRecord value, $Res Function(_RouteRevisionRecord) _then) = __$RouteRevisionRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String routeId, String vehicleId, double totalCapacityKg, double? totalCapacityVolumeM3, double pricePerKgDzd, String defaultDepartureTime, List<int> recurringDaysOfWeek, DateTime effectiveFrom, String? createdBy, DateTime? createdAt
});




}
/// @nodoc
class __$RouteRevisionRecordCopyWithImpl<$Res>
    implements _$RouteRevisionRecordCopyWith<$Res> {
  __$RouteRevisionRecordCopyWithImpl(this._self, this._then);

  final _RouteRevisionRecord _self;
  final $Res Function(_RouteRevisionRecord) _then;

/// Create a copy of RouteRevisionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routeId = null,Object? vehicleId = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? defaultDepartureTime = null,Object? recurringDaysOfWeek = null,Object? effectiveFrom = null,Object? createdBy = freezed,Object? createdAt = freezed,}) {
  return _then(_RouteRevisionRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,defaultDepartureTime: null == defaultDepartureTime ? _self.defaultDepartureTime : defaultDepartureTime // ignore: cast_nullable_to_non_nullable
as String,recurringDaysOfWeek: null == recurringDaysOfWeek ? _self._recurringDaysOfWeek : recurringDaysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,effectiveFrom: null == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$CapacityPublicationSummary {

 int get activeRecurringRouteCount; int get activeOneOffTripCount; int get upcomingDepartureCount; double get publishedCapacityKg; double get reservedCapacityKg;
/// Create a copy of CapacityPublicationSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapacityPublicationSummaryCopyWith<CapacityPublicationSummary> get copyWith => _$CapacityPublicationSummaryCopyWithImpl<CapacityPublicationSummary>(this as CapacityPublicationSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapacityPublicationSummary&&(identical(other.activeRecurringRouteCount, activeRecurringRouteCount) || other.activeRecurringRouteCount == activeRecurringRouteCount)&&(identical(other.activeOneOffTripCount, activeOneOffTripCount) || other.activeOneOffTripCount == activeOneOffTripCount)&&(identical(other.upcomingDepartureCount, upcomingDepartureCount) || other.upcomingDepartureCount == upcomingDepartureCount)&&(identical(other.publishedCapacityKg, publishedCapacityKg) || other.publishedCapacityKg == publishedCapacityKg)&&(identical(other.reservedCapacityKg, reservedCapacityKg) || other.reservedCapacityKg == reservedCapacityKg));
}


@override
int get hashCode => Object.hash(runtimeType,activeRecurringRouteCount,activeOneOffTripCount,upcomingDepartureCount,publishedCapacityKg,reservedCapacityKg);

@override
String toString() {
  return 'CapacityPublicationSummary(activeRecurringRouteCount: $activeRecurringRouteCount, activeOneOffTripCount: $activeOneOffTripCount, upcomingDepartureCount: $upcomingDepartureCount, publishedCapacityKg: $publishedCapacityKg, reservedCapacityKg: $reservedCapacityKg)';
}


}

/// @nodoc
abstract mixin class $CapacityPublicationSummaryCopyWith<$Res>  {
  factory $CapacityPublicationSummaryCopyWith(CapacityPublicationSummary value, $Res Function(CapacityPublicationSummary) _then) = _$CapacityPublicationSummaryCopyWithImpl;
@useResult
$Res call({
 int activeRecurringRouteCount, int activeOneOffTripCount, int upcomingDepartureCount, double publishedCapacityKg, double reservedCapacityKg
});




}
/// @nodoc
class _$CapacityPublicationSummaryCopyWithImpl<$Res>
    implements $CapacityPublicationSummaryCopyWith<$Res> {
  _$CapacityPublicationSummaryCopyWithImpl(this._self, this._then);

  final CapacityPublicationSummary _self;
  final $Res Function(CapacityPublicationSummary) _then;

/// Create a copy of CapacityPublicationSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeRecurringRouteCount = null,Object? activeOneOffTripCount = null,Object? upcomingDepartureCount = null,Object? publishedCapacityKg = null,Object? reservedCapacityKg = null,}) {
  return _then(_self.copyWith(
activeRecurringRouteCount: null == activeRecurringRouteCount ? _self.activeRecurringRouteCount : activeRecurringRouteCount // ignore: cast_nullable_to_non_nullable
as int,activeOneOffTripCount: null == activeOneOffTripCount ? _self.activeOneOffTripCount : activeOneOffTripCount // ignore: cast_nullable_to_non_nullable
as int,upcomingDepartureCount: null == upcomingDepartureCount ? _self.upcomingDepartureCount : upcomingDepartureCount // ignore: cast_nullable_to_non_nullable
as int,publishedCapacityKg: null == publishedCapacityKg ? _self.publishedCapacityKg : publishedCapacityKg // ignore: cast_nullable_to_non_nullable
as double,reservedCapacityKg: null == reservedCapacityKg ? _self.reservedCapacityKg : reservedCapacityKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CapacityPublicationSummary].
extension CapacityPublicationSummaryPatterns on CapacityPublicationSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapacityPublicationSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapacityPublicationSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapacityPublicationSummary value)  $default,){
final _that = this;
switch (_that) {
case _CapacityPublicationSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapacityPublicationSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CapacityPublicationSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeRecurringRouteCount,  int activeOneOffTripCount,  int upcomingDepartureCount,  double publishedCapacityKg,  double reservedCapacityKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapacityPublicationSummary() when $default != null:
return $default(_that.activeRecurringRouteCount,_that.activeOneOffTripCount,_that.upcomingDepartureCount,_that.publishedCapacityKg,_that.reservedCapacityKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeRecurringRouteCount,  int activeOneOffTripCount,  int upcomingDepartureCount,  double publishedCapacityKg,  double reservedCapacityKg)  $default,) {final _that = this;
switch (_that) {
case _CapacityPublicationSummary():
return $default(_that.activeRecurringRouteCount,_that.activeOneOffTripCount,_that.upcomingDepartureCount,_that.publishedCapacityKg,_that.reservedCapacityKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeRecurringRouteCount,  int activeOneOffTripCount,  int upcomingDepartureCount,  double publishedCapacityKg,  double reservedCapacityKg)?  $default,) {final _that = this;
switch (_that) {
case _CapacityPublicationSummary() when $default != null:
return $default(_that.activeRecurringRouteCount,_that.activeOneOffTripCount,_that.upcomingDepartureCount,_that.publishedCapacityKg,_that.reservedCapacityKg);case _:
  return null;

}
}

}

/// @nodoc


class _CapacityPublicationSummary extends CapacityPublicationSummary {
  const _CapacityPublicationSummary({required this.activeRecurringRouteCount, required this.activeOneOffTripCount, required this.upcomingDepartureCount, required this.publishedCapacityKg, required this.reservedCapacityKg}): super._();
  

@override final  int activeRecurringRouteCount;
@override final  int activeOneOffTripCount;
@override final  int upcomingDepartureCount;
@override final  double publishedCapacityKg;
@override final  double reservedCapacityKg;

/// Create a copy of CapacityPublicationSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapacityPublicationSummaryCopyWith<_CapacityPublicationSummary> get copyWith => __$CapacityPublicationSummaryCopyWithImpl<_CapacityPublicationSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapacityPublicationSummary&&(identical(other.activeRecurringRouteCount, activeRecurringRouteCount) || other.activeRecurringRouteCount == activeRecurringRouteCount)&&(identical(other.activeOneOffTripCount, activeOneOffTripCount) || other.activeOneOffTripCount == activeOneOffTripCount)&&(identical(other.upcomingDepartureCount, upcomingDepartureCount) || other.upcomingDepartureCount == upcomingDepartureCount)&&(identical(other.publishedCapacityKg, publishedCapacityKg) || other.publishedCapacityKg == publishedCapacityKg)&&(identical(other.reservedCapacityKg, reservedCapacityKg) || other.reservedCapacityKg == reservedCapacityKg));
}


@override
int get hashCode => Object.hash(runtimeType,activeRecurringRouteCount,activeOneOffTripCount,upcomingDepartureCount,publishedCapacityKg,reservedCapacityKg);

@override
String toString() {
  return 'CapacityPublicationSummary(activeRecurringRouteCount: $activeRecurringRouteCount, activeOneOffTripCount: $activeOneOffTripCount, upcomingDepartureCount: $upcomingDepartureCount, publishedCapacityKg: $publishedCapacityKg, reservedCapacityKg: $reservedCapacityKg)';
}


}

/// @nodoc
abstract mixin class _$CapacityPublicationSummaryCopyWith<$Res> implements $CapacityPublicationSummaryCopyWith<$Res> {
  factory _$CapacityPublicationSummaryCopyWith(_CapacityPublicationSummary value, $Res Function(_CapacityPublicationSummary) _then) = __$CapacityPublicationSummaryCopyWithImpl;
@override @useResult
$Res call({
 int activeRecurringRouteCount, int activeOneOffTripCount, int upcomingDepartureCount, double publishedCapacityKg, double reservedCapacityKg
});




}
/// @nodoc
class __$CapacityPublicationSummaryCopyWithImpl<$Res>
    implements _$CapacityPublicationSummaryCopyWith<$Res> {
  __$CapacityPublicationSummaryCopyWithImpl(this._self, this._then);

  final _CapacityPublicationSummary _self;
  final $Res Function(_CapacityPublicationSummary) _then;

/// Create a copy of CapacityPublicationSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeRecurringRouteCount = null,Object? activeOneOffTripCount = null,Object? upcomingDepartureCount = null,Object? publishedCapacityKg = null,Object? reservedCapacityKg = null,}) {
  return _then(_CapacityPublicationSummary(
activeRecurringRouteCount: null == activeRecurringRouteCount ? _self.activeRecurringRouteCount : activeRecurringRouteCount // ignore: cast_nullable_to_non_nullable
as int,activeOneOffTripCount: null == activeOneOffTripCount ? _self.activeOneOffTripCount : activeOneOffTripCount // ignore: cast_nullable_to_non_nullable
as int,upcomingDepartureCount: null == upcomingDepartureCount ? _self.upcomingDepartureCount : upcomingDepartureCount // ignore: cast_nullable_to_non_nullable
as int,publishedCapacityKg: null == publishedCapacityKg ? _self.publishedCapacityKg : publishedCapacityKg // ignore: cast_nullable_to_non_nullable
as double,reservedCapacityKg: null == reservedCapacityKg ? _self.reservedCapacityKg : reservedCapacityKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
