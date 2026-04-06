import 'package:flutter_templates/features/salon/domain/entities/opening_hours.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours_model.freezed.dart';
part 'opening_hours_model.g.dart';

/// Data model for [OpeningHours] with JSON serialization.
@freezed
abstract class OpeningHoursModel with _$OpeningHoursModel {
  const OpeningHoursModel._();

  const factory OpeningHoursModel({
    required String day,
    @JsonKey(name: 'open_time') required String openTime,
    @JsonKey(name: 'close_time') required String closeTime,
    @JsonKey(name: 'is_closed') @Default(false) bool isClosed,
  }) = _OpeningHoursModel;

  /// Creates an [OpeningHoursModel] from JSON.
  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursModelFromJson(json);

  /// Converts to a domain [OpeningHours] entity.
  OpeningHours toEntity() => OpeningHours(
        day: day,
        openTime: openTime,
        closeTime: closeTime,
        isClosed: isClosed,
      );

  /// Creates from a domain [OpeningHours] entity.
  static OpeningHoursModel fromEntity(OpeningHours entity) => OpeningHoursModel(
        day: entity.day,
        openTime: entity.openTime,
        closeTime: entity.closeTime,
        isClosed: entity.isClosed,
      );
}
