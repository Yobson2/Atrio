// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueueEntryModel {
  String get id;
  @JsonKey(name: 'salon_id')
  String get salonId;
  @JsonKey(name: 'booking_id')
  String get bookingId;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'user_name')
  String get userName;
  @JsonKey(name: 'service_name')
  String get serviceName;
  int get position;
  QueueEntryStatus get status;
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt;
  @JsonKey(name: 'estimated_wait_minutes')
  int get estimatedWaitMinutes;

  /// Create a copy of QueueEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QueueEntryModelCopyWith<QueueEntryModel> get copyWith =>
      _$QueueEntryModelCopyWithImpl<QueueEntryModel>(
          this as QueueEntryModel, _$identity);

  /// Serializes this QueueEntryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QueueEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.estimatedWaitMinutes, estimatedWaitMinutes) ||
                other.estimatedWaitMinutes == estimatedWaitMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, salonId, bookingId, userId,
      userName, serviceName, position, status, joinedAt, estimatedWaitMinutes);

  @override
  String toString() {
    return 'QueueEntryModel(id: $id, salonId: $salonId, bookingId: $bookingId, userId: $userId, userName: $userName, serviceName: $serviceName, position: $position, status: $status, joinedAt: $joinedAt, estimatedWaitMinutes: $estimatedWaitMinutes)';
  }
}

/// @nodoc
abstract mixin class $QueueEntryModelCopyWith<$Res> {
  factory $QueueEntryModelCopyWith(
          QueueEntryModel value, $Res Function(QueueEntryModel) _then) =
      _$QueueEntryModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      @JsonKey(name: 'booking_id') String bookingId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'service_name') String serviceName,
      int position,
      QueueEntryStatus status,
      @JsonKey(name: 'joined_at') DateTime joinedAt,
      @JsonKey(name: 'estimated_wait_minutes') int estimatedWaitMinutes});
}

/// @nodoc
class _$QueueEntryModelCopyWithImpl<$Res>
    implements $QueueEntryModelCopyWith<$Res> {
  _$QueueEntryModelCopyWithImpl(this._self, this._then);

  final QueueEntryModel _self;
  final $Res Function(QueueEntryModel) _then;

  /// Create a copy of QueueEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? bookingId = null,
    Object? userId = null,
    Object? userName = null,
    Object? serviceName = null,
    Object? position = null,
    Object? status = null,
    Object? joinedAt = null,
    Object? estimatedWaitMinutes = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      salonId: null == salonId
          ? _self.salonId
          : salonId // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _self.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueueEntryStatus,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedWaitMinutes: null == estimatedWaitMinutes
          ? _self.estimatedWaitMinutes
          : estimatedWaitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _QueueEntryModel extends QueueEntryModel {
  const _QueueEntryModel(
      {required this.id,
      @JsonKey(name: 'salon_id') required this.salonId,
      @JsonKey(name: 'booking_id') required this.bookingId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_name') required this.userName,
      @JsonKey(name: 'service_name') required this.serviceName,
      required this.position,
      this.status = QueueEntryStatus.waiting,
      @JsonKey(name: 'joined_at') required this.joinedAt,
      @JsonKey(name: 'estimated_wait_minutes') this.estimatedWaitMinutes = 0})
      : super._();
  factory _QueueEntryModel.fromJson(Map<String, dynamic> json) =>
      _$QueueEntryModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'salon_id')
  final String salonId;
  @override
  @JsonKey(name: 'booking_id')
  final String bookingId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'user_name')
  final String userName;
  @override
  @JsonKey(name: 'service_name')
  final String serviceName;
  @override
  final int position;
  @override
  @JsonKey()
  final QueueEntryStatus status;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime joinedAt;
  @override
  @JsonKey(name: 'estimated_wait_minutes')
  final int estimatedWaitMinutes;

  /// Create a copy of QueueEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QueueEntryModelCopyWith<_QueueEntryModel> get copyWith =>
      __$QueueEntryModelCopyWithImpl<_QueueEntryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QueueEntryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QueueEntryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.estimatedWaitMinutes, estimatedWaitMinutes) ||
                other.estimatedWaitMinutes == estimatedWaitMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, salonId, bookingId, userId,
      userName, serviceName, position, status, joinedAt, estimatedWaitMinutes);

  @override
  String toString() {
    return 'QueueEntryModel(id: $id, salonId: $salonId, bookingId: $bookingId, userId: $userId, userName: $userName, serviceName: $serviceName, position: $position, status: $status, joinedAt: $joinedAt, estimatedWaitMinutes: $estimatedWaitMinutes)';
  }
}

/// @nodoc
abstract mixin class _$QueueEntryModelCopyWith<$Res>
    implements $QueueEntryModelCopyWith<$Res> {
  factory _$QueueEntryModelCopyWith(
          _QueueEntryModel value, $Res Function(_QueueEntryModel) _then) =
      __$QueueEntryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      @JsonKey(name: 'booking_id') String bookingId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'service_name') String serviceName,
      int position,
      QueueEntryStatus status,
      @JsonKey(name: 'joined_at') DateTime joinedAt,
      @JsonKey(name: 'estimated_wait_minutes') int estimatedWaitMinutes});
}

/// @nodoc
class __$QueueEntryModelCopyWithImpl<$Res>
    implements _$QueueEntryModelCopyWith<$Res> {
  __$QueueEntryModelCopyWithImpl(this._self, this._then);

  final _QueueEntryModel _self;
  final $Res Function(_QueueEntryModel) _then;

  /// Create a copy of QueueEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? bookingId = null,
    Object? userId = null,
    Object? userName = null,
    Object? serviceName = null,
    Object? position = null,
    Object? status = null,
    Object? joinedAt = null,
    Object? estimatedWaitMinutes = null,
  }) {
    return _then(_QueueEntryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      salonId: null == salonId
          ? _self.salonId
          : salonId // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _self.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueueEntryStatus,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedWaitMinutes: null == estimatedWaitMinutes
          ? _self.estimatedWaitMinutes
          : estimatedWaitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
