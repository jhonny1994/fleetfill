// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminQueueFilters {

 String? get query; String? get status;
/// Create a copy of AdminQueueFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminQueueFiltersCopyWith<AdminQueueFilters> get copyWith => _$AdminQueueFiltersCopyWithImpl<AdminQueueFilters>(this as AdminQueueFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminQueueFilters&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,query,status);

@override
String toString() {
  return 'AdminQueueFilters(query: $query, status: $status)';
}


}

/// @nodoc
abstract mixin class $AdminQueueFiltersCopyWith<$Res>  {
  factory $AdminQueueFiltersCopyWith(AdminQueueFilters value, $Res Function(AdminQueueFilters) _then) = _$AdminQueueFiltersCopyWithImpl;
@useResult
$Res call({
 String? query, String? status
});




}
/// @nodoc
class _$AdminQueueFiltersCopyWithImpl<$Res>
    implements $AdminQueueFiltersCopyWith<$Res> {
  _$AdminQueueFiltersCopyWithImpl(this._self, this._then);

  final AdminQueueFilters _self;
  final $Res Function(AdminQueueFilters) _then;

/// Create a copy of AdminQueueFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminQueueFilters].
extension AdminQueueFiltersPatterns on AdminQueueFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminQueueFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminQueueFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminQueueFilters value)  $default,){
final _that = this;
switch (_that) {
case _AdminQueueFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminQueueFilters value)?  $default,){
final _that = this;
switch (_that) {
case _AdminQueueFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? query,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminQueueFilters() when $default != null:
return $default(_that.query,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? query,  String? status)  $default,) {final _that = this;
switch (_that) {
case _AdminQueueFilters():
return $default(_that.query,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? query,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _AdminQueueFilters() when $default != null:
return $default(_that.query,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _AdminQueueFilters extends AdminQueueFilters {
  const _AdminQueueFilters({this.query, this.status}): super._();
  

@override final  String? query;
@override final  String? status;

/// Create a copy of AdminQueueFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminQueueFiltersCopyWith<_AdminQueueFilters> get copyWith => __$AdminQueueFiltersCopyWithImpl<_AdminQueueFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminQueueFilters&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,query,status);

@override
String toString() {
  return 'AdminQueueFilters(query: $query, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AdminQueueFiltersCopyWith<$Res> implements $AdminQueueFiltersCopyWith<$Res> {
  factory _$AdminQueueFiltersCopyWith(_AdminQueueFilters value, $Res Function(_AdminQueueFilters) _then) = __$AdminQueueFiltersCopyWithImpl;
@override @useResult
$Res call({
 String? query, String? status
});




}
/// @nodoc
class __$AdminQueueFiltersCopyWithImpl<$Res>
    implements _$AdminQueueFiltersCopyWith<$Res> {
  __$AdminQueueFiltersCopyWithImpl(this._self, this._then);

  final _AdminQueueFilters _self;
  final $Res Function(_AdminQueueFilters) _then;

/// Create a copy of AdminQueueFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = freezed,Object? status = freezed,}) {
  return _then(_AdminQueueFilters(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AdminOperationalSummary {

 int get verificationPackets; int get pendingVerificationDocuments; int get paymentProofs; int get disputes; int get eligiblePayouts; int get emailBacklog; int get emailDeadLetter; int get auditEventsLast24h; int get overdueDeliveryReviews; int get overduePaymentResubmissions;
/// Create a copy of AdminOperationalSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminOperationalSummaryCopyWith<AdminOperationalSummary> get copyWith => _$AdminOperationalSummaryCopyWithImpl<AdminOperationalSummary>(this as AdminOperationalSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminOperationalSummary&&(identical(other.verificationPackets, verificationPackets) || other.verificationPackets == verificationPackets)&&(identical(other.pendingVerificationDocuments, pendingVerificationDocuments) || other.pendingVerificationDocuments == pendingVerificationDocuments)&&(identical(other.paymentProofs, paymentProofs) || other.paymentProofs == paymentProofs)&&(identical(other.disputes, disputes) || other.disputes == disputes)&&(identical(other.eligiblePayouts, eligiblePayouts) || other.eligiblePayouts == eligiblePayouts)&&(identical(other.emailBacklog, emailBacklog) || other.emailBacklog == emailBacklog)&&(identical(other.emailDeadLetter, emailDeadLetter) || other.emailDeadLetter == emailDeadLetter)&&(identical(other.auditEventsLast24h, auditEventsLast24h) || other.auditEventsLast24h == auditEventsLast24h)&&(identical(other.overdueDeliveryReviews, overdueDeliveryReviews) || other.overdueDeliveryReviews == overdueDeliveryReviews)&&(identical(other.overduePaymentResubmissions, overduePaymentResubmissions) || other.overduePaymentResubmissions == overduePaymentResubmissions));
}


@override
int get hashCode => Object.hash(runtimeType,verificationPackets,pendingVerificationDocuments,paymentProofs,disputes,eligiblePayouts,emailBacklog,emailDeadLetter,auditEventsLast24h,overdueDeliveryReviews,overduePaymentResubmissions);

@override
String toString() {
  return 'AdminOperationalSummary(verificationPackets: $verificationPackets, pendingVerificationDocuments: $pendingVerificationDocuments, paymentProofs: $paymentProofs, disputes: $disputes, eligiblePayouts: $eligiblePayouts, emailBacklog: $emailBacklog, emailDeadLetter: $emailDeadLetter, auditEventsLast24h: $auditEventsLast24h, overdueDeliveryReviews: $overdueDeliveryReviews, overduePaymentResubmissions: $overduePaymentResubmissions)';
}


}

/// @nodoc
abstract mixin class $AdminOperationalSummaryCopyWith<$Res>  {
  factory $AdminOperationalSummaryCopyWith(AdminOperationalSummary value, $Res Function(AdminOperationalSummary) _then) = _$AdminOperationalSummaryCopyWithImpl;
@useResult
$Res call({
 int verificationPackets, int pendingVerificationDocuments, int paymentProofs, int disputes, int eligiblePayouts, int emailBacklog, int emailDeadLetter, int auditEventsLast24h, int overdueDeliveryReviews, int overduePaymentResubmissions
});




}
/// @nodoc
class _$AdminOperationalSummaryCopyWithImpl<$Res>
    implements $AdminOperationalSummaryCopyWith<$Res> {
  _$AdminOperationalSummaryCopyWithImpl(this._self, this._then);

  final AdminOperationalSummary _self;
  final $Res Function(AdminOperationalSummary) _then;

/// Create a copy of AdminOperationalSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verificationPackets = null,Object? pendingVerificationDocuments = null,Object? paymentProofs = null,Object? disputes = null,Object? eligiblePayouts = null,Object? emailBacklog = null,Object? emailDeadLetter = null,Object? auditEventsLast24h = null,Object? overdueDeliveryReviews = null,Object? overduePaymentResubmissions = null,}) {
  return _then(_self.copyWith(
verificationPackets: null == verificationPackets ? _self.verificationPackets : verificationPackets // ignore: cast_nullable_to_non_nullable
as int,pendingVerificationDocuments: null == pendingVerificationDocuments ? _self.pendingVerificationDocuments : pendingVerificationDocuments // ignore: cast_nullable_to_non_nullable
as int,paymentProofs: null == paymentProofs ? _self.paymentProofs : paymentProofs // ignore: cast_nullable_to_non_nullable
as int,disputes: null == disputes ? _self.disputes : disputes // ignore: cast_nullable_to_non_nullable
as int,eligiblePayouts: null == eligiblePayouts ? _self.eligiblePayouts : eligiblePayouts // ignore: cast_nullable_to_non_nullable
as int,emailBacklog: null == emailBacklog ? _self.emailBacklog : emailBacklog // ignore: cast_nullable_to_non_nullable
as int,emailDeadLetter: null == emailDeadLetter ? _self.emailDeadLetter : emailDeadLetter // ignore: cast_nullable_to_non_nullable
as int,auditEventsLast24h: null == auditEventsLast24h ? _self.auditEventsLast24h : auditEventsLast24h // ignore: cast_nullable_to_non_nullable
as int,overdueDeliveryReviews: null == overdueDeliveryReviews ? _self.overdueDeliveryReviews : overdueDeliveryReviews // ignore: cast_nullable_to_non_nullable
as int,overduePaymentResubmissions: null == overduePaymentResubmissions ? _self.overduePaymentResubmissions : overduePaymentResubmissions // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminOperationalSummary].
extension AdminOperationalSummaryPatterns on AdminOperationalSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminOperationalSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminOperationalSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminOperationalSummary value)  $default,){
final _that = this;
switch (_that) {
case _AdminOperationalSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminOperationalSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AdminOperationalSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int verificationPackets,  int pendingVerificationDocuments,  int paymentProofs,  int disputes,  int eligiblePayouts,  int emailBacklog,  int emailDeadLetter,  int auditEventsLast24h,  int overdueDeliveryReviews,  int overduePaymentResubmissions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminOperationalSummary() when $default != null:
return $default(_that.verificationPackets,_that.pendingVerificationDocuments,_that.paymentProofs,_that.disputes,_that.eligiblePayouts,_that.emailBacklog,_that.emailDeadLetter,_that.auditEventsLast24h,_that.overdueDeliveryReviews,_that.overduePaymentResubmissions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int verificationPackets,  int pendingVerificationDocuments,  int paymentProofs,  int disputes,  int eligiblePayouts,  int emailBacklog,  int emailDeadLetter,  int auditEventsLast24h,  int overdueDeliveryReviews,  int overduePaymentResubmissions)  $default,) {final _that = this;
switch (_that) {
case _AdminOperationalSummary():
return $default(_that.verificationPackets,_that.pendingVerificationDocuments,_that.paymentProofs,_that.disputes,_that.eligiblePayouts,_that.emailBacklog,_that.emailDeadLetter,_that.auditEventsLast24h,_that.overdueDeliveryReviews,_that.overduePaymentResubmissions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int verificationPackets,  int pendingVerificationDocuments,  int paymentProofs,  int disputes,  int eligiblePayouts,  int emailBacklog,  int emailDeadLetter,  int auditEventsLast24h,  int overdueDeliveryReviews,  int overduePaymentResubmissions)?  $default,) {final _that = this;
switch (_that) {
case _AdminOperationalSummary() when $default != null:
return $default(_that.verificationPackets,_that.pendingVerificationDocuments,_that.paymentProofs,_that.disputes,_that.eligiblePayouts,_that.emailBacklog,_that.emailDeadLetter,_that.auditEventsLast24h,_that.overdueDeliveryReviews,_that.overduePaymentResubmissions);case _:
  return null;

}
}

}

/// @nodoc


class _AdminOperationalSummary extends AdminOperationalSummary {
  const _AdminOperationalSummary({required this.verificationPackets, required this.pendingVerificationDocuments, required this.paymentProofs, required this.disputes, required this.eligiblePayouts, required this.emailBacklog, required this.emailDeadLetter, required this.auditEventsLast24h, required this.overdueDeliveryReviews, required this.overduePaymentResubmissions}): super._();
  

@override final  int verificationPackets;
@override final  int pendingVerificationDocuments;
@override final  int paymentProofs;
@override final  int disputes;
@override final  int eligiblePayouts;
@override final  int emailBacklog;
@override final  int emailDeadLetter;
@override final  int auditEventsLast24h;
@override final  int overdueDeliveryReviews;
@override final  int overduePaymentResubmissions;

/// Create a copy of AdminOperationalSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminOperationalSummaryCopyWith<_AdminOperationalSummary> get copyWith => __$AdminOperationalSummaryCopyWithImpl<_AdminOperationalSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminOperationalSummary&&(identical(other.verificationPackets, verificationPackets) || other.verificationPackets == verificationPackets)&&(identical(other.pendingVerificationDocuments, pendingVerificationDocuments) || other.pendingVerificationDocuments == pendingVerificationDocuments)&&(identical(other.paymentProofs, paymentProofs) || other.paymentProofs == paymentProofs)&&(identical(other.disputes, disputes) || other.disputes == disputes)&&(identical(other.eligiblePayouts, eligiblePayouts) || other.eligiblePayouts == eligiblePayouts)&&(identical(other.emailBacklog, emailBacklog) || other.emailBacklog == emailBacklog)&&(identical(other.emailDeadLetter, emailDeadLetter) || other.emailDeadLetter == emailDeadLetter)&&(identical(other.auditEventsLast24h, auditEventsLast24h) || other.auditEventsLast24h == auditEventsLast24h)&&(identical(other.overdueDeliveryReviews, overdueDeliveryReviews) || other.overdueDeliveryReviews == overdueDeliveryReviews)&&(identical(other.overduePaymentResubmissions, overduePaymentResubmissions) || other.overduePaymentResubmissions == overduePaymentResubmissions));
}


@override
int get hashCode => Object.hash(runtimeType,verificationPackets,pendingVerificationDocuments,paymentProofs,disputes,eligiblePayouts,emailBacklog,emailDeadLetter,auditEventsLast24h,overdueDeliveryReviews,overduePaymentResubmissions);

@override
String toString() {
  return 'AdminOperationalSummary(verificationPackets: $verificationPackets, pendingVerificationDocuments: $pendingVerificationDocuments, paymentProofs: $paymentProofs, disputes: $disputes, eligiblePayouts: $eligiblePayouts, emailBacklog: $emailBacklog, emailDeadLetter: $emailDeadLetter, auditEventsLast24h: $auditEventsLast24h, overdueDeliveryReviews: $overdueDeliveryReviews, overduePaymentResubmissions: $overduePaymentResubmissions)';
}


}

/// @nodoc
abstract mixin class _$AdminOperationalSummaryCopyWith<$Res> implements $AdminOperationalSummaryCopyWith<$Res> {
  factory _$AdminOperationalSummaryCopyWith(_AdminOperationalSummary value, $Res Function(_AdminOperationalSummary) _then) = __$AdminOperationalSummaryCopyWithImpl;
@override @useResult
$Res call({
 int verificationPackets, int pendingVerificationDocuments, int paymentProofs, int disputes, int eligiblePayouts, int emailBacklog, int emailDeadLetter, int auditEventsLast24h, int overdueDeliveryReviews, int overduePaymentResubmissions
});




}
/// @nodoc
class __$AdminOperationalSummaryCopyWithImpl<$Res>
    implements _$AdminOperationalSummaryCopyWith<$Res> {
  __$AdminOperationalSummaryCopyWithImpl(this._self, this._then);

  final _AdminOperationalSummary _self;
  final $Res Function(_AdminOperationalSummary) _then;

/// Create a copy of AdminOperationalSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verificationPackets = null,Object? pendingVerificationDocuments = null,Object? paymentProofs = null,Object? disputes = null,Object? eligiblePayouts = null,Object? emailBacklog = null,Object? emailDeadLetter = null,Object? auditEventsLast24h = null,Object? overdueDeliveryReviews = null,Object? overduePaymentResubmissions = null,}) {
  return _then(_AdminOperationalSummary(
verificationPackets: null == verificationPackets ? _self.verificationPackets : verificationPackets // ignore: cast_nullable_to_non_nullable
as int,pendingVerificationDocuments: null == pendingVerificationDocuments ? _self.pendingVerificationDocuments : pendingVerificationDocuments // ignore: cast_nullable_to_non_nullable
as int,paymentProofs: null == paymentProofs ? _self.paymentProofs : paymentProofs // ignore: cast_nullable_to_non_nullable
as int,disputes: null == disputes ? _self.disputes : disputes // ignore: cast_nullable_to_non_nullable
as int,eligiblePayouts: null == eligiblePayouts ? _self.eligiblePayouts : eligiblePayouts // ignore: cast_nullable_to_non_nullable
as int,emailBacklog: null == emailBacklog ? _self.emailBacklog : emailBacklog // ignore: cast_nullable_to_non_nullable
as int,emailDeadLetter: null == emailDeadLetter ? _self.emailDeadLetter : emailDeadLetter // ignore: cast_nullable_to_non_nullable
as int,auditEventsLast24h: null == auditEventsLast24h ? _self.auditEventsLast24h : auditEventsLast24h // ignore: cast_nullable_to_non_nullable
as int,overdueDeliveryReviews: null == overdueDeliveryReviews ? _self.overdueDeliveryReviews : overdueDeliveryReviews // ignore: cast_nullable_to_non_nullable
as int,overduePaymentResubmissions: null == overduePaymentResubmissions ? _self.overduePaymentResubmissions : overduePaymentResubmissions // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PlatformSettingRecord {

 String get key; Map<String, dynamic> get value; bool get isPublic; String? get description; String? get updatedBy; DateTime? get updatedAt;
/// Create a copy of PlatformSettingRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformSettingRecordCopyWith<PlatformSettingRecord> get copyWith => _$PlatformSettingRecordCopyWithImpl<PlatformSettingRecord>(this as PlatformSettingRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformSettingRecord&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.description, description) || other.description == description)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(value),isPublic,description,updatedBy,updatedAt);

@override
String toString() {
  return 'PlatformSettingRecord(key: $key, value: $value, isPublic: $isPublic, description: $description, updatedBy: $updatedBy, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlatformSettingRecordCopyWith<$Res>  {
  factory $PlatformSettingRecordCopyWith(PlatformSettingRecord value, $Res Function(PlatformSettingRecord) _then) = _$PlatformSettingRecordCopyWithImpl;
@useResult
$Res call({
 String key, Map<String, dynamic> value, bool isPublic, String? description, String? updatedBy, DateTime? updatedAt
});




}
/// @nodoc
class _$PlatformSettingRecordCopyWithImpl<$Res>
    implements $PlatformSettingRecordCopyWith<$Res> {
  _$PlatformSettingRecordCopyWithImpl(this._self, this._then);

  final PlatformSettingRecord _self;
  final $Res Function(PlatformSettingRecord) _then;

/// Create a copy of PlatformSettingRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? value = null,Object? isPublic = null,Object? description = freezed,Object? updatedBy = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformSettingRecord].
extension PlatformSettingRecordPatterns on PlatformSettingRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformSettingRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformSettingRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformSettingRecord value)  $default,){
final _that = this;
switch (_that) {
case _PlatformSettingRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformSettingRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformSettingRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  Map<String, dynamic> value,  bool isPublic,  String? description,  String? updatedBy,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformSettingRecord() when $default != null:
return $default(_that.key,_that.value,_that.isPublic,_that.description,_that.updatedBy,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  Map<String, dynamic> value,  bool isPublic,  String? description,  String? updatedBy,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlatformSettingRecord():
return $default(_that.key,_that.value,_that.isPublic,_that.description,_that.updatedBy,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  Map<String, dynamic> value,  bool isPublic,  String? description,  String? updatedBy,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlatformSettingRecord() when $default != null:
return $default(_that.key,_that.value,_that.isPublic,_that.description,_that.updatedBy,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PlatformSettingRecord extends PlatformSettingRecord {
  const _PlatformSettingRecord({required this.key, required final  Map<String, dynamic> value, required this.isPublic, required this.description, required this.updatedBy, required this.updatedAt}): _value = value,super._();
  

@override final  String key;
 final  Map<String, dynamic> _value;
@override Map<String, dynamic> get value {
  if (_value is EqualUnmodifiableMapView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_value);
}

@override final  bool isPublic;
@override final  String? description;
@override final  String? updatedBy;
@override final  DateTime? updatedAt;

/// Create a copy of PlatformSettingRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformSettingRecordCopyWith<_PlatformSettingRecord> get copyWith => __$PlatformSettingRecordCopyWithImpl<_PlatformSettingRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformSettingRecord&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other._value, _value)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.description, description) || other.description == description)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(_value),isPublic,description,updatedBy,updatedAt);

@override
String toString() {
  return 'PlatformSettingRecord(key: $key, value: $value, isPublic: $isPublic, description: $description, updatedBy: $updatedBy, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlatformSettingRecordCopyWith<$Res> implements $PlatformSettingRecordCopyWith<$Res> {
  factory _$PlatformSettingRecordCopyWith(_PlatformSettingRecord value, $Res Function(_PlatformSettingRecord) _then) = __$PlatformSettingRecordCopyWithImpl;
@override @useResult
$Res call({
 String key, Map<String, dynamic> value, bool isPublic, String? description, String? updatedBy, DateTime? updatedAt
});




}
/// @nodoc
class __$PlatformSettingRecordCopyWithImpl<$Res>
    implements _$PlatformSettingRecordCopyWith<$Res> {
  __$PlatformSettingRecordCopyWithImpl(this._self, this._then);

  final _PlatformSettingRecord _self;
  final $Res Function(_PlatformSettingRecord) _then;

/// Create a copy of PlatformSettingRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? value = null,Object? isPublic = null,Object? description = freezed,Object? updatedBy = freezed,Object? updatedAt = freezed,}) {
  return _then(_PlatformSettingRecord(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$AdminUserListItem {

 AppProfile get profile;
/// Create a copy of AdminUserListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminUserListItemCopyWith<AdminUserListItem> get copyWith => _$AdminUserListItemCopyWithImpl<AdminUserListItem>(this as AdminUserListItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminUserListItem&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'AdminUserListItem(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $AdminUserListItemCopyWith<$Res>  {
  factory $AdminUserListItemCopyWith(AdminUserListItem value, $Res Function(AdminUserListItem) _then) = _$AdminUserListItemCopyWithImpl;
@useResult
$Res call({
 AppProfile profile
});




}
/// @nodoc
class _$AdminUserListItemCopyWithImpl<$Res>
    implements $AdminUserListItemCopyWith<$Res> {
  _$AdminUserListItemCopyWithImpl(this._self, this._then);

  final AdminUserListItem _self;
  final $Res Function(AdminUserListItem) _then;

/// Create a copy of AdminUserListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AppProfile,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminUserListItem].
extension AdminUserListItemPatterns on AdminUserListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminUserListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminUserListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminUserListItem value)  $default,){
final _that = this;
switch (_that) {
case _AdminUserListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminUserListItem value)?  $default,){
final _that = this;
switch (_that) {
case _AdminUserListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppProfile profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminUserListItem() when $default != null:
return $default(_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppProfile profile)  $default,) {final _that = this;
switch (_that) {
case _AdminUserListItem():
return $default(_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppProfile profile)?  $default,) {final _that = this;
switch (_that) {
case _AdminUserListItem() when $default != null:
return $default(_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class _AdminUserListItem extends AdminUserListItem {
  const _AdminUserListItem({required this.profile}): super._();
  

@override final  AppProfile profile;

/// Create a copy of AdminUserListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminUserListItemCopyWith<_AdminUserListItem> get copyWith => __$AdminUserListItemCopyWithImpl<_AdminUserListItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminUserListItem&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'AdminUserListItem(profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$AdminUserListItemCopyWith<$Res> implements $AdminUserListItemCopyWith<$Res> {
  factory _$AdminUserListItemCopyWith(_AdminUserListItem value, $Res Function(_AdminUserListItem) _then) = __$AdminUserListItemCopyWithImpl;
@override @useResult
$Res call({
 AppProfile profile
});




}
/// @nodoc
class __$AdminUserListItemCopyWithImpl<$Res>
    implements _$AdminUserListItemCopyWith<$Res> {
  __$AdminUserListItemCopyWithImpl(this._self, this._then);

  final _AdminUserListItem _self;
  final $Res Function(_AdminUserListItem) _then;

/// Create a copy of AdminUserListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(_AdminUserListItem(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AppProfile,
  ));
}


}

/// @nodoc
mixin _$AdminUserDetail {

 AppProfile get profile; List<BookingRecord> get bookings; List<CarrierVehicle> get vehicles; List<VerificationDocumentRecord> get verificationDocuments; List<EmailDeliveryLogRecord> get emailLogs;
/// Create a copy of AdminUserDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminUserDetailCopyWith<AdminUserDetail> get copyWith => _$AdminUserDetailCopyWithImpl<AdminUserDetail>(this as AdminUserDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminUserDetail&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.bookings, bookings)&&const DeepCollectionEquality().equals(other.vehicles, vehicles)&&const DeepCollectionEquality().equals(other.verificationDocuments, verificationDocuments)&&const DeepCollectionEquality().equals(other.emailLogs, emailLogs));
}


@override
int get hashCode => Object.hash(runtimeType,profile,const DeepCollectionEquality().hash(bookings),const DeepCollectionEquality().hash(vehicles),const DeepCollectionEquality().hash(verificationDocuments),const DeepCollectionEquality().hash(emailLogs));

@override
String toString() {
  return 'AdminUserDetail(profile: $profile, bookings: $bookings, vehicles: $vehicles, verificationDocuments: $verificationDocuments, emailLogs: $emailLogs)';
}


}

/// @nodoc
abstract mixin class $AdminUserDetailCopyWith<$Res>  {
  factory $AdminUserDetailCopyWith(AdminUserDetail value, $Res Function(AdminUserDetail) _then) = _$AdminUserDetailCopyWithImpl;
@useResult
$Res call({
 AppProfile profile, List<BookingRecord> bookings, List<CarrierVehicle> vehicles, List<VerificationDocumentRecord> verificationDocuments, List<EmailDeliveryLogRecord> emailLogs
});




}
/// @nodoc
class _$AdminUserDetailCopyWithImpl<$Res>
    implements $AdminUserDetailCopyWith<$Res> {
  _$AdminUserDetailCopyWithImpl(this._self, this._then);

  final AdminUserDetail _self;
  final $Res Function(AdminUserDetail) _then;

/// Create a copy of AdminUserDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? bookings = null,Object? vehicles = null,Object? verificationDocuments = null,Object? emailLogs = null,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AppProfile,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<BookingRecord>,vehicles: null == vehicles ? _self.vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<CarrierVehicle>,verificationDocuments: null == verificationDocuments ? _self.verificationDocuments : verificationDocuments // ignore: cast_nullable_to_non_nullable
as List<VerificationDocumentRecord>,emailLogs: null == emailLogs ? _self.emailLogs : emailLogs // ignore: cast_nullable_to_non_nullable
as List<EmailDeliveryLogRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminUserDetail].
extension AdminUserDetailPatterns on AdminUserDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminUserDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminUserDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminUserDetail value)  $default,){
final _that = this;
switch (_that) {
case _AdminUserDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminUserDetail value)?  $default,){
final _that = this;
switch (_that) {
case _AdminUserDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppProfile profile,  List<BookingRecord> bookings,  List<CarrierVehicle> vehicles,  List<VerificationDocumentRecord> verificationDocuments,  List<EmailDeliveryLogRecord> emailLogs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminUserDetail() when $default != null:
return $default(_that.profile,_that.bookings,_that.vehicles,_that.verificationDocuments,_that.emailLogs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppProfile profile,  List<BookingRecord> bookings,  List<CarrierVehicle> vehicles,  List<VerificationDocumentRecord> verificationDocuments,  List<EmailDeliveryLogRecord> emailLogs)  $default,) {final _that = this;
switch (_that) {
case _AdminUserDetail():
return $default(_that.profile,_that.bookings,_that.vehicles,_that.verificationDocuments,_that.emailLogs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppProfile profile,  List<BookingRecord> bookings,  List<CarrierVehicle> vehicles,  List<VerificationDocumentRecord> verificationDocuments,  List<EmailDeliveryLogRecord> emailLogs)?  $default,) {final _that = this;
switch (_that) {
case _AdminUserDetail() when $default != null:
return $default(_that.profile,_that.bookings,_that.vehicles,_that.verificationDocuments,_that.emailLogs);case _:
  return null;

}
}

}

/// @nodoc


class _AdminUserDetail extends AdminUserDetail {
  const _AdminUserDetail({required this.profile, required final  List<BookingRecord> bookings, required final  List<CarrierVehicle> vehicles, required final  List<VerificationDocumentRecord> verificationDocuments, required final  List<EmailDeliveryLogRecord> emailLogs}): _bookings = bookings,_vehicles = vehicles,_verificationDocuments = verificationDocuments,_emailLogs = emailLogs,super._();
  

@override final  AppProfile profile;
 final  List<BookingRecord> _bookings;
@override List<BookingRecord> get bookings {
  if (_bookings is EqualUnmodifiableListView) return _bookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookings);
}

 final  List<CarrierVehicle> _vehicles;
@override List<CarrierVehicle> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}

 final  List<VerificationDocumentRecord> _verificationDocuments;
@override List<VerificationDocumentRecord> get verificationDocuments {
  if (_verificationDocuments is EqualUnmodifiableListView) return _verificationDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verificationDocuments);
}

 final  List<EmailDeliveryLogRecord> _emailLogs;
@override List<EmailDeliveryLogRecord> get emailLogs {
  if (_emailLogs is EqualUnmodifiableListView) return _emailLogs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emailLogs);
}


/// Create a copy of AdminUserDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminUserDetailCopyWith<_AdminUserDetail> get copyWith => __$AdminUserDetailCopyWithImpl<_AdminUserDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminUserDetail&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other._bookings, _bookings)&&const DeepCollectionEquality().equals(other._vehicles, _vehicles)&&const DeepCollectionEquality().equals(other._verificationDocuments, _verificationDocuments)&&const DeepCollectionEquality().equals(other._emailLogs, _emailLogs));
}


@override
int get hashCode => Object.hash(runtimeType,profile,const DeepCollectionEquality().hash(_bookings),const DeepCollectionEquality().hash(_vehicles),const DeepCollectionEquality().hash(_verificationDocuments),const DeepCollectionEquality().hash(_emailLogs));

@override
String toString() {
  return 'AdminUserDetail(profile: $profile, bookings: $bookings, vehicles: $vehicles, verificationDocuments: $verificationDocuments, emailLogs: $emailLogs)';
}


}

/// @nodoc
abstract mixin class _$AdminUserDetailCopyWith<$Res> implements $AdminUserDetailCopyWith<$Res> {
  factory _$AdminUserDetailCopyWith(_AdminUserDetail value, $Res Function(_AdminUserDetail) _then) = __$AdminUserDetailCopyWithImpl;
@override @useResult
$Res call({
 AppProfile profile, List<BookingRecord> bookings, List<CarrierVehicle> vehicles, List<VerificationDocumentRecord> verificationDocuments, List<EmailDeliveryLogRecord> emailLogs
});




}
/// @nodoc
class __$AdminUserDetailCopyWithImpl<$Res>
    implements _$AdminUserDetailCopyWith<$Res> {
  __$AdminUserDetailCopyWithImpl(this._self, this._then);

  final _AdminUserDetail _self;
  final $Res Function(_AdminUserDetail) _then;

/// Create a copy of AdminUserDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? bookings = null,Object? vehicles = null,Object? verificationDocuments = null,Object? emailLogs = null,}) {
  return _then(_AdminUserDetail(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AppProfile,bookings: null == bookings ? _self._bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<BookingRecord>,vehicles: null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<CarrierVehicle>,verificationDocuments: null == verificationDocuments ? _self._verificationDocuments : verificationDocuments // ignore: cast_nullable_to_non_nullable
as List<VerificationDocumentRecord>,emailLogs: null == emailLogs ? _self._emailLogs : emailLogs // ignore: cast_nullable_to_non_nullable
as List<EmailDeliveryLogRecord>,
  ));
}


}

/// @nodoc
mixin _$EmailDeliveryLogRecord {

 String get id; String? get profileId; String? get bookingId; String get templateKey; String get locale; String get recipientEmail; String? get subjectPreview; String? get providerMessageId; String get status; String get provider; int get attemptCount; DateTime? get lastAttemptAt; DateTime? get nextRetryAt; DateTime? get lastErrorAt; String? get errorCode; String? get errorMessage; Map<String, dynamic> get payloadSnapshot; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of EmailDeliveryLogRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailDeliveryLogRecordCopyWith<EmailDeliveryLogRecord> get copyWith => _$EmailDeliveryLogRecordCopyWithImpl<EmailDeliveryLogRecord>(this as EmailDeliveryLogRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailDeliveryLogRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.templateKey, templateKey) || other.templateKey == templateKey)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.recipientEmail, recipientEmail) || other.recipientEmail == recipientEmail)&&(identical(other.subjectPreview, subjectPreview) || other.subjectPreview == subjectPreview)&&(identical(other.providerMessageId, providerMessageId) || other.providerMessageId == providerMessageId)&&(identical(other.status, status) || other.status == status)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.lastAttemptAt, lastAttemptAt) || other.lastAttemptAt == lastAttemptAt)&&(identical(other.nextRetryAt, nextRetryAt) || other.nextRetryAt == nextRetryAt)&&(identical(other.lastErrorAt, lastErrorAt) || other.lastErrorAt == lastErrorAt)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.payloadSnapshot, payloadSnapshot)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,profileId,bookingId,templateKey,locale,recipientEmail,subjectPreview,providerMessageId,status,provider,attemptCount,lastAttemptAt,nextRetryAt,lastErrorAt,errorCode,errorMessage,const DeepCollectionEquality().hash(payloadSnapshot),createdAt,updatedAt]);

@override
String toString() {
  return 'EmailDeliveryLogRecord(id: $id, profileId: $profileId, bookingId: $bookingId, templateKey: $templateKey, locale: $locale, recipientEmail: $recipientEmail, subjectPreview: $subjectPreview, providerMessageId: $providerMessageId, status: $status, provider: $provider, attemptCount: $attemptCount, lastAttemptAt: $lastAttemptAt, nextRetryAt: $nextRetryAt, lastErrorAt: $lastErrorAt, errorCode: $errorCode, errorMessage: $errorMessage, payloadSnapshot: $payloadSnapshot, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EmailDeliveryLogRecordCopyWith<$Res>  {
  factory $EmailDeliveryLogRecordCopyWith(EmailDeliveryLogRecord value, $Res Function(EmailDeliveryLogRecord) _then) = _$EmailDeliveryLogRecordCopyWithImpl;
@useResult
$Res call({
 String id, String? profileId, String? bookingId, String templateKey, String locale, String recipientEmail, String? subjectPreview, String? providerMessageId, String status, String provider, int attemptCount, DateTime? lastAttemptAt, DateTime? nextRetryAt, DateTime? lastErrorAt, String? errorCode, String? errorMessage, Map<String, dynamic> payloadSnapshot, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$EmailDeliveryLogRecordCopyWithImpl<$Res>
    implements $EmailDeliveryLogRecordCopyWith<$Res> {
  _$EmailDeliveryLogRecordCopyWithImpl(this._self, this._then);

  final EmailDeliveryLogRecord _self;
  final $Res Function(EmailDeliveryLogRecord) _then;

/// Create a copy of EmailDeliveryLogRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = freezed,Object? bookingId = freezed,Object? templateKey = null,Object? locale = null,Object? recipientEmail = null,Object? subjectPreview = freezed,Object? providerMessageId = freezed,Object? status = null,Object? provider = null,Object? attemptCount = null,Object? lastAttemptAt = freezed,Object? nextRetryAt = freezed,Object? lastErrorAt = freezed,Object? errorCode = freezed,Object? errorMessage = freezed,Object? payloadSnapshot = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,templateKey: null == templateKey ? _self.templateKey : templateKey // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,recipientEmail: null == recipientEmail ? _self.recipientEmail : recipientEmail // ignore: cast_nullable_to_non_nullable
as String,subjectPreview: freezed == subjectPreview ? _self.subjectPreview : subjectPreview // ignore: cast_nullable_to_non_nullable
as String?,providerMessageId: freezed == providerMessageId ? _self.providerMessageId : providerMessageId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextRetryAt: freezed == nextRetryAt ? _self.nextRetryAt : nextRetryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastErrorAt: freezed == lastErrorAt ? _self.lastErrorAt : lastErrorAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,payloadSnapshot: null == payloadSnapshot ? _self.payloadSnapshot : payloadSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailDeliveryLogRecord].
extension EmailDeliveryLogRecordPatterns on EmailDeliveryLogRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailDeliveryLogRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailDeliveryLogRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailDeliveryLogRecord value)  $default,){
final _that = this;
switch (_that) {
case _EmailDeliveryLogRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailDeliveryLogRecord value)?  $default,){
final _that = this;
switch (_that) {
case _EmailDeliveryLogRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? profileId,  String? bookingId,  String templateKey,  String locale,  String recipientEmail,  String? subjectPreview,  String? providerMessageId,  String status,  String provider,  int attemptCount,  DateTime? lastAttemptAt,  DateTime? nextRetryAt,  DateTime? lastErrorAt,  String? errorCode,  String? errorMessage,  Map<String, dynamic> payloadSnapshot,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailDeliveryLogRecord() when $default != null:
return $default(_that.id,_that.profileId,_that.bookingId,_that.templateKey,_that.locale,_that.recipientEmail,_that.subjectPreview,_that.providerMessageId,_that.status,_that.provider,_that.attemptCount,_that.lastAttemptAt,_that.nextRetryAt,_that.lastErrorAt,_that.errorCode,_that.errorMessage,_that.payloadSnapshot,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? profileId,  String? bookingId,  String templateKey,  String locale,  String recipientEmail,  String? subjectPreview,  String? providerMessageId,  String status,  String provider,  int attemptCount,  DateTime? lastAttemptAt,  DateTime? nextRetryAt,  DateTime? lastErrorAt,  String? errorCode,  String? errorMessage,  Map<String, dynamic> payloadSnapshot,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EmailDeliveryLogRecord():
return $default(_that.id,_that.profileId,_that.bookingId,_that.templateKey,_that.locale,_that.recipientEmail,_that.subjectPreview,_that.providerMessageId,_that.status,_that.provider,_that.attemptCount,_that.lastAttemptAt,_that.nextRetryAt,_that.lastErrorAt,_that.errorCode,_that.errorMessage,_that.payloadSnapshot,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? profileId,  String? bookingId,  String templateKey,  String locale,  String recipientEmail,  String? subjectPreview,  String? providerMessageId,  String status,  String provider,  int attemptCount,  DateTime? lastAttemptAt,  DateTime? nextRetryAt,  DateTime? lastErrorAt,  String? errorCode,  String? errorMessage,  Map<String, dynamic> payloadSnapshot,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EmailDeliveryLogRecord() when $default != null:
return $default(_that.id,_that.profileId,_that.bookingId,_that.templateKey,_that.locale,_that.recipientEmail,_that.subjectPreview,_that.providerMessageId,_that.status,_that.provider,_that.attemptCount,_that.lastAttemptAt,_that.nextRetryAt,_that.lastErrorAt,_that.errorCode,_that.errorMessage,_that.payloadSnapshot,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EmailDeliveryLogRecord extends EmailDeliveryLogRecord {
  const _EmailDeliveryLogRecord({required this.id, required this.profileId, required this.bookingId, required this.templateKey, required this.locale, required this.recipientEmail, required this.subjectPreview, required this.providerMessageId, required this.status, required this.provider, required this.attemptCount, required this.lastAttemptAt, required this.nextRetryAt, required this.lastErrorAt, required this.errorCode, required this.errorMessage, required final  Map<String, dynamic> payloadSnapshot, required this.createdAt, required this.updatedAt}): _payloadSnapshot = payloadSnapshot,super._();
  

@override final  String id;
@override final  String? profileId;
@override final  String? bookingId;
@override final  String templateKey;
@override final  String locale;
@override final  String recipientEmail;
@override final  String? subjectPreview;
@override final  String? providerMessageId;
@override final  String status;
@override final  String provider;
@override final  int attemptCount;
@override final  DateTime? lastAttemptAt;
@override final  DateTime? nextRetryAt;
@override final  DateTime? lastErrorAt;
@override final  String? errorCode;
@override final  String? errorMessage;
 final  Map<String, dynamic> _payloadSnapshot;
@override Map<String, dynamic> get payloadSnapshot {
  if (_payloadSnapshot is EqualUnmodifiableMapView) return _payloadSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payloadSnapshot);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of EmailDeliveryLogRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailDeliveryLogRecordCopyWith<_EmailDeliveryLogRecord> get copyWith => __$EmailDeliveryLogRecordCopyWithImpl<_EmailDeliveryLogRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailDeliveryLogRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.templateKey, templateKey) || other.templateKey == templateKey)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.recipientEmail, recipientEmail) || other.recipientEmail == recipientEmail)&&(identical(other.subjectPreview, subjectPreview) || other.subjectPreview == subjectPreview)&&(identical(other.providerMessageId, providerMessageId) || other.providerMessageId == providerMessageId)&&(identical(other.status, status) || other.status == status)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.lastAttemptAt, lastAttemptAt) || other.lastAttemptAt == lastAttemptAt)&&(identical(other.nextRetryAt, nextRetryAt) || other.nextRetryAt == nextRetryAt)&&(identical(other.lastErrorAt, lastErrorAt) || other.lastErrorAt == lastErrorAt)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._payloadSnapshot, _payloadSnapshot)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,profileId,bookingId,templateKey,locale,recipientEmail,subjectPreview,providerMessageId,status,provider,attemptCount,lastAttemptAt,nextRetryAt,lastErrorAt,errorCode,errorMessage,const DeepCollectionEquality().hash(_payloadSnapshot),createdAt,updatedAt]);

@override
String toString() {
  return 'EmailDeliveryLogRecord(id: $id, profileId: $profileId, bookingId: $bookingId, templateKey: $templateKey, locale: $locale, recipientEmail: $recipientEmail, subjectPreview: $subjectPreview, providerMessageId: $providerMessageId, status: $status, provider: $provider, attemptCount: $attemptCount, lastAttemptAt: $lastAttemptAt, nextRetryAt: $nextRetryAt, lastErrorAt: $lastErrorAt, errorCode: $errorCode, errorMessage: $errorMessage, payloadSnapshot: $payloadSnapshot, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EmailDeliveryLogRecordCopyWith<$Res> implements $EmailDeliveryLogRecordCopyWith<$Res> {
  factory _$EmailDeliveryLogRecordCopyWith(_EmailDeliveryLogRecord value, $Res Function(_EmailDeliveryLogRecord) _then) = __$EmailDeliveryLogRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String? profileId, String? bookingId, String templateKey, String locale, String recipientEmail, String? subjectPreview, String? providerMessageId, String status, String provider, int attemptCount, DateTime? lastAttemptAt, DateTime? nextRetryAt, DateTime? lastErrorAt, String? errorCode, String? errorMessage, Map<String, dynamic> payloadSnapshot, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$EmailDeliveryLogRecordCopyWithImpl<$Res>
    implements _$EmailDeliveryLogRecordCopyWith<$Res> {
  __$EmailDeliveryLogRecordCopyWithImpl(this._self, this._then);

  final _EmailDeliveryLogRecord _self;
  final $Res Function(_EmailDeliveryLogRecord) _then;

/// Create a copy of EmailDeliveryLogRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = freezed,Object? bookingId = freezed,Object? templateKey = null,Object? locale = null,Object? recipientEmail = null,Object? subjectPreview = freezed,Object? providerMessageId = freezed,Object? status = null,Object? provider = null,Object? attemptCount = null,Object? lastAttemptAt = freezed,Object? nextRetryAt = freezed,Object? lastErrorAt = freezed,Object? errorCode = freezed,Object? errorMessage = freezed,Object? payloadSnapshot = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_EmailDeliveryLogRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,templateKey: null == templateKey ? _self.templateKey : templateKey // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,recipientEmail: null == recipientEmail ? _self.recipientEmail : recipientEmail // ignore: cast_nullable_to_non_nullable
as String,subjectPreview: freezed == subjectPreview ? _self.subjectPreview : subjectPreview // ignore: cast_nullable_to_non_nullable
as String?,providerMessageId: freezed == providerMessageId ? _self.providerMessageId : providerMessageId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextRetryAt: freezed == nextRetryAt ? _self.nextRetryAt : nextRetryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastErrorAt: freezed == lastErrorAt ? _self.lastErrorAt : lastErrorAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,payloadSnapshot: null == payloadSnapshot ? _self._payloadSnapshot : payloadSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$EmailOutboxJobRecord {

 String get id; String get eventKey; String get dedupeKey; String? get profileId; String? get bookingId; String get templateKey; String get locale; String get recipientEmail; String get priority; String get status; int get attemptCount; int get maxAttempts; DateTime? get availableAt; DateTime? get lockedAt; String? get lockedBy; String? get lastErrorCode; String? get lastErrorMessage; Map<String, dynamic> get payloadSnapshot; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of EmailOutboxJobRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailOutboxJobRecordCopyWith<EmailOutboxJobRecord> get copyWith => _$EmailOutboxJobRecordCopyWithImpl<EmailOutboxJobRecord>(this as EmailOutboxJobRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailOutboxJobRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.eventKey, eventKey) || other.eventKey == eventKey)&&(identical(other.dedupeKey, dedupeKey) || other.dedupeKey == dedupeKey)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.templateKey, templateKey) || other.templateKey == templateKey)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.recipientEmail, recipientEmail) || other.recipientEmail == recipientEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.availableAt, availableAt) || other.availableAt == availableAt)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lastErrorCode, lastErrorCode) || other.lastErrorCode == lastErrorCode)&&(identical(other.lastErrorMessage, lastErrorMessage) || other.lastErrorMessage == lastErrorMessage)&&const DeepCollectionEquality().equals(other.payloadSnapshot, payloadSnapshot)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,eventKey,dedupeKey,profileId,bookingId,templateKey,locale,recipientEmail,priority,status,attemptCount,maxAttempts,availableAt,lockedAt,lockedBy,lastErrorCode,lastErrorMessage,const DeepCollectionEquality().hash(payloadSnapshot),createdAt,updatedAt]);

