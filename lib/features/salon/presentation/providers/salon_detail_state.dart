import 'package:flutter_templates/features/salon/domain/usecases/get_salon_detail_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_detail_state.freezed.dart';

/// State for the salon detail screen.
@freezed
sealed class SalonDetailState with _$SalonDetailState {
  const factory SalonDetailState.initial() = SalonDetailInitial;
  const factory SalonDetailState.loading() = SalonDetailLoading;
  const factory SalonDetailState.loaded(SalonDetail detail) =
      SalonDetailLoaded;
  const factory SalonDetailState.error(String message) = SalonDetailError;
}
