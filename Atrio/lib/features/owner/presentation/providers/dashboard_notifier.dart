import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/owner/domain/entities/salon_stats.dart';
import 'package:flutter_templates/features/owner/domain/usecases/get_stats_usecase.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_notifier.g.dart';

/// Manages the owner dashboard state and actions.
@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  DashboardState build() {
    return const DashboardState.initial();
  }

  /// Loads the full dashboard: salon info, stats, and today's bookings.
  Future<void> loadDashboard() async {
    state = const DashboardState.loading();
    try {
      final salonResult =
          await ref.read(getMySalonUseCaseProvider).call(const NoParams());
      final statsResult =
          await ref.read(getStatsUseCaseProvider).call(const GetStatsParams());
      final bookingsResult = await ref
          .read(getTodayBookingsUseCaseProvider)
          .call(const NoParams());

      // If salon fetch fails, show error immediately.
      final salon = salonResult.fold(
        (failure) {
          state = DashboardState.error(failure.message);
          return null;
        },
        (salon) => salon,
      );
      if (salon == null) return;

      final stats = statsResult.fold(
        (_) => null,
        (stats) => stats,
      );
      final bookings = bookingsResult.fold(
        (_) => <Booking>[],
        (bookings) => bookings,
      );

      state = DashboardState.loaded(
        salon: salon,
        stats: stats ?? const SalonStats(),
        todayBookings: bookings,
      );
    } catch (e) {
      state = DashboardState.error(e.toString());
    }
  }

  /// Refreshes only the stats and bookings (lighter refresh).
  Future<void> refreshStats() async {
    final currentState = state;
    if (currentState is! DashboardLoaded) {
      return loadDashboard();
    }

    try {
      final statsResult =
          await ref.read(getStatsUseCaseProvider).call(const GetStatsParams());
      final bookingsResult = await ref
          .read(getTodayBookingsUseCaseProvider)
          .call(const NoParams());

      final stats = statsResult.fold(
        (_) => currentState.stats,
        (stats) => stats,
      );
      final bookings = bookingsResult.fold(
        (_) => currentState.todayBookings,
        (bookings) => bookings,
      );

      state = DashboardState.loaded(
        salon: currentState.salon,
        stats: stats,
        todayBookings: bookings,
      );
    } catch (e) {
      // Keep current data on refresh failure.
    }
  }
}
