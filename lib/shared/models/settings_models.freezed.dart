// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientSettings {

 BookingPricingSettings get bookingPricing; DeliveryReviewSettings get deliveryReview; AppRuntimeSettings get appRuntime; List<PlatformPaymentAccountSettings> get paymentAccounts;
/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientSettingsCopyWith<ClientSettings> get copyWith => _$ClientSettingsCopyWithImpl<ClientSettings>(this as ClientSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientSettings&&(identical(other.bookingPricing, bookingPricing) || other.bookingPricing == bookingPricing)&&(identical(other.deliveryReview, deliveryReview) || other.deliveryReview == deliveryReview)&&(identical(other.appRuntime, appRuntime) || other.appRuntime == appRuntime)&&const DeepCollectionEquality().equals(other.paymentAccounts, paymentAccounts));
}


@override
int get hashCode => Object.hash(runtimeType,bookingPricing,deliveryReview,appRuntime,const DeepCollectionEquality().hash(paymentAccounts));

@override
String toString() {
  return 'ClientSettings(bookingPricing: $bookingPricing, deliveryReview: $deliveryReview, appRuntime: $appRuntime, paymentAccounts: $paymentAccounts)';
}


}

/// @nodoc
abstract mixin class $ClientSettingsCopyWith<$Res>  {
  factory $ClientSettingsCopyWith(ClientSettings value, $Res Function(ClientSettings) _then) = _$ClientSettingsCopyWithImpl;
@useResult
$Res call({
 BookingPricingSettings bookingPricing, DeliveryReviewSettings deliveryReview, AppRuntimeSettings appRuntime, List<PlatformPaymentAccountSettings> paymentAccounts
});


$BookingPricingSettingsCopyWith<$Res> get bookingPricing;$DeliveryReviewSettingsCopyWith<$Res> get deliveryReview;$AppRuntimeSettingsCopyWith<$Res> get appRuntime;

}
/// @nodoc
class _$ClientSettingsCopyWithImpl<$Res>
    implements $ClientSettingsCopyWith<$Res> {
  _$ClientSettingsCopyWithImpl(this._self, this._then);

  final ClientSettings _self;
  final $Res Function(ClientSettings) _then;

/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingPricing = null,Object? deliveryReview = null,Object? appRuntime = null,Object? paymentAccounts = null,}) {
  return _then(_self.copyWith(
bookingPricing: null == bookingPricing ? _self.bookingPricing : bookingPricing // ignore: cast_nullable_to_non_nullable
as BookingPricingSettings,deliveryReview: null == deliveryReview ? _self.deliveryReview : deliveryReview // ignore: cast_nullable_to_non_nullable
as DeliveryReviewSettings,appRuntime: null == appRuntime ? _self.appRuntime : appRuntime // ignore: cast_nullable_to_non_nullable
as AppRuntimeSettings,paymentAccounts: null == paymentAccounts ? _self.paymentAccounts : paymentAccounts // ignore: cast_nullable_to_non_nullable
as List<PlatformPaymentAccountSettings>,
  ));
}
/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingPricingSettingsCopyWith<$Res> get bookingPricing {
  
  return $BookingPricingSettingsCopyWith<$Res>(_self.bookingPricing, (value) {
    return _then(_self.copyWith(bookingPricing: value));
  });
}/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeliveryReviewSettingsCopyWith<$Res> get deliveryReview {
  
  return $DeliveryReviewSettingsCopyWith<$Res>(_self.deliveryReview, (value) {
    return _then(_self.copyWith(deliveryReview: value));
  });
}/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppRuntimeSettingsCopyWith<$Res> get appRuntime {
  
  return $AppRuntimeSettingsCopyWith<$Res>(_self.appRuntime, (value) {
    return _then(_self.copyWith(appRuntime: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClientSettings].
extension ClientSettingsPatterns on ClientSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientSettings value)  $default,){
final _that = this;
switch (_that) {
case _ClientSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ClientSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BookingPricingSettings bookingPricing,  DeliveryReviewSettings deliveryReview,  AppRuntimeSettings appRuntime,  List<PlatformPaymentAccountSettings> paymentAccounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientSettings() when $default != null:
return $default(_that.bookingPricing,_that.deliveryReview,_that.appRuntime,_that.paymentAccounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BookingPricingSettings bookingPricing,  DeliveryReviewSettings deliveryReview,  AppRuntimeSettings appRuntime,  List<PlatformPaymentAccountSettings> paymentAccounts)  $default,) {final _that = this;
switch (_that) {
case _ClientSettings():
return $default(_that.bookingPricing,_that.deliveryReview,_that.appRuntime,_that.paymentAccounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BookingPricingSettings bookingPricing,  DeliveryReviewSettings deliveryReview,  AppRuntimeSettings appRuntime,  List<PlatformPaymentAccountSettings> paymentAccounts)?  $default,) {final _that = this;
switch (_that) {
case _ClientSettings() when $default != null:
return $default(_that.bookingPricing,_that.deliveryReview,_that.appRuntime,_that.paymentAccounts);case _:
  return null;

}
}

}

/// @nodoc


class _ClientSettings extends ClientSettings {
  const _ClientSettings({required this.bookingPricing, required this.deliveryReview, required this.appRuntime, required final  List<PlatformPaymentAccountSettings> paymentAccounts}): _paymentAccounts = paymentAccounts,super._();
  

@override final  BookingPricingSettings bookingPricing;
@override final  DeliveryReviewSettings deliveryReview;
@override final  AppRuntimeSettings appRuntime;
 final  List<PlatformPaymentAccountSettings> _paymentAccounts;
@override List<PlatformPaymentAccountSettings> get paymentAccounts {
  if (_paymentAccounts is EqualUnmodifiableListView) return _paymentAccounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentAccounts);
}


/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientSettingsCopyWith<_ClientSettings> get copyWith => __$ClientSettingsCopyWithImpl<_ClientSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientSettings&&(identical(other.bookingPricing, bookingPricing) || other.bookingPricing == bookingPricing)&&(identical(other.deliveryReview, deliveryReview) || other.deliveryReview == deliveryReview)&&(identical(other.appRuntime, appRuntime) || other.appRuntime == appRuntime)&&const DeepCollectionEquality().equals(other._paymentAccounts, _paymentAccounts));
}


@override
int get hashCode => Object.hash(runtimeType,bookingPricing,deliveryReview,appRuntime,const DeepCollectionEquality().hash(_paymentAccounts));

@override
String toString() {
  return 'ClientSettings(bookingPricing: $bookingPricing, deliveryReview: $deliveryReview, appRuntime: $appRuntime, paymentAccounts: $paymentAccounts)';
}


}

