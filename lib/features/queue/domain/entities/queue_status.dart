import 'package:flutter/foundation.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';

/// Domain entity representing the overall queue status for a salon.
@immutable
class QueueStatus {
  const QueueStatus({
    required this.salonId,
    required this.totalInQueue,
    required this.currentlyServing,
    required this.averageWaitMinutes,
    required this.entries,
    this.salonName,
    this.salonAddress,
    this.salonPhone,
    this.userPosition,
    this.userEstimatedWait,
    this.dailyRevenue,
  });

  final String salonId;
  final int totalInQueue;
  final int currentlyServing;
  final int averageWaitMinutes;
  final List<QueueEntry> entries;
  final String? salonName;
  final String? salonAddress;
  final String? salonPhone;

  /// The current user's position in line (null if not in queue).
  final int? userPosition;

  /// Estimated wait for the current user in minutes.
  final int? userEstimatedWait;

  /// Total revenue for the day (owner view).
  final double? dailyRevenue;
}
