import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barber_management_state.freezed.dart';

/// Represents the barber management state.
@freezed
sealed class BarberManagementState with _$BarberManagementState {
  /// Initial state before any data is loaded.
  const factory BarberManagementState.initial() = BarberManagementInitial;

  /// Loading state during data fetch or mutation.
  const factory BarberManagementState.loading() = BarberManagementLoading;

  /// Barbers loaded successfully.
  const factory BarberManagementState.loaded(List<Barber> barbers) =
      BarberManagementLoaded;

  /// A mutation (add/update/remove) succeeded.
  const factory BarberManagementState.success(String message) =
      BarberManagementSuccess;

  /// An error occurred.
  const factory BarberManagementState.error(String message) =
      BarberManagementError;
}