/// @nodoc
abstract mixin class _$ClientSettingsCopyWith<$Res> implements $ClientSettingsCopyWith<$Res> {
  factory _$ClientSettingsCopyWith(_ClientSettings value, $Res Function(_ClientSettings) _then) = __$ClientSettingsCopyWithImpl;
@override @useResult
$Res call({
 BookingPricingSettings bookingPricing, DeliveryReviewSettings deliveryReview, AppRuntimeSettings appRuntime, List<PlatformPaymentAccountSettings> paymentAccounts
});


@override $BookingPricingSettingsCopyWith<$Res> get bookingPricing;@override $DeliveryReviewSettingsCopyWith<$Res> get deliveryReview;@override $AppRuntimeSettingsCopyWith<$Res> get appRuntime;

}
/// @nodoc
class __$ClientSettingsCopyWithImpl<$Res>
    implements _$ClientSettingsCopyWith<$Res> {
  __$ClientSettingsCopyWithImpl(this._self, this._then);

  final _ClientSettings _self;
  final $Res Function(_ClientSettings) _then;

/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingPricing = null,Object? deliveryReview = null,Object? appRuntime = null,Object? paymentAccounts = null,}) {
  return _then(_ClientSettings(
bookingPricing: null == bookingPricing ? _self.bookingPricing : bookingPricing // ignore: cast_nullable_to_non_nullable
as BookingPricingSettings,deliveryReview: null == deliveryReview ? _self.deliveryReview : deliveryReview // ignore: cast_nullable_to_non_nullable
as DeliveryReviewSettings,appRuntime: null == appRuntime ? _self.appRuntime : appRuntime // ignore: cast_nullable_to_non_nullable
as AppRuntimeSettings,paymentAccounts: null == paymentAccounts ? _self._paymentAccounts : paymentAccounts // ignore: cast_nullable_to_non_nullable
as List<PlatformPaymentAccountSettings>,
  ));
}

/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingPricingSettingsCopyWith<$Res> get bookingPricing {
  
  return $BookingPricingSettingsCopyWith<$Res>(_self.bookingPricing, (value) {
    return _then(_self.copyWith(bookingPricing: value));
  });
}/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeliveryReviewSettingsCopyWith<$Res> get deliveryReview {
  
  return $DeliveryReviewSettingsCopyWith<$Res>(_self.deliveryReview, (value) {
    return _then(_self.copyWith(deliveryReview: value));
  });
}/// Create a copy of ClientSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppRuntimeSettingsCopyWith<$Res> get appRuntime {
  
  return $AppRuntimeSettingsCopyWith<$Res>(_self.appRuntime, (value) {
    return _then(_self.copyWith(appRuntime: value));
  });
}
}

