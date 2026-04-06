import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_setup_state.freezed.dart';

/// State for the salon setup flow.
@freezed
sealed class SalonSetupState with _$SalonSetupState {
  /// Initial idle state.
  const factory SalonSetupState.initial() = SalonSetupInitial;

  /// Submitting salon creation.
  const factory SalonSetupState.loading() = SalonSetupLoading;

  /// Salon created successfully.
  const factory SalonSetupState.success(Salon salon) = SalonSetupSuccess;

  /// An error occurred.
  const factory SalonSetupState.error(String message) = SalonSetupError;
}
