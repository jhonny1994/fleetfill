// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SupportRequestRecord {

 String get id; String get createdBy; AppUserRole? get requesterRole; String get subject; SupportRequestStatus get status; SupportRequestPriority get priority; String? get shipmentId; String? get bookingId; String? get paymentProofId; String? get disputeId; String? get assignedAdminId; String? get lastMessagePreview; SupportMessageSenderType get lastMessageSenderType; DateTime get lastMessageAt; DateTime? get userLastReadAt; DateTime? get adminLastReadAt; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of SupportRequestRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportRequestRecordCopyWith<SupportRequestRecord> get copyWith => _$SupportRequestRecordCopyWithImpl<SupportRequestRecord>(this as SupportRequestRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportRequestRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.requesterRole, requesterRole) || other.requesterRole == requesterRole)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.shipmentId, shipmentId) || other.shipmentId == shipmentId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.paymentProofId, paymentProofId) || other.paymentProofId == paymentProofId)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.assignedAdminId, assignedAdminId) || other.assignedAdminId == assignedAdminId)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.lastMessageSenderType, lastMessageSenderType) || other.lastMessageSenderType == lastMessageSenderType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.userLastReadAt, userLastReadAt) || other.userLastReadAt == userLastReadAt)&&(identical(other.adminLastReadAt, adminLastReadAt) || other.adminLastReadAt == adminLastReadAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,createdBy,requesterRole,subject,status,priority,shipmentId,bookingId,paymentProofId,disputeId,assignedAdminId,lastMessagePreview,lastMessageSenderType,lastMessageAt,userLastReadAt,adminLastReadAt,createdAt,updatedAt);

