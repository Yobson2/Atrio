import 'package:flutter/foundation.dart';

/// Domain entity representing opening hours for a day.
@immutable
class OpeningHours {
  /// Creates an [OpeningHours].
  const OpeningHours({
    required this.day,
    required this.openTime,
    required this.closeTime,
    this.isClosed = false,
  });

  /// Day of the week (e.g. "Monday").
  final String day;

  /// Opening time (e.g. "09:00").
  final String openTime;

  /// Closing time (e.g. "18:00").
  final String closeTime;

  /// Whether the salon is closed on this day.
  final bool isClosed;
}
