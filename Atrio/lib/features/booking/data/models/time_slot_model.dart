import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot_model.freezed.dart';
part 'time_slot_model.g.dart';

/// Data model for [TimeSlot] with JSON serialization.
@freezed
abstract class TimeSlotModel with _$TimeSlotModel {
  const TimeSlotModel._();

  const factory TimeSlotModel({
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
  }) = _TimeSlotModel;

  /// Creates a [TimeSlotModel] from JSON.
  factory TimeSlotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotModelFromJson(json);

  /// Converts this model to a domain [TimeSlot] entity.
  TimeSlot toEntity() => TimeSlot(
        startTime: startTime,
        endTime: endTime,
        isAvailable: isAvailable,
      );
}
