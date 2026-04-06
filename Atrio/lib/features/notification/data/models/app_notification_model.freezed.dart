// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppNotificationModel {
  String get id;
  String get title;
  String get body;
  String get type;
  Map<String, dynamic> get data;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'is_read')
  bool get isRead;

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppNotificationModelCopyWith<AppNotificationModel> get copyWith =>
      _$AppNotificationModelCopyWithImpl<AppNotificationModel>(
          this as AppNotificationModel, _$identity);

  /// Serializes this AppNotificationModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppNotificationModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, type,
      const DeepCollectionEquality().hash(data), createdAt, isRead);

  @override
  String toString() {
    return 'AppNotificationModel(id: $id, title: $title, body: $body, type: $type, data: $data, createdAt: $createdAt, isRead: $isRead)';
  }
}

/// @nodoc
abstract mixin class $AppNotificationModelCopyWith<$Res> {
  factory $AppNotificationModelCopyWith(AppNotificationModel value,
          $Res Function(AppNotificationModel) _then) =
      _$AppNotificationModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String body,
      String type,
      Map<String, dynamic> data,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'is_read') bool isRead});
}

/// @nodoc
class _$AppNotificationModelCopyWithImpl<$Res>
    implements $AppNotificationModelCopyWith<$Res> {
  _$AppNotificationModelCopyWithImpl(this._self, this._then);

  final AppNotificationModel _self;
  final $Res Function(AppNotificationModel) _then;

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? data = null,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AppNotificationModel extends AppNotificationModel {
  const _AppNotificationModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.type,
      final Map<String, dynamic> data = const <String, dynamic>{},
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'is_read') this.isRead = false})
      : _data = data,
        super._();
  factory _AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final String type;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppNotificationModelCopyWith<_AppNotificationModel> get copyWith =>
      __$AppNotificationModelCopyWithImpl<_AppNotificationModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppNotificationModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppNotificationModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, type,
      const DeepCollectionEquality().hash(_data), createdAt, isRead);

  @override
  String toString() {
    return 'AppNotificationModel(id: $id, title: $title, body: $body, type: $type, data: $data, createdAt: $createdAt, isRead: $isRead)';
  }
}

/// @nodoc
abstract mixin class _$AppNotificationModelCopyWith<$Res>
    implements $AppNotificationModelCopyWith<$Res> {
  factory _$AppNotificationModelCopyWith(_AppNotificationModel value,
          $Res Function(_AppNotificationModel) _then) =
      __$AppNotificationModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String body,
      String type,
      Map<String, dynamic> data,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'is_read') bool isRead});
}

/// @nodoc
class __$AppNotificationModelCopyWithImpl<$Res>
    implements _$AppNotificationModelCopyWith<$Res> {
  __$AppNotificationModelCopyWithImpl(this._self, this._then);

  final _AppNotificationModel _self;
  final $Res Function(_AppNotificationModel) _then;

  /// Create a copy of AppNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? data = null,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(_AppNotificationModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
