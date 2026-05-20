import 'package:flutter/foundation.dart';

/// Domain entity representing an available time slot.
@immutable
class TimeSlot {
  const TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
    this.barberId,
  });

  /// Start time (e.g., "9:00 AM").
  final String startTime;

  /// End time (e.g., "9:45 AM").
  final String endTime;

  /// Whether this slot can be booked.
  final bool isAvailable;

  /// Specific barber this slot belongs to, if any.
  final String? barberId;
}
