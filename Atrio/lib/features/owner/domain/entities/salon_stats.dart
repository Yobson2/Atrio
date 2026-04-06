import 'package:flutter/foundation.dart';

/// Domain entity representing aggregated statistics for a salon.
@immutable
class SalonStats {
  /// Creates a [SalonStats].
  const SalonStats({
    this.todayBookings = 0,
    this.todayCompleted = 0,
    this.todayRevenue = 0.0,
    this.weekBookings = 0,
    this.weekRevenue = 0.0,
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.averageWaitMinutes = 0.0,
  });

  /// Number of bookings today.
  final int todayBookings;

  /// Number of completed bookings today.
  final int todayCompleted;

  /// Revenue earned today.
  final double todayRevenue;

  /// Number of bookings this week.
  final int weekBookings;

  /// Revenue earned this week.
  final double weekRevenue;

  /// Average rating (0-5).
  final double averageRating;

  /// Total number of reviews.
  final int totalReviews;

  /// Average wait time in minutes.
  final double averageWaitMinutes;
}
