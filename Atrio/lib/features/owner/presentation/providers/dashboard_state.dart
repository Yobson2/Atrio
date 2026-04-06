import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/owner/domain/entities/salon_stats.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

/// Represents the owner dashboard state.
@freezed
sealed class DashboardState with _$DashboardState {
  /// Initial state before any data is loaded.
  const factory DashboardState.initial() = DashboardInitial;

  /// Loading state during data fetch.
  const factory DashboardState.loading() = DashboardLoading;

  /// Data loaded successfully.
  const factory DashboardState.loaded({
    required Salon salon,
    required SalonStats stats,
    required List<Booking> todayBookings,
  }) = DashboardLoaded;

  /// An error occurred.
  const factory DashboardState.error(String message) = DashboardError;
}
