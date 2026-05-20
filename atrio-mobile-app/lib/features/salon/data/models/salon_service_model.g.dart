// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SalonServiceModel _$SalonServiceModelFromJson(Map<String, dynamic> json) =>
    _SalonServiceModel(
      id: json['id'] as String,
      salonId: json['salon_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String?,
      tier: json['tier'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      isPopular: json['is_popular'] as bool? ?? false,
    );

Map<String, dynamic> _$SalonServiceModelToJson(_SalonServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salonId,
      'name': instance.name,
      'price': instance.price,
      'duration_minutes': instance.durationMinutes,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'category': instance.category,
      'tier': instance.tier,
      'is_active': instance.isActive,
      'is_popular': instance.isPopular,
    };