@override
String toString() {
  return 'EmailOutboxJobRecord(id: $id, eventKey: $eventKey, dedupeKey: $dedupeKey, profileId: $profileId, bookingId: $bookingId, templateKey: $templateKey, locale: $locale, recipientEmail: $recipientEmail, priority: $priority, status: $status, attemptCount: $attemptCount, maxAttempts: $maxAttempts, availableAt: $availableAt, lockedAt: $lockedAt, lockedBy: $lockedBy, lastErrorCode: $lastErrorCode, lastErrorMessage: $lastErrorMessage, payloadSnapshot: $payloadSnapshot, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EmailOutboxJobRecordCopyWith<$Res>  {
  factory $EmailOutboxJobRecordCopyWith(EmailOutboxJobRecord value, $Res Function(EmailOutboxJobRecord) _then) = _$EmailOutboxJobRecordCopyWithImpl;
@useResult
$Res call({
 String id, String eventKey, String dedupeKey, String? profileId, String? bookingId, String templateKey, String locale, String recipientEmail, String priority, String status, int attemptCount, int maxAttempts, DateTime? availableAt, DateTime? lockedAt, String? lockedBy, String? lastErrorCode, String? lastErrorMessage, Map<String, dynamic> payloadSnapshot, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$EmailOutboxJobRecordCopyWithImpl<$Res>
    implements $EmailOutboxJobRecordCopyWith<$Res> {
  _$EmailOutboxJobRecordCopyWithImpl(this._self, this._then);

  final EmailOutboxJobRecord _self;
  final $Res Function(EmailOutboxJobRecord) _then;

/// Create a copy of EmailOutboxJobRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventKey = null,Object? dedupeKey = null,Object? profileId = freezed,Object? bookingId = freezed,Object? templateKey = null,Object? locale = null,Object? recipientEmail = null,Object? priority = null,Object? status = null,Object? attemptCount = null,Object? maxAttempts = null,Object? availableAt = freezed,Object? lockedAt = freezed,Object? lockedBy = freezed,Object? lastErrorCode = freezed,Object? lastErrorMessage = freezed,Object? payloadSnapshot = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventKey: null == eventKey ? _self.eventKey : eventKey // ignore: cast_nullable_to_non_nullable
as String,dedupeKey: null == dedupeKey ? _self.dedupeKey : dedupeKey // ignore: cast_nullable_to_non_nullable
as String,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,templateKey: null == templateKey ? _self.templateKey : templateKey // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,recipientEmail: null == recipientEmail ? _self.recipientEmail : recipientEmail // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,availableAt: freezed == availableAt ? _self.availableAt : availableAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lastErrorCode: freezed == lastErrorCode ? _self.lastErrorCode : lastErrorCode // ignore: cast_nullable_to_non_nullable
as String?,lastErrorMessage: freezed == lastErrorMessage ? _self.lastErrorMessage : lastErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,payloadSnapshot: null == payloadSnapshot ? _self.payloadSnapshot : payloadSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailOutboxJobRecord].
extension EmailOutboxJobRecordPatterns on EmailOutboxJobRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailOutboxJobRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailOutboxJobRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailOutboxJobRecord value)  $default,){
final _that = this;
switch (_that) {
case _EmailOutboxJobRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailOutboxJobRecord value)?  $default,){
final _that = this;
switch (_that) {
case _EmailOutboxJobRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventKey,  String dedupeKey,  String? profileId,  String? bookingId,  String templateKey,  String locale,  String recipientEmail,  String priority,  String status,  int attemptCount,  int maxAttempts,  DateTime? availableAt,  DateTime? lockedAt,  String? lockedBy,  String? lastErrorCode,  String? lastErrorMessage,  Map<String, dynamic> payloadSnapshot,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailOutboxJobRecord() when $default != null:
return $default(_that.id,_that.eventKey,_that.dedupeKey,_that.profileId,_that.bookingId,_that.templateKey,_that.locale,_that.recipientEmail,_that.priority,_that.status,_that.attemptCount,_that.maxAttempts,_that.availableAt,_that.lockedAt,_that.lockedBy,_that.lastErrorCode,_that.lastErrorMessage,_that.payloadSnapshot,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventKey,  String dedupeKey,  String? profileId,  String? bookingId,  String templateKey,  String locale,  String recipientEmail,  String priority,  String status,  int attemptCount,  int maxAttempts,  DateTime? availableAt,  DateTime? lockedAt,  String? lockedBy,  String? lastErrorCode,  String? lastErrorMessage,  Map<String, dynamic> payloadSnapshot,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EmailOutboxJobRecord():
return $default(_that.id,_that.eventKey,_that.dedupeKey,_that.profileId,_that.bookingId,_that.templateKey,_that.locale,_that.recipientEmail,_that.priority,_that.status,_that.attemptCount,_that.maxAttempts,_that.availableAt,_that.lockedAt,_that.lockedBy,_that.lastErrorCode,_that.lastErrorMessage,_that.payloadSnapshot,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventKey,  String dedupeKey,  String? profileId,  String? bookingId,  String templateKey,  String locale,  String recipientEmail,  String priority,  String status,  int attemptCount,  int maxAttempts,  DateTime? availableAt,  DateTime? lockedAt,  String? lockedBy,  String? lastErrorCode,  String? lastErrorMessage,  Map<String, dynamic> payloadSnapshot,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EmailOutboxJobRecord() when $default != null:
return $default(_that.id,_that.eventKey,_that.dedupeKey,_that.profileId,_that.bookingId,_that.templateKey,_that.locale,_that.recipientEmail,_that.priority,_that.status,_that.attemptCount,_that.maxAttempts,_that.availableAt,_that.lockedAt,_that.lockedBy,_that.lastErrorCode,_that.lastErrorMessage,_that.payloadSnapshot,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EmailOutboxJobRecord extends EmailOutboxJobRecord {
  const _EmailOutboxJobRecord({required this.id, required this.eventKey, required this.dedupeKey, required this.profileId, required this.bookingId, required this.templateKey, required this.locale, required this.recipientEmail, required this.priority, required this.status, required this.attemptCount, required this.maxAttempts, required this.availableAt, required this.lockedAt, required this.lockedBy, required this.lastErrorCode, required this.lastErrorMessage, required final  Map<String, dynamic> payloadSnapshot, required this.createdAt, required this.updatedAt}): _payloadSnapshot = payloadSnapshot,super._();
  

@override final  String id;
@override final  String eventKey;
@override final  String dedupeKey;
@override final  String? profileId;
@override final  String? bookingId;
@override final  String templateKey;
@override final  String locale;
@override final  String recipientEmail;
@override final  String priority;
@override final  String status;
@override final  int attemptCount;
@override final  int maxAttempts;
@override final  DateTime? availableAt;
@override final  DateTime? lockedAt;
@override final  String? lockedBy;
@override final  String? lastErrorCode;
@override final  String? lastErrorMessage;
 final  Map<String, dynamic> _payloadSnapshot;
@override Map<String, dynamic> get payloadSnapshot {
  if (_payloadSnapshot is EqualUnmodifiableMapView) return _payloadSnapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payloadSnapshot);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of EmailOutboxJobRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailOutboxJobRecordCopyWith<_EmailOutboxJobRecord> get copyWith => __$EmailOutboxJobRecordCopyWithImpl<_EmailOutboxJobRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailOutboxJobRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.eventKey, eventKey) || other.eventKey == eventKey)&&(identical(other.dedupeKey, dedupeKey) || other.dedupeKey == dedupeKey)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.templateKey, templateKey) || other.templateKey == templateKey)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.recipientEmail, recipientEmail) || other.recipientEmail == recipientEmail)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.availableAt, availableAt) || other.availableAt == availableAt)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lastErrorCode, lastErrorCode) || other.lastErrorCode == lastErrorCode)&&(identical(other.lastErrorMessage, lastErrorMessage) || other.lastErrorMessage == lastErrorMessage)&&const DeepCollectionEquality().equals(other._payloadSnapshot, _payloadSnapshot)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,eventKey,dedupeKey,profileId,bookingId,templateKey,locale,recipientEmail,priority,status,attemptCount,maxAttempts,availableAt,lockedAt,lockedBy,lastErrorCode,lastErrorMessage,const DeepCollectionEquality().hash(_payloadSnapshot),createdAt,updatedAt]);

