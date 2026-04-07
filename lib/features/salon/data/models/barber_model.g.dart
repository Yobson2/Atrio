// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BarberModel _$BarberModelFromJson(Map<String, dynamic> json) => _BarberModel(
      id: json['id'] as String,
      salonId: json['salon_id'] as String,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      photoUrl: json['photo_url'] as String?,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      specialties: (json['specialties'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tier: json['tier'] as String?,
      isAvailable: json['is_available'] as bool? ?? true,
      nextAvailableAt: json['next_available_at'] == null
          ? null
          : DateTime.parse(json['next_available_at'] as String),
    );

Map<String, dynamic> _$BarberModelToJson(_BarberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salonId,
      'name': instance.name,
      'rating': instance.rating,
      'photo_url': instance.photoUrl,
      'review_count': instance.reviewCount,
      'specialties': instance.specialties,
      'tier': instance.tier,
      'is_available': instance.isAvailable,
      'next_available_at': instance.nextAvailableAt?.toIso8601String(),
    };
