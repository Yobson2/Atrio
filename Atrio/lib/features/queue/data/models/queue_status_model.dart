import 'package:flutter_templates/features/queue/data/models/queue_entry_model.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_status_model.freezed.dart';
part 'queue_status_model.g.dart';

/// Data model for [QueueStatus] with JSON serialization.
@freezed
abstract class QueueStatusModel with _$QueueStatusModel {
  const QueueStatusModel._();

  const factory QueueStatusModel({
    @JsonKey(name: 'salon_id') required String salonId,
    @JsonKey(name: 'total_waiting') @Default(0) int totalWaiting,
    @JsonKey(name: 'estimated_wait_minutes')
    @Default(0)
    int estimatedWaitMinutes,
    @JsonKey(name: 'currently_serving') @Default(0) int currentlyServing,
    @Default([]) List<QueueEntryModel> entries,
    @JsonKey(name: 'last_updated_at') required DateTime lastUpdatedAt,
  }) = _QueueStatusModel;

  /// Creates a [QueueStatusModel] from JSON.
  factory QueueStatusModel.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusModelFromJson(json);

  /// Converts this model to a domain [QueueStatus] entity.
  QueueStatus toEntity() => QueueStatus(
        salonId: salonId,
        totalWaiting: totalWaiting,
        estimatedWaitMinutes: estimatedWaitMinutes,
        currentlyServing: currentlyServing,
        entries: entries.map((e) => e.toEntity()).toList(),
        lastUpdatedAt: lastUpdatedAt,
      );

  /// Creates a [QueueStatusModel] from a domain [QueueStatus] entity.
  factory QueueStatusModel.fromEntity(QueueStatus entity) => QueueStatusModel(
        salonId: entity.salonId,
        totalWaiting: entity.totalWaiting,
        estimatedWaitMinutes: entity.estimatedWaitMinutes,
        currentlyServing: entity.currentlyServing,
        entries: entity.entries.map(QueueEntryModel.fromEntity).toList(),
        lastUpdatedAt: entity.lastUpdatedAt,
      );
}