@override
String toString() {
  return 'EmailOutboxJobRecord(id: $id, eventKey: $eventKey, dedupeKey: $dedupeKey, profileId: $profileId, bookingId: $bookingId, templateKey: $templateKey, locale: $locale, recipientEmail: $recipientEmail, priority: $priority, status: $status, attemptCount: $attemptCount, maxAttempts: $maxAttempts, availableAt: $availableAt, lockedAt: $lockedAt, lockedBy: $lockedBy, lastErrorCode: $lastErrorCode, lastErrorMessage: $lastErrorMessage, payloadSnapshot: $payloadSnapshot, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EmailOutboxJobRecordCopyWith<$Res> implements $EmailOutboxJobRecordCopyWith<$Res> {
  factory _$EmailOutboxJobRecordCopyWith(_EmailOutboxJobRecord value, $Res Function(_EmailOutboxJobRecord) _then) = __$EmailOutboxJobRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventKey, String dedupeKey, String? profileId, String? bookingId, String templateKey, String locale, String recipientEmail, String priority, String status, int attemptCount, int maxAttempts, DateTime? availableAt, DateTime? lockedAt, String? lockedBy, String? lastErrorCode, String? lastErrorMessage, Map<String, dynamic> payloadSnapshot, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$EmailOutboxJobRecordCopyWithImpl<$Res>
    implements _$EmailOutboxJobRecordCopyWith<$Res> {
  __$EmailOutboxJobRecordCopyWithImpl(this._self, this._then);

  final _EmailOutboxJobRecord _self;
  final $Res Function(_EmailOutboxJobRecord) _then;

/// Create a copy of EmailOutboxJobRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventKey = null,Object? dedupeKey = null,Object? profileId = freezed,Object? bookingId = freezed,Object? templateKey = null,Object? locale = null,Object? recipientEmail = null,Object? priority = null,Object? status = null,Object? attemptCount = null,Object? maxAttempts = null,Object? availableAt = freezed,Object? lockedAt = freezed,Object? lockedBy = freezed,Object? lastErrorCode = freezed,Object? lastErrorMessage = freezed,Object? payloadSnapshot = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_EmailOutboxJobRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventKey: null == eventKey ? _self.eventKey : eventKey // ignore: cast_nullable_to_non_nullable
as String,dedupeKey: null == dedupeKey ? _self.dedupeKey : dedupeKey // ignore: cast_nullable_to_non_nullable
as String,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,templateKey: null == templateKey ? _self.templateKey : templateKey // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,recipientEmail: null == recipientEmail ? _self.recipientEmail : recipientEmail // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,availableAt: freezed == availableAt ? _self.availableAt : availableAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lastErrorCode: freezed == lastErrorCode ? _self.lastErrorCode : lastErrorCode // ignore: cast_nullable_to_non_nullable
as String?,lastErrorMessage: freezed == lastErrorMessage ? _self.lastErrorMessage : lastErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,payloadSnapshot: null == payloadSnapshot ? _self._payloadSnapshot : payloadSnapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$EligiblePayoutQueueItem {

 BookingRecord get booking; AppProfile? get carrier;
/// Create a copy of EligiblePayoutQueueItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EligiblePayoutQueueItemCopyWith<EligiblePayoutQueueItem> get copyWith => _$EligiblePayoutQueueItemCopyWithImpl<EligiblePayoutQueueItem>(this as EligiblePayoutQueueItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EligiblePayoutQueueItem&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.carrier, carrier) || other.carrier == carrier));
}


@override
int get hashCode => Object.hash(runtimeType,booking,carrier);

@override
String toString() {
  return 'EligiblePayoutQueueItem(booking: $booking, carrier: $carrier)';
}


}

/// @nodoc
abstract mixin class $EligiblePayoutQueueItemCopyWith<$Res>  {
  factory $EligiblePayoutQueueItemCopyWith(EligiblePayoutQueueItem value, $Res Function(EligiblePayoutQueueItem) _then) = _$EligiblePayoutQueueItemCopyWithImpl;
@useResult
$Res call({
 BookingRecord booking, AppProfile? carrier
});


$BookingRecordCopyWith<$Res> get booking;

}
/// @nodoc
class _$EligiblePayoutQueueItemCopyWithImpl<$Res>
    implements $EligiblePayoutQueueItemCopyWith<$Res> {
  _$EligiblePayoutQueueItemCopyWithImpl(this._self, this._then);

  final EligiblePayoutQueueItem _self;
  final $Res Function(EligiblePayoutQueueItem) _then;

/// Create a copy of EligiblePayoutQueueItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = null,Object? carrier = freezed,}) {
  return _then(_self.copyWith(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingRecord,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as AppProfile?,
  ));
}
/// Create a copy of EligiblePayoutQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingRecordCopyWith<$Res> get booking {
  
  return $BookingRecordCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [EligiblePayoutQueueItem].
extension EligiblePayoutQueueItemPatterns on EligiblePayoutQueueItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EligiblePayoutQueueItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EligiblePayoutQueueItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EligiblePayoutQueueItem value)  $default,){
final _that = this;
switch (_that) {
case _EligiblePayoutQueueItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EligiblePayoutQueueItem value)?  $default,){
final _that = this;
switch (_that) {
case _EligiblePayoutQueueItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingRecord booking,  AppProfile? carrier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EligiblePayoutQueueItem() when $default != null:
return $default(_that.booking,_that.carrier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingRecord booking,  AppProfile? carrier)  $default,) {final _that = this;
switch (_that) {
case _EligiblePayoutQueueItem():
return $default(_that.booking,_that.carrier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingRecord booking,  AppProfile? carrier)?  $default,) {final _that = this;
switch (_that) {
case _EligiblePayoutQueueItem() when $default != null:
return $default(_that.booking,_that.carrier);case _:
  return null;

}
}

}

/// @nodoc


class _EligiblePayoutQueueItem extends EligiblePayoutQueueItem {
  const _EligiblePayoutQueueItem({required this.booking, required this.carrier}): super._();
  

@override final  BookingRecord booking;
@override final  AppProfile? carrier;

/// Create a copy of EligiblePayoutQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EligiblePayoutQueueItemCopyWith<_EligiblePayoutQueueItem> get copyWith => __$EligiblePayoutQueueItemCopyWithImpl<_EligiblePayoutQueueItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EligiblePayoutQueueItem&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.carrier, carrier) || other.carrier == carrier));
}


@override
int get hashCode => Object.hash(runtimeType,booking,carrier);

@override
String toString() {
  return 'EligiblePayoutQueueItem(booking: $booking, carrier: $carrier)';
}


}

