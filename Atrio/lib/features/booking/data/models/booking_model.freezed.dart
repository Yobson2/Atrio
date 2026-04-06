// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingModel {
  String get id;
  @JsonKey(name: 'salon_id')
  String get salonId;
  @JsonKey(name: 'salon_name')
  String get salonName;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'service_id')
  String get serviceId;
  @JsonKey(name: 'service_name')
  String get serviceName;
  @JsonKey(name: 'barber_id')
  String? get barberId;
  @JsonKey(name: 'barber_name')
  String? get barberName;
  String get type;
  String get status;
  @JsonKey(name: 'scheduled_at')
  DateTime? get scheduledAt;
  @JsonKey(name: 'estimated_duration_minutes')
  int get estimatedDurationMinutes;
  double get price;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookingModelCopyWith<BookingModel> get copyWith =>
      _$BookingModelCopyWithImpl<BookingModel>(
          this as BookingModel, _$identity);

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookingModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.salonName, salonName) ||
                other.salonName == salonName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.barberName, barberName) ||
                other.barberName == barberName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(
                    other.estimatedDurationMinutes, estimatedDurationMinutes) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      salonName,
      userId,
      serviceId,
      serviceName,
      barberId,
      barberName,
      type,
      status,
      scheduledAt,
      estimatedDurationMinutes,
      price,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'BookingModel(id: $id, salonId: $salonId, salonName: $salonName, userId: $userId, serviceId: $serviceId, serviceName: $serviceName, barberId: $barberId, barberName: $barberName, type: $type, status: $status, scheduledAt: $scheduledAt, estimatedDurationMinutes: $estimatedDurationMinutes, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
          BookingModel value, $Res Function(BookingModel) _then) =
      _$BookingModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      @JsonKey(name: 'salon_name') String salonName,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'service_id') String serviceId,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'barber_id') String? barberId,
      @JsonKey(name: 'barber_name') String? barberName,
      String type,
      String status,
      @JsonKey(name: 'scheduled_at') DateTime? scheduledAt,
      @JsonKey(name: 'estimated_duration_minutes') int estimatedDurationMinutes,
      double price,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res> implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._self, this._then);

  final BookingModel _self;
  final $Res Function(BookingModel) _then;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? salonName = null,
    Object? userId = null,
    Object? serviceId = null,
    Object? serviceName = null,
    Object? barberId = freezed,
    Object? barberName = freezed,
    Object? type = null,
    Object? status = null,
    Object? scheduledAt = freezed,
    Object? estimatedDurationMinutes = null,
    Object? price = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      salonName: null == salonName
          ? _self.salonName
          : salonName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      barberId: freezed == barberId
          ? _self.barberId
          : barberId // ignore: cast_nullable_to_non_nullable
              as String?,
      barberName: freezed == barberName
          ? _self.barberName
          : barberName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: freezed == scheduledAt
          ? _self.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _self.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BookingModel extends BookingModel {
  const _BookingModel(
      {required this.id,
      @JsonKey(name: 'salon_id') required this.salonId,
      @JsonKey(name: 'salon_name') required this.salonName,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'service_id') required this.serviceId,
      @JsonKey(name: 'service_name') required this.serviceName,
      @JsonKey(name: 'barber_id') this.barberId,
      @JsonKey(name: 'barber_name') this.barberName,
      required this.type,
      required this.status,
      @JsonKey(name: 'scheduled_at') this.scheduledAt,
      @JsonKey(name: 'estimated_duration_minutes')
      required this.estimatedDurationMinutes,
      required this.price,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : super._();
  factory _BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'salon_id')
  final String salonId;
  @override
  @JsonKey(name: 'salon_name')
  final String salonName;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'service_id')
  final String serviceId;
  @override
  @JsonKey(name: 'service_name')
  final String serviceName;
  @override
  @JsonKey(name: 'barber_id')
  final String? barberId;
  @override
  @JsonKey(name: 'barber_name')
  final String? barberName;
  @override
  final String type;
  @override
  final String status;
  @override
  @JsonKey(name: 'scheduled_at')
  final DateTime? scheduledAt;
  @override
  @JsonKey(name: 'estimated_duration_minutes')
  final int estimatedDurationMinutes;
  @override
  final double price;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookingModelCopyWith<_BookingModel> get copyWith =>
      __$BookingModelCopyWithImpl<_BookingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BookingModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookingModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.salonName, salonName) ||
                other.salonName == salonName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.barberName, barberName) ||
                other.barberName == barberName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(
                    other.estimatedDurationMinutes, estimatedDurationMinutes) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      salonName,
      userId,
      serviceId,
      serviceName,
      barberId,
      barberName,
      type,
      status,
      scheduledAt,
      estimatedDurationMinutes,
      price,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'BookingModel(id: $id, salonId: $salonId, salonName: $salonName, userId: $userId, serviceId: $serviceId, serviceName: $serviceName, barberId: $barberId, barberName: $barberName, type: $type, status: $status, scheduledAt: $scheduledAt, estimatedDurationMinutes: $estimatedDurationMinutes, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$BookingModelCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$BookingModelCopyWith(
          _BookingModel value, $Res Function(_BookingModel) _then) =
      __$BookingModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      @JsonKey(name: 'salon_name') String salonName,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'service_id') String serviceId,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'barber_id') String? barberId,
      @JsonKey(name: 'barber_name') String? barberName,
      String type,
      String status,
      @JsonKey(name: 'scheduled_at') DateTime? scheduledAt,
      @JsonKey(name: 'estimated_duration_minutes') int estimatedDurationMinutes,
      double price,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$BookingModelCopyWithImpl<$Res>
    implements _$BookingModelCopyWith<$Res> {
  __$BookingModelCopyWithImpl(this._self, this._then);

  final _BookingModel _self;
  final $Res Function(_BookingModel) _then;

  /// Create a copy of BookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? salonName = null,
    Object? userId = null,
    Object? serviceId = null,
    Object? serviceName = null,
    Object? barberId = freezed,
    Object? barberName = freezed,
    Object? type = null,
    Object? status = null,
    Object? scheduledAt = freezed,
    Object? estimatedDurationMinutes = null,
    Object? price = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_BookingModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      salonId: null == salonId
          ? _self.salonId
          : salonId // ignore: cast_nullable_to_non_nullable
              as String,
      salonName: null == salonName
          ? _self.salonName
          : salonName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      barberId: freezed == barberId
          ? _self.barberId
          : barberId // ignore: cast_nullable_to_non_nullable
              as String?,
      barberName: freezed == barberName
          ? _self.barberName
          : barberName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: freezed == scheduledAt
          ? _self.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _self.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
