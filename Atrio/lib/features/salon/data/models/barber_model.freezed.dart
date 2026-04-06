// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barber_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BarberModel {
  String get id;
  @JsonKey(name: 'salon_id')
  String get salonId;
  String get name;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  double get rating;
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @JsonKey(name: 'service_ids')
  List<String> get serviceIds;

  /// Create a copy of BarberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BarberModelCopyWith<BarberModel> get copyWith =>
      _$BarberModelCopyWithImpl<BarberModel>(this as BarberModel, _$identity);

  /// Serializes this BarberModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BarberModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality()
                .equals(other.serviceIds, serviceIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, salonId, name, avatarUrl,
      rating, isAvailable, const DeepCollectionEquality().hash(serviceIds));

  @override
  String toString() {
    return 'BarberModel(id: $id, salonId: $salonId, name: $name, avatarUrl: $avatarUrl, rating: $rating, isAvailable: $isAvailable, serviceIds: $serviceIds)';
  }
}

/// @nodoc
abstract mixin class $BarberModelCopyWith<$Res> {
  factory $BarberModelCopyWith(
          BarberModel value, $Res Function(BarberModel) _then) =
      _$BarberModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      String name,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      double rating,
      @JsonKey(name: 'is_available') bool isAvailable,
      @JsonKey(name: 'service_ids') List<String> serviceIds});
}

/// @nodoc
class _$BarberModelCopyWithImpl<$Res> implements $BarberModelCopyWith<$Res> {
  _$BarberModelCopyWithImpl(this._self, this._then);

  final BarberModel _self;
  final $Res Function(BarberModel) _then;

  /// Create a copy of BarberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? rating = null,
    Object? isAvailable = null,
    Object? serviceIds = null,
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
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      serviceIds: null == serviceIds
          ? _self.serviceIds
          : serviceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BarberModel extends BarberModel {
  const _BarberModel(
      {required this.id,
      @JsonKey(name: 'salon_id') required this.salonId,
      required this.name,
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      this.rating = 0.0,
      @JsonKey(name: 'is_available') this.isAvailable = true,
      @JsonKey(name: 'service_ids') final List<String> serviceIds = const []})
      : _serviceIds = serviceIds,
        super._();
  factory _BarberModel.fromJson(Map<String, dynamic> json) =>
      _$BarberModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'salon_id')
  final String salonId;
  @override
  final String name;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  final List<String> _serviceIds;
  @override
  @JsonKey(name: 'service_ids')
  List<String> get serviceIds {
    if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceIds);
  }

  /// Create a copy of BarberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BarberModelCopyWith<_BarberModel> get copyWith =>
      __$BarberModelCopyWithImpl<_BarberModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BarberModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BarberModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            const DeepCollectionEquality()
                .equals(other._serviceIds, _serviceIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, salonId, name, avatarUrl,
      rating, isAvailable, const DeepCollectionEquality().hash(_serviceIds));

  @override
  String toString() {
    return 'BarberModel(id: $id, salonId: $salonId, name: $name, avatarUrl: $avatarUrl, rating: $rating, isAvailable: $isAvailable, serviceIds: $serviceIds)';
  }
}

/// @nodoc
abstract mixin class _$BarberModelCopyWith<$Res>
    implements $BarberModelCopyWith<$Res> {
  factory _$BarberModelCopyWith(
          _BarberModel value, $Res Function(_BarberModel) _then) =
      __$BarberModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      String name,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      double rating,
      @JsonKey(name: 'is_available') bool isAvailable,
      @JsonKey(name: 'service_ids') List<String> serviceIds});
}

/// @nodoc
class __$BarberModelCopyWithImpl<$Res> implements _$BarberModelCopyWith<$Res> {
  __$BarberModelCopyWithImpl(this._self, this._then);

  final _BarberModel _self;
  final $Res Function(_BarberModel) _then;

  /// Create a copy of BarberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? rating = null,
    Object? isAvailable = null,
    Object? serviceIds = null,
  }) {
    return _then(_BarberModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      salonId: null == salonId
          ? _self.salonId
          : salonId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      serviceIds: null == serviceIds
          ? _self._serviceIds
          : serviceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