/// @nodoc
mixin _$BookingPricingSettings {

 double get platformFeeRate; double get carrierFeeRate; double get insuranceRate; double get insuranceMinFeeDzd; double get taxRate; int get paymentResubmissionDeadlineHours;
/// Create a copy of BookingPricingSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingPricingSettingsCopyWith<BookingPricingSettings> get copyWith => _$BookingPricingSettingsCopyWithImpl<BookingPricingSettings>(this as BookingPricingSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingPricingSettings&&(identical(other.platformFeeRate, platformFeeRate) || other.platformFeeRate == platformFeeRate)&&(identical(other.carrierFeeRate, carrierFeeRate) || other.carrierFeeRate == carrierFeeRate)&&(identical(other.insuranceRate, insuranceRate) || other.insuranceRate == insuranceRate)&&(identical(other.insuranceMinFeeDzd, insuranceMinFeeDzd) || other.insuranceMinFeeDzd == insuranceMinFeeDzd)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.paymentResubmissionDeadlineHours, paymentResubmissionDeadlineHours) || other.paymentResubmissionDeadlineHours == paymentResubmissionDeadlineHours));
}


@override
int get hashCode => Object.hash(runtimeType,platformFeeRate,carrierFeeRate,insuranceRate,insuranceMinFeeDzd,taxRate,paymentResubmissionDeadlineHours);

@override
String toString() {
  return 'BookingPricingSettings(platformFeeRate: $platformFeeRate, carrierFeeRate: $carrierFeeRate, insuranceRate: $insuranceRate, insuranceMinFeeDzd: $insuranceMinFeeDzd, taxRate: $taxRate, paymentResubmissionDeadlineHours: $paymentResubmissionDeadlineHours)';
}


}

