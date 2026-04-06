import 'package:flutter/foundation.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';

/// Domain entity representing the overall status of a salon's queue.
@immutable
class QueueStatus {
  /// Creates a [QueueStatus].
  const QueueStatus({
    required this.salonId,
    this.totalWaiting = 0,
    this.estimatedWaitMinutes = 0,
    this.currentlyServing = 0,
    this.entries = const [],
    required this.lastUpdatedAt,
  });

  /// The salon this queue belongs to.
  final String salonId;

  /// Total number of people waiting.
  final int totalWaiting;

  /// Estimated wait time for the last person in the queue.
  final int estimatedWaitMinutes;

  /// Number of people currently being served.
  final int currentlyServing;

  /// Ordered list of queue entries.
  final List<QueueEntry> entries;

  /// When this status was last updated.
  final DateTime lastUpdatedAt;
}
