import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_entry_model.freezed.dart';
part 'queue_entry_model.g.dart';

/// Data model for [QueueEntry] with JSON serialization.
@freezed
abstract class QueueEntryModel with _$QueueEntryModel {
  const QueueEntryModel._();

  const factory QueueEntryModel({
    required String id,
    @JsonKey(name: 'salon_id') required String salonId,
    @JsonKey(name: 'booking_id') required String bookingId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'service_name') required String serviceName,
    required int position,
    @Default(QueueEntryStatus.waiting) QueueEntryStatus status,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
    @JsonKey(name: 'estimated_wait_minutes')
    @Default(0)
    int estimatedWaitMinutes,
  }) = _QueueEntryModel;

  /// Creates a [QueueEntryModel] from JSON.
  factory QueueEntryModel.fromJson(Map<String, dynamic> json) =>
      _$QueueEntryModelFromJson(json);

  /// Converts this model to a domain [QueueEntry] entity.
  QueueEntry toEntity() => QueueEntry(
        id: id,
        salonId: salonId,
        bookingId: bookingId,
        userId: userId,
        userName: userName,
        serviceName: serviceName,
        position: position,
        status: status,
        joinedAt: joinedAt,
        estimatedWaitMinutes: estimatedWaitMinutes,
      );

  /// Creates a [QueueEntryModel] from a domain [QueueEntry] entity.
  factory QueueEntryModel.fromEntity(QueueEntry entity) => QueueEntryModel(
        id: entity.id,
        salonId: entity.salonId,
        bookingId: entity.bookingId,
        userId: entity.userId,
        userName: entity.userName,
        serviceName: entity.serviceName,
        position: entity.position,
        status: entity.status,
        joinedAt: entity.joinedAt,
        estimatedWaitMinutes: entity.estimatedWaitMinutes,
      );
}
