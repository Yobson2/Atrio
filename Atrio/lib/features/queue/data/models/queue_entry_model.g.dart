// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueueEntryModel _$QueueEntryModelFromJson(Map<String, dynamic> json) =>
    _QueueEntryModel(
      id: json['id'] as String,
      salonId: json['salon_id'] as String,
      bookingId: json['booking_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      serviceName: json['service_name'] as String,
      position: (json['position'] as num).toInt(),
      status: $enumDecodeNullable(_$QueueEntryStatusEnumMap, json['status']) ??
          QueueEntryStatus.waiting,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      estimatedWaitMinutes:
          (json['estimated_wait_minutes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$QueueEntryModelToJson(_QueueEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salon_id': instance.salonId,
      'booking_id': instance.bookingId,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'service_name': instance.serviceName,
      'position': instance.position,
      'status': _$QueueEntryStatusEnumMap[instance.status]!,
      'joined_at': instance.joinedAt.toIso8601String(),
      'estimated_wait_minutes': instance.estimatedWaitMinutes,
    };

const _$QueueEntryStatusEnumMap = {
  QueueEntryStatus.waiting: 'waiting',
  QueueEntryStatus.serving: 'serving',
  QueueEntryStatus.served: 'served',
  QueueEntryStatus.skipped: 'skipped',
};
