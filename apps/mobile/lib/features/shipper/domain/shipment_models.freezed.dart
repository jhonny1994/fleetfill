// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shipment_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShipmentDraftRecord {

 String get id; String get shipperId; int get originCommuneId; int get destinationCommuneId; double get totalWeightKg; double? get totalVolumeM3; String? get details; ShipmentStatus get status; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of ShipmentDraftRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipmentDraftRecordCopyWith<ShipmentDraftRecord> get copyWith => _$ShipmentDraftRecordCopyWithImpl<ShipmentDraftRecord>(this as ShipmentDraftRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipmentDraftRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.totalWeightKg, totalWeightKg) || other.totalWeightKg == totalWeightKg)&&(identical(other.totalVolumeM3, totalVolumeM3) || other.totalVolumeM3 == totalVolumeM3)&&(identical(other.details, details) || other.details == details)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,shipperId,originCommuneId,destinationCommuneId,totalWeightKg,totalVolumeM3,details,status,createdAt,updatedAt);

@override
String toString() {
  return 'ShipmentDraftRecord(id: $id, shipperId: $shipperId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, totalWeightKg: $totalWeightKg, totalVolumeM3: $totalVolumeM3, details: $details, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShipmentDraftRecordCopyWith<$Res>  {
  factory $ShipmentDraftRecordCopyWith(ShipmentDraftRecord value, $Res Function(ShipmentDraftRecord) _then) = _$ShipmentDraftRecordCopyWithImpl;
@useResult
$Res call({
 String id, String shipperId, int originCommuneId, int destinationCommuneId, double totalWeightKg, double? totalVolumeM3, String? details, ShipmentStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ShipmentDraftRecordCopyWithImpl<$Res>
    implements $ShipmentDraftRecordCopyWith<$Res> {
  _$ShipmentDraftRecordCopyWithImpl(this._self, this._then);

  final ShipmentDraftRecord _self;
  final $Res Function(ShipmentDraftRecord) _then;

/// Create a copy of ShipmentDraftRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shipperId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? totalWeightKg = null,Object? totalVolumeM3 = freezed,Object? details = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shipperId: null == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,totalWeightKg: null == totalWeightKg ? _self.totalWeightKg : totalWeightKg // ignore: cast_nullable_to_non_nullable
as double,totalVolumeM3: freezed == totalVolumeM3 ? _self.totalVolumeM3 : totalVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShipmentStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipmentDraftRecord].
extension ShipmentDraftRecordPatterns on ShipmentDraftRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipmentDraftRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipmentDraftRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipmentDraftRecord value)  $default,){
final _that = this;
switch (_that) {
case _ShipmentDraftRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipmentDraftRecord value)?  $default,){
final _that = this;
switch (_that) {
case _ShipmentDraftRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String shipperId,  int originCommuneId,  int destinationCommuneId,  double totalWeightKg,  double? totalVolumeM3,  String? details,  ShipmentStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipmentDraftRecord() when $default != null:
return $default(_that.id,_that.shipperId,_that.originCommuneId,_that.destinationCommuneId,_that.totalWeightKg,_that.totalVolumeM3,_that.details,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String shipperId,  int originCommuneId,  int destinationCommuneId,  double totalWeightKg,  double? totalVolumeM3,  String? details,  ShipmentStatus status,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShipmentDraftRecord():
return $default(_that.id,_that.shipperId,_that.originCommuneId,_that.destinationCommuneId,_that.totalWeightKg,_that.totalVolumeM3,_that.details,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String shipperId,  int originCommuneId,  int destinationCommuneId,  double totalWeightKg,  double? totalVolumeM3,  String? details,  ShipmentStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShipmentDraftRecord() when $default != null:
return $default(_that.id,_that.shipperId,_that.originCommuneId,_that.destinationCommuneId,_that.totalWeightKg,_that.totalVolumeM3,_that.details,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ShipmentDraftRecord extends ShipmentDraftRecord {
  const _ShipmentDraftRecord({required this.id, required this.shipperId, required this.originCommuneId, required this.destinationCommuneId, required this.totalWeightKg, required this.totalVolumeM3, required this.details, required this.status, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String shipperId;
@override final  int originCommuneId;
@override final  int destinationCommuneId;
@override final  double totalWeightKg;
@override final  double? totalVolumeM3;
@override final  String? details;
@override final  ShipmentStatus status;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ShipmentDraftRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipmentDraftRecordCopyWith<_ShipmentDraftRecord> get copyWith => __$ShipmentDraftRecordCopyWithImpl<_ShipmentDraftRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipmentDraftRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.shipperId, shipperId) || other.shipperId == shipperId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.totalWeightKg, totalWeightKg) || other.totalWeightKg == totalWeightKg)&&(identical(other.totalVolumeM3, totalVolumeM3) || other.totalVolumeM3 == totalVolumeM3)&&(identical(other.details, details) || other.details == details)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,shipperId,originCommuneId,destinationCommuneId,totalWeightKg,totalVolumeM3,details,status,createdAt,updatedAt);

@override
String toString() {
  return 'ShipmentDraftRecord(id: $id, shipperId: $shipperId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, totalWeightKg: $totalWeightKg, totalVolumeM3: $totalVolumeM3, details: $details, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShipmentDraftRecordCopyWith<$Res> implements $ShipmentDraftRecordCopyWith<$Res> {
  factory _$ShipmentDraftRecordCopyWith(_ShipmentDraftRecord value, $Res Function(_ShipmentDraftRecord) _then) = __$ShipmentDraftRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String shipperId, int originCommuneId, int destinationCommuneId, double totalWeightKg, double? totalVolumeM3, String? details, ShipmentStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ShipmentDraftRecordCopyWithImpl<$Res>
    implements _$ShipmentDraftRecordCopyWith<$Res> {
  __$ShipmentDraftRecordCopyWithImpl(this._self, this._then);

  final _ShipmentDraftRecord _self;
  final $Res Function(_ShipmentDraftRecord) _then;

/// Create a copy of ShipmentDraftRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shipperId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? totalWeightKg = null,Object? totalVolumeM3 = freezed,Object? details = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ShipmentDraftRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shipperId: null == shipperId ? _self.shipperId : shipperId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,totalWeightKg: null == totalWeightKg ? _self.totalWeightKg : totalWeightKg // ignore: cast_nullable_to_non_nullable
as double,totalVolumeM3: freezed == totalVolumeM3 ? _self.totalVolumeM3 : totalVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ShipmentStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ShipmentDraftInput {

 int get originCommuneId; int get destinationCommuneId; double get totalWeightKg; double? get totalVolumeM3; String? get details;
/// Create a copy of ShipmentDraftInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipmentDraftInputCopyWith<ShipmentDraftInput> get copyWith => _$ShipmentDraftInputCopyWithImpl<ShipmentDraftInput>(this as ShipmentDraftInput, _$identity);

  /// Serializes this ShipmentDraftInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipmentDraftInput&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.totalWeightKg, totalWeightKg) || other.totalWeightKg == totalWeightKg)&&(identical(other.totalVolumeM3, totalVolumeM3) || other.totalVolumeM3 == totalVolumeM3)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originCommuneId,destinationCommuneId,totalWeightKg,totalVolumeM3,details);

@override
String toString() {
  return 'ShipmentDraftInput(originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, totalWeightKg: $totalWeightKg, totalVolumeM3: $totalVolumeM3, details: $details)';
}


}

/// @nodoc
abstract mixin class $ShipmentDraftInputCopyWith<$Res>  {
  factory $ShipmentDraftInputCopyWith(ShipmentDraftInput value, $Res Function(ShipmentDraftInput) _then) = _$ShipmentDraftInputCopyWithImpl;
@useResult
$Res call({
 int originCommuneId, int destinationCommuneId, double totalWeightKg, double? totalVolumeM3, String? details
});




}
/// @nodoc
class _$ShipmentDraftInputCopyWithImpl<$Res>
    implements $ShipmentDraftInputCopyWith<$Res> {
  _$ShipmentDraftInputCopyWithImpl(this._self, this._then);

  final ShipmentDraftInput _self;
  final $Res Function(ShipmentDraftInput) _then;

/// Create a copy of ShipmentDraftInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originCommuneId = null,Object? destinationCommuneId = null,Object? totalWeightKg = null,Object? totalVolumeM3 = freezed,Object? details = freezed,}) {
  return _then(_self.copyWith(
originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,totalWeightKg: null == totalWeightKg ? _self.totalWeightKg : totalWeightKg // ignore: cast_nullable_to_non_nullable
as double,totalVolumeM3: freezed == totalVolumeM3 ? _self.totalVolumeM3 : totalVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipmentDraftInput].
extension ShipmentDraftInputPatterns on ShipmentDraftInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipmentDraftInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipmentDraftInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipmentDraftInput value)  $default,){
final _that = this;
switch (_that) {
case _ShipmentDraftInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipmentDraftInput value)?  $default,){
final _that = this;
switch (_that) {
case _ShipmentDraftInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int originCommuneId,  int destinationCommuneId,  double totalWeightKg,  double? totalVolumeM3,  String? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipmentDraftInput() when $default != null:
return $default(_that.originCommuneId,_that.destinationCommuneId,_that.totalWeightKg,_that.totalVolumeM3,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int originCommuneId,  int destinationCommuneId,  double totalWeightKg,  double? totalVolumeM3,  String? details)  $default,) {final _that = this;
switch (_that) {
case _ShipmentDraftInput():
return $default(_that.originCommuneId,_that.destinationCommuneId,_that.totalWeightKg,_that.totalVolumeM3,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int originCommuneId,  int destinationCommuneId,  double totalWeightKg,  double? totalVolumeM3,  String? details)?  $default,) {final _that = this;
switch (_that) {
case _ShipmentDraftInput() when $default != null:
return $default(_that.originCommuneId,_that.destinationCommuneId,_that.totalWeightKg,_that.totalVolumeM3,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShipmentDraftInput extends ShipmentDraftInput {
  const _ShipmentDraftInput({required this.originCommuneId, required this.destinationCommuneId, required this.totalWeightKg, required this.totalVolumeM3, required this.details}): super._();
  factory _ShipmentDraftInput.fromJson(Map<String, dynamic> json) => _$ShipmentDraftInputFromJson(json);

@override final  int originCommuneId;
@override final  int destinationCommuneId;
@override final  double totalWeightKg;
@override final  double? totalVolumeM3;
@override final  String? details;

/// Create a copy of ShipmentDraftInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipmentDraftInputCopyWith<_ShipmentDraftInput> get copyWith => __$ShipmentDraftInputCopyWithImpl<_ShipmentDraftInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShipmentDraftInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipmentDraftInput&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.totalWeightKg, totalWeightKg) || other.totalWeightKg == totalWeightKg)&&(identical(other.totalVolumeM3, totalVolumeM3) || other.totalVolumeM3 == totalVolumeM3)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originCommuneId,destinationCommuneId,totalWeightKg,totalVolumeM3,details);

@override
String toString() {
  return 'ShipmentDraftInput(originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, totalWeightKg: $totalWeightKg, totalVolumeM3: $totalVolumeM3, details: $details)';
}


}

/// @nodoc
abstract mixin class _$ShipmentDraftInputCopyWith<$Res> implements $ShipmentDraftInputCopyWith<$Res> {
  factory _$ShipmentDraftInputCopyWith(_ShipmentDraftInput value, $Res Function(_ShipmentDraftInput) _then) = __$ShipmentDraftInputCopyWithImpl;
@override @useResult
$Res call({
 int originCommuneId, int destinationCommuneId, double totalWeightKg, double? totalVolumeM3, String? details
});




}
/// @nodoc
class __$ShipmentDraftInputCopyWithImpl<$Res>
    implements _$ShipmentDraftInputCopyWith<$Res> {
  __$ShipmentDraftInputCopyWithImpl(this._self, this._then);

  final _ShipmentDraftInput _self;
  final $Res Function(_ShipmentDraftInput) _then;

/// Create a copy of ShipmentDraftInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originCommuneId = null,Object? destinationCommuneId = null,Object? totalWeightKg = null,Object? totalVolumeM3 = freezed,Object? details = freezed,}) {
  return _then(_ShipmentDraftInput(
originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,totalWeightKg: null == totalWeightKg ? _self.totalWeightKg : totalWeightKg // ignore: cast_nullable_to_non_nullable
as double,totalVolumeM3: freezed == totalVolumeM3 ? _self.totalVolumeM3 : totalVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ShipmentSearchQuery {

 int get originCommuneId; int get destinationCommuneId; DateTime get requestedDate; double get totalWeightKg; double? get totalVolumeM3; SearchSortOption get sort; int get offset; int get limit;
/// Create a copy of ShipmentSearchQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipmentSearchQueryCopyWith<ShipmentSearchQuery> get copyWith => _$ShipmentSearchQueryCopyWithImpl<ShipmentSearchQuery>(this as ShipmentSearchQuery, _$identity);

  /// Serializes this ShipmentSearchQuery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipmentSearchQuery&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.requestedDate, requestedDate) || other.requestedDate == requestedDate)&&(identical(other.totalWeightKg, totalWeightKg) || other.totalWeightKg == totalWeightKg)&&(identical(other.totalVolumeM3, totalVolumeM3) || other.totalVolumeM3 == totalVolumeM3)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originCommuneId,destinationCommuneId,requestedDate,totalWeightKg,totalVolumeM3,sort,offset,limit);

@override
String toString() {
  return 'ShipmentSearchQuery(originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, requestedDate: $requestedDate, totalWeightKg: $totalWeightKg, totalVolumeM3: $totalVolumeM3, sort: $sort, offset: $offset, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ShipmentSearchQueryCopyWith<$Res>  {
  factory $ShipmentSearchQueryCopyWith(ShipmentSearchQuery value, $Res Function(ShipmentSearchQuery) _then) = _$ShipmentSearchQueryCopyWithImpl;
@useResult
$Res call({
 int originCommuneId, int destinationCommuneId, DateTime requestedDate, double totalWeightKg, double? totalVolumeM3, SearchSortOption sort, int offset, int limit
});




}
/// @nodoc
class _$ShipmentSearchQueryCopyWithImpl<$Res>
    implements $ShipmentSearchQueryCopyWith<$Res> {
  _$ShipmentSearchQueryCopyWithImpl(this._self, this._then);

  final ShipmentSearchQuery _self;
  final $Res Function(ShipmentSearchQuery) _then;

/// Create a copy of ShipmentSearchQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originCommuneId = null,Object? destinationCommuneId = null,Object? requestedDate = null,Object? totalWeightKg = null,Object? totalVolumeM3 = freezed,Object? sort = null,Object? offset = null,Object? limit = null,}) {
  return _then(_self.copyWith(
originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,requestedDate: null == requestedDate ? _self.requestedDate : requestedDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalWeightKg: null == totalWeightKg ? _self.totalWeightKg : totalWeightKg // ignore: cast_nullable_to_non_nullable
as double,totalVolumeM3: freezed == totalVolumeM3 ? _self.totalVolumeM3 : totalVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SearchSortOption,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipmentSearchQuery].
extension ShipmentSearchQueryPatterns on ShipmentSearchQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipmentSearchQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipmentSearchQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipmentSearchQuery value)  $default,){
final _that = this;
switch (_that) {
case _ShipmentSearchQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipmentSearchQuery value)?  $default,){
final _that = this;
switch (_that) {
case _ShipmentSearchQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int originCommuneId,  int destinationCommuneId,  DateTime requestedDate,  double totalWeightKg,  double? totalVolumeM3,  SearchSortOption sort,  int offset,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipmentSearchQuery() when $default != null:
return $default(_that.originCommuneId,_that.destinationCommuneId,_that.requestedDate,_that.totalWeightKg,_that.totalVolumeM3,_that.sort,_that.offset,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int originCommuneId,  int destinationCommuneId,  DateTime requestedDate,  double totalWeightKg,  double? totalVolumeM3,  SearchSortOption sort,  int offset,  int limit)  $default,) {final _that = this;
switch (_that) {
case _ShipmentSearchQuery():
return $default(_that.originCommuneId,_that.destinationCommuneId,_that.requestedDate,_that.totalWeightKg,_that.totalVolumeM3,_that.sort,_that.offset,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int originCommuneId,  int destinationCommuneId,  DateTime requestedDate,  double totalWeightKg,  double? totalVolumeM3,  SearchSortOption sort,  int offset,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ShipmentSearchQuery() when $default != null:
return $default(_that.originCommuneId,_that.destinationCommuneId,_that.requestedDate,_that.totalWeightKg,_that.totalVolumeM3,_that.sort,_that.offset,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShipmentSearchQuery extends ShipmentSearchQuery {
  const _ShipmentSearchQuery({required this.originCommuneId, required this.destinationCommuneId, required this.requestedDate, required this.totalWeightKg, required this.totalVolumeM3, this.sort = SearchSortOption.recommended, this.offset = 0, this.limit = 20}): super._();
  factory _ShipmentSearchQuery.fromJson(Map<String, dynamic> json) => _$ShipmentSearchQueryFromJson(json);

@override final  int originCommuneId;
@override final  int destinationCommuneId;
@override final  DateTime requestedDate;
@override final  double totalWeightKg;
@override final  double? totalVolumeM3;
@override@JsonKey() final  SearchSortOption sort;
@override@JsonKey() final  int offset;
@override@JsonKey() final  int limit;

/// Create a copy of ShipmentSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipmentSearchQueryCopyWith<_ShipmentSearchQuery> get copyWith => __$ShipmentSearchQueryCopyWithImpl<_ShipmentSearchQuery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShipmentSearchQueryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipmentSearchQuery&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.requestedDate, requestedDate) || other.requestedDate == requestedDate)&&(identical(other.totalWeightKg, totalWeightKg) || other.totalWeightKg == totalWeightKg)&&(identical(other.totalVolumeM3, totalVolumeM3) || other.totalVolumeM3 == totalVolumeM3)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originCommuneId,destinationCommuneId,requestedDate,totalWeightKg,totalVolumeM3,sort,offset,limit);

@override
String toString() {
  return 'ShipmentSearchQuery(originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, requestedDate: $requestedDate, totalWeightKg: $totalWeightKg, totalVolumeM3: $totalVolumeM3, sort: $sort, offset: $offset, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ShipmentSearchQueryCopyWith<$Res> implements $ShipmentSearchQueryCopyWith<$Res> {
  factory _$ShipmentSearchQueryCopyWith(_ShipmentSearchQuery value, $Res Function(_ShipmentSearchQuery) _then) = __$ShipmentSearchQueryCopyWithImpl;
@override @useResult
$Res call({
 int originCommuneId, int destinationCommuneId, DateTime requestedDate, double totalWeightKg, double? totalVolumeM3, SearchSortOption sort, int offset, int limit
});




}
/// @nodoc
class __$ShipmentSearchQueryCopyWithImpl<$Res>
    implements _$ShipmentSearchQueryCopyWith<$Res> {
  __$ShipmentSearchQueryCopyWithImpl(this._self, this._then);

  final _ShipmentSearchQuery _self;
  final $Res Function(_ShipmentSearchQuery) _then;

/// Create a copy of ShipmentSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originCommuneId = null,Object? destinationCommuneId = null,Object? requestedDate = null,Object? totalWeightKg = null,Object? totalVolumeM3 = freezed,Object? sort = null,Object? offset = null,Object? limit = null,}) {
  return _then(_ShipmentSearchQuery(
originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,requestedDate: null == requestedDate ? _self.requestedDate : requestedDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalWeightKg: null == totalWeightKg ? _self.totalWeightKg : totalWeightKg // ignore: cast_nullable_to_non_nullable
as double,totalVolumeM3: freezed == totalVolumeM3 ? _self.totalVolumeM3 : totalVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as SearchSortOption,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ShipmentSearchResult {

 String get sourceId; String get sourceType; String get carrierId; String get carrierName; String get vehicleId; int get originCommuneId; int get destinationCommuneId; DateTime get departureAt; DateTime get departureDate; double get totalCapacityKg; double? get totalCapacityVolumeM3; double get remainingCapacityKg; double? get remainingVolumeM3; double get pricePerKgDzd; double get estimatedTotalDzd; double get ratingAverage; int get ratingCount; int get dayDistance;
/// Create a copy of ShipmentSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipmentSearchResultCopyWith<ShipmentSearchResult> get copyWith => _$ShipmentSearchResultCopyWithImpl<ShipmentSearchResult>(this as ShipmentSearchResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipmentSearchResult&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.carrierName, carrierName) || other.carrierName == carrierName)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.departureAt, departureAt) || other.departureAt == departureAt)&&(identical(other.departureDate, departureDate) || other.departureDate == departureDate)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.remainingCapacityKg, remainingCapacityKg) || other.remainingCapacityKg == remainingCapacityKg)&&(identical(other.remainingVolumeM3, remainingVolumeM3) || other.remainingVolumeM3 == remainingVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.estimatedTotalDzd, estimatedTotalDzd) || other.estimatedTotalDzd == estimatedTotalDzd)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.dayDistance, dayDistance) || other.dayDistance == dayDistance));
}


@override
int get hashCode => Object.hash(runtimeType,sourceId,sourceType,carrierId,carrierName,vehicleId,originCommuneId,destinationCommuneId,departureAt,departureDate,totalCapacityKg,totalCapacityVolumeM3,remainingCapacityKg,remainingVolumeM3,pricePerKgDzd,estimatedTotalDzd,ratingAverage,ratingCount,dayDistance);

@override
String toString() {
  return 'ShipmentSearchResult(sourceId: $sourceId, sourceType: $sourceType, carrierId: $carrierId, carrierName: $carrierName, vehicleId: $vehicleId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, departureAt: $departureAt, departureDate: $departureDate, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, remainingCapacityKg: $remainingCapacityKg, remainingVolumeM3: $remainingVolumeM3, pricePerKgDzd: $pricePerKgDzd, estimatedTotalDzd: $estimatedTotalDzd, ratingAverage: $ratingAverage, ratingCount: $ratingCount, dayDistance: $dayDistance)';
}


}

/// @nodoc
abstract mixin class $ShipmentSearchResultCopyWith<$Res>  {
  factory $ShipmentSearchResultCopyWith(ShipmentSearchResult value, $Res Function(ShipmentSearchResult) _then) = _$ShipmentSearchResultCopyWithImpl;
@useResult
$Res call({
 String sourceId, String sourceType, String carrierId, String carrierName, String vehicleId, int originCommuneId, int destinationCommuneId, DateTime departureAt, DateTime departureDate, double totalCapacityKg, double? totalCapacityVolumeM3, double remainingCapacityKg, double? remainingVolumeM3, double pricePerKgDzd, double estimatedTotalDzd, double ratingAverage, int ratingCount, int dayDistance
});




}
/// @nodoc
class _$ShipmentSearchResultCopyWithImpl<$Res>
    implements $ShipmentSearchResultCopyWith<$Res> {
  _$ShipmentSearchResultCopyWithImpl(this._self, this._then);

  final ShipmentSearchResult _self;
  final $Res Function(ShipmentSearchResult) _then;

/// Create a copy of ShipmentSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceId = null,Object? sourceType = null,Object? carrierId = null,Object? carrierName = null,Object? vehicleId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? departureAt = null,Object? departureDate = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? remainingCapacityKg = null,Object? remainingVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? estimatedTotalDzd = null,Object? ratingAverage = null,Object? ratingCount = null,Object? dayDistance = null,}) {
  return _then(_self.copyWith(
sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,carrierName: null == carrierName ? _self.carrierName : carrierName // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,departureAt: null == departureAt ? _self.departureAt : departureAt // ignore: cast_nullable_to_non_nullable
as DateTime,departureDate: null == departureDate ? _self.departureDate : departureDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,remainingCapacityKg: null == remainingCapacityKg ? _self.remainingCapacityKg : remainingCapacityKg // ignore: cast_nullable_to_non_nullable
as double,remainingVolumeM3: freezed == remainingVolumeM3 ? _self.remainingVolumeM3 : remainingVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,estimatedTotalDzd: null == estimatedTotalDzd ? _self.estimatedTotalDzd : estimatedTotalDzd // ignore: cast_nullable_to_non_nullable
as double,ratingAverage: null == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,dayDistance: null == dayDistance ? _self.dayDistance : dayDistance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipmentSearchResult].
extension ShipmentSearchResultPatterns on ShipmentSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipmentSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipmentSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipmentSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _ShipmentSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipmentSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _ShipmentSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceId,  String sourceType,  String carrierId,  String carrierName,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  DateTime departureAt,  DateTime departureDate,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double remainingCapacityKg,  double? remainingVolumeM3,  double pricePerKgDzd,  double estimatedTotalDzd,  double ratingAverage,  int ratingCount,  int dayDistance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipmentSearchResult() when $default != null:
return $default(_that.sourceId,_that.sourceType,_that.carrierId,_that.carrierName,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.departureAt,_that.departureDate,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.remainingCapacityKg,_that.remainingVolumeM3,_that.pricePerKgDzd,_that.estimatedTotalDzd,_that.ratingAverage,_that.ratingCount,_that.dayDistance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceId,  String sourceType,  String carrierId,  String carrierName,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  DateTime departureAt,  DateTime departureDate,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double remainingCapacityKg,  double? remainingVolumeM3,  double pricePerKgDzd,  double estimatedTotalDzd,  double ratingAverage,  int ratingCount,  int dayDistance)  $default,) {final _that = this;
switch (_that) {
case _ShipmentSearchResult():
return $default(_that.sourceId,_that.sourceType,_that.carrierId,_that.carrierName,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.departureAt,_that.departureDate,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.remainingCapacityKg,_that.remainingVolumeM3,_that.pricePerKgDzd,_that.estimatedTotalDzd,_that.ratingAverage,_that.ratingCount,_that.dayDistance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceId,  String sourceType,  String carrierId,  String carrierName,  String vehicleId,  int originCommuneId,  int destinationCommuneId,  DateTime departureAt,  DateTime departureDate,  double totalCapacityKg,  double? totalCapacityVolumeM3,  double remainingCapacityKg,  double? remainingVolumeM3,  double pricePerKgDzd,  double estimatedTotalDzd,  double ratingAverage,  int ratingCount,  int dayDistance)?  $default,) {final _that = this;
switch (_that) {
case _ShipmentSearchResult() when $default != null:
return $default(_that.sourceId,_that.sourceType,_that.carrierId,_that.carrierName,_that.vehicleId,_that.originCommuneId,_that.destinationCommuneId,_that.departureAt,_that.departureDate,_that.totalCapacityKg,_that.totalCapacityVolumeM3,_that.remainingCapacityKg,_that.remainingVolumeM3,_that.pricePerKgDzd,_that.estimatedTotalDzd,_that.ratingAverage,_that.ratingCount,_that.dayDistance);case _:
  return null;

}
}

}

/// @nodoc


class _ShipmentSearchResult extends ShipmentSearchResult {
  const _ShipmentSearchResult({required this.sourceId, required this.sourceType, required this.carrierId, required this.carrierName, required this.vehicleId, required this.originCommuneId, required this.destinationCommuneId, required this.departureAt, required this.departureDate, required this.totalCapacityKg, required this.totalCapacityVolumeM3, required this.remainingCapacityKg, required this.remainingVolumeM3, required this.pricePerKgDzd, required this.estimatedTotalDzd, required this.ratingAverage, required this.ratingCount, required this.dayDistance}): super._();
  

@override final  String sourceId;
@override final  String sourceType;
@override final  String carrierId;
@override final  String carrierName;
@override final  String vehicleId;
@override final  int originCommuneId;
@override final  int destinationCommuneId;
@override final  DateTime departureAt;
@override final  DateTime departureDate;
@override final  double totalCapacityKg;
@override final  double? totalCapacityVolumeM3;
@override final  double remainingCapacityKg;
@override final  double? remainingVolumeM3;
@override final  double pricePerKgDzd;
@override final  double estimatedTotalDzd;
@override final  double ratingAverage;
@override final  int ratingCount;
@override final  int dayDistance;

/// Create a copy of ShipmentSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipmentSearchResultCopyWith<_ShipmentSearchResult> get copyWith => __$ShipmentSearchResultCopyWithImpl<_ShipmentSearchResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipmentSearchResult&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.carrierName, carrierName) || other.carrierName == carrierName)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.originCommuneId, originCommuneId) || other.originCommuneId == originCommuneId)&&(identical(other.destinationCommuneId, destinationCommuneId) || other.destinationCommuneId == destinationCommuneId)&&(identical(other.departureAt, departureAt) || other.departureAt == departureAt)&&(identical(other.departureDate, departureDate) || other.departureDate == departureDate)&&(identical(other.totalCapacityKg, totalCapacityKg) || other.totalCapacityKg == totalCapacityKg)&&(identical(other.totalCapacityVolumeM3, totalCapacityVolumeM3) || other.totalCapacityVolumeM3 == totalCapacityVolumeM3)&&(identical(other.remainingCapacityKg, remainingCapacityKg) || other.remainingCapacityKg == remainingCapacityKg)&&(identical(other.remainingVolumeM3, remainingVolumeM3) || other.remainingVolumeM3 == remainingVolumeM3)&&(identical(other.pricePerKgDzd, pricePerKgDzd) || other.pricePerKgDzd == pricePerKgDzd)&&(identical(other.estimatedTotalDzd, estimatedTotalDzd) || other.estimatedTotalDzd == estimatedTotalDzd)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.dayDistance, dayDistance) || other.dayDistance == dayDistance));
}


@override
int get hashCode => Object.hash(runtimeType,sourceId,sourceType,carrierId,carrierName,vehicleId,originCommuneId,destinationCommuneId,departureAt,departureDate,totalCapacityKg,totalCapacityVolumeM3,remainingCapacityKg,remainingVolumeM3,pricePerKgDzd,estimatedTotalDzd,ratingAverage,ratingCount,dayDistance);

@override
String toString() {
  return 'ShipmentSearchResult(sourceId: $sourceId, sourceType: $sourceType, carrierId: $carrierId, carrierName: $carrierName, vehicleId: $vehicleId, originCommuneId: $originCommuneId, destinationCommuneId: $destinationCommuneId, departureAt: $departureAt, departureDate: $departureDate, totalCapacityKg: $totalCapacityKg, totalCapacityVolumeM3: $totalCapacityVolumeM3, remainingCapacityKg: $remainingCapacityKg, remainingVolumeM3: $remainingVolumeM3, pricePerKgDzd: $pricePerKgDzd, estimatedTotalDzd: $estimatedTotalDzd, ratingAverage: $ratingAverage, ratingCount: $ratingCount, dayDistance: $dayDistance)';
}


}

/// @nodoc
abstract mixin class _$ShipmentSearchResultCopyWith<$Res> implements $ShipmentSearchResultCopyWith<$Res> {
  factory _$ShipmentSearchResultCopyWith(_ShipmentSearchResult value, $Res Function(_ShipmentSearchResult) _then) = __$ShipmentSearchResultCopyWithImpl;
@override @useResult
$Res call({
 String sourceId, String sourceType, String carrierId, String carrierName, String vehicleId, int originCommuneId, int destinationCommuneId, DateTime departureAt, DateTime departureDate, double totalCapacityKg, double? totalCapacityVolumeM3, double remainingCapacityKg, double? remainingVolumeM3, double pricePerKgDzd, double estimatedTotalDzd, double ratingAverage, int ratingCount, int dayDistance
});




}
/// @nodoc
class __$ShipmentSearchResultCopyWithImpl<$Res>
    implements _$ShipmentSearchResultCopyWith<$Res> {
  __$ShipmentSearchResultCopyWithImpl(this._self, this._then);

  final _ShipmentSearchResult _self;
  final $Res Function(_ShipmentSearchResult) _then;

/// Create a copy of ShipmentSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceId = null,Object? sourceType = null,Object? carrierId = null,Object? carrierName = null,Object? vehicleId = null,Object? originCommuneId = null,Object? destinationCommuneId = null,Object? departureAt = null,Object? departureDate = null,Object? totalCapacityKg = null,Object? totalCapacityVolumeM3 = freezed,Object? remainingCapacityKg = null,Object? remainingVolumeM3 = freezed,Object? pricePerKgDzd = null,Object? estimatedTotalDzd = null,Object? ratingAverage = null,Object? ratingCount = null,Object? dayDistance = null,}) {
  return _then(_ShipmentSearchResult(
sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,carrierName: null == carrierName ? _self.carrierName : carrierName // ignore: cast_nullable_to_non_nullable
as String,vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,originCommuneId: null == originCommuneId ? _self.originCommuneId : originCommuneId // ignore: cast_nullable_to_non_nullable
as int,destinationCommuneId: null == destinationCommuneId ? _self.destinationCommuneId : destinationCommuneId // ignore: cast_nullable_to_non_nullable
as int,departureAt: null == departureAt ? _self.departureAt : departureAt // ignore: cast_nullable_to_non_nullable
as DateTime,departureDate: null == departureDate ? _self.departureDate : departureDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalCapacityKg: null == totalCapacityKg ? _self.totalCapacityKg : totalCapacityKg // ignore: cast_nullable_to_non_nullable
as double,totalCapacityVolumeM3: freezed == totalCapacityVolumeM3 ? _self.totalCapacityVolumeM3 : totalCapacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,remainingCapacityKg: null == remainingCapacityKg ? _self.remainingCapacityKg : remainingCapacityKg // ignore: cast_nullable_to_non_nullable
as double,remainingVolumeM3: freezed == remainingVolumeM3 ? _self.remainingVolumeM3 : remainingVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,pricePerKgDzd: null == pricePerKgDzd ? _self.pricePerKgDzd : pricePerKgDzd // ignore: cast_nullable_to_non_nullable
as double,estimatedTotalDzd: null == estimatedTotalDzd ? _self.estimatedTotalDzd : estimatedTotalDzd // ignore: cast_nullable_to_non_nullable
as double,ratingAverage: null == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,dayDistance: null == dayDistance ? _self.dayDistance : dayDistance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ShipmentSearchResponse {

 SearchResultMode get mode; List<ShipmentSearchResult> get results; List<DateTime> get nearestDates; int? get nextOffset; int get totalCount;
/// Create a copy of ShipmentSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipmentSearchResponseCopyWith<ShipmentSearchResponse> get copyWith => _$ShipmentSearchResponseCopyWithImpl<ShipmentSearchResponse>(this as ShipmentSearchResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipmentSearchResponse&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.nearestDates, nearestDates)&&(identical(other.nextOffset, nextOffset) || other.nextOffset == nextOffset)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}


@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(nearestDates),nextOffset,totalCount);

@override
String toString() {
  return 'ShipmentSearchResponse(mode: $mode, results: $results, nearestDates: $nearestDates, nextOffset: $nextOffset, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class $ShipmentSearchResponseCopyWith<$Res>  {
  factory $ShipmentSearchResponseCopyWith(ShipmentSearchResponse value, $Res Function(ShipmentSearchResponse) _then) = _$ShipmentSearchResponseCopyWithImpl;
@useResult
$Res call({
 SearchResultMode mode, List<ShipmentSearchResult> results, List<DateTime> nearestDates, int? nextOffset, int totalCount
});




}
/// @nodoc
class _$ShipmentSearchResponseCopyWithImpl<$Res>
    implements $ShipmentSearchResponseCopyWith<$Res> {
  _$ShipmentSearchResponseCopyWithImpl(this._self, this._then);

  final ShipmentSearchResponse _self;
  final $Res Function(ShipmentSearchResponse) _then;

/// Create a copy of ShipmentSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? results = null,Object? nearestDates = null,Object? nextOffset = freezed,Object? totalCount = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SearchResultMode,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<ShipmentSearchResult>,nearestDates: null == nearestDates ? _self.nearestDates : nearestDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,nextOffset: freezed == nextOffset ? _self.nextOffset : nextOffset // ignore: cast_nullable_to_non_nullable
as int?,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipmentSearchResponse].
extension ShipmentSearchResponsePatterns on ShipmentSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShipmentSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShipmentSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShipmentSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _ShipmentSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShipmentSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ShipmentSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchResultMode mode,  List<ShipmentSearchResult> results,  List<DateTime> nearestDates,  int? nextOffset,  int totalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShipmentSearchResponse() when $default != null:
return $default(_that.mode,_that.results,_that.nearestDates,_that.nextOffset,_that.totalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchResultMode mode,  List<ShipmentSearchResult> results,  List<DateTime> nearestDates,  int? nextOffset,  int totalCount)  $default,) {final _that = this;
switch (_that) {
case _ShipmentSearchResponse():
return $default(_that.mode,_that.results,_that.nearestDates,_that.nextOffset,_that.totalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchResultMode mode,  List<ShipmentSearchResult> results,  List<DateTime> nearestDates,  int? nextOffset,  int totalCount)?  $default,) {final _that = this;
switch (_that) {
case _ShipmentSearchResponse() when $default != null:
return $default(_that.mode,_that.results,_that.nearestDates,_that.nextOffset,_that.totalCount);case _:
  return null;

}
}

}

/// @nodoc


class _ShipmentSearchResponse extends ShipmentSearchResponse {
  const _ShipmentSearchResponse({required this.mode, required final  List<ShipmentSearchResult> results, required final  List<DateTime> nearestDates, required this.nextOffset, required this.totalCount}): _results = results,_nearestDates = nearestDates,super._();
  

@override final  SearchResultMode mode;
 final  List<ShipmentSearchResult> _results;
@override List<ShipmentSearchResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  List<DateTime> _nearestDates;
@override List<DateTime> get nearestDates {
  if (_nearestDates is EqualUnmodifiableListView) return _nearestDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearestDates);
}

@override final  int? nextOffset;
@override final  int totalCount;

/// Create a copy of ShipmentSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShipmentSearchResponseCopyWith<_ShipmentSearchResponse> get copyWith => __$ShipmentSearchResponseCopyWithImpl<_ShipmentSearchResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShipmentSearchResponse&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other._nearestDates, _nearestDates)&&(identical(other.nextOffset, nextOffset) || other.nextOffset == nextOffset)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}


@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_nearestDates),nextOffset,totalCount);

@override
String toString() {
  return 'ShipmentSearchResponse(mode: $mode, results: $results, nearestDates: $nearestDates, nextOffset: $nextOffset, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class _$ShipmentSearchResponseCopyWith<$Res> implements $ShipmentSearchResponseCopyWith<$Res> {
  factory _$ShipmentSearchResponseCopyWith(_ShipmentSearchResponse value, $Res Function(_ShipmentSearchResponse) _then) = __$ShipmentSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 SearchResultMode mode, List<ShipmentSearchResult> results, List<DateTime> nearestDates, int? nextOffset, int totalCount
});




}
/// @nodoc
class __$ShipmentSearchResponseCopyWithImpl<$Res>
    implements _$ShipmentSearchResponseCopyWith<$Res> {
  __$ShipmentSearchResponseCopyWithImpl(this._self, this._then);

  final _ShipmentSearchResponse _self;
  final $Res Function(_ShipmentSearchResponse) _then;

/// Create a copy of ShipmentSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? results = null,Object? nearestDates = null,Object? nextOffset = freezed,Object? totalCount = null,}) {
  return _then(_ShipmentSearchResponse(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SearchResultMode,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<ShipmentSearchResult>,nearestDates: null == nearestDates ? _self._nearestDates : nearestDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,nextOffset: freezed == nextOffset ? _self.nextOffset : nextOffset // ignore: cast_nullable_to_non_nullable
as int?,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BookingReviewSelection {

 ShipmentDraftRecord get shipment; ShipmentSearchResult get result; DateTime get requestedDate;
/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingReviewSelectionCopyWith<BookingReviewSelection> get copyWith => _$BookingReviewSelectionCopyWithImpl<BookingReviewSelection>(this as BookingReviewSelection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingReviewSelection&&(identical(other.shipment, shipment) || other.shipment == shipment)&&(identical(other.result, result) || other.result == result)&&(identical(other.requestedDate, requestedDate) || other.requestedDate == requestedDate));
}


@override
int get hashCode => Object.hash(runtimeType,shipment,result,requestedDate);

@override
String toString() {
  return 'BookingReviewSelection(shipment: $shipment, result: $result, requestedDate: $requestedDate)';
}


}

/// @nodoc
abstract mixin class $BookingReviewSelectionCopyWith<$Res>  {
  factory $BookingReviewSelectionCopyWith(BookingReviewSelection value, $Res Function(BookingReviewSelection) _then) = _$BookingReviewSelectionCopyWithImpl;
@useResult
$Res call({
 ShipmentDraftRecord shipment, ShipmentSearchResult result, DateTime requestedDate
});


$ShipmentDraftRecordCopyWith<$Res> get shipment;$ShipmentSearchResultCopyWith<$Res> get result;

}
/// @nodoc
class _$BookingReviewSelectionCopyWithImpl<$Res>
    implements $BookingReviewSelectionCopyWith<$Res> {
  _$BookingReviewSelectionCopyWithImpl(this._self, this._then);

  final BookingReviewSelection _self;
  final $Res Function(BookingReviewSelection) _then;

/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shipment = null,Object? result = null,Object? requestedDate = null,}) {
  return _then(_self.copyWith(
shipment: null == shipment ? _self.shipment : shipment // ignore: cast_nullable_to_non_nullable
as ShipmentDraftRecord,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ShipmentSearchResult,requestedDate: null == requestedDate ? _self.requestedDate : requestedDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShipmentDraftRecordCopyWith<$Res> get shipment {
  
  return $ShipmentDraftRecordCopyWith<$Res>(_self.shipment, (value) {
    return _then(_self.copyWith(shipment: value));
  });
}/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShipmentSearchResultCopyWith<$Res> get result {
  
  return $ShipmentSearchResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingReviewSelection].
extension BookingReviewSelectionPatterns on BookingReviewSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingReviewSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingReviewSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingReviewSelection value)  $default,){
final _that = this;
switch (_that) {
case _BookingReviewSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingReviewSelection value)?  $default,){
final _that = this;
switch (_that) {
case _BookingReviewSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ShipmentDraftRecord shipment,  ShipmentSearchResult result,  DateTime requestedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingReviewSelection() when $default != null:
return $default(_that.shipment,_that.result,_that.requestedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ShipmentDraftRecord shipment,  ShipmentSearchResult result,  DateTime requestedDate)  $default,) {final _that = this;
switch (_that) {
case _BookingReviewSelection():
return $default(_that.shipment,_that.result,_that.requestedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ShipmentDraftRecord shipment,  ShipmentSearchResult result,  DateTime requestedDate)?  $default,) {final _that = this;
switch (_that) {
case _BookingReviewSelection() when $default != null:
return $default(_that.shipment,_that.result,_that.requestedDate);case _:
  return null;

}
}

}

/// @nodoc


class _BookingReviewSelection extends BookingReviewSelection {
  const _BookingReviewSelection({required this.shipment, required this.result, required this.requestedDate}): super._();
  

@override final  ShipmentDraftRecord shipment;
@override final  ShipmentSearchResult result;
@override final  DateTime requestedDate;

/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingReviewSelectionCopyWith<_BookingReviewSelection> get copyWith => __$BookingReviewSelectionCopyWithImpl<_BookingReviewSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingReviewSelection&&(identical(other.shipment, shipment) || other.shipment == shipment)&&(identical(other.result, result) || other.result == result)&&(identical(other.requestedDate, requestedDate) || other.requestedDate == requestedDate));
}


@override
int get hashCode => Object.hash(runtimeType,shipment,result,requestedDate);

@override
String toString() {
  return 'BookingReviewSelection(shipment: $shipment, result: $result, requestedDate: $requestedDate)';
}


}

/// @nodoc
abstract mixin class _$BookingReviewSelectionCopyWith<$Res> implements $BookingReviewSelectionCopyWith<$Res> {
  factory _$BookingReviewSelectionCopyWith(_BookingReviewSelection value, $Res Function(_BookingReviewSelection) _then) = __$BookingReviewSelectionCopyWithImpl;
@override @useResult
$Res call({
 ShipmentDraftRecord shipment, ShipmentSearchResult result, DateTime requestedDate
});


@override $ShipmentDraftRecordCopyWith<$Res> get shipment;@override $ShipmentSearchResultCopyWith<$Res> get result;

}
/// @nodoc
class __$BookingReviewSelectionCopyWithImpl<$Res>
    implements _$BookingReviewSelectionCopyWith<$Res> {
  __$BookingReviewSelectionCopyWithImpl(this._self, this._then);

  final _BookingReviewSelection _self;
  final $Res Function(_BookingReviewSelection) _then;

/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shipment = null,Object? result = null,Object? requestedDate = null,}) {
  return _then(_BookingReviewSelection(
shipment: null == shipment ? _self.shipment : shipment // ignore: cast_nullable_to_non_nullable
as ShipmentDraftRecord,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ShipmentSearchResult,requestedDate: null == requestedDate ? _self.requestedDate : requestedDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShipmentDraftRecordCopyWith<$Res> get shipment {
  
  return $ShipmentDraftRecordCopyWith<$Res>(_self.shipment, (value) {
    return _then(_self.copyWith(shipment: value));
  });
}/// Create a copy of BookingReviewSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShipmentSearchResultCopyWith<$Res> get result {
  
  return $ShipmentSearchResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
