// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SalonStatsModel _$SalonStatsModelFromJson(Map<String, dynamic> json) =>
    _SalonStatsModel(
      todayBookings: (json['today_bookings'] as num?)?.toInt() ?? 0,
      todayCompleted: (json['today_completed'] as num?)?.toInt() ?? 0,
      todayRevenue: (json['today_revenue'] as num?)?.toDouble() ?? 0.0,
      weekBookings: (json['week_bookings'] as num?)?.toInt() ?? 0,
      weekRevenue: (json['week_revenue'] as num?)?.toDouble() ?? 0.0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
      averageWaitMinutes:
          (json['average_wait_minutes'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$SalonStatsModelToJson(_SalonStatsModel instance) =>
    <String, dynamic>{
      'today_bookings': instance.todayBookings,
      'today_completed': instance.todayCompleted,
      'today_revenue': instance.todayRevenue,
      'week_bookings': instance.weekBookings,
      'week_revenue': instance.weekRevenue,
      'average_rating': instance.averageRating,
      'total_reviews': instance.totalReviews,
      'average_wait_minutes': instance.averageWaitMinutes,
    };
