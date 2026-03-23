// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppNotificationRecord {

 String get id; String get type; String get title; String get body; Map<String, dynamic> get data; bool get isRead; DateTime get createdAt; DateTime? get readAt;
/// Create a copy of AppNotificationRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationRecordCopyWith<AppNotificationRecord> get copyWith => _$AppNotificationRecordCopyWithImpl<AppNotificationRecord>(this as AppNotificationRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotificationRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,const DeepCollectionEquality().hash(data),isRead,createdAt,readAt);

@override
String toString() {
  return 'AppNotificationRecord(id: $id, type: $type, title: $title, body: $body, data: $data, isRead: $isRead, createdAt: $createdAt, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class $AppNotificationRecordCopyWith<$Res>  {
  factory $AppNotificationRecordCopyWith(AppNotificationRecord value, $Res Function(AppNotificationRecord) _then) = _$AppNotificationRecordCopyWithImpl;
@useResult
$Res call({
 String id, String type, String title, String body, Map<String, dynamic> data, bool isRead, DateTime createdAt, DateTime? readAt
});




}
/// @nodoc
class _$AppNotificationRecordCopyWithImpl<$Res>
    implements $AppNotificationRecordCopyWith<$Res> {
  _$AppNotificationRecordCopyWithImpl(this._self, this._then);

  final AppNotificationRecord _self;
  final $Res Function(AppNotificationRecord) _then;

/// Create a copy of AppNotificationRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? body = null,Object? data = null,Object? isRead = null,Object? createdAt = null,Object? readAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppNotificationRecord].
extension AppNotificationRecordPatterns on AppNotificationRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppNotificationRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppNotificationRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppNotificationRecord value)  $default,){
final _that = this;
switch (_that) {
case _AppNotificationRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppNotificationRecord value)?  $default,){
final _that = this;
switch (_that) {
case _AppNotificationRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String body,  Map<String, dynamic> data,  bool isRead,  DateTime createdAt,  DateTime? readAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppNotificationRecord() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.data,_that.isRead,_that.createdAt,_that.readAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String body,  Map<String, dynamic> data,  bool isRead,  DateTime createdAt,  DateTime? readAt)  $default,) {final _that = this;
switch (_that) {
case _AppNotificationRecord():
return $default(_that.id,_that.type,_that.title,_that.body,_that.data,_that.isRead,_that.createdAt,_that.readAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String title,  String body,  Map<String, dynamic> data,  bool isRead,  DateTime createdAt,  DateTime? readAt)?  $default,) {final _that = this;
switch (_that) {
case _AppNotificationRecord() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.data,_that.isRead,_that.createdAt,_that.readAt);case _:
  return null;

}
}

}

/// @nodoc


class _AppNotificationRecord extends AppNotificationRecord {
  const _AppNotificationRecord({required this.id, required this.type, required this.title, required this.body, required final  Map<String, dynamic> data, required this.isRead, required this.createdAt, required this.readAt}): _data = data,super._();
  

@override final  String id;
@override final  String type;
@override final  String title;
@override final  String body;
 final  Map<String, dynamic> _data;
@override Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

@override final  bool isRead;
@override final  DateTime createdAt;
@override final  DateTime? readAt;

/// Create a copy of AppNotificationRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationRecordCopyWith<_AppNotificationRecord> get copyWith => __$AppNotificationRecordCopyWithImpl<_AppNotificationRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotificationRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,const DeepCollectionEquality().hash(_data),isRead,createdAt,readAt);

@override
String toString() {
  return 'AppNotificationRecord(id: $id, type: $type, title: $title, body: $body, data: $data, isRead: $isRead, createdAt: $createdAt, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationRecordCopyWith<$Res> implements $AppNotificationRecordCopyWith<$Res> {
  factory _$AppNotificationRecordCopyWith(_AppNotificationRecord value, $Res Function(_AppNotificationRecord) _then) = __$AppNotificationRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String title, String body, Map<String, dynamic> data, bool isRead, DateTime createdAt, DateTime? readAt
});




}
/// @nodoc
class __$AppNotificationRecordCopyWithImpl<$Res>
    implements _$AppNotificationRecordCopyWith<$Res> {
  __$AppNotificationRecordCopyWithImpl(this._self, this._then);

  final _AppNotificationRecord _self;
  final $Res Function(_AppNotificationRecord) _then;

/// Create a copy of AppNotificationRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? body = null,Object? data = null,Object? isRead = null,Object? createdAt = null,Object? readAt = freezed,}) {
  return _then(_AppNotificationRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$NotificationPage {

 List<AppNotificationRecord> get items; int get offset; int get limit; bool get hasMore;
/// Create a copy of NotificationPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPageCopyWith<NotificationPage> get copyWith => _$NotificationPageCopyWithImpl<NotificationPage>(this as NotificationPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),offset,limit,hasMore);

@override
String toString() {
  return 'NotificationPage(items: $items, offset: $offset, limit: $limit, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $NotificationPageCopyWith<$Res>  {
  factory $NotificationPageCopyWith(NotificationPage value, $Res Function(NotificationPage) _then) = _$NotificationPageCopyWithImpl;
@useResult
$Res call({
 List<AppNotificationRecord> items, int offset, int limit, bool hasMore
});




}
/// @nodoc
class _$NotificationPageCopyWithImpl<$Res>
    implements $NotificationPageCopyWith<$Res> {
  _$NotificationPageCopyWithImpl(this._self, this._then);

  final NotificationPage _self;
  final $Res Function(NotificationPage) _then;

/// Create a copy of NotificationPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? offset = null,Object? limit = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotificationRecord>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPage].
extension NotificationPagePatterns on NotificationPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPage value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPage value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AppNotificationRecord> items,  int offset,  int limit,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPage() when $default != null:
return $default(_that.items,_that.offset,_that.limit,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AppNotificationRecord> items,  int offset,  int limit,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _NotificationPage():
return $default(_that.items,_that.offset,_that.limit,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AppNotificationRecord> items,  int offset,  int limit,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPage() when $default != null:
return $default(_that.items,_that.offset,_that.limit,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationPage extends NotificationPage {
  const _NotificationPage({required final  List<AppNotificationRecord> items, required this.offset, required this.limit, required this.hasMore}): _items = items,super._();
  

 final  List<AppNotificationRecord> _items;
@override List<AppNotificationRecord> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int offset;
@override final  int limit;
@override final  bool hasMore;

/// Create a copy of NotificationPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPageCopyWith<_NotificationPage> get copyWith => __$NotificationPageCopyWithImpl<_NotificationPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),offset,limit,hasMore);

@override
String toString() {
  return 'NotificationPage(items: $items, offset: $offset, limit: $limit, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$NotificationPageCopyWith<$Res> implements $NotificationPageCopyWith<$Res> {
  factory _$NotificationPageCopyWith(_NotificationPage value, $Res Function(_NotificationPage) _then) = __$NotificationPageCopyWithImpl;
@override @useResult
$Res call({
 List<AppNotificationRecord> items, int offset, int limit, bool hasMore
});




}
/// @nodoc
class __$NotificationPageCopyWithImpl<$Res>
    implements _$NotificationPageCopyWith<$Res> {
  __$NotificationPageCopyWithImpl(this._self, this._then);

  final _NotificationPage _self;
  final $Res Function(_NotificationPage) _then;

/// Create a copy of NotificationPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? offset = null,Object? limit = null,Object? hasMore = null,}) {
  return _then(_NotificationPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotificationRecord>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
