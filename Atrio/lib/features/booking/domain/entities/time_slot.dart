import 'package:flutter/foundation.dart';

/// Domain entity representing an available time slot.
@immutable
class TimeSlot {
  /// Creates a [TimeSlot].
  const TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });

  /// Start time of the slot.
  final DateTime startTime;

  /// End time of the slot.
  final DateTime endTime;

  /// Whether this slot is available for booking.
  final bool isAvailable;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlot &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode => Object.hash(startTime, endTime);

  @override
  String toString() => 'TimeSlot(start: $startTime, end: $endTime, '
      'available: $isAvailable)';
}
