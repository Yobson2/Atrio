// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalonModel {
  String get id;
  String get name;
  String get address;
  double get rating;
  @JsonKey(name: 'review_count')
  int get reviewCount;
  String? get description;
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @JsonKey(name: 'gallery_urls')
  List<String> get galleryUrls;
  String? get phone;
  String? get email;
  double? get latitude;
  double? get longitude;
  @JsonKey(name: 'is_active')
  bool get isActive;
  List<String> get tags;
  String? get tier;

  /// Create a copy of SalonModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonModelCopyWith<SalonModel> get copyWith =>
      _$SalonModelCopyWithImpl<SalonModel>(this as SalonModel, _$identity);

  /// Serializes this SalonModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other.galleryUrls, galleryUrls) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.tier, tier) || other.tier == tier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      address,
      rating,
      reviewCount,
      description,
      imageUrl,
      const DeepCollectionEquality().hash(galleryUrls),
      phone,
      email,
      latitude,
      longitude,
      isActive,
      const DeepCollectionEquality().hash(tags),
      tier);

  @override
  String toString() {
    return 'SalonModel(id: $id, name: $name, address: $address, rating: $rating, reviewCount: $reviewCount, description: $description, imageUrl: $imageUrl, galleryUrls: $galleryUrls, phone: $phone, email: $email, latitude: $latitude, longitude: $longitude, isActive: $isActive, tags: $tags, tier: $tier)';
  }
}

/// @nodoc
abstract mixin class $SalonModelCopyWith<$Res> {
  factory $SalonModelCopyWith(
          SalonModel value, $Res Function(SalonModel) _then) =
      _$SalonModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      double rating,
      @JsonKey(name: 'review_count') int reviewCount,
      String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'gallery_urls') List<String> galleryUrls,
      String? phone,
      String? email,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'is_active') bool isActive,
      List<String> tags,
      String? tier});
}

/// @nodoc
class _$SalonModelCopyWithImpl<$Res> implements $SalonModelCopyWith<$Res> {
  _$SalonModelCopyWithImpl(this._self, this._then);

  final SalonModel _self;
  final $Res Function(SalonModel) _then;

  /// Create a copy of SalonModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? galleryUrls = null,
    Object? phone = freezed,
    Object? email = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isActive = null,
    Object? tags = null,
    Object? tier = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _self.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      galleryUrls: null == galleryUrls
          ? _self.galleryUrls
          : galleryUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SalonModel extends SalonModel {
  const _SalonModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.rating,
      @JsonKey(name: 'review_count') required this.reviewCount,
      this.description,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'gallery_urls') final List<String> galleryUrls = const [],
      this.phone,
      this.email,
      this.latitude,
      this.longitude,
      @JsonKey(name: 'is_active') this.isActive = true,
      final List<String> tags = const [],
      this.tier})
      : _galleryUrls = galleryUrls,
        _tags = tags,
        super._();
  factory _SalonModel.fromJson(Map<String, dynamic> json) =>
      _$SalonModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final double rating;
  @override
  @JsonKey(name: 'review_count')
  final int reviewCount;
  @override
  final String? description;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<String> _galleryUrls;
  @override
  @JsonKey(name: 'gallery_urls')
  List<String> get galleryUrls {
    if (_galleryUrls is EqualUnmodifiableListView) return _galleryUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryUrls);
  }

  @override
  final String? phone;
  @override
  final String? email;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? tier;

  /// Create a copy of SalonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SalonModelCopyWith<_SalonModel> get copyWith =>
      __$SalonModelCopyWithImpl<_SalonModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SalonModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SalonModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._galleryUrls, _galleryUrls) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.tier, tier) || other.tier == tier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      address,
      rating,
      reviewCount,
      description,
      imageUrl,
      const DeepCollectionEquality().hash(_galleryUrls),
      phone,
      email,
      latitude,
      longitude,
      isActive,
      const DeepCollectionEquality().hash(_tags),
      tier);

  @override
  String toString() {
    return 'SalonModel(id: $id, name: $name, address: $address, rating: $rating, reviewCount: $reviewCount, description: $description, imageUrl: $imageUrl, galleryUrls: $galleryUrls, phone: $phone, email: $email, latitude: $latitude, longitude: $longitude, isActive: $isActive, tags: $tags, tier: $tier)';
  }
}

/// @nodoc
abstract mixin class _$SalonModelCopyWith<$Res>
    implements $SalonModelCopyWith<$Res> {
  factory _$SalonModelCopyWith(
          _SalonModel value, $Res Function(_SalonModel) _then) =
      __$SalonModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      double rating,
      @JsonKey(name: 'review_count') int reviewCount,
      String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'gallery_urls') List<String> galleryUrls,
      String? phone,
      String? email,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'is_active') bool isActive,
      List<String> tags,
      String? tier});
}

/// @nodoc
class __$SalonModelCopyWithImpl<$Res> implements _$SalonModelCopyWith<$Res> {
  __$SalonModelCopyWithImpl(this._self, this._then);

  final _SalonModel _self;
  final $Res Function(_SalonModel) _then;

  /// Create a copy of SalonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? galleryUrls = null,
    Object? phone = freezed,
    Object? email = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isActive = null,
    Object? tags = null,
    Object? tier = freezed,
  }) {
    return _then(_SalonModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _self.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      galleryUrls: null == galleryUrls
          ? _self._galleryUrls
          : galleryUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tier: freezed == tier
          ? _self.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
