import 'package:flutter/foundation.dart';

/// Queue entry status.
enum QueueEntryStatus { waiting, serving, completed, skipped }

/// Domain entity representing a single entry in the salon queue.
@immutable
class QueueEntry {
  const QueueEntry({
    required this.id,
    required this.salonId,
    required this.clientName,
    required this.serviceName,
    required this.position,
    required this.status,
    required this.joinedAt,
    this.clientPhotoUrl,
    this.barberId,
    this.estimatedWaitMinutes,
  });

  final String id;
  final String salonId;
  final String clientName;
  final String serviceName;
  final int position;
  final QueueEntryStatus status;
  final DateTime joinedAt;
  final String? clientPhotoUrl;
  final String? barberId;
  final int? estimatedWaitMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueEntry && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
