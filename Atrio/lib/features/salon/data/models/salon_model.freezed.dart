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
  String get description;
  String get address;
  double get latitude;
  double get longitude;
  String get phone;
  @JsonKey(name: 'cover_image_url')
  String? get coverImageUrl;
  @JsonKey(name: 'photo_urls')
  List<String> get photoUrls;
  double get rating;
  @JsonKey(name: 'review_count')
  int get reviewCount;
  @JsonKey(name: 'is_open')
  bool get isOpen;
  @JsonKey(name: 'owner_id')
  String get ownerId;
  @JsonKey(name: 'opening_hours')
  List<OpeningHoursModel> get openingHours;

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
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            const DeepCollectionEquality().equals(other.photoUrls, photoUrls) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other.openingHours, openingHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      address,
      latitude,
      longitude,
      phone,
      coverImageUrl,
      const DeepCollectionEquality().hash(photoUrls),
      rating,
      reviewCount,
      isOpen,
      ownerId,
      const DeepCollectionEquality().hash(openingHours));

  @override
  String toString() {
    return 'SalonModel(id: $id, name: $name, description: $description, address: $address, latitude: $latitude, longitude: $longitude, phone: $phone, coverImageUrl: $coverImageUrl, photoUrls: $photoUrls, rating: $rating, reviewCount: $reviewCount, isOpen: $isOpen, ownerId: $ownerId, openingHours: $openingHours)';
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
      String description,
      String address,
      double latitude,
      double longitude,
      String phone,
      @JsonKey(name: 'cover_image_url') String? coverImageUrl,
      @JsonKey(name: 'photo_urls') List<String> photoUrls,
      double rating,
      @JsonKey(name: 'review_count') int reviewCount,
      @JsonKey(name: 'is_open') bool isOpen,
      @JsonKey(name: 'owner_id') String ownerId,
      @JsonKey(name: 'opening_hours') List<OpeningHoursModel> openingHours});
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
    Object? description = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? phone = null,
    Object? coverImageUrl = freezed,
    Object? photoUrls = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isOpen = null,
    Object? ownerId = null,
    Object? openingHours = null,
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrl: freezed == coverImageUrl
          ? _self.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: null == photoUrls
          ? _self.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _self.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOpen: null == isOpen
          ? _self.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      openingHours: null == openingHours
          ? _self.openingHours
          : openingHours // ignore: cast_nullable_to_non_nullable
              as List<OpeningHoursModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SalonModel extends SalonModel {
  const _SalonModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.phone,
      @JsonKey(name: 'cover_image_url') this.coverImageUrl,
      @JsonKey(name: 'photo_urls') final List<String> photoUrls = const [],
      this.rating = 0.0,
      @JsonKey(name: 'review_count') this.reviewCount = 0,
      @JsonKey(name: 'is_open') this.isOpen = false,
      @JsonKey(name: 'owner_id') required this.ownerId,
      @JsonKey(name: 'opening_hours')
      final List<OpeningHoursModel> openingHours = const []})
      : _photoUrls = photoUrls,
        _openingHours = openingHours,
        super._();
  factory _SalonModel.fromJson(Map<String, dynamic> json) =>
      _$SalonModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String address;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String phone;
  @override
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  final List<String> _photoUrls;
  @override
  @JsonKey(name: 'photo_urls')
  List<String> get photoUrls {
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photoUrls);
  }

  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'review_count')
  final int reviewCount;
  @override
  @JsonKey(name: 'is_open')
  final bool isOpen;
  @override
  @JsonKey(name: 'owner_id')
  final String ownerId;
  final List<OpeningHoursModel> _openingHours;
  @override
  @JsonKey(name: 'opening_hours')
  List<OpeningHoursModel> get openingHours {
    if (_openingHours is EqualUnmodifiableListView) return _openingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openingHours);
  }

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
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._openingHours, _openingHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      address,
      latitude,
      longitude,
      phone,
      coverImageUrl,
      const DeepCollectionEquality().hash(_photoUrls),
      rating,
      reviewCount,
      isOpen,
      ownerId,
      const DeepCollectionEquality().hash(_openingHours));

  @override
  String toString() {
    return 'SalonModel(id: $id, name: $name, description: $description, address: $address, latitude: $latitude, longitude: $longitude, phone: $phone, coverImageUrl: $coverImageUrl, photoUrls: $photoUrls, rating: $rating, reviewCount: $reviewCount, isOpen: $isOpen, ownerId: $ownerId, openingHours: $openingHours)';
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
      String description,
      String address,
      double latitude,
      double longitude,
      String phone,
      @JsonKey(name: 'cover_image_url') String? coverImageUrl,
      @JsonKey(name: 'photo_urls') List<String> photoUrls,
      double rating,
      @JsonKey(name: 'review_count') int reviewCount,
      @JsonKey(name: 'is_open') bool isOpen,
      @JsonKey(name: 'owner_id') String ownerId,
      @JsonKey(name: 'opening_hours') List<OpeningHoursModel> openingHours});
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
    Object? description = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? phone = null,
    Object? coverImageUrl = freezed,
    Object? photoUrls = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isOpen = null,
    Object? ownerId = null,
    Object? openingHours = null,
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrl: freezed == coverImageUrl
          ? _self.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: null == photoUrls
          ? _self._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _self.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOpen: null == isOpen
          ? _self.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      openingHours: null == openingHours
          ? _self._openingHours
          : openingHours // ignore: cast_nullable_to_non_nullable
              as List<OpeningHoursModel>,
    ));
  }
}

// dart format on