/// @nodoc
abstract mixin class _$EligiblePayoutQueueItemCopyWith<$Res> implements $EligiblePayoutQueueItemCopyWith<$Res> {
  factory _$EligiblePayoutQueueItemCopyWith(_EligiblePayoutQueueItem value, $Res Function(_EligiblePayoutQueueItem) _then) = __$EligiblePayoutQueueItemCopyWithImpl;
@override @useResult
$Res call({
 BookingRecord booking, AppProfile? carrier
});


@override $BookingRecordCopyWith<$Res> get booking;

}
/// @nodoc
class __$EligiblePayoutQueueItemCopyWithImpl<$Res>
    implements _$EligiblePayoutQueueItemCopyWith<$Res> {
  __$EligiblePayoutQueueItemCopyWithImpl(this._self, this._then);

  final _EligiblePayoutQueueItem _self;
  final $Res Function(_EligiblePayoutQueueItem) _then;

/// Create a copy of EligiblePayoutQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = null,Object? carrier = freezed,}) {
  return _then(_EligiblePayoutQueueItem(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingRecord,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as AppProfile?,
  ));
}

/// Create a copy of EligiblePayoutQueueItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingRecordCopyWith<$Res> get booking {
  
  return $BookingRecordCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

/// @nodoc
mixin _$AdminAutomationAlertItem {

 BookingRecord get booking; String get kind; DateTime get referenceAt; int get thresholdHours;
/// Create a copy of AdminAutomationAlertItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAutomationAlertItemCopyWith<AdminAutomationAlertItem> get copyWith => _$AdminAutomationAlertItemCopyWithImpl<AdminAutomationAlertItem>(this as AdminAutomationAlertItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAutomationAlertItem&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.referenceAt, referenceAt) || other.referenceAt == referenceAt)&&(identical(other.thresholdHours, thresholdHours) || other.thresholdHours == thresholdHours));
}


