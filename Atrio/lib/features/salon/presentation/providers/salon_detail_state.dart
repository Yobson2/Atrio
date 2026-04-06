import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_detail_state.freezed.dart';

/// Represents the state of the salon detail screen.
@freezed
sealed class SalonDetailState with _$SalonDetailState {
  /// Initial idle state.
  const factory SalonDetailState.initial() = SalonDetailInitial;

  /// Loading salon detail.
  const factory SalonDetailState.loading() = SalonDetailLoading;

  /// Salon detail loaded successfully.
  const factory SalonDetailState.loaded({
    required Salon salon,
    required List<SalonService> services,
    required List<Barber> barbers,
  }) = SalonDetailLoaded;

  /// An error occurred.
  const factory SalonDetailState.error(String message) = SalonDetailError;
}
