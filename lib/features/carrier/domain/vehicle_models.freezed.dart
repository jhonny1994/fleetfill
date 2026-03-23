// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CarrierVehicle {

 String get id; String get carrierId; String get plateNumber; String get vehicleType; double get capacityWeightKg; double? get capacityVolumeM3; AppVerificationState get verificationStatus; String? get verificationRejectionReason; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CarrierVehicle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarrierVehicleCopyWith<CarrierVehicle> get copyWith => _$CarrierVehicleCopyWithImpl<CarrierVehicle>(this as CarrierVehicle, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarrierVehicle&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.capacityWeightKg, capacityWeightKg) || other.capacityWeightKg == capacityWeightKg)&&(identical(other.capacityVolumeM3, capacityVolumeM3) || other.capacityVolumeM3 == capacityVolumeM3)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.verificationRejectionReason, verificationRejectionReason) || other.verificationRejectionReason == verificationRejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,plateNumber,vehicleType,capacityWeightKg,capacityVolumeM3,verificationStatus,verificationRejectionReason,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierVehicle(id: $id, carrierId: $carrierId, plateNumber: $plateNumber, vehicleType: $vehicleType, capacityWeightKg: $capacityWeightKg, capacityVolumeM3: $capacityVolumeM3, verificationStatus: $verificationStatus, verificationRejectionReason: $verificationRejectionReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CarrierVehicleCopyWith<$Res>  {
  factory $CarrierVehicleCopyWith(CarrierVehicle value, $Res Function(CarrierVehicle) _then) = _$CarrierVehicleCopyWithImpl;
@useResult
$Res call({
 String id, String carrierId, String plateNumber, String vehicleType, double capacityWeightKg, double? capacityVolumeM3, AppVerificationState verificationStatus, String? verificationRejectionReason, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CarrierVehicleCopyWithImpl<$Res>
    implements $CarrierVehicleCopyWith<$Res> {
  _$CarrierVehicleCopyWithImpl(this._self, this._then);

  final CarrierVehicle _self;
  final $Res Function(CarrierVehicle) _then;

/// Create a copy of CarrierVehicle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? carrierId = null,Object? plateNumber = null,Object? vehicleType = null,Object? capacityWeightKg = null,Object? capacityVolumeM3 = freezed,Object? verificationStatus = null,Object? verificationRejectionReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,capacityWeightKg: null == capacityWeightKg ? _self.capacityWeightKg : capacityWeightKg // ignore: cast_nullable_to_non_nullable
as double,capacityVolumeM3: freezed == capacityVolumeM3 ? _self.capacityVolumeM3 : capacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as AppVerificationState,verificationRejectionReason: freezed == verificationRejectionReason ? _self.verificationRejectionReason : verificationRejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CarrierVehicle].
extension CarrierVehiclePatterns on CarrierVehicle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarrierVehicle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarrierVehicle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarrierVehicle value)  $default,){
final _that = this;
switch (_that) {
case _CarrierVehicle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarrierVehicle value)?  $default,){
final _that = this;
switch (_that) {
case _CarrierVehicle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String carrierId,  String plateNumber,  String vehicleType,  double capacityWeightKg,  double? capacityVolumeM3,  AppVerificationState verificationStatus,  String? verificationRejectionReason,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarrierVehicle() when $default != null:
return $default(_that.id,_that.carrierId,_that.plateNumber,_that.vehicleType,_that.capacityWeightKg,_that.capacityVolumeM3,_that.verificationStatus,_that.verificationRejectionReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String carrierId,  String plateNumber,  String vehicleType,  double capacityWeightKg,  double? capacityVolumeM3,  AppVerificationState verificationStatus,  String? verificationRejectionReason,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CarrierVehicle():
return $default(_that.id,_that.carrierId,_that.plateNumber,_that.vehicleType,_that.capacityWeightKg,_that.capacityVolumeM3,_that.verificationStatus,_that.verificationRejectionReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String carrierId,  String plateNumber,  String vehicleType,  double capacityWeightKg,  double? capacityVolumeM3,  AppVerificationState verificationStatus,  String? verificationRejectionReason,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CarrierVehicle() when $default != null:
return $default(_that.id,_that.carrierId,_that.plateNumber,_that.vehicleType,_that.capacityWeightKg,_that.capacityVolumeM3,_that.verificationStatus,_that.verificationRejectionReason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CarrierVehicle extends CarrierVehicle {
  const _CarrierVehicle({required this.id, required this.carrierId, required this.plateNumber, required this.vehicleType, required this.capacityWeightKg, required this.capacityVolumeM3, required this.verificationStatus, required this.verificationRejectionReason, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String carrierId;
@override final  String plateNumber;
@override final  String vehicleType;
@override final  double capacityWeightKg;
@override final  double? capacityVolumeM3;
@override final  AppVerificationState verificationStatus;
@override final  String? verificationRejectionReason;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CarrierVehicle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarrierVehicleCopyWith<_CarrierVehicle> get copyWith => __$CarrierVehicleCopyWithImpl<_CarrierVehicle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarrierVehicle&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.capacityWeightKg, capacityWeightKg) || other.capacityWeightKg == capacityWeightKg)&&(identical(other.capacityVolumeM3, capacityVolumeM3) || other.capacityVolumeM3 == capacityVolumeM3)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.verificationRejectionReason, verificationRejectionReason) || other.verificationRejectionReason == verificationRejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,plateNumber,vehicleType,capacityWeightKg,capacityVolumeM3,verificationStatus,verificationRejectionReason,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierVehicle(id: $id, carrierId: $carrierId, plateNumber: $plateNumber, vehicleType: $vehicleType, capacityWeightKg: $capacityWeightKg, capacityVolumeM3: $capacityVolumeM3, verificationStatus: $verificationStatus, verificationRejectionReason: $verificationRejectionReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CarrierVehicleCopyWith<$Res> implements $CarrierVehicleCopyWith<$Res> {
  factory _$CarrierVehicleCopyWith(_CarrierVehicle value, $Res Function(_CarrierVehicle) _then) = __$CarrierVehicleCopyWithImpl;
@override @useResult
$Res call({
 String id, String carrierId, String plateNumber, String vehicleType, double capacityWeightKg, double? capacityVolumeM3, AppVerificationState verificationStatus, String? verificationRejectionReason, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CarrierVehicleCopyWithImpl<$Res>
    implements _$CarrierVehicleCopyWith<$Res> {
  __$CarrierVehicleCopyWithImpl(this._self, this._then);

  final _CarrierVehicle _self;
  final $Res Function(_CarrierVehicle) _then;

/// Create a copy of CarrierVehicle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? carrierId = null,Object? plateNumber = null,Object? vehicleType = null,Object? capacityWeightKg = null,Object? capacityVolumeM3 = freezed,Object? verificationStatus = null,Object? verificationRejectionReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CarrierVehicle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,capacityWeightKg: null == capacityWeightKg ? _self.capacityWeightKg : capacityWeightKg // ignore: cast_nullable_to_non_nullable
as double,capacityVolumeM3: freezed == capacityVolumeM3 ? _self.capacityVolumeM3 : capacityVolumeM3 // ignore: cast_nullable_to_non_nullable
as double?,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as AppVerificationState,verificationRejectionReason: freezed == verificationRejectionReason ? _self.verificationRejectionReason : verificationRejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$VerificationDocumentRecord {

 String get id; String get ownerProfileId; VerificationEntityType get entityType; String get entityId; VerificationDocumentType get documentType; String get storagePath; AppVerificationState get status; String? get rejectionReason; String? get reviewedBy; DateTime? get reviewedAt; DateTime? get expiresAt; int get version; String? get contentType; int? get byteSize; String? get checksumSha256; String? get uploadedBy; String? get uploadSessionId; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of VerificationDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationDocumentRecordCopyWith<VerificationDocumentRecord> get copyWith => _$VerificationDocumentRecordCopyWithImpl<VerificationDocumentRecord>(this as VerificationDocumentRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationDocumentRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerProfileId, ownerProfileId) || other.ownerProfileId == ownerProfileId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.version, version) || other.version == version)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&(identical(other.checksumSha256, checksumSha256) || other.checksumSha256 == checksumSha256)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.uploadSessionId, uploadSessionId) || other.uploadSessionId == uploadSessionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,ownerProfileId,entityType,entityId,documentType,storagePath,status,rejectionReason,reviewedBy,reviewedAt,expiresAt,version,contentType,byteSize,checksumSha256,uploadedBy,uploadSessionId,createdAt,updatedAt]);

@override
String toString() {
  return 'VerificationDocumentRecord(id: $id, ownerProfileId: $ownerProfileId, entityType: $entityType, entityId: $entityId, documentType: $documentType, storagePath: $storagePath, status: $status, rejectionReason: $rejectionReason, reviewedBy: $reviewedBy, reviewedAt: $reviewedAt, expiresAt: $expiresAt, version: $version, contentType: $contentType, byteSize: $byteSize, checksumSha256: $checksumSha256, uploadedBy: $uploadedBy, uploadSessionId: $uploadSessionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $VerificationDocumentRecordCopyWith<$Res>  {
  factory $VerificationDocumentRecordCopyWith(VerificationDocumentRecord value, $Res Function(VerificationDocumentRecord) _then) = _$VerificationDocumentRecordCopyWithImpl;
@useResult
$Res call({
 String id, String ownerProfileId, VerificationEntityType entityType, String entityId, VerificationDocumentType documentType, String storagePath, AppVerificationState status, String? rejectionReason, String? reviewedBy, DateTime? reviewedAt, DateTime? expiresAt, int version, String? contentType, int? byteSize, String? checksumSha256, String? uploadedBy, String? uploadSessionId, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$VerificationDocumentRecordCopyWithImpl<$Res>
    implements $VerificationDocumentRecordCopyWith<$Res> {
  _$VerificationDocumentRecordCopyWithImpl(this._self, this._then);

  final VerificationDocumentRecord _self;
  final $Res Function(VerificationDocumentRecord) _then;

/// Create a copy of VerificationDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerProfileId = null,Object? entityType = null,Object? entityId = null,Object? documentType = null,Object? storagePath = null,Object? status = null,Object? rejectionReason = freezed,Object? reviewedBy = freezed,Object? reviewedAt = freezed,Object? expiresAt = freezed,Object? version = null,Object? contentType = freezed,Object? byteSize = freezed,Object? checksumSha256 = freezed,Object? uploadedBy = freezed,Object? uploadSessionId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerProfileId: null == ownerProfileId ? _self.ownerProfileId : ownerProfileId // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as VerificationEntityType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as VerificationDocumentType,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppVerificationState,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,byteSize: freezed == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int?,checksumSha256: freezed == checksumSha256 ? _self.checksumSha256 : checksumSha256 // ignore: cast_nullable_to_non_nullable
as String?,uploadedBy: freezed == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String?,uploadSessionId: freezed == uploadSessionId ? _self.uploadSessionId : uploadSessionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationDocumentRecord].
extension VerificationDocumentRecordPatterns on VerificationDocumentRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationDocumentRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationDocumentRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationDocumentRecord value)  $default,){
final _that = this;
switch (_that) {
case _VerificationDocumentRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationDocumentRecord value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationDocumentRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ownerProfileId,  VerificationEntityType entityType,  String entityId,  VerificationDocumentType documentType,  String storagePath,  AppVerificationState status,  String? rejectionReason,  String? reviewedBy,  DateTime? reviewedAt,  DateTime? expiresAt,  int version,  String? contentType,  int? byteSize,  String? checksumSha256,  String? uploadedBy,  String? uploadSessionId,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationDocumentRecord() when $default != null:
return $default(_that.id,_that.ownerProfileId,_that.entityType,_that.entityId,_that.documentType,_that.storagePath,_that.status,_that.rejectionReason,_that.reviewedBy,_that.reviewedAt,_that.expiresAt,_that.version,_that.contentType,_that.byteSize,_that.checksumSha256,_that.uploadedBy,_that.uploadSessionId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ownerProfileId,  VerificationEntityType entityType,  String entityId,  VerificationDocumentType documentType,  String storagePath,  AppVerificationState status,  String? rejectionReason,  String? reviewedBy,  DateTime? reviewedAt,  DateTime? expiresAt,  int version,  String? contentType,  int? byteSize,  String? checksumSha256,  String? uploadedBy,  String? uploadSessionId,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _VerificationDocumentRecord():
return $default(_that.id,_that.ownerProfileId,_that.entityType,_that.entityId,_that.documentType,_that.storagePath,_that.status,_that.rejectionReason,_that.reviewedBy,_that.reviewedAt,_that.expiresAt,_that.version,_that.contentType,_that.byteSize,_that.checksumSha256,_that.uploadedBy,_that.uploadSessionId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ownerProfileId,  VerificationEntityType entityType,  String entityId,  VerificationDocumentType documentType,  String storagePath,  AppVerificationState status,  String? rejectionReason,  String? reviewedBy,  DateTime? reviewedAt,  DateTime? expiresAt,  int version,  String? contentType,  int? byteSize,  String? checksumSha256,  String? uploadedBy,  String? uploadSessionId,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _VerificationDocumentRecord() when $default != null:
return $default(_that.id,_that.ownerProfileId,_that.entityType,_that.entityId,_that.documentType,_that.storagePath,_that.status,_that.rejectionReason,_that.reviewedBy,_that.reviewedAt,_that.expiresAt,_that.version,_that.contentType,_that.byteSize,_that.checksumSha256,_that.uploadedBy,_that.uploadSessionId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _VerificationDocumentRecord extends VerificationDocumentRecord {
  const _VerificationDocumentRecord({required this.id, required this.ownerProfileId, required this.entityType, required this.entityId, required this.documentType, required this.storagePath, required this.status, required this.rejectionReason, required this.reviewedBy, required this.reviewedAt, required this.expiresAt, required this.version, required this.contentType, required this.byteSize, required this.checksumSha256, required this.uploadedBy, required this.uploadSessionId, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String ownerProfileId;
@override final  VerificationEntityType entityType;
@override final  String entityId;
@override final  VerificationDocumentType documentType;
@override final  String storagePath;
@override final  AppVerificationState status;
@override final  String? rejectionReason;
@override final  String? reviewedBy;
@override final  DateTime? reviewedAt;
@override final  DateTime? expiresAt;
@override final  int version;
@override final  String? contentType;
@override final  int? byteSize;
@override final  String? checksumSha256;
@override final  String? uploadedBy;
@override final  String? uploadSessionId;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of VerificationDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationDocumentRecordCopyWith<_VerificationDocumentRecord> get copyWith => __$VerificationDocumentRecordCopyWithImpl<_VerificationDocumentRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationDocumentRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerProfileId, ownerProfileId) || other.ownerProfileId == ownerProfileId)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.version, version) || other.version == version)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&(identical(other.checksumSha256, checksumSha256) || other.checksumSha256 == checksumSha256)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.uploadSessionId, uploadSessionId) || other.uploadSessionId == uploadSessionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,ownerProfileId,entityType,entityId,documentType,storagePath,status,rejectionReason,reviewedBy,reviewedAt,expiresAt,version,contentType,byteSize,checksumSha256,uploadedBy,uploadSessionId,createdAt,updatedAt]);

@override
String toString() {
  return 'VerificationDocumentRecord(id: $id, ownerProfileId: $ownerProfileId, entityType: $entityType, entityId: $entityId, documentType: $documentType, storagePath: $storagePath, status: $status, rejectionReason: $rejectionReason, reviewedBy: $reviewedBy, reviewedAt: $reviewedAt, expiresAt: $expiresAt, version: $version, contentType: $contentType, byteSize: $byteSize, checksumSha256: $checksumSha256, uploadedBy: $uploadedBy, uploadSessionId: $uploadSessionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$VerificationDocumentRecordCopyWith<$Res> implements $VerificationDocumentRecordCopyWith<$Res> {
  factory _$VerificationDocumentRecordCopyWith(_VerificationDocumentRecord value, $Res Function(_VerificationDocumentRecord) _then) = __$VerificationDocumentRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String ownerProfileId, VerificationEntityType entityType, String entityId, VerificationDocumentType documentType, String storagePath, AppVerificationState status, String? rejectionReason, String? reviewedBy, DateTime? reviewedAt, DateTime? expiresAt, int version, String? contentType, int? byteSize, String? checksumSha256, String? uploadedBy, String? uploadSessionId, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$VerificationDocumentRecordCopyWithImpl<$Res>
    implements _$VerificationDocumentRecordCopyWith<$Res> {
  __$VerificationDocumentRecordCopyWithImpl(this._self, this._then);

  final _VerificationDocumentRecord _self;
  final $Res Function(_VerificationDocumentRecord) _then;

/// Create a copy of VerificationDocumentRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerProfileId = null,Object? entityType = null,Object? entityId = null,Object? documentType = null,Object? storagePath = null,Object? status = null,Object? rejectionReason = freezed,Object? reviewedBy = freezed,Object? reviewedAt = freezed,Object? expiresAt = freezed,Object? version = null,Object? contentType = freezed,Object? byteSize = freezed,Object? checksumSha256 = freezed,Object? uploadedBy = freezed,Object? uploadSessionId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_VerificationDocumentRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerProfileId: null == ownerProfileId ? _self.ownerProfileId : ownerProfileId // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as VerificationEntityType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as VerificationDocumentType,storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppVerificationState,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,byteSize: freezed == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int?,checksumSha256: freezed == checksumSha256 ? _self.checksumSha256 : checksumSha256 // ignore: cast_nullable_to_non_nullable
as String?,uploadedBy: freezed == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as String?,uploadSessionId: freezed == uploadSessionId ? _self.uploadSessionId : uploadSessionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$VehicleVerificationOverview {

 CarrierVehicle get vehicle; List<VerificationDocumentRecord> get documents;
/// Create a copy of VehicleVerificationOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleVerificationOverviewCopyWith<VehicleVerificationOverview> get copyWith => _$VehicleVerificationOverviewCopyWithImpl<VehicleVerificationOverview>(this as VehicleVerificationOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleVerificationOverview&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&const DeepCollectionEquality().equals(other.documents, documents));
}


@override
int get hashCode => Object.hash(runtimeType,vehicle,const DeepCollectionEquality().hash(documents));

@override
String toString() {
  return 'VehicleVerificationOverview(vehicle: $vehicle, documents: $documents)';
}


}

/// @nodoc
abstract mixin class $VehicleVerificationOverviewCopyWith<$Res>  {
  factory $VehicleVerificationOverviewCopyWith(VehicleVerificationOverview value, $Res Function(VehicleVerificationOverview) _then) = _$VehicleVerificationOverviewCopyWithImpl;
@useResult
$Res call({
 CarrierVehicle vehicle, List<VerificationDocumentRecord> documents
});


$CarrierVehicleCopyWith<$Res> get vehicle;

}
/// @nodoc
class _$VehicleVerificationOverviewCopyWithImpl<$Res>
    implements $VehicleVerificationOverviewCopyWith<$Res> {
  _$VehicleVerificationOverviewCopyWithImpl(this._self, this._then);

  final VehicleVerificationOverview _self;
  final $Res Function(VehicleVerificationOverview) _then;

/// Create a copy of VehicleVerificationOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vehicle = null,Object? documents = null,}) {
  return _then(_self.copyWith(
vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as CarrierVehicle,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<VerificationDocumentRecord>,
  ));
}
/// Create a copy of VehicleVerificationOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarrierVehicleCopyWith<$Res> get vehicle {
  
  return $CarrierVehicleCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}


/// Adds pattern-matching-related methods to [VehicleVerificationOverview].
extension VehicleVerificationOverviewPatterns on VehicleVerificationOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleVerificationOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleVerificationOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleVerificationOverview value)  $default,){
final _that = this;
switch (_that) {
case _VehicleVerificationOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleVerificationOverview value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleVerificationOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CarrierVehicle vehicle,  List<VerificationDocumentRecord> documents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleVerificationOverview() when $default != null:
return $default(_that.vehicle,_that.documents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CarrierVehicle vehicle,  List<VerificationDocumentRecord> documents)  $default,) {final _that = this;
switch (_that) {
case _VehicleVerificationOverview():
return $default(_that.vehicle,_that.documents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CarrierVehicle vehicle,  List<VerificationDocumentRecord> documents)?  $default,) {final _that = this;
switch (_that) {
case _VehicleVerificationOverview() when $default != null:
return $default(_that.vehicle,_that.documents);case _:
  return null;

}
}

}

/// @nodoc


class _VehicleVerificationOverview extends VehicleVerificationOverview {
  const _VehicleVerificationOverview({required this.vehicle, required final  List<VerificationDocumentRecord> documents}): _documents = documents,super._();
  

@override final  CarrierVehicle vehicle;
 final  List<VerificationDocumentRecord> _documents;
@override List<VerificationDocumentRecord> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}


/// Create a copy of VehicleVerificationOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleVerificationOverviewCopyWith<_VehicleVerificationOverview> get copyWith => __$VehicleVerificationOverviewCopyWithImpl<_VehicleVerificationOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleVerificationOverview&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&const DeepCollectionEquality().equals(other._documents, _documents));
}


@override
int get hashCode => Object.hash(runtimeType,vehicle,const DeepCollectionEquality().hash(_documents));

@override
String toString() {
  return 'VehicleVerificationOverview(vehicle: $vehicle, documents: $documents)';
}


}

/// @nodoc
abstract mixin class _$VehicleVerificationOverviewCopyWith<$Res> implements $VehicleVerificationOverviewCopyWith<$Res> {
  factory _$VehicleVerificationOverviewCopyWith(_VehicleVerificationOverview value, $Res Function(_VehicleVerificationOverview) _then) = __$VehicleVerificationOverviewCopyWithImpl;
@override @useResult
$Res call({
 CarrierVehicle vehicle, List<VerificationDocumentRecord> documents
});


@override $CarrierVehicleCopyWith<$Res> get vehicle;

}
/// @nodoc
class __$VehicleVerificationOverviewCopyWithImpl<$Res>
    implements _$VehicleVerificationOverviewCopyWith<$Res> {
  __$VehicleVerificationOverviewCopyWithImpl(this._self, this._then);

  final _VehicleVerificationOverview _self;
  final $Res Function(_VehicleVerificationOverview) _then;

/// Create a copy of VehicleVerificationOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vehicle = null,Object? documents = null,}) {
  return _then(_VehicleVerificationOverview(
vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as CarrierVehicle,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<VerificationDocumentRecord>,
  ));
}

/// Create a copy of VehicleVerificationOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarrierVehicleCopyWith<$Res> get vehicle {
  
  return $CarrierVehicleCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}
}

/// @nodoc
mixin _$VerificationUploadDraft {

 String get path; String get filename; String get extension; String get contentType; int get byteSize; List<int>? get bytes;
/// Create a copy of VerificationUploadDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationUploadDraftCopyWith<VerificationUploadDraft> get copyWith => _$VerificationUploadDraftCopyWithImpl<VerificationUploadDraft>(this as VerificationUploadDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationUploadDraft&&(identical(other.path, path) || other.path == path)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.extension, extension) || other.extension == extension)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&const DeepCollectionEquality().equals(other.bytes, bytes));
}


@override
int get hashCode => Object.hash(runtimeType,path,filename,extension,contentType,byteSize,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'VerificationUploadDraft(path: $path, filename: $filename, extension: $extension, contentType: $contentType, byteSize: $byteSize, bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $VerificationUploadDraftCopyWith<$Res>  {
  factory $VerificationUploadDraftCopyWith(VerificationUploadDraft value, $Res Function(VerificationUploadDraft) _then) = _$VerificationUploadDraftCopyWithImpl;
@useResult
$Res call({
 String path, String filename, String extension, String contentType, int byteSize, List<int>? bytes
});




}
/// @nodoc
class _$VerificationUploadDraftCopyWithImpl<$Res>
    implements $VerificationUploadDraftCopyWith<$Res> {
  _$VerificationUploadDraftCopyWithImpl(this._self, this._then);

  final VerificationUploadDraft _self;
  final $Res Function(VerificationUploadDraft) _then;

/// Create a copy of VerificationUploadDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? filename = null,Object? extension = null,Object? contentType = null,Object? byteSize = null,Object? bytes = freezed,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,byteSize: null == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int,bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationUploadDraft].
extension VerificationUploadDraftPatterns on VerificationUploadDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationUploadDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationUploadDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationUploadDraft value)  $default,){
final _that = this;
switch (_that) {
case _VerificationUploadDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationUploadDraft value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationUploadDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String filename,  String extension,  String contentType,  int byteSize,  List<int>? bytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationUploadDraft() when $default != null:
return $default(_that.path,_that.filename,_that.extension,_that.contentType,_that.byteSize,_that.bytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String filename,  String extension,  String contentType,  int byteSize,  List<int>? bytes)  $default,) {final _that = this;
switch (_that) {
case _VerificationUploadDraft():
return $default(_that.path,_that.filename,_that.extension,_that.contentType,_that.byteSize,_that.bytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String filename,  String extension,  String contentType,  int byteSize,  List<int>? bytes)?  $default,) {final _that = this;
switch (_that) {
case _VerificationUploadDraft() when $default != null:
return $default(_that.path,_that.filename,_that.extension,_that.contentType,_that.byteSize,_that.bytes);case _:
  return null;

}
}

}

/// @nodoc


class _VerificationUploadDraft extends VerificationUploadDraft {
  const _VerificationUploadDraft({required this.path, required this.filename, required this.extension, required this.contentType, required this.byteSize, final  List<int>? bytes}): _bytes = bytes,super._();
  

@override final  String path;
@override final  String filename;
@override final  String extension;
@override final  String contentType;
@override final  int byteSize;
 final  List<int>? _bytes;
@override List<int>? get bytes {
  final value = _bytes;
  if (value == null) return null;
  if (_bytes is EqualUnmodifiableListView) return _bytes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of VerificationUploadDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationUploadDraftCopyWith<_VerificationUploadDraft> get copyWith => __$VerificationUploadDraftCopyWithImpl<_VerificationUploadDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationUploadDraft&&(identical(other.path, path) || other.path == path)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.extension, extension) || other.extension == extension)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.byteSize, byteSize) || other.byteSize == byteSize)&&const DeepCollectionEquality().equals(other._bytes, _bytes));
}


@override
int get hashCode => Object.hash(runtimeType,path,filename,extension,contentType,byteSize,const DeepCollectionEquality().hash(_bytes));

@override
String toString() {
  return 'VerificationUploadDraft(path: $path, filename: $filename, extension: $extension, contentType: $contentType, byteSize: $byteSize, bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class _$VerificationUploadDraftCopyWith<$Res> implements $VerificationUploadDraftCopyWith<$Res> {
  factory _$VerificationUploadDraftCopyWith(_VerificationUploadDraft value, $Res Function(_VerificationUploadDraft) _then) = __$VerificationUploadDraftCopyWithImpl;
@override @useResult
$Res call({
 String path, String filename, String extension, String contentType, int byteSize, List<int>? bytes
});




}
/// @nodoc
class __$VerificationUploadDraftCopyWithImpl<$Res>
    implements _$VerificationUploadDraftCopyWith<$Res> {
  __$VerificationUploadDraftCopyWithImpl(this._self, this._then);

  final _VerificationUploadDraft _self;
  final $Res Function(_VerificationUploadDraft) _then;

/// Create a copy of VerificationUploadDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? filename = null,Object? extension = null,Object? contentType = null,Object? byteSize = null,Object? bytes = freezed,}) {
  return _then(_VerificationUploadDraft(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,byteSize: null == byteSize ? _self.byteSize : byteSize // ignore: cast_nullable_to_non_nullable
as int,bytes: freezed == bytes ? _self._bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

/// @nodoc
mixin _$VerificationReviewPacket {

 String get carrierId; String get displayName; String? get companyName; AppVerificationState get profileStatus; String? get profileRejectionReason; List<VerificationDocumentRecord> get profileDocuments; List<VehicleVerificationOverview> get vehicles;
/// Create a copy of VerificationReviewPacket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationReviewPacketCopyWith<VerificationReviewPacket> get copyWith => _$VerificationReviewPacketCopyWithImpl<VerificationReviewPacket>(this as VerificationReviewPacket, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationReviewPacket&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.profileRejectionReason, profileRejectionReason) || other.profileRejectionReason == profileRejectionReason)&&const DeepCollectionEquality().equals(other.profileDocuments, profileDocuments)&&const DeepCollectionEquality().equals(other.vehicles, vehicles));
}


@override
int get hashCode => Object.hash(runtimeType,carrierId,displayName,companyName,profileStatus,profileRejectionReason,const DeepCollectionEquality().hash(profileDocuments),const DeepCollectionEquality().hash(vehicles));

@override
String toString() {
  return 'VerificationReviewPacket(carrierId: $carrierId, displayName: $displayName, companyName: $companyName, profileStatus: $profileStatus, profileRejectionReason: $profileRejectionReason, profileDocuments: $profileDocuments, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class $VerificationReviewPacketCopyWith<$Res>  {
  factory $VerificationReviewPacketCopyWith(VerificationReviewPacket value, $Res Function(VerificationReviewPacket) _then) = _$VerificationReviewPacketCopyWithImpl;
@useResult
$Res call({
 String carrierId, String displayName, String? companyName, AppVerificationState profileStatus, String? profileRejectionReason, List<VerificationDocumentRecord> profileDocuments, List<VehicleVerificationOverview> vehicles
});




}
/// @nodoc
class _$VerificationReviewPacketCopyWithImpl<$Res>
    implements $VerificationReviewPacketCopyWith<$Res> {
  _$VerificationReviewPacketCopyWithImpl(this._self, this._then);

  final VerificationReviewPacket _self;
  final $Res Function(VerificationReviewPacket) _then;

/// Create a copy of VerificationReviewPacket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? carrierId = null,Object? displayName = null,Object? companyName = freezed,Object? profileStatus = null,Object? profileRejectionReason = freezed,Object? profileDocuments = null,Object? vehicles = null,}) {
  return _then(_self.copyWith(
carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as AppVerificationState,profileRejectionReason: freezed == profileRejectionReason ? _self.profileRejectionReason : profileRejectionReason // ignore: cast_nullable_to_non_nullable
as String?,profileDocuments: null == profileDocuments ? _self.profileDocuments : profileDocuments // ignore: cast_nullable_to_non_nullable
as List<VerificationDocumentRecord>,vehicles: null == vehicles ? _self.vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<VehicleVerificationOverview>,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationReviewPacket].
extension VerificationReviewPacketPatterns on VerificationReviewPacket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationReviewPacket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationReviewPacket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationReviewPacket value)  $default,){
final _that = this;
switch (_that) {
case _VerificationReviewPacket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationReviewPacket value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationReviewPacket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String carrierId,  String displayName,  String? companyName,  AppVerificationState profileStatus,  String? profileRejectionReason,  List<VerificationDocumentRecord> profileDocuments,  List<VehicleVerificationOverview> vehicles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationReviewPacket() when $default != null:
return $default(_that.carrierId,_that.displayName,_that.companyName,_that.profileStatus,_that.profileRejectionReason,_that.profileDocuments,_that.vehicles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String carrierId,  String displayName,  String? companyName,  AppVerificationState profileStatus,  String? profileRejectionReason,  List<VerificationDocumentRecord> profileDocuments,  List<VehicleVerificationOverview> vehicles)  $default,) {final _that = this;
switch (_that) {
case _VerificationReviewPacket():
return $default(_that.carrierId,_that.displayName,_that.companyName,_that.profileStatus,_that.profileRejectionReason,_that.profileDocuments,_that.vehicles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String carrierId,  String displayName,  String? companyName,  AppVerificationState profileStatus,  String? profileRejectionReason,  List<VerificationDocumentRecord> profileDocuments,  List<VehicleVerificationOverview> vehicles)?  $default,) {final _that = this;
switch (_that) {
case _VerificationReviewPacket() when $default != null:
return $default(_that.carrierId,_that.displayName,_that.companyName,_that.profileStatus,_that.profileRejectionReason,_that.profileDocuments,_that.vehicles);case _:
  return null;

}
}

}

/// @nodoc


class _VerificationReviewPacket extends VerificationReviewPacket {
  const _VerificationReviewPacket({required this.carrierId, required this.displayName, required this.companyName, required this.profileStatus, required this.profileRejectionReason, required final  List<VerificationDocumentRecord> profileDocuments, required final  List<VehicleVerificationOverview> vehicles}): _profileDocuments = profileDocuments,_vehicles = vehicles,super._();
  

@override final  String carrierId;
@override final  String displayName;
@override final  String? companyName;
@override final  AppVerificationState profileStatus;
@override final  String? profileRejectionReason;
 final  List<VerificationDocumentRecord> _profileDocuments;
@override List<VerificationDocumentRecord> get profileDocuments {
  if (_profileDocuments is EqualUnmodifiableListView) return _profileDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profileDocuments);
}

 final  List<VehicleVerificationOverview> _vehicles;
@override List<VehicleVerificationOverview> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}


/// Create a copy of VerificationReviewPacket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationReviewPacketCopyWith<_VerificationReviewPacket> get copyWith => __$VerificationReviewPacketCopyWithImpl<_VerificationReviewPacket>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationReviewPacket&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.profileRejectionReason, profileRejectionReason) || other.profileRejectionReason == profileRejectionReason)&&const DeepCollectionEquality().equals(other._profileDocuments, _profileDocuments)&&const DeepCollectionEquality().equals(other._vehicles, _vehicles));
}


@override
int get hashCode => Object.hash(runtimeType,carrierId,displayName,companyName,profileStatus,profileRejectionReason,const DeepCollectionEquality().hash(_profileDocuments),const DeepCollectionEquality().hash(_vehicles));

@override
String toString() {
  return 'VerificationReviewPacket(carrierId: $carrierId, displayName: $displayName, companyName: $companyName, profileStatus: $profileStatus, profileRejectionReason: $profileRejectionReason, profileDocuments: $profileDocuments, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class _$VerificationReviewPacketCopyWith<$Res> implements $VerificationReviewPacketCopyWith<$Res> {
  factory _$VerificationReviewPacketCopyWith(_VerificationReviewPacket value, $Res Function(_VerificationReviewPacket) _then) = __$VerificationReviewPacketCopyWithImpl;
@override @useResult
$Res call({
 String carrierId, String displayName, String? companyName, AppVerificationState profileStatus, String? profileRejectionReason, List<VerificationDocumentRecord> profileDocuments, List<VehicleVerificationOverview> vehicles
});




}
/// @nodoc
class __$VerificationReviewPacketCopyWithImpl<$Res>
    implements _$VerificationReviewPacketCopyWith<$Res> {
  __$VerificationReviewPacketCopyWithImpl(this._self, this._then);

  final _VerificationReviewPacket _self;
  final $Res Function(_VerificationReviewPacket) _then;

/// Create a copy of VerificationReviewPacket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? carrierId = null,Object? displayName = null,Object? companyName = freezed,Object? profileStatus = null,Object? profileRejectionReason = freezed,Object? profileDocuments = null,Object? vehicles = null,}) {
  return _then(_VerificationReviewPacket(
carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as AppVerificationState,profileRejectionReason: freezed == profileRejectionReason ? _self.profileRejectionReason : profileRejectionReason // ignore: cast_nullable_to_non_nullable
as String?,profileDocuments: null == profileDocuments ? _self._profileDocuments : profileDocuments // ignore: cast_nullable_to_non_nullable
as List<VerificationDocumentRecord>,vehicles: null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<VehicleVerificationOverview>,
  ));
}


}

/// @nodoc
mixin _$AdminAuditLogRecord {

 String get id; String get action; String get targetType; String? get targetId; String get outcome; String? get reason; Map<String, dynamic> get metadata; DateTime? get createdAt;
/// Create a copy of AdminAuditLogRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAuditLogRecordCopyWith<AdminAuditLogRecord> get copyWith => _$AdminAuditLogRecordCopyWithImpl<AdminAuditLogRecord>(this as AdminAuditLogRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAuditLogRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,action,targetType,targetId,outcome,reason,const DeepCollectionEquality().hash(metadata),createdAt);

@override
String toString() {
  return 'AdminAuditLogRecord(id: $id, action: $action, targetType: $targetType, targetId: $targetId, outcome: $outcome, reason: $reason, metadata: $metadata, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AdminAuditLogRecordCopyWith<$Res>  {
  factory $AdminAuditLogRecordCopyWith(AdminAuditLogRecord value, $Res Function(AdminAuditLogRecord) _then) = _$AdminAuditLogRecordCopyWithImpl;
@useResult
$Res call({
 String id, String action, String targetType, String? targetId, String outcome, String? reason, Map<String, dynamic> metadata, DateTime? createdAt
});




}
/// @nodoc
class _$AdminAuditLogRecordCopyWithImpl<$Res>
    implements $AdminAuditLogRecordCopyWith<$Res> {
  _$AdminAuditLogRecordCopyWithImpl(this._self, this._then);

  final AdminAuditLogRecord _self;
  final $Res Function(AdminAuditLogRecord) _then;

/// Create a copy of AdminAuditLogRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? targetType = null,Object? targetId = freezed,Object? outcome = null,Object? reason = freezed,Object? metadata = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminAuditLogRecord].
extension AdminAuditLogRecordPatterns on AdminAuditLogRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminAuditLogRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminAuditLogRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminAuditLogRecord value)  $default,){
final _that = this;
switch (_that) {
case _AdminAuditLogRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminAuditLogRecord value)?  $default,){
final _that = this;
switch (_that) {
case _AdminAuditLogRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String action,  String targetType,  String? targetId,  String outcome,  String? reason,  Map<String, dynamic> metadata,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminAuditLogRecord() when $default != null:
return $default(_that.id,_that.action,_that.targetType,_that.targetId,_that.outcome,_that.reason,_that.metadata,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String action,  String targetType,  String? targetId,  String outcome,  String? reason,  Map<String, dynamic> metadata,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AdminAuditLogRecord():
return $default(_that.id,_that.action,_that.targetType,_that.targetId,_that.outcome,_that.reason,_that.metadata,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String action,  String targetType,  String? targetId,  String outcome,  String? reason,  Map<String, dynamic> metadata,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AdminAuditLogRecord() when $default != null:
return $default(_that.id,_that.action,_that.targetType,_that.targetId,_that.outcome,_that.reason,_that.metadata,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _AdminAuditLogRecord extends AdminAuditLogRecord {
  const _AdminAuditLogRecord({required this.id, required this.action, required this.targetType, required this.targetId, required this.outcome, required this.reason, required final  Map<String, dynamic> metadata, required this.createdAt}): _metadata = metadata,super._();
  

@override final  String id;
@override final  String action;
@override final  String targetType;
@override final  String? targetId;
@override final  String outcome;
@override final  String? reason;
 final  Map<String, dynamic> _metadata;
@override Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  DateTime? createdAt;

/// Create a copy of AdminAuditLogRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminAuditLogRecordCopyWith<_AdminAuditLogRecord> get copyWith => __$AdminAuditLogRecordCopyWithImpl<_AdminAuditLogRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminAuditLogRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,action,targetType,targetId,outcome,reason,const DeepCollectionEquality().hash(_metadata),createdAt);

@override
String toString() {
  return 'AdminAuditLogRecord(id: $id, action: $action, targetType: $targetType, targetId: $targetId, outcome: $outcome, reason: $reason, metadata: $metadata, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AdminAuditLogRecordCopyWith<$Res> implements $AdminAuditLogRecordCopyWith<$Res> {
  factory _$AdminAuditLogRecordCopyWith(_AdminAuditLogRecord value, $Res Function(_AdminAuditLogRecord) _then) = __$AdminAuditLogRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String action, String targetType, String? targetId, String outcome, String? reason, Map<String, dynamic> metadata, DateTime? createdAt
});




}
/// @nodoc
class __$AdminAuditLogRecordCopyWithImpl<$Res>
    implements _$AdminAuditLogRecordCopyWith<$Res> {
  __$AdminAuditLogRecordCopyWithImpl(this._self, this._then);

  final _AdminAuditLogRecord _self;
  final $Res Function(_AdminAuditLogRecord) _then;

/// Create a copy of AdminAuditLogRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? action = null,Object? targetType = null,Object? targetId = freezed,Object? outcome = null,Object? reason = freezed,Object? metadata = null,Object? createdAt = freezed,}) {
  return _then(_AdminAuditLogRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
