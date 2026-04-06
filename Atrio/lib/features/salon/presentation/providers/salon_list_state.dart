import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_list_state.freezed.dart';

/// Represents the state of the salon list / discovery screen.
@freezed
sealed class SalonListState with _$SalonListState {
  /// Initial idle state.
  const factory SalonListState.initial() = SalonListInitial;

  /// Loading salons.
  const factory SalonListState.loading() = SalonListLoading;

  /// Salons loaded successfully.
  const factory SalonListState.loaded(List<Salon> salons) = SalonListLoaded;

  /// An error occurred.
  const factory SalonListState.error(String message) = SalonListError;
}
