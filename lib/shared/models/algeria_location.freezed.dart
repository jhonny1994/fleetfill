// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'algeria_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlgeriaCommune {

 int get id;@JsonKey(name: 'wilaya_id') int get wilayaId;@JsonKey(name: 'name_fr', readValue: _readCommuneLatinName) String get nameFr;@JsonKey(name: 'name_ar') String get nameAr;
/// Create a copy of AlgeriaCommune
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlgeriaCommuneCopyWith<AlgeriaCommune> get copyWith => _$AlgeriaCommuneCopyWithImpl<AlgeriaCommune>(this as AlgeriaCommune, _$identity);

  /// Serializes this AlgeriaCommune to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlgeriaCommune&&(identical(other.id, id) || other.id == id)&&(identical(other.wilayaId, wilayaId) || other.wilayaId == wilayaId)&&(identical(other.nameFr, nameFr) || other.nameFr == nameFr)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,wilayaId,nameFr,nameAr);

@override
String toString() {
  return 'AlgeriaCommune(id: $id, wilayaId: $wilayaId, nameFr: $nameFr, nameAr: $nameAr)';
}


}

/// @nodoc
abstract mixin class $AlgeriaCommuneCopyWith<$Res>  {
  factory $AlgeriaCommuneCopyWith(AlgeriaCommune value, $Res Function(AlgeriaCommune) _then) = _$AlgeriaCommuneCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'wilaya_id') int wilayaId,@JsonKey(name: 'name_fr', readValue: _readCommuneLatinName) String nameFr,@JsonKey(name: 'name_ar') String nameAr
});




}
/// @nodoc
class _$AlgeriaCommuneCopyWithImpl<$Res>
    implements $AlgeriaCommuneCopyWith<$Res> {
  _$AlgeriaCommuneCopyWithImpl(this._self, this._then);

  final AlgeriaCommune _self;
  final $Res Function(AlgeriaCommune) _then;

/// Create a copy of AlgeriaCommune
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? wilayaId = null,Object? nameFr = null,Object? nameAr = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,wilayaId: null == wilayaId ? _self.wilayaId : wilayaId // ignore: cast_nullable_to_non_nullable
as int,nameFr: null == nameFr ? _self.nameFr : nameFr // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AlgeriaCommune].
extension AlgeriaCommunePatterns on AlgeriaCommune {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlgeriaCommune value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlgeriaCommune() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlgeriaCommune value)  $default,){
final _that = this;
switch (_that) {
case _AlgeriaCommune():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlgeriaCommune value)?  $default,){
final _that = this;
switch (_that) {
case _AlgeriaCommune() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'wilaya_id')  int wilayaId, @JsonKey(name: 'name_fr', readValue: _readCommuneLatinName)  String nameFr, @JsonKey(name: 'name_ar')  String nameAr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlgeriaCommune() when $default != null:
return $default(_that.id,_that.wilayaId,_that.nameFr,_that.nameAr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'wilaya_id')  int wilayaId, @JsonKey(name: 'name_fr', readValue: _readCommuneLatinName)  String nameFr, @JsonKey(name: 'name_ar')  String nameAr)  $default,) {final _that = this;
switch (_that) {
case _AlgeriaCommune():
return $default(_that.id,_that.wilayaId,_that.nameFr,_that.nameAr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'wilaya_id')  int wilayaId, @JsonKey(name: 'name_fr', readValue: _readCommuneLatinName)  String nameFr, @JsonKey(name: 'name_ar')  String nameAr)?  $default,) {final _that = this;
switch (_that) {
case _AlgeriaCommune() when $default != null:
return $default(_that.id,_that.wilayaId,_that.nameFr,_that.nameAr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlgeriaCommune extends AlgeriaCommune {
  const _AlgeriaCommune({required this.id, @JsonKey(name: 'wilaya_id') required this.wilayaId, @JsonKey(name: 'name_fr', readValue: _readCommuneLatinName) required this.nameFr, @JsonKey(name: 'name_ar') required this.nameAr}): super._();
  factory _AlgeriaCommune.fromJson(Map<String, dynamic> json) => _$AlgeriaCommuneFromJson(json);

@override final  int id;
@override@JsonKey(name: 'wilaya_id') final  int wilayaId;
@override@JsonKey(name: 'name_fr', readValue: _readCommuneLatinName) final  String nameFr;
@override@JsonKey(name: 'name_ar') final  String nameAr;

/// Create a copy of AlgeriaCommune
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlgeriaCommuneCopyWith<_AlgeriaCommune> get copyWith => __$AlgeriaCommuneCopyWithImpl<_AlgeriaCommune>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlgeriaCommuneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlgeriaCommune&&(identical(other.id, id) || other.id == id)&&(identical(other.wilayaId, wilayaId) || other.wilayaId == wilayaId)&&(identical(other.nameFr, nameFr) || other.nameFr == nameFr)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,wilayaId,nameFr,nameAr);

@override
String toString() {
  return 'AlgeriaCommune(id: $id, wilayaId: $wilayaId, nameFr: $nameFr, nameAr: $nameAr)';
}


}

/// @nodoc
abstract mixin class _$AlgeriaCommuneCopyWith<$Res> implements $AlgeriaCommuneCopyWith<$Res> {
  factory _$AlgeriaCommuneCopyWith(_AlgeriaCommune value, $Res Function(_AlgeriaCommune) _then) = __$AlgeriaCommuneCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'wilaya_id') int wilayaId,@JsonKey(name: 'name_fr', readValue: _readCommuneLatinName) String nameFr,@JsonKey(name: 'name_ar') String nameAr
});




}
/// @nodoc
class __$AlgeriaCommuneCopyWithImpl<$Res>
    implements _$AlgeriaCommuneCopyWith<$Res> {
  __$AlgeriaCommuneCopyWithImpl(this._self, this._then);

  final _AlgeriaCommune _self;
  final $Res Function(_AlgeriaCommune) _then;

/// Create a copy of AlgeriaCommune
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? wilayaId = null,Object? nameFr = null,Object? nameAr = null,}) {
  return _then(_AlgeriaCommune(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,wilayaId: null == wilayaId ? _self.wilayaId : wilayaId // ignore: cast_nullable_to_non_nullable
as int,nameFr: null == nameFr ? _self.nameFr : nameFr // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AlgeriaWilaya {

 int get id; String get nameFr;@JsonKey(name: 'name_ar') String get nameAr;
/// Create a copy of AlgeriaWilaya
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlgeriaWilayaCopyWith<AlgeriaWilaya> get copyWith => _$AlgeriaWilayaCopyWithImpl<AlgeriaWilaya>(this as AlgeriaWilaya, _$identity);

  /// Serializes this AlgeriaWilaya to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlgeriaWilaya&&(identical(other.id, id) || other.id == id)&&(identical(other.nameFr, nameFr) || other.nameFr == nameFr)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameFr,nameAr);

@override
String toString() {
  return 'AlgeriaWilaya(id: $id, nameFr: $nameFr, nameAr: $nameAr)';
}


}

/// @nodoc
abstract mixin class $AlgeriaWilayaCopyWith<$Res>  {
  factory $AlgeriaWilayaCopyWith(AlgeriaWilaya value, $Res Function(AlgeriaWilaya) _then) = _$AlgeriaWilayaCopyWithImpl;
@useResult
$Res call({
 int id, String nameFr,@JsonKey(name: 'name_ar') String nameAr
});




}
/// @nodoc
class _$AlgeriaWilayaCopyWithImpl<$Res>
    implements $AlgeriaWilayaCopyWith<$Res> {
  _$AlgeriaWilayaCopyWithImpl(this._self, this._then);

  final AlgeriaWilaya _self;
  final $Res Function(AlgeriaWilaya) _then;

/// Create a copy of AlgeriaWilaya
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameFr = null,Object? nameAr = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameFr: null == nameFr ? _self.nameFr : nameFr // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AlgeriaWilaya].
extension AlgeriaWilayaPatterns on AlgeriaWilaya {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlgeriaWilaya value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlgeriaWilaya() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlgeriaWilaya value)  $default,){
final _that = this;
switch (_that) {
case _AlgeriaWilaya():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlgeriaWilaya value)?  $default,){
final _that = this;
switch (_that) {
case _AlgeriaWilaya() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameFr, @JsonKey(name: 'name_ar')  String nameAr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlgeriaWilaya() when $default != null:
return $default(_that.id,_that.nameFr,_that.nameAr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameFr, @JsonKey(name: 'name_ar')  String nameAr)  $default,) {final _that = this;
switch (_that) {
case _AlgeriaWilaya():
return $default(_that.id,_that.nameFr,_that.nameAr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameFr, @JsonKey(name: 'name_ar')  String nameAr)?  $default,) {final _that = this;
switch (_that) {
case _AlgeriaWilaya() when $default != null:
return $default(_that.id,_that.nameFr,_that.nameAr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlgeriaWilaya extends AlgeriaWilaya {
  const _AlgeriaWilaya({required this.id, required this.nameFr, @JsonKey(name: 'name_ar') required this.nameAr}): super._();
  factory _AlgeriaWilaya.fromJson(Map<String, dynamic> json) => _$AlgeriaWilayaFromJson(json);

@override final  int id;
@override final  String nameFr;
@override@JsonKey(name: 'name_ar') final  String nameAr;

/// Create a copy of AlgeriaWilaya
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlgeriaWilayaCopyWith<_AlgeriaWilaya> get copyWith => __$AlgeriaWilayaCopyWithImpl<_AlgeriaWilaya>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlgeriaWilayaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlgeriaWilaya&&(identical(other.id, id) || other.id == id)&&(identical(other.nameFr, nameFr) || other.nameFr == nameFr)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameFr,nameAr);

@override
String toString() {
  return 'AlgeriaWilaya(id: $id, nameFr: $nameFr, nameAr: $nameAr)';
}


}

/// @nodoc
abstract mixin class _$AlgeriaWilayaCopyWith<$Res> implements $AlgeriaWilayaCopyWith<$Res> {
  factory _$AlgeriaWilayaCopyWith(_AlgeriaWilaya value, $Res Function(_AlgeriaWilaya) _then) = __$AlgeriaWilayaCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameFr,@JsonKey(name: 'name_ar') String nameAr
});




}
/// @nodoc
class __$AlgeriaWilayaCopyWithImpl<$Res>
    implements _$AlgeriaWilayaCopyWith<$Res> {
  __$AlgeriaWilayaCopyWithImpl(this._self, this._then);

  final _AlgeriaWilaya _self;
  final $Res Function(_AlgeriaWilaya) _then;

/// Create a copy of AlgeriaWilaya
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameFr = null,Object? nameAr = null,}) {
  return _then(_AlgeriaWilaya(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameFr: null == nameFr ? _self.nameFr : nameFr // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AlgeriaLocationDirectory {

 List<AlgeriaWilaya> get wilayas; List<AlgeriaCommune> get communes;
/// Create a copy of AlgeriaLocationDirectory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlgeriaLocationDirectoryCopyWith<AlgeriaLocationDirectory> get copyWith => _$AlgeriaLocationDirectoryCopyWithImpl<AlgeriaLocationDirectory>(this as AlgeriaLocationDirectory, _$identity);

  /// Serializes this AlgeriaLocationDirectory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlgeriaLocationDirectory&&const DeepCollectionEquality().equals(other.wilayas, wilayas)&&const DeepCollectionEquality().equals(other.communes, communes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(wilayas),const DeepCollectionEquality().hash(communes));

@override
String toString() {
  return 'AlgeriaLocationDirectory(wilayas: $wilayas, communes: $communes)';
}


}

/// @nodoc
abstract mixin class $AlgeriaLocationDirectoryCopyWith<$Res>  {
  factory $AlgeriaLocationDirectoryCopyWith(AlgeriaLocationDirectory value, $Res Function(AlgeriaLocationDirectory) _then) = _$AlgeriaLocationDirectoryCopyWithImpl;
@useResult
$Res call({
 List<AlgeriaWilaya> wilayas, List<AlgeriaCommune> communes
});




}
/// @nodoc
class _$AlgeriaLocationDirectoryCopyWithImpl<$Res>
    implements $AlgeriaLocationDirectoryCopyWith<$Res> {
  _$AlgeriaLocationDirectoryCopyWithImpl(this._self, this._then);

  final AlgeriaLocationDirectory _self;
  final $Res Function(AlgeriaLocationDirectory) _then;

/// Create a copy of AlgeriaLocationDirectory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wilayas = null,Object? communes = null,}) {
  return _then(_self.copyWith(
wilayas: null == wilayas ? _self.wilayas : wilayas // ignore: cast_nullable_to_non_nullable
as List<AlgeriaWilaya>,communes: null == communes ? _self.communes : communes // ignore: cast_nullable_to_non_nullable
as List<AlgeriaCommune>,
  ));
}

}


/// Adds pattern-matching-related methods to [AlgeriaLocationDirectory].
extension AlgeriaLocationDirectoryPatterns on AlgeriaLocationDirectory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlgeriaLocationDirectory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlgeriaLocationDirectory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlgeriaLocationDirectory value)  $default,){
final _that = this;
switch (_that) {
case _AlgeriaLocationDirectory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlgeriaLocationDirectory value)?  $default,){
final _that = this;
switch (_that) {
case _AlgeriaLocationDirectory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AlgeriaWilaya> wilayas,  List<AlgeriaCommune> communes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlgeriaLocationDirectory() when $default != null:
return $default(_that.wilayas,_that.communes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AlgeriaWilaya> wilayas,  List<AlgeriaCommune> communes)  $default,) {final _that = this;
switch (_that) {
case _AlgeriaLocationDirectory():
return $default(_that.wilayas,_that.communes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AlgeriaWilaya> wilayas,  List<AlgeriaCommune> communes)?  $default,) {final _that = this;
switch (_that) {
case _AlgeriaLocationDirectory() when $default != null:
return $default(_that.wilayas,_that.communes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlgeriaLocationDirectory extends AlgeriaLocationDirectory {
  const _AlgeriaLocationDirectory({required final  List<AlgeriaWilaya> wilayas, required final  List<AlgeriaCommune> communes}): _wilayas = wilayas,_communes = communes,super._();
  factory _AlgeriaLocationDirectory.fromJson(Map<String, dynamic> json) => _$AlgeriaLocationDirectoryFromJson(json);

 final  List<AlgeriaWilaya> _wilayas;
@override List<AlgeriaWilaya> get wilayas {
  if (_wilayas is EqualUnmodifiableListView) return _wilayas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wilayas);
}

 final  List<AlgeriaCommune> _communes;
@override List<AlgeriaCommune> get communes {
  if (_communes is EqualUnmodifiableListView) return _communes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communes);
}


/// Create a copy of AlgeriaLocationDirectory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlgeriaLocationDirectoryCopyWith<_AlgeriaLocationDirectory> get copyWith => __$AlgeriaLocationDirectoryCopyWithImpl<_AlgeriaLocationDirectory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlgeriaLocationDirectoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlgeriaLocationDirectory&&const DeepCollectionEquality().equals(other._wilayas, _wilayas)&&const DeepCollectionEquality().equals(other._communes, _communes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_wilayas),const DeepCollectionEquality().hash(_communes));

@override
String toString() {
  return 'AlgeriaLocationDirectory(wilayas: $wilayas, communes: $communes)';
}


}

/// @nodoc
abstract mixin class _$AlgeriaLocationDirectoryCopyWith<$Res> implements $AlgeriaLocationDirectoryCopyWith<$Res> {
  factory _$AlgeriaLocationDirectoryCopyWith(_AlgeriaLocationDirectory value, $Res Function(_AlgeriaLocationDirectory) _then) = __$AlgeriaLocationDirectoryCopyWithImpl;
@override @useResult
$Res call({
 List<AlgeriaWilaya> wilayas, List<AlgeriaCommune> communes
});




}
/// @nodoc
class __$AlgeriaLocationDirectoryCopyWithImpl<$Res>
    implements _$AlgeriaLocationDirectoryCopyWith<$Res> {
  __$AlgeriaLocationDirectoryCopyWithImpl(this._self, this._then);

  final _AlgeriaLocationDirectory _self;
  final $Res Function(_AlgeriaLocationDirectory) _then;

/// Create a copy of AlgeriaLocationDirectory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wilayas = null,Object? communes = null,}) {
  return _then(_AlgeriaLocationDirectory(
wilayas: null == wilayas ? _self._wilayas : wilayas // ignore: cast_nullable_to_non_nullable
as List<AlgeriaWilaya>,communes: null == communes ? _self._communes : communes // ignore: cast_nullable_to_non_nullable
as List<AlgeriaCommune>,
  ));
}


}

// dart format on
