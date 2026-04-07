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
  double get rating;
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @JsonKey(name: 'review_count')
  int get reviewCount;
  List<String> get specialties;
  String? get tier;
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @JsonKey(name: 'next_available_at')
  DateTime? get nextAvailableAt;

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
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            const DeepCollectionEquality()
                .equals(other.specialties, specialties) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.nextAvailableAt, nextAvailableAt) ||
                other.nextAvailableAt == nextAvailableAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      name,
      rating,
      photoUrl,
      reviewCount,
      const DeepCollectionEquality().hash(specialties),
      tier,
      isAvailable,
      nextAvailableAt);

  @override
  String toString() {
    return 'BarberModel(id: $id, salonId: $salonId, name: $name, rating: $rating, photoUrl: $photoUrl, reviewCount: $reviewCount, specialties: $specialties, tier: $tier, isAvailable: $isAvailable, nextAvailableAt: $nextAvailableAt)';
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
      double rating,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'review_count') int reviewCount,
      List<String> specialties,
      String? tier,
      @JsonKey(name: 'is_available') bool isAvailable,
      @JsonKey(name: 'next_available_at') DateTime? nextAvailableAt});
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
    Object? rating = null,
    Object? photoUrl = freezed,
    Object? reviewCount = null,
    Object? specialties = null,
    Object? tier = freezed,
    Object? isAvailable = null,
    Object? nextAvailableAt = freezed,
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
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewCount: null == reviewCount
          ? _self.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      specialties: null == specialties
          ? _self.specialties
          : specialties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      nextAvailableAt: freezed == nextAvailableAt
          ? _self.nextAvailableAt
          : nextAvailableAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      required this.rating,
      @JsonKey(name: 'photo_url') this.photoUrl,
      @JsonKey(name: 'review_count') this.reviewCount = 0,
      final List<String> specialties = const [],
      this.tier,
      @JsonKey(name: 'is_available') this.isAvailable = true,
      @JsonKey(name: 'next_available_at') this.nextAvailableAt})
      : _specialties = specialties,
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
  final double rating;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  @JsonKey(name: 'review_count')
  final int reviewCount;
  final List<String> _specialties;
  @override
  @JsonKey()
  List<String> get specialties {
    if (_specialties is EqualUnmodifiableListView) return _specialties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specialties);
  }

  @override
  final String? tier;
  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @override
  @JsonKey(name: 'next_available_at')
  final DateTime? nextAvailableAt;

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
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            const DeepCollectionEquality()
                .equals(other._specialties, _specialties) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.nextAvailableAt, nextAvailableAt) ||
                other.nextAvailableAt == nextAvailableAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      name,
      rating,
      photoUrl,
      reviewCount,
      const DeepCollectionEquality().hash(_specialties),
      tier,
      isAvailable,
      nextAvailableAt);

  @override
  String toString() {
    return 'BarberModel(id: $id, salonId: $salonId, name: $name, rating: $rating, photoUrl: $photoUrl, reviewCount: $reviewCount, specialties: $specialties, tier: $tier, isAvailable: $isAvailable, nextAvailableAt: $nextAvailableAt)';
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
      double rating,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'review_count') int reviewCount,
      List<String> specialties,
      String? tier,
      @JsonKey(name: 'is_available') bool isAvailable,
      @JsonKey(name: 'next_available_at') DateTime? nextAvailableAt});
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
    Object? rating = null,
    Object? photoUrl = freezed,
    Object? reviewCount = null,
    Object? specialties = null,
    Object? tier = freezed,
    Object? isAvailable = null,
    Object? nextAvailableAt = freezed,
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
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewCount: null == reviewCount
          ? _self.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      specialties: null == specialties
          ? _self._specialties
          : specialties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: null == isAvailable
          ? _self.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      nextAvailableAt: freezed == nextAvailableAt
          ? _self.nextAvailableAt
          : nextAvailableAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
