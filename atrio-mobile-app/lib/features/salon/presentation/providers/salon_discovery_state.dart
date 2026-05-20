import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_discovery_state.freezed.dart';

/// State for the salon discovery screen.
@freezed
sealed class SalonDiscoveryState with _$SalonDiscoveryState {
  const factory SalonDiscoveryState.initial() = SalonDiscoveryInitial;
  const factory SalonDiscoveryState.loading() = SalonDiscoveryLoading;
  const factory SalonDiscoveryState.loaded(List<Salon> salons) =
      SalonDiscoveryLoaded;
  const factory SalonDiscoveryState.error(String message) =
      SalonDiscoveryError;
}