@override
String toString() {
  return 'SupportRequestRecord(id: $id, createdBy: $createdBy, requesterRole: $requesterRole, subject: $subject, status: $status, priority: $priority, shipmentId: $shipmentId, bookingId: $bookingId, paymentProofId: $paymentProofId, disputeId: $disputeId, assignedAdminId: $assignedAdminId, lastMessagePreview: $lastMessagePreview, lastMessageSenderType: $lastMessageSenderType, lastMessageAt: $lastMessageAt, userLastReadAt: $userLastReadAt, adminLastReadAt: $adminLastReadAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SupportRequestRecordCopyWith<$Res>  {
  factory $SupportRequestRecordCopyWith(SupportRequestRecord value, $Res Function(SupportRequestRecord) _then) = _$SupportRequestRecordCopyWithImpl;
@useResult
$Res call({
 String id, String createdBy, AppUserRole? requesterRole, String subject, SupportRequestStatus status, SupportRequestPriority priority, String? shipmentId, String? bookingId, String? paymentProofId, String? disputeId, String? assignedAdminId, String? lastMessagePreview, SupportMessageSenderType lastMessageSenderType, DateTime lastMessageAt, DateTime? userLastReadAt, DateTime? adminLastReadAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$SupportRequestRecordCopyWithImpl<$Res>
    implements $SupportRequestRecordCopyWith<$Res> {
  _$SupportRequestRecordCopyWithImpl(this._self, this._then);

  final SupportRequestRecord _self;
  final $Res Function(SupportRequestRecord) _then;

/// Create a copy of SupportRequestRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdBy = null,Object? requesterRole = freezed,Object? subject = null,Object? status = null,Object? priority = null,Object? shipmentId = freezed,Object? bookingId = freezed,Object? paymentProofId = freezed,Object? disputeId = freezed,Object? assignedAdminId = freezed,Object? lastMessagePreview = freezed,Object? lastMessageSenderType = null,Object? lastMessageAt = null,Object? userLastReadAt = freezed,Object? adminLastReadAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,requesterRole: freezed == requesterRole ? _self.requesterRole : requesterRole // ignore: cast_nullable_to_non_nullable
as AppUserRole?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SupportRequestStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SupportRequestPriority,shipmentId: freezed == shipmentId ? _self.shipmentId : shipmentId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,paymentProofId: freezed == paymentProofId ? _self.paymentProofId : paymentProofId // ignore: cast_nullable_to_non_nullable
as String?,disputeId: freezed == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String?,assignedAdminId: freezed == assignedAdminId ? _self.assignedAdminId : assignedAdminId // ignore: cast_nullable_to_non_nullable
as String?,lastMessagePreview: freezed == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderType: null == lastMessageSenderType ? _self.lastMessageSenderType : lastMessageSenderType // ignore: cast_nullable_to_non_nullable
as SupportMessageSenderType,lastMessageAt: null == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime,userLastReadAt: freezed == userLastReadAt ? _self.userLastReadAt : userLastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminLastReadAt: freezed == adminLastReadAt ? _self.adminLastReadAt : adminLastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportRequestRecord].
extension SupportRequestRecordPatterns on SupportRequestRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportRequestRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportRequestRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportRequestRecord value)  $default,){
final _that = this;
switch (_that) {
case _SupportRequestRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportRequestRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SupportRequestRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String createdBy,  AppUserRole? requesterRole,  String subject,  SupportRequestStatus status,  SupportRequestPriority priority,  String? shipmentId,  String? bookingId,  String? paymentProofId,  String? disputeId,  String? assignedAdminId,  String? lastMessagePreview,  SupportMessageSenderType lastMessageSenderType,  DateTime lastMessageAt,  DateTime? userLastReadAt,  DateTime? adminLastReadAt,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportRequestRecord() when $default != null:
return $default(_that.id,_that.createdBy,_that.requesterRole,_that.subject,_that.status,_that.priority,_that.shipmentId,_that.bookingId,_that.paymentProofId,_that.disputeId,_that.assignedAdminId,_that.lastMessagePreview,_that.lastMessageSenderType,_that.lastMessageAt,_that.userLastReadAt,_that.adminLastReadAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String createdBy,  AppUserRole? requesterRole,  String subject,  SupportRequestStatus status,  SupportRequestPriority priority,  String? shipmentId,  String? bookingId,  String? paymentProofId,  String? disputeId,  String? assignedAdminId,  String? lastMessagePreview,  SupportMessageSenderType lastMessageSenderType,  DateTime lastMessageAt,  DateTime? userLastReadAt,  DateTime? adminLastReadAt,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SupportRequestRecord():
return $default(_that.id,_that.createdBy,_that.requesterRole,_that.subject,_that.status,_that.priority,_that.shipmentId,_that.bookingId,_that.paymentProofId,_that.disputeId,_that.assignedAdminId,_that.lastMessagePreview,_that.lastMessageSenderType,_that.lastMessageAt,_that.userLastReadAt,_that.adminLastReadAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String createdBy,  AppUserRole? requesterRole,  String subject,  SupportRequestStatus status,  SupportRequestPriority priority,  String? shipmentId,  String? bookingId,  String? paymentProofId,  String? disputeId,  String? assignedAdminId,  String? lastMessagePreview,  SupportMessageSenderType lastMessageSenderType,  DateTime lastMessageAt,  DateTime? userLastReadAt,  DateTime? adminLastReadAt,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SupportRequestRecord() when $default != null:
return $default(_that.id,_that.createdBy,_that.requesterRole,_that.subject,_that.status,_that.priority,_that.shipmentId,_that.bookingId,_that.paymentProofId,_that.disputeId,_that.assignedAdminId,_that.lastMessagePreview,_that.lastMessageSenderType,_that.lastMessageAt,_that.userLastReadAt,_that.adminLastReadAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SupportRequestRecord extends SupportRequestRecord {
  const _SupportRequestRecord({required this.id, required this.createdBy, required this.requesterRole, required this.subject, required this.status, required this.priority, required this.shipmentId, required this.bookingId, required this.paymentProofId, required this.disputeId, required this.assignedAdminId, required this.lastMessagePreview, required this.lastMessageSenderType, required this.lastMessageAt, required this.userLastReadAt, required this.adminLastReadAt, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String createdBy;
@override final  AppUserRole? requesterRole;
@override final  String subject;
@override final  SupportRequestStatus status;
@override final  SupportRequestPriority priority;
@override final  String? shipmentId;
@override final  String? bookingId;
@override final  String? paymentProofId;
@override final  String? disputeId;
@override final  String? assignedAdminId;
@override final  String? lastMessagePreview;
@override final  SupportMessageSenderType lastMessageSenderType;
@override final  DateTime lastMessageAt;
@override final  DateTime? userLastReadAt;
@override final  DateTime? adminLastReadAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of SupportRequestRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportRequestRecordCopyWith<_SupportRequestRecord> get copyWith => __$SupportRequestRecordCopyWithImpl<_SupportRequestRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportRequestRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.requesterRole, requesterRole) || other.requesterRole == requesterRole)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.shipmentId, shipmentId) || other.shipmentId == shipmentId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.paymentProofId, paymentProofId) || other.paymentProofId == paymentProofId)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.assignedAdminId, assignedAdminId) || other.assignedAdminId == assignedAdminId)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.lastMessageSenderType, lastMessageSenderType) || other.lastMessageSenderType == lastMessageSenderType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.userLastReadAt, userLastReadAt) || other.userLastReadAt == userLastReadAt)&&(identical(other.adminLastReadAt, adminLastReadAt) || other.adminLastReadAt == adminLastReadAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,createdBy,requesterRole,subject,status,priority,shipmentId,bookingId,paymentProofId,disputeId,assignedAdminId,lastMessagePreview,lastMessageSenderType,lastMessageAt,userLastReadAt,adminLastReadAt,createdAt,updatedAt);

