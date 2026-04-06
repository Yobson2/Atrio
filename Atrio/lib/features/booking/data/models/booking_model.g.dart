// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingModel _$BookingModelFromJson(Map<String, dynamic> json) =>
    _BookingModel(
      id: json['id'] as String,
      salonId: json['salon_id'] as String,
      salonName: json['salon_name'] as String,
      userId: json['user_id'] as String,
      serviceId: json['service_id'] as String,
      serviceName: json['service_name'] as String,
      barberId: json['barber_id'] as String?,
      barberName: json['barber_name'] as String?,
      type: json['type'] as String,
      status: json['status'] as String,
      scheduledAt: json['scheduled_at'] == null
          ? null
          : DateTime.parse(json['scheduled_at'] as String),
      estimatedDurationMinutes:
          (json['estimated_duration_minutes'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$BookingModelToJson(_BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salonId,
      'salon_name': instance.salonName,
      'user_id': instance.userId,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'barber_id': instance.barberId,
      'barber_name': instance.barberName,
      'type': instance.type,
      'status': instance.status,
      'scheduled_at': instance.scheduledAt?.toIso8601String(),
      'estimated_duration_minutes': instance.estimatedDurationMinutes,
      'price': instance.price,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
