// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpeningHoursModel _$OpeningHoursModelFromJson(Map<String, dynamic> json) =>
    _OpeningHoursModel(
      day: json['day'] as String,
      openTime: json['open_time'] as String,
      closeTime: json['close_time'] as String,
      isClosed: json['is_closed'] as bool? ?? false,
    );

Map<String, dynamic> _$OpeningHoursModelToJson(_OpeningHoursModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
      'is_closed': instance.isClosed,
    };
