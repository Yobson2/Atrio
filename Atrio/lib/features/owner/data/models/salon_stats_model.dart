import 'package:flutter_templates/features/owner/domain/entities/salon_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_stats_model.freezed.dart';
part 'salon_stats_model.g.dart';

/// Data model for [SalonStats] with JSON serialization.
@freezed
abstract class SalonStatsModel with _$SalonStatsModel {
  const SalonStatsModel._();

  const factory SalonStatsModel({
    @JsonKey(name: 'today_bookings') @Default(0) int todayBookings,
    @JsonKey(name: 'today_completed') @Default(0) int todayCompleted,
    @JsonKey(name: 'today_revenue') @Default(0.0) double todayRevenue,
    @JsonKey(name: 'week_bookings') @Default(0) int weekBookings,
    @JsonKey(name: 'week_revenue') @Default(0.0) double weekRevenue,
    @JsonKey(name: 'average_rating') @Default(0.0) double averageRating,
    @JsonKey(name: 'total_reviews') @Default(0) int totalReviews,
    @JsonKey(name: 'average_wait_minutes')
    @Default(0.0)
    double averageWaitMinutes,
  }) = _SalonStatsModel;

  /// Creates a [SalonStatsModel] from JSON.
  factory SalonStatsModel.fromJson(Map<String, dynamic> json) =>
      _$SalonStatsModelFromJson(json);

  /// Converts to a domain [SalonStats] entity.
  SalonStats toEntity() => SalonStats(
        todayBookings: todayBookings,
        todayCompleted: todayCompleted,
        todayRevenue: todayRevenue,
        weekBookings: weekBookings,
        weekRevenue: weekRevenue,
        averageRating: averageRating,
        totalReviews: totalReviews,
        averageWaitMinutes: averageWaitMinutes,
      );

  /// Creates from a domain [SalonStats] entity.
  static SalonStatsModel fromEntity(SalonStats entity) => SalonStatsModel(
        todayBookings: entity.todayBookings,
        todayCompleted: entity.todayCompleted,
        todayRevenue: entity.todayRevenue,
        weekBookings: entity.weekBookings,
        weekRevenue: entity.weekRevenue,
        averageRating: entity.averageRating,
        totalReviews: entity.totalReviews,
        averageWaitMinutes: entity.averageWaitMinutes,
      );
}