@override
String toString() {
  return 'SupportRequestRecord(id: $id, createdBy: $createdBy, requesterRole: $requesterRole, subject: $subject, status: $status, priority: $priority, shipmentId: $shipmentId, bookingId: $bookingId, paymentProofId: $paymentProofId, disputeId: $disputeId, assignedAdminId: $assignedAdminId, lastMessagePreview: $lastMessagePreview, lastMessageSenderType: $lastMessageSenderType, lastMessageAt: $lastMessageAt, userLastReadAt: $userLastReadAt, adminLastReadAt: $adminLastReadAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SupportRequestRecordCopyWith<$Res> implements $SupportRequestRecordCopyWith<$Res> {
  factory _$SupportRequestRecordCopyWith(_SupportRequestRecord value, $Res Function(_SupportRequestRecord) _then) = __$SupportRequestRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String createdBy, AppUserRole? requesterRole, String subject, SupportRequestStatus status, SupportRequestPriority priority, String? shipmentId, String? bookingId, String? paymentProofId, String? disputeId, String? assignedAdminId, String? lastMessagePreview, SupportMessageSenderType lastMessageSenderType, DateTime lastMessageAt, DateTime? userLastReadAt, DateTime? adminLastReadAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$SupportRequestRecordCopyWithImpl<$Res>
    implements _$SupportRequestRecordCopyWith<$Res> {
  __$SupportRequestRecordCopyWithImpl(this._self, this._then);

  final _SupportRequestRecord _self;
  final $Res Function(_SupportRequestRecord) _then;

/// Create a copy of SupportRequestRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdBy = null,Object? requesterRole = freezed,Object? subject = null,Object? status = null,Object? priority = null,Object? shipmentId = freezed,Object? bookingId = freezed,Object? paymentProofId = freezed,Object? disputeId = freezed,Object? assignedAdminId = freezed,Object? lastMessagePreview = freezed,Object? lastMessageSenderType = null,Object? lastMessageAt = null,Object? userLastReadAt = freezed,Object? adminLastReadAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_SupportRequestRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,requesterRole: freezed == requesterRole ? _self.requesterRole : requesterRole // ignore: cast_nullable_to_non_nullable
as AppUserRole?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SupportRequestStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as SupportRequestPriority,shipmentId: freezed == shipmentId ? _self.shipmentId : shipmentId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,paymentProofId: freezed == paymentProofId ? _self.paymentProofId : paymentProofId // ignore: cast_nullable_to_non_nullable
as String?,disputeId: freezed == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String?,assignedAdminId: freezed == assignedAdminId ? _self.assignedAdminId : assignedAdminId // ignore: cast_nullable_to_non_nullable
as String?,lastMessagePreview: freezed == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderType: null == lastMessageSenderType ? _self.lastMessageSenderType : lastMessageSenderType // ignore: cast_nullable_to_non_nullable
as SupportMessageSenderType,lastMessageAt: null == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime,userLastReadAt: freezed == userLastReadAt ? _self.userLastReadAt : userLastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminLastReadAt: freezed == adminLastReadAt ? _self.adminLastReadAt : adminLastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$SupportMessageRecord {

 String get id; String get requestId; String? get senderProfileId; SupportMessageSenderType get senderType; String get body; DateTime get createdAt;
/// Create a copy of SupportMessageRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportMessageRecordCopyWith<SupportMessageRecord> get copyWith => _$SupportMessageRecordCopyWithImpl<SupportMessageRecord>(this as SupportMessageRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportMessageRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.senderProfileId, senderProfileId) || other.senderProfileId == senderProfileId)&&(identical(other.senderType, senderType) || other.senderType == senderType)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,requestId,senderProfileId,senderType,body,createdAt);

@override
String toString() {
  return 'SupportMessageRecord(id: $id, requestId: $requestId, senderProfileId: $senderProfileId, senderType: $senderType, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SupportMessageRecordCopyWith<$Res>  {
  factory $SupportMessageRecordCopyWith(SupportMessageRecord value, $Res Function(SupportMessageRecord) _then) = _$SupportMessageRecordCopyWithImpl;
@useResult
$Res call({
 String id, String requestId, String? senderProfileId, SupportMessageSenderType senderType, String body, DateTime createdAt
});




}
/// @nodoc
class _$SupportMessageRecordCopyWithImpl<$Res>
    implements $SupportMessageRecordCopyWith<$Res> {
  _$SupportMessageRecordCopyWithImpl(this._self, this._then);

  final SupportMessageRecord _self;
  final $Res Function(SupportMessageRecord) _then;

/// Create a copy of SupportMessageRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestId = null,Object? senderProfileId = freezed,Object? senderType = null,Object? body = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,senderProfileId: freezed == senderProfileId ? _self.senderProfileId : senderProfileId // ignore: cast_nullable_to_non_nullable
as String?,senderType: null == senderType ? _self.senderType : senderType // ignore: cast_nullable_to_non_nullable
as SupportMessageSenderType,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportMessageRecord].
extension SupportMessageRecordPatterns on SupportMessageRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportMessageRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportMessageRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportMessageRecord value)  $default,){
final _that = this;
switch (_that) {
case _SupportMessageRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportMessageRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SupportMessageRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String requestId,  String? senderProfileId,  SupportMessageSenderType senderType,  String body,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportMessageRecord() when $default != null:
return $default(_that.id,_that.requestId,_that.senderProfileId,_that.senderType,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String requestId,  String? senderProfileId,  SupportMessageSenderType senderType,  String body,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SupportMessageRecord():
return $default(_that.id,_that.requestId,_that.senderProfileId,_that.senderType,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String requestId,  String? senderProfileId,  SupportMessageSenderType senderType,  String body,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SupportMessageRecord() when $default != null:
return $default(_that.id,_that.requestId,_that.senderProfileId,_that.senderType,_that.body,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _SupportMessageRecord extends SupportMessageRecord {
  const _SupportMessageRecord({required this.id, required this.requestId, required this.senderProfileId, required this.senderType, required this.body, required this.createdAt}): super._();
  

@override final  String id;
@override final  String requestId;
@override final  String? senderProfileId;
@override final  SupportMessageSenderType senderType;
@override final  String body;
@override final  DateTime createdAt;

/// Create a copy of SupportMessageRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportMessageRecordCopyWith<_SupportMessageRecord> get copyWith => __$SupportMessageRecordCopyWithImpl<_SupportMessageRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportMessageRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.senderProfileId, senderProfileId) || other.senderProfileId == senderProfileId)&&(identical(other.senderType, senderType) || other.senderType == senderType)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,requestId,senderProfileId,senderType,body,createdAt);

@override
String toString() {
  return 'SupportMessageRecord(id: $id, requestId: $requestId, senderProfileId: $senderProfileId, senderType: $senderType, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SupportMessageRecordCopyWith<$Res> implements $SupportMessageRecordCopyWith<$Res> {
  factory _$SupportMessageRecordCopyWith(_SupportMessageRecord value, $Res Function(_SupportMessageRecord) _then) = __$SupportMessageRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String requestId, String? senderProfileId, SupportMessageSenderType senderType, String body, DateTime createdAt
});




}
/// @nodoc
class __$SupportMessageRecordCopyWithImpl<$Res>
    implements _$SupportMessageRecordCopyWith<$Res> {
  __$SupportMessageRecordCopyWithImpl(this._self, this._then);

  final _SupportMessageRecord _self;
  final $Res Function(_SupportMessageRecord) _then;

/// Create a copy of SupportMessageRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requestId = null,Object? senderProfileId = freezed,Object? senderType = null,Object? body = null,Object? createdAt = null,}) {
  return _then(_SupportMessageRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,senderProfileId: freezed == senderProfileId ? _self.senderProfileId : senderProfileId // ignore: cast_nullable_to_non_nullable
as String?,senderType: null == senderType ? _self.senderType : senderType // ignore: cast_nullable_to_non_nullable
as SupportMessageSenderType,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$SupportThreadRecord {

 SupportRequestRecord get request; List<SupportMessageRecord> get messages;
/// Create a copy of SupportThreadRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportThreadRecordCopyWith<SupportThreadRecord> get copyWith => _$SupportThreadRecordCopyWithImpl<SupportThreadRecord>(this as SupportThreadRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportThreadRecord&&(identical(other.request, request) || other.request == request)&&const DeepCollectionEquality().equals(other.messages, messages));
}


@override
int get hashCode => Object.hash(runtimeType,request,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'SupportThreadRecord(request: $request, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $SupportThreadRecordCopyWith<$Res>  {
  factory $SupportThreadRecordCopyWith(SupportThreadRecord value, $Res Function(SupportThreadRecord) _then) = _$SupportThreadRecordCopyWithImpl;
@useResult
$Res call({
 SupportRequestRecord request, List<SupportMessageRecord> messages
});


$SupportRequestRecordCopyWith<$Res> get request;

}
/// @nodoc
class _$SupportThreadRecordCopyWithImpl<$Res>
    implements $SupportThreadRecordCopyWith<$Res> {
  _$SupportThreadRecordCopyWithImpl(this._self, this._then);

  final SupportThreadRecord _self;
  final $Res Function(SupportThreadRecord) _then;

/// Create a copy of SupportThreadRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? request = null,Object? messages = null,}) {
  return _then(_self.copyWith(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as SupportRequestRecord,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<SupportMessageRecord>,
  ));
}
/// Create a copy of SupportThreadRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportRequestRecordCopyWith<$Res> get request {
  
  return $SupportRequestRecordCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [SupportThreadRecord].
extension SupportThreadRecordPatterns on SupportThreadRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportThreadRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportThreadRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportThreadRecord value)  $default,){
final _that = this;
switch (_that) {
case _SupportThreadRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportThreadRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SupportThreadRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SupportRequestRecord request,  List<SupportMessageRecord> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportThreadRecord() when $default != null:
return $default(_that.request,_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SupportRequestRecord request,  List<SupportMessageRecord> messages)  $default,) {final _that = this;
switch (_that) {
case _SupportThreadRecord():
return $default(_that.request,_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SupportRequestRecord request,  List<SupportMessageRecord> messages)?  $default,) {final _that = this;
switch (_that) {
case _SupportThreadRecord() when $default != null:
return $default(_that.request,_that.messages);case _:
  return null;

}
}

}

/// @nodoc


class _SupportThreadRecord implements SupportThreadRecord {
  const _SupportThreadRecord({required this.request, required final  List<SupportMessageRecord> messages}): _messages = messages;
  

@override final  SupportRequestRecord request;
 final  List<SupportMessageRecord> _messages;
@override List<SupportMessageRecord> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of SupportThreadRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportThreadRecordCopyWith<_SupportThreadRecord> get copyWith => __$SupportThreadRecordCopyWithImpl<_SupportThreadRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportThreadRecord&&(identical(other.request, request) || other.request == request)&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,request,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'SupportThreadRecord(request: $request, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$SupportThreadRecordCopyWith<$Res> implements $SupportThreadRecordCopyWith<$Res> {
  factory _$SupportThreadRecordCopyWith(_SupportThreadRecord value, $Res Function(_SupportThreadRecord) _then) = __$SupportThreadRecordCopyWithImpl;
@override @useResult
$Res call({
 SupportRequestRecord request, List<SupportMessageRecord> messages
});


@override $SupportRequestRecordCopyWith<$Res> get request;

}
/// @nodoc
class __$SupportThreadRecordCopyWithImpl<$Res>
    implements _$SupportThreadRecordCopyWith<$Res> {
  __$SupportThreadRecordCopyWithImpl(this._self, this._then);

  final _SupportThreadRecord _self;
  final $Res Function(_SupportThreadRecord) _then;

/// Create a copy of SupportThreadRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? request = null,Object? messages = null,}) {
  return _then(_SupportThreadRecord(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as SupportRequestRecord,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<SupportMessageRecord>,
  ));
}

/// Create a copy of SupportThreadRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportRequestRecordCopyWith<$Res> get request {
  
  return $SupportRequestRecordCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
