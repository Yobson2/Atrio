import 'package:flutter/foundation.dart';

/// Domain entity representing a revenue data point for charts.
@immutable
class RevenueDataPoint {
  const RevenueDataPoint({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;
}

/// Aggregated statistics for the statistics page.
@immutable
class PerformanceStats {
  const PerformanceStats({
    required this.totalBookings,
    required this.averageRating,
    required this.totalRevenue,
    required this.topServiceName,
    required this.completedBookings,
    required this.cancelledBookings,
    required this.revenueData,
    required this.leaderboard,
    this.revenueTargetPercent = 0,
    this.revenueTargetRemaining = 0,
  });

  final int totalBookings;
  final double averageRating;
  final double totalRevenue;
  final String topServiceName;
  final int completedBookings;
  final int cancelledBookings;
  final List<RevenueDataPoint> revenueData;
  final List<LeaderboardEntry> leaderboard;
  final int revenueTargetPercent;
  final double revenueTargetRemaining;
}

/// Leaderboard entry for top performing barbers.
@immutable
class LeaderboardEntry {
  const LeaderboardEntry({
    required this.name,
    required this.bookings,
    required this.revenue,
    this.photoUrl,
  });

  final String name;
  final int bookings;
  final double revenue;
  final String? photoUrl;
}
