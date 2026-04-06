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
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$SalonServiceModelToJson(_SalonServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salonId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'duration_minutes': instance.durationMinutes,
      'image_url': instance.imageUrl,
      'is_active': instance.isActive,
    };
