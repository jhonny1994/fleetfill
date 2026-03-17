// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_environment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppEnvironmentConfig {

 AppEnvironment get environment; String get supabaseUrl; String get supabaseAnonKey; bool get maintenanceMode; bool get forceUpdateRequired; bool get crashReportingEnabled;
/// Create a copy of AppEnvironmentConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppEnvironmentConfigCopyWith<AppEnvironmentConfig> get copyWith => _$AppEnvironmentConfigCopyWithImpl<AppEnvironmentConfig>(this as AppEnvironmentConfig, _$identity);

  /// Serializes this AppEnvironmentConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEnvironmentConfig&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.supabaseUrl, supabaseUrl) || other.supabaseUrl == supabaseUrl)&&(identical(other.supabaseAnonKey, supabaseAnonKey) || other.supabaseAnonKey == supabaseAnonKey)&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.forceUpdateRequired, forceUpdateRequired) || other.forceUpdateRequired == forceUpdateRequired)&&(identical(other.crashReportingEnabled, crashReportingEnabled) || other.crashReportingEnabled == crashReportingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,environment,supabaseUrl,supabaseAnonKey,maintenanceMode,forceUpdateRequired,crashReportingEnabled);

@override
String toString() {
  return 'AppEnvironmentConfig(environment: $environment, supabaseUrl: $supabaseUrl, supabaseAnonKey: $supabaseAnonKey, maintenanceMode: $maintenanceMode, forceUpdateRequired: $forceUpdateRequired, crashReportingEnabled: $crashReportingEnabled)';
}


}

