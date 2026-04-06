// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SalonModel _$SalonModelFromJson(Map<String, dynamic> json) => _SalonModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phone: json['phone'] as String,
      coverImageUrl: json['cover_image_url'] as String?,
      photoUrls: (json['photo_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      isOpen: json['is_open'] as bool? ?? false,
      ownerId: json['owner_id'] as String,
      openingHours: (json['opening_hours'] as List<dynamic>?)
              ?.map(
                  (e) => OpeningHoursModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SalonModelToJson(_SalonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'phone': instance.phone,
      'cover_image_url': instance.coverImageUrl,
      'photo_urls': instance.photoUrls,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'is_open': instance.isOpen,
      'owner_id': instance.ownerId,
      'opening_hours': instance.openingHours,
    };
