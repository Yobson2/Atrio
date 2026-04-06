import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_management_state.freezed.dart';

/// Represents the service management state.
@freezed
sealed class ServiceManagementState with _$ServiceManagementState {
  /// Initial state before any data is loaded.
  const factory ServiceManagementState.initial() = ServiceManagementInitial;

  /// Loading state during data fetch or mutation.
  const factory ServiceManagementState.loading() = ServiceManagementLoading;

  /// Services loaded successfully.
  const factory ServiceManagementState.loaded(List<SalonService> services) =
      ServiceManagementLoaded;

  /// A mutation (create/update/delete) succeeded.
  const factory ServiceManagementState.success(String message) =
      ServiceManagementSuccess;

  /// An error occurred.
  const factory ServiceManagementState.error(String message) =
      ServiceManagementError;
}