/// @nodoc
abstract mixin class $AppEnvironmentConfigCopyWith<$Res>  {
  factory $AppEnvironmentConfigCopyWith(AppEnvironmentConfig value, $Res Function(AppEnvironmentConfig) _then) = _$AppEnvironmentConfigCopyWithImpl;
@useResult
$Res call({
 AppEnvironment environment, String supabaseUrl, String supabaseAnonKey, bool maintenanceMode, bool forceUpdateRequired, bool crashReportingEnabled
});




}
/// @nodoc
class _$AppEnvironmentConfigCopyWithImpl<$Res>
    implements $AppEnvironmentConfigCopyWith<$Res> {
  _$AppEnvironmentConfigCopyWithImpl(this._self, this._then);

  final AppEnvironmentConfig _self;
  final $Res Function(AppEnvironmentConfig) _then;

/// Create a copy of AppEnvironmentConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? environment = null,Object? supabaseUrl = null,Object? supabaseAnonKey = null,Object? maintenanceMode = null,Object? forceUpdateRequired = null,Object? crashReportingEnabled = null,}) {
  return _then(_self.copyWith(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as AppEnvironment,supabaseUrl: null == supabaseUrl ? _self.supabaseUrl : supabaseUrl // ignore: cast_nullable_to_non_nullable
as String,supabaseAnonKey: null == supabaseAnonKey ? _self.supabaseAnonKey : supabaseAnonKey // ignore: cast_nullable_to_non_nullable
as String,maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,forceUpdateRequired: null == forceUpdateRequired ? _self.forceUpdateRequired : forceUpdateRequired // ignore: cast_nullable_to_non_nullable
as bool,crashReportingEnabled: null == crashReportingEnabled ? _self.crashReportingEnabled : crashReportingEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppEnvironmentConfig].
extension AppEnvironmentConfigPatterns on AppEnvironmentConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppEnvironmentConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppEnvironmentConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppEnvironmentConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppEnvironmentConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppEnvironmentConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppEnvironmentConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppEnvironment environment,  String supabaseUrl,  String supabaseAnonKey,  bool maintenanceMode,  bool forceUpdateRequired,  bool crashReportingEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppEnvironmentConfig() when $default != null:
return $default(_that.environment,_that.supabaseUrl,_that.supabaseAnonKey,_that.maintenanceMode,_that.forceUpdateRequired,_that.crashReportingEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppEnvironment environment,  String supabaseUrl,  String supabaseAnonKey,  bool maintenanceMode,  bool forceUpdateRequired,  bool crashReportingEnabled)  $default,) {final _that = this;
switch (_that) {
case _AppEnvironmentConfig():
return $default(_that.environment,_that.supabaseUrl,_that.supabaseAnonKey,_that.maintenanceMode,_that.forceUpdateRequired,_that.crashReportingEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppEnvironment environment,  String supabaseUrl,  String supabaseAnonKey,  bool maintenanceMode,  bool forceUpdateRequired,  bool crashReportingEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AppEnvironmentConfig() when $default != null:
return $default(_that.environment,_that.supabaseUrl,_that.supabaseAnonKey,_that.maintenanceMode,_that.forceUpdateRequired,_that.crashReportingEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppEnvironmentConfig extends AppEnvironmentConfig {
  const _AppEnvironmentConfig({required this.environment, this.supabaseUrl = '', this.supabaseAnonKey = '', this.maintenanceMode = false, this.forceUpdateRequired = false, this.crashReportingEnabled = false}): super._();
  factory _AppEnvironmentConfig.fromJson(Map<String, dynamic> json) => _$AppEnvironmentConfigFromJson(json);

@override final  AppEnvironment environment;
@override@JsonKey() final  String supabaseUrl;
@override@JsonKey() final  String supabaseAnonKey;
@override@JsonKey() final  bool maintenanceMode;
@override@JsonKey() final  bool forceUpdateRequired;
@override@JsonKey() final  bool crashReportingEnabled;

/// Create a copy of AppEnvironmentConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppEnvironmentConfigCopyWith<_AppEnvironmentConfig> get copyWith => __$AppEnvironmentConfigCopyWithImpl<_AppEnvironmentConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppEnvironmentConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppEnvironmentConfig&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.supabaseUrl, supabaseUrl) || other.supabaseUrl == supabaseUrl)&&(identical(other.supabaseAnonKey, supabaseAnonKey) || other.supabaseAnonKey == supabaseAnonKey)&&(identical(other.maintenanceMode, maintenanceMode) || other.maintenanceMode == maintenanceMode)&&(identical(other.forceUpdateRequired, forceUpdateRequired) || other.forceUpdateRequired == forceUpdateRequired)&&(identical(other.crashReportingEnabled, crashReportingEnabled) || other.crashReportingEnabled == crashReportingEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,environment,supabaseUrl,supabaseAnonKey,maintenanceMode,forceUpdateRequired,crashReportingEnabled);

@override
String toString() {
  return 'AppEnvironmentConfig(environment: $environment, supabaseUrl: $supabaseUrl, supabaseAnonKey: $supabaseAnonKey, maintenanceMode: $maintenanceMode, forceUpdateRequired: $forceUpdateRequired, crashReportingEnabled: $crashReportingEnabled)';
}


}

/// @nodoc
abstract mixin class _$AppEnvironmentConfigCopyWith<$Res> implements $AppEnvironmentConfigCopyWith<$Res> {
  factory _$AppEnvironmentConfigCopyWith(_AppEnvironmentConfig value, $Res Function(_AppEnvironmentConfig) _then) = __$AppEnvironmentConfigCopyWithImpl;
@override @useResult
$Res call({
 AppEnvironment environment, String supabaseUrl, String supabaseAnonKey, bool maintenanceMode, bool forceUpdateRequired, bool crashReportingEnabled
});




}
/// @nodoc
class __$AppEnvironmentConfigCopyWithImpl<$Res>
    implements _$AppEnvironmentConfigCopyWith<$Res> {
  __$AppEnvironmentConfigCopyWithImpl(this._self, this._then);

  final _AppEnvironmentConfig _self;
  final $Res Function(_AppEnvironmentConfig) _then;

/// Create a copy of AppEnvironmentConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? environment = null,Object? supabaseUrl = null,Object? supabaseAnonKey = null,Object? maintenanceMode = null,Object? forceUpdateRequired = null,Object? crashReportingEnabled = null,}) {
  return _then(_AppEnvironmentConfig(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as AppEnvironment,supabaseUrl: null == supabaseUrl ? _self.supabaseUrl : supabaseUrl // ignore: cast_nullable_to_non_nullable
as String,supabaseAnonKey: null == supabaseAnonKey ? _self.supabaseAnonKey : supabaseAnonKey // ignore: cast_nullable_to_non_nullable
as String,maintenanceMode: null == maintenanceMode ? _self.maintenanceMode : maintenanceMode // ignore: cast_nullable_to_non_nullable
as bool,forceUpdateRequired: null == forceUpdateRequired ? _self.forceUpdateRequired : forceUpdateRequired // ignore: cast_nullable_to_non_nullable
as bool,crashReportingEnabled: null == crashReportingEnabled ? _self.crashReportingEnabled : crashReportingEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
