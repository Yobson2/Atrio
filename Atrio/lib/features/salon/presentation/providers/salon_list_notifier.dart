import 'package:flutter_templates/features/salon/domain/entities/salon_filter.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_nearby_salons_usecase.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_list_state.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'salon_list_notifier.g.dart';

/// Manages the salon discovery list state.
@riverpod
class SalonListNotifier extends _$SalonListNotifier {
  SalonFilter _currentFilter = const SalonFilter();

  @override
  SalonListState build() => const SalonListState.initial();

  /// Loads nearby salons based on user location.
  Future<void> loadNearbySalons({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
  }) async {
    state = const SalonListState.loading();
    try {
      final result = await ref.read(getNearbySalonsUseCaseProvider).call(
            GetNearbySalonsParams(
              latitude: latitude,
              longitude: longitude,
              radiusKm: radiusKm,
              filter: _currentFilter,
            ),
          );
      state = result.fold(
        (failure) => SalonListState.error(failure.message),
        SalonListState.loaded,
      );
    } catch (e) {
      state = SalonListState.error(e.toString());
    }
  }

  /// Searches salons by query text.
  Future<void> search(String query) async {
    _currentFilter = SalonFilter(
      query: query.isEmpty ? null : query,
      minRating: _currentFilter.minRating,
      isOpenNow: _currentFilter.isOpenNow,
      maxDistance: _currentFilter.maxDistance,
      maxPrice: _currentFilter.maxPrice,
      serviceType: _currentFilter.serviceType,
    );
    await _reloadWithCurrentFilter();
  }

  /// Applies a filter and reloads.
  Future<void> applyFilter(SalonFilter filter) async {
    _currentFilter = filter;
    await _reloadWithCurrentFilter();
  }

  Future<void> _reloadWithCurrentFilter() async {
    // Use default location for mock; in production, use actual user location.
    await loadNearbySalons(
      latitude: _currentFilter.latitude ?? 48.8566,
      longitude: _currentFilter.longitude ?? 2.3522,
    );
  }
}
