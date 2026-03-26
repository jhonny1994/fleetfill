// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout_account_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CarrierPayoutAccount {

 String get id; String get carrierId; PayoutAccountType get accountType; String get accountHolderName; String get accountIdentifier; String? get bankOrCcpName; bool get isActive; bool get isVerified; DateTime? get verifiedAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CarrierPayoutAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarrierPayoutAccountCopyWith<CarrierPayoutAccount> get copyWith => _$CarrierPayoutAccountCopyWithImpl<CarrierPayoutAccount>(this as CarrierPayoutAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarrierPayoutAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.accountHolderName, accountHolderName) || other.accountHolderName == accountHolderName)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.bankOrCcpName, bankOrCcpName) || other.bankOrCcpName == bankOrCcpName)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,accountType,accountHolderName,accountIdentifier,bankOrCcpName,isActive,isVerified,verifiedAt,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierPayoutAccount(id: $id, carrierId: $carrierId, accountType: $accountType, accountHolderName: $accountHolderName, accountIdentifier: $accountIdentifier, bankOrCcpName: $bankOrCcpName, isActive: $isActive, isVerified: $isVerified, verifiedAt: $verifiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CarrierPayoutAccountCopyWith<$Res>  {
  factory $CarrierPayoutAccountCopyWith(CarrierPayoutAccount value, $Res Function(CarrierPayoutAccount) _then) = _$CarrierPayoutAccountCopyWithImpl;
@useResult
$Res call({
 String id, String carrierId, PayoutAccountType accountType, String accountHolderName, String accountIdentifier, String? bankOrCcpName, bool isActive, bool isVerified, DateTime? verifiedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CarrierPayoutAccountCopyWithImpl<$Res>
    implements $CarrierPayoutAccountCopyWith<$Res> {
  _$CarrierPayoutAccountCopyWithImpl(this._self, this._then);

  final CarrierPayoutAccount _self;
  final $Res Function(CarrierPayoutAccount) _then;

/// Create a copy of CarrierPayoutAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? carrierId = null,Object? accountType = null,Object? accountHolderName = null,Object? accountIdentifier = null,Object? bankOrCcpName = freezed,Object? isActive = null,Object? isVerified = null,Object? verifiedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as PayoutAccountType,accountHolderName: null == accountHolderName ? _self.accountHolderName : accountHolderName // ignore: cast_nullable_to_non_nullable
as String,accountIdentifier: null == accountIdentifier ? _self.accountIdentifier : accountIdentifier // ignore: cast_nullable_to_non_nullable
as String,bankOrCcpName: freezed == bankOrCcpName ? _self.bankOrCcpName : bankOrCcpName // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CarrierPayoutAccount].
extension CarrierPayoutAccountPatterns on CarrierPayoutAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarrierPayoutAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarrierPayoutAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarrierPayoutAccount value)  $default,){
final _that = this;
switch (_that) {
case _CarrierPayoutAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarrierPayoutAccount value)?  $default,){
final _that = this;
switch (_that) {
case _CarrierPayoutAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String carrierId,  PayoutAccountType accountType,  String accountHolderName,  String accountIdentifier,  String? bankOrCcpName,  bool isActive,  bool isVerified,  DateTime? verifiedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarrierPayoutAccount() when $default != null:
return $default(_that.id,_that.carrierId,_that.accountType,_that.accountHolderName,_that.accountIdentifier,_that.bankOrCcpName,_that.isActive,_that.isVerified,_that.verifiedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String carrierId,  PayoutAccountType accountType,  String accountHolderName,  String accountIdentifier,  String? bankOrCcpName,  bool isActive,  bool isVerified,  DateTime? verifiedAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CarrierPayoutAccount():
return $default(_that.id,_that.carrierId,_that.accountType,_that.accountHolderName,_that.accountIdentifier,_that.bankOrCcpName,_that.isActive,_that.isVerified,_that.verifiedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String carrierId,  PayoutAccountType accountType,  String accountHolderName,  String accountIdentifier,  String? bankOrCcpName,  bool isActive,  bool isVerified,  DateTime? verifiedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CarrierPayoutAccount() when $default != null:
return $default(_that.id,_that.carrierId,_that.accountType,_that.accountHolderName,_that.accountIdentifier,_that.bankOrCcpName,_that.isActive,_that.isVerified,_that.verifiedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CarrierPayoutAccount extends CarrierPayoutAccount {
  const _CarrierPayoutAccount({required this.id, required this.carrierId, required this.accountType, required this.accountHolderName, required this.accountIdentifier, required this.bankOrCcpName, required this.isActive, required this.isVerified, required this.verifiedAt, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String carrierId;
@override final  PayoutAccountType accountType;
@override final  String accountHolderName;
@override final  String accountIdentifier;
@override final  String? bankOrCcpName;
@override final  bool isActive;
@override final  bool isVerified;
@override final  DateTime? verifiedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CarrierPayoutAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarrierPayoutAccountCopyWith<_CarrierPayoutAccount> get copyWith => __$CarrierPayoutAccountCopyWithImpl<_CarrierPayoutAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarrierPayoutAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.carrierId, carrierId) || other.carrierId == carrierId)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.accountHolderName, accountHolderName) || other.accountHolderName == accountHolderName)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.bankOrCcpName, bankOrCcpName) || other.bankOrCcpName == bankOrCcpName)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,carrierId,accountType,accountHolderName,accountIdentifier,bankOrCcpName,isActive,isVerified,verifiedAt,createdAt,updatedAt);

@override
String toString() {
  return 'CarrierPayoutAccount(id: $id, carrierId: $carrierId, accountType: $accountType, accountHolderName: $accountHolderName, accountIdentifier: $accountIdentifier, bankOrCcpName: $bankOrCcpName, isActive: $isActive, isVerified: $isVerified, verifiedAt: $verifiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CarrierPayoutAccountCopyWith<$Res> implements $CarrierPayoutAccountCopyWith<$Res> {
  factory _$CarrierPayoutAccountCopyWith(_CarrierPayoutAccount value, $Res Function(_CarrierPayoutAccount) _then) = __$CarrierPayoutAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String carrierId, PayoutAccountType accountType, String accountHolderName, String accountIdentifier, String? bankOrCcpName, bool isActive, bool isVerified, DateTime? verifiedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CarrierPayoutAccountCopyWithImpl<$Res>
    implements _$CarrierPayoutAccountCopyWith<$Res> {
  __$CarrierPayoutAccountCopyWithImpl(this._self, this._then);

  final _CarrierPayoutAccount _self;
  final $Res Function(_CarrierPayoutAccount) _then;

/// Create a copy of CarrierPayoutAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? carrierId = null,Object? accountType = null,Object? accountHolderName = null,Object? accountIdentifier = null,Object? bankOrCcpName = freezed,Object? isActive = null,Object? isVerified = null,Object? verifiedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CarrierPayoutAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,carrierId: null == carrierId ? _self.carrierId : carrierId // ignore: cast_nullable_to_non_nullable
as String,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as PayoutAccountType,accountHolderName: null == accountHolderName ? _self.accountHolderName : accountHolderName // ignore: cast_nullable_to_non_nullable
as String,accountIdentifier: null == accountIdentifier ? _self.accountIdentifier : accountIdentifier // ignore: cast_nullable_to_non_nullable
as String,bankOrCcpName: freezed == bankOrCcpName ? _self.bankOrCcpName : bankOrCcpName // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
