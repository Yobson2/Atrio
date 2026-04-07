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
  @JsonKey(name: 'service_id')
  String get serviceId;
  @JsonKey(name: 'service_name')
  String get serviceName;
  @JsonKey(name: 'client_id')
  String get clientId;
  DateTime get date;
  @JsonKey(name: 'start_time')
  String get startTime;
  @JsonKey(name: 'total_price')
  double get totalPrice;
  String get status;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'barber_id')
  String? get barberId;
  @JsonKey(name: 'barber_name')
  String? get barberName;
  @JsonKey(name: 'end_time')
  String? get endTime;
  String? get notes;
  @JsonKey(name: 'salon_address')
  String? get salonAddress;
  @JsonKey(name: 'service_duration')
  int? get serviceDuration;

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
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.barberName, barberName) ||
                other.barberName == barberName) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.salonAddress, salonAddress) ||
                other.salonAddress == salonAddress) &&
            (identical(other.serviceDuration, serviceDuration) ||
                other.serviceDuration == serviceDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      salonName,
      serviceId,
      serviceName,
      clientId,
      date,
      startTime,
      totalPrice,
      status,
      createdAt,
      barberId,
      barberName,
      endTime,
      notes,
      salonAddress,
      serviceDuration);

  @override
  String toString() {
    return 'BookingModel(id: $id, salonId: $salonId, salonName: $salonName, serviceId: $serviceId, serviceName: $serviceName, clientId: $clientId, date: $date, startTime: $startTime, totalPrice: $totalPrice, status: $status, createdAt: $createdAt, barberId: $barberId, barberName: $barberName, endTime: $endTime, notes: $notes, salonAddress: $salonAddress, serviceDuration: $serviceDuration)';
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
      @JsonKey(name: 'service_id') String serviceId,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'client_id') String clientId,
      DateTime date,
      @JsonKey(name: 'start_time') String startTime,
      @JsonKey(name: 'total_price') double totalPrice,
      String status,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'barber_id') String? barberId,
      @JsonKey(name: 'barber_name') String? barberName,
      @JsonKey(name: 'end_time') String? endTime,
      String? notes,
      @JsonKey(name: 'salon_address') String? salonAddress,
      @JsonKey(name: 'service_duration') int? serviceDuration});
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
    Object? serviceId = null,
    Object? serviceName = null,
    Object? clientId = null,
    Object? date = null,
    Object? startTime = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? barberId = freezed,
    Object? barberName = freezed,
    Object? endTime = freezed,
    Object? notes = freezed,
    Object? salonAddress = freezed,
    Object? serviceDuration = freezed,
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
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      barberId: freezed == barberId
          ? _self.barberId
          : barberId // ignore: cast_nullable_to_non_nullable
              as String?,
      barberName: freezed == barberName
          ? _self.barberName
          : barberName // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      salonAddress: freezed == salonAddress
          ? _self.salonAddress
          : salonAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDuration: freezed == serviceDuration
          ? _self.serviceDuration
          : serviceDuration // ignore: cast_nullable_to_non_nullable
              as int?,
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
      @JsonKey(name: 'service_id') required this.serviceId,
      @JsonKey(name: 'service_name') required this.serviceName,
      @JsonKey(name: 'client_id') required this.clientId,
      required this.date,
      @JsonKey(name: 'start_time') required this.startTime,
      @JsonKey(name: 'total_price') required this.totalPrice,
      required this.status,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'barber_id') this.barberId,
      @JsonKey(name: 'barber_name') this.barberName,
      @JsonKey(name: 'end_time') this.endTime,
      this.notes,
      @JsonKey(name: 'salon_address') this.salonAddress,
      @JsonKey(name: 'service_duration') this.serviceDuration})
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
  @JsonKey(name: 'service_id')
  final String serviceId;
  @override
  @JsonKey(name: 'service_name')
  final String serviceName;
  @override
  @JsonKey(name: 'client_id')
  final String clientId;
  @override
  final DateTime date;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'total_price')
  final double totalPrice;
  @override
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'barber_id')
  final String? barberId;
  @override
  @JsonKey(name: 'barber_name')
  final String? barberName;
  @override
  @JsonKey(name: 'end_time')
  final String? endTime;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'salon_address')
  final String? salonAddress;
  @override
  @JsonKey(name: 'service_duration')
  final int? serviceDuration;

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
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.barberName, barberName) ||
                other.barberName == barberName) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.salonAddress, salonAddress) ||
                other.salonAddress == salonAddress) &&
            (identical(other.serviceDuration, serviceDuration) ||
                other.serviceDuration == serviceDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      salonName,
      serviceId,
      serviceName,
      clientId,
      date,
      startTime,
      totalPrice,
      status,
      createdAt,
      barberId,
      barberName,
      endTime,
      notes,
      salonAddress,
      serviceDuration);

  @override
  String toString() {
    return 'BookingModel(id: $id, salonId: $salonId, salonName: $salonName, serviceId: $serviceId, serviceName: $serviceName, clientId: $clientId, date: $date, startTime: $startTime, totalPrice: $totalPrice, status: $status, createdAt: $createdAt, barberId: $barberId, barberName: $barberName, endTime: $endTime, notes: $notes, salonAddress: $salonAddress, serviceDuration: $serviceDuration)';
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
      @JsonKey(name: 'service_id') String serviceId,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'client_id') String clientId,
      DateTime date,
      @JsonKey(name: 'start_time') String startTime,
      @JsonKey(name: 'total_price') double totalPrice,
      String status,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'barber_id') String? barberId,
      @JsonKey(name: 'barber_name') String? barberName,
      @JsonKey(name: 'end_time') String? endTime,
      String? notes,
      @JsonKey(name: 'salon_address') String? salonAddress,
      @JsonKey(name: 'service_duration') int? serviceDuration});
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
    Object? serviceId = null,
    Object? serviceName = null,
    Object? clientId = null,
    Object? date = null,
    Object? startTime = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? barberId = freezed,
    Object? barberName = freezed,
    Object? endTime = freezed,
    Object? notes = freezed,
    Object? salonAddress = freezed,
    Object? serviceDuration = freezed,
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
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      barberId: freezed == barberId
          ? _self.barberId
          : barberId // ignore: cast_nullable_to_non_nullable
              as String?,
      barberName: freezed == barberName
          ? _self.barberName
          : barberName // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      salonAddress: freezed == salonAddress
          ? _self.salonAddress
          : salonAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDuration: freezed == serviceDuration
          ? _self.serviceDuration
          : serviceDuration // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
