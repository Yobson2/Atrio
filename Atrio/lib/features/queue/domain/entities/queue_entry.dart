import 'package:flutter/foundation.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry_status.dart';

/// Domain entity representing a single entry in a salon queue.
@immutable
class QueueEntry {
  /// Creates a [QueueEntry].
  const QueueEntry({
    required this.id,
    required this.salonId,
    required this.bookingId,
    required this.userId,
    required this.userName,
    required this.serviceName,
    required this.position,
    this.status = QueueEntryStatus.waiting,
    required this.joinedAt,
    this.estimatedWaitMinutes = 0,
  });

  /// Unique identifier for this queue entry.
  final String id;

  /// Salon this entry belongs to.
  final String salonId;

  /// Associated booking ID.
  final String bookingId;

  /// User who joined the queue.
  final String userId;

  /// Display name of the user.
  final String userName;

  /// Name of the service requested.
  final String serviceName;

  /// Current position in the queue (1-based).
  final int position;

  /// Current status of this entry.
  final QueueEntryStatus status;

  /// When the user joined the queue.
  final DateTime joinedAt;

  /// Estimated wait time in minutes.
  final int estimatedWaitMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QueueEntry && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
