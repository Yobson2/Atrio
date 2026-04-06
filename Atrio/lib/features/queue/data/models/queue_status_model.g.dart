// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueueStatusModel _$QueueStatusModelFromJson(Map<String, dynamic> json) =>
    _QueueStatusModel(
      salonId: json['salon_id'] as String,
      totalWaiting: (json['total_waiting'] as num?)?.toInt() ?? 0,
      estimatedWaitMinutes:
          (json['estimated_wait_minutes'] as num?)?.toInt() ?? 0,
      currentlyServing: (json['currently_serving'] as num?)?.toInt() ?? 0,
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => QueueEntryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdatedAt: DateTime.parse(json['last_updated_at'] as String),
    );

Map<String, dynamic> _$QueueStatusModelToJson(_QueueStatusModel instance) =>
    <String, dynamic>{
      'salon_id': instance.salonId,
      'total_waiting': instance.totalWaiting,
      'estimated_wait_minutes': instance.estimatedWaitMinutes,
      'currently_serving': instance.currentlyServing,
      'entries': instance.entries,
      'last_updated_at': instance.lastUpdatedAt.toIso8601String(),
    };