/// @nodoc
abstract mixin class $BookingPricingSettingsCopyWith<$Res>  {
  factory $BookingPricingSettingsCopyWith(BookingPricingSettings value, $Res Function(BookingPricingSettings) _then) = _$BookingPricingSettingsCopyWithImpl;
@useResult
$Res call({
 double platformFeeRate, double carrierFeeRate, double insuranceRate, double insuranceMinFeeDzd, double taxRate, int paymentResubmissionDeadlineHours
});




}
/// @nodoc
class _$BookingPricingSettingsCopyWithImpl<$Res>
    implements $BookingPricingSettingsCopyWith<$Res> {
  _$BookingPricingSettingsCopyWithImpl(this._self, this._then);

  final BookingPricingSettings _self;
  final $Res Function(BookingPricingSettings) _then;

/// Create a copy of BookingPricingSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platformFeeRate = null,Object? carrierFeeRate = null,Object? insuranceRate = null,Object? insuranceMinFeeDzd = null,Object? taxRate = null,Object? paymentResubmissionDeadlineHours = null,}) {
  return _then(_self.copyWith(
platformFeeRate: null == platformFeeRate ? _self.platformFeeRate : platformFeeRate // ignore: cast_nullable_to_non_nullable
as double,carrierFeeRate: null == carrierFeeRate ? _self.carrierFeeRate : carrierFeeRate // ignore: cast_nullable_to_non_nullable
as double,insuranceRate: null == insuranceRate ? _self.insuranceRate : insuranceRate // ignore: cast_nullable_to_non_nullable
as double,insuranceMinFeeDzd: null == insuranceMinFeeDzd ? _self.insuranceMinFeeDzd : insuranceMinFeeDzd // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,paymentResubmissionDeadlineHours: null == paymentResubmissionDeadlineHours ? _self.paymentResubmissionDeadlineHours : paymentResubmissionDeadlineHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingPricingSettings].
extension BookingPricingSettingsPatterns on BookingPricingSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingPricingSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingPricingSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingPricingSettings value)  $default,){
final _that = this;
switch (_that) {
case _BookingPricingSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingPricingSettings value)?  $default,){
final _that = this;
switch (_that) {
case _BookingPricingSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double platformFeeRate,  double carrierFeeRate,  double insuranceRate,  double insuranceMinFeeDzd,  double taxRate,  int paymentResubmissionDeadlineHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingPricingSettings() when $default != null:
return $default(_that.platformFeeRate,_that.carrierFeeRate,_that.insuranceRate,_that.insuranceMinFeeDzd,_that.taxRate,_that.paymentResubmissionDeadlineHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double platformFeeRate,  double carrierFeeRate,  double insuranceRate,  double insuranceMinFeeDzd,  double taxRate,  int paymentResubmissionDeadlineHours)  $default,) {final _that = this;
switch (_that) {
case _BookingPricingSettings():
return $default(_that.platformFeeRate,_that.carrierFeeRate,_that.insuranceRate,_that.insuranceMinFeeDzd,_that.taxRate,_that.paymentResubmissionDeadlineHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double platformFeeRate,  double carrierFeeRate,  double insuranceRate,  double insuranceMinFeeDzd,  double taxRate,  int paymentResubmissionDeadlineHours)?  $default,) {final _that = this;
switch (_that) {
case _BookingPricingSettings() when $default != null:
return $default(_that.platformFeeRate,_that.carrierFeeRate,_that.insuranceRate,_that.insuranceMinFeeDzd,_that.taxRate,_that.paymentResubmissionDeadlineHours);case _:
  return null;

}
}

}

/// @nodoc


class _BookingPricingSettings extends BookingPricingSettings {
  const _BookingPricingSettings({required this.platformFeeRate, required this.carrierFeeRate, required this.insuranceRate, required this.insuranceMinFeeDzd, required this.taxRate, required this.paymentResubmissionDeadlineHours}): super._();
  

@override final  double platformFeeRate;
@override final  double carrierFeeRate;
@override final  double insuranceRate;
@override final  double insuranceMinFeeDzd;
@override final  double taxRate;
@override final  int paymentResubmissionDeadlineHours;

/// Create a copy of BookingPricingSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingPricingSettingsCopyWith<_BookingPricingSettings> get copyWith => __$BookingPricingSettingsCopyWithImpl<_BookingPricingSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingPricingSettings&&(identical(other.platformFeeRate, platformFeeRate) || other.platformFeeRate == platformFeeRate)&&(identical(other.carrierFeeRate, carrierFeeRate) || other.carrierFeeRate == carrierFeeRate)&&(identical(other.insuranceRate, insuranceRate) || other.insuranceRate == insuranceRate)&&(identical(other.insuranceMinFeeDzd, insuranceMinFeeDzd) || other.insuranceMinFeeDzd == insuranceMinFeeDzd)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.paymentResubmissionDeadlineHours, paymentResubmissionDeadlineHours) || other.paymentResubmissionDeadlineHours == paymentResubmissionDeadlineHours));
}


@override
int get hashCode => Object.hash(runtimeType,platformFeeRate,carrierFeeRate,insuranceRate,insuranceMinFeeDzd,taxRate,paymentResubmissionDeadlineHours);

@override
String toString() {
  return 'BookingPricingSettings(platformFeeRate: $platformFeeRate, carrierFeeRate: $carrierFeeRate, insuranceRate: $insuranceRate, insuranceMinFeeDzd: $insuranceMinFeeDzd, taxRate: $taxRate, paymentResubmissionDeadlineHours: $paymentResubmissionDeadlineHours)';
}


}

/// @nodoc
abstract mixin class _$BookingPricingSettingsCopyWith<$Res> implements $BookingPricingSettingsCopyWith<$Res> {
  factory _$BookingPricingSettingsCopyWith(_BookingPricingSettings value, $Res Function(_BookingPricingSettings) _then) = __$BookingPricingSettingsCopyWithImpl;
@override @useResult
$Res call({
 double platformFeeRate, double carrierFeeRate, double insuranceRate, double insuranceMinFeeDzd, double taxRate, int paymentResubmissionDeadlineHours
});




}
/// @nodoc
class __$BookingPricingSettingsCopyWithImpl<$Res>
    implements _$BookingPricingSettingsCopyWith<$Res> {
  __$BookingPricingSettingsCopyWithImpl(this._self, this._then);

  final _BookingPricingSettings _self;
  final $Res Function(_BookingPricingSettings) _then;

/// Create a copy of BookingPricingSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platformFeeRate = null,Object? carrierFeeRate = null,Object? insuranceRate = null,Object? insuranceMinFeeDzd = null,Object? taxRate = null,Object? paymentResubmissionDeadlineHours = null,}) {
  return _then(_BookingPricingSettings(
platformFeeRate: null == platformFeeRate ? _self.platformFeeRate : platformFeeRate // ignore: cast_nullable_to_non_nullable
as double,carrierFeeRate: null == carrierFeeRate ? _self.carrierFeeRate : carrierFeeRate // ignore: cast_nullable_to_non_nullable
as double,insuranceRate: null == insuranceRate ? _self.insuranceRate : insuranceRate // ignore: cast_nullable_to_non_nullable
as double,insuranceMinFeeDzd: null == insuranceMinFeeDzd ? _self.insuranceMinFeeDzd : insuranceMinFeeDzd // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,paymentResubmissionDeadlineHours: null == paymentResubmissionDeadlineHours ? _self.paymentResubmissionDeadlineHours : paymentResubmissionDeadlineHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$DeliveryReviewSettings {

 int get graceWindowHours;
/// Create a copy of DeliveryReviewSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryReviewSettingsCopyWith<DeliveryReviewSettings> get copyWith => _$DeliveryReviewSettingsCopyWithImpl<DeliveryReviewSettings>(this as DeliveryReviewSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryReviewSettings&&(identical(other.graceWindowHours, graceWindowHours) || other.graceWindowHours == graceWindowHours));
}


@override
int get hashCode => Object.hash(runtimeType,graceWindowHours);

@override
String toString() {
  return 'DeliveryReviewSettings(graceWindowHours: $graceWindowHours)';
}


}

/// @nodoc
abstract mixin class $DeliveryReviewSettingsCopyWith<$Res>  {
  factory $DeliveryReviewSettingsCopyWith(DeliveryReviewSettings value, $Res Function(DeliveryReviewSettings) _then) = _$DeliveryReviewSettingsCopyWithImpl;
@useResult
$Res call({
 int graceWindowHours
});




}
/// @nodoc
class _$DeliveryReviewSettingsCopyWithImpl<$Res>
    implements $DeliveryReviewSettingsCopyWith<$Res> {
  _$DeliveryReviewSettingsCopyWithImpl(this._self, this._then);

  final DeliveryReviewSettings _self;
  final $Res Function(DeliveryReviewSettings) _then;

/// Create a copy of DeliveryReviewSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? graceWindowHours = null,}) {
  return _then(_self.copyWith(
graceWindowHours: null == graceWindowHours ? _self.graceWindowHours : graceWindowHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryReviewSettings].
extension DeliveryReviewSettingsPatterns on DeliveryReviewSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryReviewSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryReviewSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryReviewSettings value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryReviewSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryReviewSettings value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryReviewSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int graceWindowHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryReviewSettings() when $default != null:
return $default(_that.graceWindowHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int graceWindowHours)  $default,) {final _that = this;
switch (_that) {
case _DeliveryReviewSettings():
return $default(_that.graceWindowHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int graceWindowHours)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryReviewSettings() when $default != null:
return $default(_that.graceWindowHours);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryReviewSettings extends DeliveryReviewSettings {
  const _DeliveryReviewSettings({required this.graceWindowHours}): super._();
  

@override final  int graceWindowHours;

/// Create a copy of DeliveryReviewSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryReviewSettingsCopyWith<_DeliveryReviewSettings> get copyWith => __$DeliveryReviewSettingsCopyWithImpl<_DeliveryReviewSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryReviewSettings&&(identical(other.graceWindowHours, graceWindowHours) || other.graceWindowHours == graceWindowHours));
}


@override
int get hashCode => Object.hash(runtimeType,graceWindowHours);

@override
String toString() {
  return 'DeliveryReviewSettings(graceWindowHours: $graceWindowHours)';
}


}

/// @nodoc
abstract mixin class _$DeliveryReviewSettingsCopyWith<$Res> implements $DeliveryReviewSettingsCopyWith<$Res> {
  factory _$DeliveryReviewSettingsCopyWith(_DeliveryReviewSettings value, $Res Function(_DeliveryReviewSettings) _then) = __$DeliveryReviewSettingsCopyWithImpl;
@override @useResult
$Res call({
 int graceWindowHours
});




}
/// @nodoc
class __$DeliveryReviewSettingsCopyWithImpl<$Res>
    implements _$DeliveryReviewSettingsCopyWith<$Res> {
  __$DeliveryReviewSettingsCopyWithImpl(this._self, this._then);

  final _DeliveryReviewSettings _self;
  final $Res Function(_DeliveryReviewSettings) _then;

/// Create a copy of DeliveryReviewSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? graceWindowHours = null,}) {
  return _then(_DeliveryReviewSettings(
graceWindowHours: null == graceWindowHours ? _self.graceWindowHours : graceWindowHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$AppRuntimeSettings {

 bool get maintenanceMode; bool get forceUpdateRequired; int get minimumSupportedAndroidVersion; int get minimumSupportedIosVersion;
/// Create a copy of AppRuntimeSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppRuntimeSettingsCopyWith<AppRuntimeSettings> get copyWith => _$AppRuntimeSettingsCopyWithImpl<AppRuntimeSettings>(this as AppRuntimeSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRuntimeSettings&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.forceUpdateRequired, forceUpdateRequired) || other.forceUpdateRequired == forceUpdateRequired)&&(identical(other.minimumSupportedAndroidVersion, minimumSupportedAndroidVersion) || other.minimumSupportedAndroidVersion == minimumSupportedAndroidVersion)&&(identical(other.minimumSupportedIosVersion, minimumSupportedIosVersion) || other.minimumSupportedIosVersion == minimumSupportedIosVersion));
}


@override
int get hashCode => Object.hash(runtimeType,maintenanceMode,forceUpdateRequired,minimumSupportedAndroidVersion,minimumSupportedIosVersion);

@override
String toString() {
  return 'AppRuntimeSettings(maintenanceMode: $maintenanceMode, forceUpdateRequired: $forceUpdateRequired, minimumSupportedAndroidVersion: $minimumSupportedAndroidVersion, minimumSupportedIosVersion: $minimumSupportedIosVersion)';
}


}

/// @nodoc
abstract mixin class $AppRuntimeSettingsCopyWith<$Res>  {
  factory $AppRuntimeSettingsCopyWith(AppRuntimeSettings value, $Res Function(AppRuntimeSettings) _then) = _$AppRuntimeSettingsCopyWithImpl;
@useResult
$Res call({
 bool maintenanceMode, bool forceUpdateRequired, int minimumSupportedAndroidVersion, int minimumSupportedIosVersion
});




}
/// @nodoc
class _$AppRuntimeSettingsCopyWithImpl<$Res>
    implements $AppRuntimeSettingsCopyWith<$Res> {
  _$AppRuntimeSettingsCopyWithImpl(this._self, this._then);

  final AppRuntimeSettings _self;
  final $Res Function(AppRuntimeSettings) _then;

/// Create a copy of AppRuntimeSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maintenanceMode = null,Object? forceUpdateRequired = null,Object? minimumSupportedAndroidVersion = null,Object? minimumSupportedIosVersion = null,}) {
  return _then(_self.copyWith(
maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,forceUpdateRequired: null == forceUpdateRequired ? _self.forceUpdateRequired : forceUpdateRequired // ignore: cast_nullable_to_non_nullable
as bool,minimumSupportedAndroidVersion: null == minimumSupportedAndroidVersion ? _self.minimumSupportedAndroidVersion : minimumSupportedAndroidVersion // ignore: cast_nullable_to_non_nullable
as int,minimumSupportedIosVersion: null == minimumSupportedIosVersion ? _self.minimumSupportedIosVersion : minimumSupportedIosVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppRuntimeSettings].
extension AppRuntimeSettingsPatterns on AppRuntimeSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppRuntimeSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppRuntimeSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppRuntimeSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppRuntimeSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppRuntimeSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppRuntimeSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool maintenanceMode,  bool forceUpdateRequired,  int minimumSupportedAndroidVersion,  int minimumSupportedIosVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppRuntimeSettings() when $default != null:
return $default(_that.maintenanceMode,_that.forceUpdateRequired,_that.minimumSupportedAndroidVersion,_that.minimumSupportedIosVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool maintenanceMode,  bool forceUpdateRequired,  int minimumSupportedAndroidVersion,  int minimumSupportedIosVersion)  $default,) {final _that = this;
switch (_that) {
case _AppRuntimeSettings():
return $default(_that.maintenanceMode,_that.forceUpdateRequired,_that.minimumSupportedAndroidVersion,_that.minimumSupportedIosVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool maintenanceMode,  bool forceUpdateRequired,  int minimumSupportedAndroidVersion,  int minimumSupportedIosVersion)?  $default,) {final _that = this;
switch (_that) {
case _AppRuntimeSettings() when $default != null:
return $default(_that.maintenanceMode,_that.forceUpdateRequired,_that.minimumSupportedAndroidVersion,_that.minimumSupportedIosVersion);case _:
  return null;

}
}

}

/// @nodoc


class _AppRuntimeSettings extends AppRuntimeSettings {
  const _AppRuntimeSettings({required this.maintenanceMode, required this.forceUpdateRequired, required this.minimumSupportedAndroidVersion, required this.minimumSupportedIosVersion}): super._();
  

@override final  bool maintenanceMode;
@override final  bool forceUpdateRequired;
@override final  int minimumSupportedAndroidVersion;
@override final  int minimumSupportedIosVersion;

/// Create a copy of AppRuntimeSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppRuntimeSettingsCopyWith<_AppRuntimeSettings> get copyWith => __$AppRuntimeSettingsCopyWithImpl<_AppRuntimeSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppRuntimeSettings&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.forceUpdateRequired, forceUpdateRequired) || other.forceUpdateRequired == forceUpdateRequired)&&(identical(other.minimumSupportedAndroidVersion, minimumSupportedAndroidVersion) || other.minimumSupportedAndroidVersion == minimumSupportedAndroidVersion)&&(identical(other.minimumSupportedIosVersion, minimumSupportedIosVersion) || other.minimumSupportedIosVersion == minimumSupportedIosVersion));
}


@override
int get hashCode => Object.hash(runtimeType,maintenanceMode,forceUpdateRequired,minimumSupportedAndroidVersion,minimumSupportedIosVersion);

@override
String toString() {
  return 'AppRuntimeSettings(maintenanceMode: $maintenanceMode, forceUpdateRequired: $forceUpdateRequired, minimumSupportedAndroidVersion: $minimumSupportedAndroidVersion, minimumSupportedIosVersion: $minimumSupportedIosVersion)';
}


}

/// @nodoc
abstract mixin class _$AppRuntimeSettingsCopyWith<$Res> implements $AppRuntimeSettingsCopyWith<$Res> {
  factory _$AppRuntimeSettingsCopyWith(_AppRuntimeSettings value, $Res Function(_AppRuntimeSettings) _then) = __$AppRuntimeSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool maintenanceMode, bool forceUpdateRequired, int minimumSupportedAndroidVersion, int minimumSupportedIosVersion
});




}
/// @nodoc
class __$AppRuntimeSettingsCopyWithImpl<$Res>
    implements _$AppRuntimeSettingsCopyWith<$Res> {
  __$AppRuntimeSettingsCopyWithImpl(this._self, this._then);

  final _AppRuntimeSettings _self;
  final $Res Function(_AppRuntimeSettings) _then;

/// Create a copy of AppRuntimeSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maintenanceMode = null,Object? forceUpdateRequired = null,Object? minimumSupportedAndroidVersion = null,Object? minimumSupportedIosVersion = null,}) {
  return _then(_AppRuntimeSettings(
maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,forceUpdateRequired: null == forceUpdateRequired ? _self.forceUpdateRequired : forceUpdateRequired // ignore: cast_nullable_to_non_nullable
as bool,minimumSupportedAndroidVersion: null == minimumSupportedAndroidVersion ? _self.minimumSupportedAndroidVersion : minimumSupportedAndroidVersion // ignore: cast_nullable_to_non_nullable
as int,minimumSupportedIosVersion: null == minimumSupportedIosVersion ? _self.minimumSupportedIosVersion : minimumSupportedIosVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PlatformPaymentAccountSettings {

 String get id; String get paymentRail; String get displayName; String get accountIdentifier; String get accountHolderName; String? get instructionsText;
/// Create a copy of PlatformPaymentAccountSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformPaymentAccountSettingsCopyWith<PlatformPaymentAccountSettings> get copyWith => _$PlatformPaymentAccountSettingsCopyWithImpl<PlatformPaymentAccountSettings>(this as PlatformPaymentAccountSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformPaymentAccountSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.paymentRail, paymentRail) || other.paymentRail == paymentRail)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.accountHolderName, accountHolderName) || other.accountHolderName == accountHolderName)&&(identical(other.instructionsText, instructionsText) || other.instructionsText == instructionsText));
}


@override
int get hashCode => Object.hash(runtimeType,id,paymentRail,displayName,accountIdentifier,accountHolderName,instructionsText);

@override
String toString() {
  return 'PlatformPaymentAccountSettings(id: $id, paymentRail: $paymentRail, displayName: $displayName, accountIdentifier: $accountIdentifier, accountHolderName: $accountHolderName, instructionsText: $instructionsText)';
}


}

/// @nodoc
abstract mixin class $PlatformPaymentAccountSettingsCopyWith<$Res>  {
  factory $PlatformPaymentAccountSettingsCopyWith(PlatformPaymentAccountSettings value, $Res Function(PlatformPaymentAccountSettings) _then) = _$PlatformPaymentAccountSettingsCopyWithImpl;
@useResult
$Res call({
 String id, String paymentRail, String displayName, String accountIdentifier, String accountHolderName, String? instructionsText
});




}
/// @nodoc
class _$PlatformPaymentAccountSettingsCopyWithImpl<$Res>
    implements $PlatformPaymentAccountSettingsCopyWith<$Res> {
  _$PlatformPaymentAccountSettingsCopyWithImpl(this._self, this._then);

  final PlatformPaymentAccountSettings _self;
  final $Res Function(PlatformPaymentAccountSettings) _then;

/// Create a copy of PlatformPaymentAccountSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? paymentRail = null,Object? displayName = null,Object? accountIdentifier = null,Object? accountHolderName = null,Object? instructionsText = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,paymentRail: null == paymentRail ? _self.paymentRail : paymentRail // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,accountIdentifier: null == accountIdentifier ? _self.accountIdentifier : accountIdentifier // ignore: cast_nullable_to_non_nullable
as String,accountHolderName: null == accountHolderName ? _self.accountHolderName : accountHolderName // ignore: cast_nullable_to_non_nullable
as String,instructionsText: freezed == instructionsText ? _self.instructionsText : instructionsText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformPaymentAccountSettings].
extension PlatformPaymentAccountSettingsPatterns on PlatformPaymentAccountSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformPaymentAccountSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformPaymentAccountSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformPaymentAccountSettings value)  $default,){
final _that = this;
switch (_that) {
case _PlatformPaymentAccountSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformPaymentAccountSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformPaymentAccountSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String paymentRail,  String displayName,  String accountIdentifier,  String accountHolderName,  String? instructionsText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformPaymentAccountSettings() when $default != null:
return $default(_that.id,_that.paymentRail,_that.displayName,_that.accountIdentifier,_that.accountHolderName,_that.instructionsText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String paymentRail,  String displayName,  String accountIdentifier,  String accountHolderName,  String? instructionsText)  $default,) {final _that = this;
switch (_that) {
case _PlatformPaymentAccountSettings():
return $default(_that.id,_that.paymentRail,_that.displayName,_that.accountIdentifier,_that.accountHolderName,_that.instructionsText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String paymentRail,  String displayName,  String accountIdentifier,  String accountHolderName,  String? instructionsText)?  $default,) {final _that = this;
switch (_that) {
case _PlatformPaymentAccountSettings() when $default != null:
return $default(_that.id,_that.paymentRail,_that.displayName,_that.accountIdentifier,_that.accountHolderName,_that.instructionsText);case _:
  return null;

}
}

}

/// @nodoc


class _PlatformPaymentAccountSettings extends PlatformPaymentAccountSettings {
  const _PlatformPaymentAccountSettings({required this.id, required this.paymentRail, required this.displayName, required this.accountIdentifier, required this.accountHolderName, required this.instructionsText}): super._();
  

@override final  String id;
@override final  String paymentRail;
@override final  String displayName;
@override final  String accountIdentifier;
@override final  String accountHolderName;
@override final  String? instructionsText;

/// Create a copy of PlatformPaymentAccountSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformPaymentAccountSettingsCopyWith<_PlatformPaymentAccountSettings> get copyWith => __$PlatformPaymentAccountSettingsCopyWithImpl<_PlatformPaymentAccountSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformPaymentAccountSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.paymentRail, paymentRail) || other.paymentRail == paymentRail)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.accountHolderName, accountHolderName) || other.accountHolderName == accountHolderName)&&(identical(other.instructionsText, instructionsText) || other.instructionsText == instructionsText));
}


@override
int get hashCode => Object.hash(runtimeType,id,paymentRail,displayName,accountIdentifier,accountHolderName,instructionsText);

@override
String toString() {
  return 'PlatformPaymentAccountSettings(id: $id, paymentRail: $paymentRail, displayName: $displayName, accountIdentifier: $accountIdentifier, accountHolderName: $accountHolderName, instructionsText: $instructionsText)';
}


}

/// @nodoc
abstract mixin class _$PlatformPaymentAccountSettingsCopyWith<$Res> implements $PlatformPaymentAccountSettingsCopyWith<$Res> {
  factory _$PlatformPaymentAccountSettingsCopyWith(_PlatformPaymentAccountSettings value, $Res Function(_PlatformPaymentAccountSettings) _then) = __$PlatformPaymentAccountSettingsCopyWithImpl;
@override @useResult
$Res call({
 String id, String paymentRail, String displayName, String accountIdentifier, String accountHolderName, String? instructionsText
});




}
/// @nodoc
class __$PlatformPaymentAccountSettingsCopyWithImpl<$Res>
    implements _$PlatformPaymentAccountSettingsCopyWith<$Res> {
  __$PlatformPaymentAccountSettingsCopyWithImpl(this._self, this._then);

  final _PlatformPaymentAccountSettings _self;
  final $Res Function(_PlatformPaymentAccountSettings) _then;

/// Create a copy of PlatformPaymentAccountSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? paymentRail = null,Object? displayName = null,Object? accountIdentifier = null,Object? accountHolderName = null,Object? instructionsText = freezed,}) {
  return _then(_PlatformPaymentAccountSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,paymentRail: null == paymentRail ? _self.paymentRail : paymentRail // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,accountIdentifier: null == accountIdentifier ? _self.accountIdentifier : accountIdentifier // ignore: cast_nullable_to_non_nullable
as String,accountHolderName: null == accountHolderName ? _self.accountHolderName : accountHolderName // ignore: cast_nullable_to_non_nullable
as String,instructionsText: freezed == instructionsText ? _self.instructionsText : instructionsText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
