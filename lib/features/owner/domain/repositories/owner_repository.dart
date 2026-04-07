import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/owner/domain/entities/dashboard_stats.dart';
import 'package:flutter_templates/features/owner/domain/entities/revenue_data.dart';

/// Abstract owner repository defined in the domain layer.
abstract class OwnerRepository {
  /// Gets dashboard statistics.
  Future<Either<Failure, DashboardStats>> getDashboardStats();

  /// Gets performance statistics for a period.
  Future<Either<Failure, PerformanceStats>> getPerformanceStats({
    bool isMonthly = true,
  });
}
