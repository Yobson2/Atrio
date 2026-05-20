import 'package:flutter/foundation.dart';

/// Domain entity representing opening hours for a day of the week.
@immutable
class BusinessHours {
  const BusinessHours({
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    this.isClosed = false,
  });

  /// Day of week (1 = Monday, 7 = Sunday).
  final int dayOfWeek;

  /// Opening time (e.g., "09:00").
  final String openTime;

  /// Closing time (e.g., "21:00").
  final String closeTime;

  /// Whether the salon is closed on this day.
  final bool isClosed;

  String get dayName {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday',
    ];
    return days[dayOfWeek - 1];
  }

  String get shortDayName {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dayOfWeek - 1];
  }
}
