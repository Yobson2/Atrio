// coverage:ignore-file

import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/owner/domain/entities/dashboard_stats.dart';
import 'package:flutter_templates/features/owner/domain/entities/revenue_data.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Mock implementation of [OwnerRepository] with sample data.
class MockOwnerRepository implements OwnerRepository {
  static const _delay = Duration(milliseconds: 600);

  @override
  Future<Either<Failure, DashboardStats>> getDashboardStats() async {
    await Future<void>.delayed(_delay);
    return const Right(
      DashboardStats(
        todaysBookings: 18,
        todaysRevenue: 940,
        averageRating: 4.9,
        totalBookings: 124,
        activeBarbers: 8,
        totalBarbers: 12,
        availabilityPercent: 91,
        avgWaitMinutes: 8,
        staffOnline: 6,
      ),
    );
  }

  @override
  Future<Either<Failure, PerformanceStats>> getPerformanceStats({
    bool isMonthly = true,
  }) async {
    await Future<void>.delayed(_delay);
    return Right(
      PerformanceStats(
        totalBookings: 1284,
        averageRating: 4.9,
        totalRevenue: 42105,
        topServiceName: 'Signature Fade & Beard Sculpt',
        completedBookings: 1206,
        cancelledBookings: 78,
        revenueTargetPercent: 88,
        revenueTargetRemaining: 5300,
        revenueData: const [
          RevenueDataPoint(label: 'Mon', value: 1200),
          RevenueDataPoint(label: 'Tue', value: 1800),
          RevenueDataPoint(label: 'Wed', value: 1400),
          RevenueDataPoint(label: 'Thu', value: 2200),
          RevenueDataPoint(label: 'Fri', value: 2800),
          RevenueDataPoint(label: 'Sat', value: 3200),
          RevenueDataPoint(label: 'Sun', value: 1600),
        ],
        leaderboard: const [
          LeaderboardEntry(
            name: 'Alex Precision',
            bookings: 245,
            revenue: 12450,
          ),
          LeaderboardEntry(
            name: 'Marco Van Cut',
            bookings: 198,
            revenue: 9900,
          ),
          LeaderboardEntry(
            name: 'Sarah Sharp',
            bookings: 176,
            revenue: 8800,
          ),
        ],
      ),
    );
  }
}
