import 'package:flutter/foundation.dart';

/// Domain entity representing owner dashboard statistics.
@immutable
class DashboardStats {
  const DashboardStats({
    required this.todaysBookings,
    required this.todaysRevenue,
    required this.averageRating,
    required this.totalBookings,
    required this.activeBarbers,
    required this.totalBarbers,
    this.availabilityPercent = 0,
    this.avgWaitMinutes = 0,
    this.staffOnline = 0,
  });

  final int todaysBookings;
  final double todaysRevenue;
  final double averageRating;
  final int totalBookings;
  final int activeBarbers;
  final int totalBarbers;
  final int availabilityPercent;
  final int avgWaitMinutes;
  final int staffOnline;
}
