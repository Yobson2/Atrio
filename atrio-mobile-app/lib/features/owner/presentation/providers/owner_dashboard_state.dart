import 'package:flutter_templates/features/owner/domain/entities/dashboard_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_dashboard_state.freezed.dart';

/// State for the owner dashboard.
@freezed
sealed class OwnerDashboardState with _$OwnerDashboardState {
  const factory OwnerDashboardState.initial() = OwnerDashboardInitial;
  const factory OwnerDashboardState.loading() = OwnerDashboardLoading;
  const factory OwnerDashboardState.loaded(DashboardStats stats) =
      OwnerDashboardLoaded;
  const factory OwnerDashboardState.error(String message) =
      OwnerDashboardError;
}