@override
int get hashCode => Object.hash(runtimeType,booking,kind,referenceAt,thresholdHours);

@override
String toString() {
  return 'AdminAutomationAlertItem(booking: $booking, kind: $kind, referenceAt: $referenceAt, thresholdHours: $thresholdHours)';
}


}

/// @nodoc
abstract mixin class $AdminAutomationAlertItemCopyWith<$Res>  {
  factory $AdminAutomationAlertItemCopyWith(AdminAutomationAlertItem value, $Res Function(AdminAutomationAlertItem) _then) = _$AdminAutomationAlertItemCopyWithImpl;
@useResult
$Res call({
 BookingRecord booking, String kind, DateTime referenceAt, int thresholdHours
});


$BookingRecordCopyWith<$Res> get booking;

}
/// @nodoc
class _$AdminAutomationAlertItemCopyWithImpl<$Res>
    implements $AdminAutomationAlertItemCopyWith<$Res> {
  _$AdminAutomationAlertItemCopyWithImpl(this._self, this._then);

  final AdminAutomationAlertItem _self;
  final $Res Function(AdminAutomationAlertItem) _then;

/// Create a copy of AdminAutomationAlertItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = null,Object? kind = null,Object? referenceAt = null,Object? thresholdHours = null,}) {
  return _then(_self.copyWith(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingRecord,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,referenceAt: null == referenceAt ? _self.referenceAt : referenceAt // ignore: cast_nullable_to_non_nullable
as DateTime,thresholdHours: null == thresholdHours ? _self.thresholdHours : thresholdHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of AdminAutomationAlertItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingRecordCopyWith<$Res> get booking {
  
  return $BookingRecordCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminAutomationAlertItem].
extension AdminAutomationAlertItemPatterns on AdminAutomationAlertItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminAutomationAlertItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminAutomationAlertItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminAutomationAlertItem value)  $default,){
final _that = this;
switch (_that) {
case _AdminAutomationAlertItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminAutomationAlertItem value)?  $default,){
final _that = this;
switch (_that) {
case _AdminAutomationAlertItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingRecord booking,  String kind,  DateTime referenceAt,  int thresholdHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminAutomationAlertItem() when $default != null:
return $default(_that.booking,_that.kind,_that.referenceAt,_that.thresholdHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingRecord booking,  String kind,  DateTime referenceAt,  int thresholdHours)  $default,) {final _that = this;
switch (_that) {
case _AdminAutomationAlertItem():
return $default(_that.booking,_that.kind,_that.referenceAt,_that.thresholdHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingRecord booking,  String kind,  DateTime referenceAt,  int thresholdHours)?  $default,) {final _that = this;
switch (_that) {
case _AdminAutomationAlertItem() when $default != null:
return $default(_that.booking,_that.kind,_that.referenceAt,_that.thresholdHours);case _:
  return null;

}
}

}

/// @nodoc


class _AdminAutomationAlertItem extends AdminAutomationAlertItem {
  const _AdminAutomationAlertItem({required this.booking, required this.kind, required this.referenceAt, required this.thresholdHours}): super._();
  

@override final  BookingRecord booking;
@override final  String kind;
@override final  DateTime referenceAt;
@override final  int thresholdHours;

/// Create a copy of AdminAutomationAlertItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminAutomationAlertItemCopyWith<_AdminAutomationAlertItem> get copyWith => __$AdminAutomationAlertItemCopyWithImpl<_AdminAutomationAlertItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminAutomationAlertItem&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.referenceAt, referenceAt) || other.referenceAt == referenceAt)&&(identical(other.thresholdHours, thresholdHours) || other.thresholdHours == thresholdHours));
}


@override
int get hashCode => Object.hash(runtimeType,booking,kind,referenceAt,thresholdHours);

@override
String toString() {
  return 'AdminAutomationAlertItem(booking: $booking, kind: $kind, referenceAt: $referenceAt, thresholdHours: $thresholdHours)';
}


}

/// @nodoc
abstract mixin class _$AdminAutomationAlertItemCopyWith<$Res> implements $AdminAutomationAlertItemCopyWith<$Res> {
  factory _$AdminAutomationAlertItemCopyWith(_AdminAutomationAlertItem value, $Res Function(_AdminAutomationAlertItem) _then) = __$AdminAutomationAlertItemCopyWithImpl;
@override @useResult
$Res call({
 BookingRecord booking, String kind, DateTime referenceAt, int thresholdHours
});


@override $BookingRecordCopyWith<$Res> get booking;

}
/// @nodoc
class __$AdminAutomationAlertItemCopyWithImpl<$Res>
    implements _$AdminAutomationAlertItemCopyWith<$Res> {
  __$AdminAutomationAlertItemCopyWithImpl(this._self, this._then);

  final _AdminAutomationAlertItem _self;
  final $Res Function(_AdminAutomationAlertItem) _then;

/// Create a copy of AdminAutomationAlertItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = null,Object? kind = null,Object? referenceAt = null,Object? thresholdHours = null,}) {
  return _then(_AdminAutomationAlertItem(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingRecord,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,referenceAt: null == referenceAt ? _self.referenceAt : referenceAt // ignore: cast_nullable_to_non_nullable
as DateTime,thresholdHours: null == thresholdHours ? _self.thresholdHours : thresholdHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of AdminAutomationAlertItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingRecordCopyWith<$Res> get booking {
  
  return $BookingRecordCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on
