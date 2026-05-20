// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salon_service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalonServiceModel {
  String get id;
  @JsonKey(name: 'salon_id')
  String get salonId;
  String get name;
  double get price;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  String? get description;
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  String? get category;
  String? get tier;
  @JsonKey(name: 'is_active')
  bool get isActive;
  @JsonKey(name: 'is_popular')
  bool get isPopular;

  /// Create a copy of SalonServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonServiceModelCopyWith<SalonServiceModel> get copyWith =>
      _$SalonServiceModelCopyWithImpl<SalonServiceModel>(
          this as SalonServiceModel, _$identity);

  /// Serializes this SalonServiceModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      name,
      price,
      durationMinutes,
      description,
      imageUrl,
      category,
      tier,
      isActive,
      isPopular);

  @override
  String toString() {
    return 'SalonServiceModel(id: $id, salonId: $salonId, name: $name, price: $price, durationMinutes: $durationMinutes, description: $description, imageUrl: $imageUrl, category: $category, tier: $tier, isActive: $isActive, isPopular: $isPopular)';
  }
}

/// @nodoc
abstract mixin class $SalonServiceModelCopyWith<$Res> {
  factory $SalonServiceModelCopyWith(
          SalonServiceModel value, $Res Function(SalonServiceModel) _then) =
      _$SalonServiceModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      String name,
      double price,
      @JsonKey(name: 'duration_minutes') int durationMinutes,
      String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? category,
      String? tier,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'is_popular') bool isPopular});
}

/// @nodoc
class _$SalonServiceModelCopyWithImpl<$Res>
    implements $SalonServiceModelCopyWith<$Res> {
  _$SalonServiceModelCopyWithImpl(this._self, this._then);

  final SalonServiceModel _self;
  final $Res Function(SalonServiceModel) _then;

  /// Create a copy of SalonServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? name = null,
    Object? price = null,
    Object? durationMinutes = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? category = freezed,
    Object? tier = freezed,
    Object? isActive = null,
    Object? isPopular = null,
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
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _self.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SalonServiceModel extends SalonServiceModel {
  const _SalonServiceModel(
      {required this.id,
      @JsonKey(name: 'salon_id') required this.salonId,
      required this.name,
      required this.price,
      @JsonKey(name: 'duration_minutes') required this.durationMinutes,
      this.description,
      @JsonKey(name: 'image_url') this.imageUrl,
      this.category,
      this.tier,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'is_popular') this.isPopular = false})
      : super._();
  factory _SalonServiceModel.fromJson(Map<String, dynamic> json) =>
      _$SalonServiceModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'salon_id')
  final String salonId;
  @override
  final String name;
  @override
  final double price;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  final String? description;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String? category;
  @override
  final String? tier;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'is_popular')
  final bool isPopular;

  /// Create a copy of SalonServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SalonServiceModelCopyWith<_SalonServiceModel> get copyWith =>
      __$SalonServiceModelCopyWithImpl<_SalonServiceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SalonServiceModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SalonServiceModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      salonId,
      name,
      price,
      durationMinutes,
      description,
      imageUrl,
      category,
      tier,
      isActive,
      isPopular);

  @override
  String toString() {
    return 'SalonServiceModel(id: $id, salonId: $salonId, name: $name, price: $price, durationMinutes: $durationMinutes, description: $description, imageUrl: $imageUrl, category: $category, tier: $tier, isActive: $isActive, isPopular: $isPopular)';
  }
}

/// @nodoc
abstract mixin class _$SalonServiceModelCopyWith<$Res>
    implements $SalonServiceModelCopyWith<$Res> {
  factory _$SalonServiceModelCopyWith(
          _SalonServiceModel value, $Res Function(_SalonServiceModel) _then) =
      __$SalonServiceModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'salon_id') String salonId,
      String name,
      double price,
      @JsonKey(name: 'duration_minutes') int durationMinutes,
      String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? category,
      String? tier,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'is_popular') bool isPopular});
}

/// @nodoc
class __$SalonServiceModelCopyWithImpl<$Res>
    implements _$SalonServiceModelCopyWith<$Res> {
  __$SalonServiceModelCopyWithImpl(this._self, this._then);

  final _SalonServiceModel _self;
  final $Res Function(_SalonServiceModel) _then;

  /// Create a copy of SalonServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? salonId = null,
    Object? name = null,
    Object? price = null,
    Object? durationMinutes = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? category = freezed,
    Object? tier = freezed,
    Object? isActive = null,
    Object? isPopular = null,
  }) {
    return _then(_SalonServiceModel(
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
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPopular: null == isPopular
          ? _self.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
