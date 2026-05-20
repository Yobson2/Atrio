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
      serviceId: json['service_id'] as String,
      serviceName: json['service_name'] as String,
      clientId: json['client_id'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['start_time'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      barberId: json['barber_id'] as String?,
      barberName: json['barber_name'] as String?,
      endTime: json['end_time'] as String?,
      notes: json['notes'] as String?,
      salonAddress: json['salon_address'] as String?,
      serviceDuration: (json['service_duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookingModelToJson(_BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salonId,
      'salon_name': instance.salonName,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'client_id': instance.clientId,
      'date': instance.date.toIso8601String(),
      'start_time': instance.startTime,
      'total_price': instance.totalPrice,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'barber_id': instance.barberId,
      'barber_name': instance.barberName,
      'end_time': instance.endTime,
      'notes': instance.notes,
      'salon_address': instance.salonAddress,
      'service_duration': instance.serviceDuration,
    };
