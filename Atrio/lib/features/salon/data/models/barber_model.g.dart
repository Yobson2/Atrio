// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BarberModel _$BarberModelFromJson(Map<String, dynamic> json) => _BarberModel(
      id: json['id'] as String,
      salonId: json['salon_id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isAvailable: json['is_available'] as bool? ?? true,
      serviceIds: (json['service_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BarberModelToJson(_BarberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salonId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'rating': instance.rating,
      'is_available': instance.isAvailable,
      'service_ids': instance.serviceIds,
    };
