import 'package:flutter_templates/features/salon/domain/usecases/get_salons_usecase.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_discovery_state.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'salon_discovery_notifier.g.dart';

/// Notifier for salon discovery -- manages search and filtering.
@riverpod
class SalonDiscoveryNotifier extends _$SalonDiscoveryNotifier {
  @override
  SalonDiscoveryState build() {
    // Load salons on build
    loadSalons();
    return const SalonDiscoveryState.loading();
  }

  /// Loads all salons, optionally filtered by search query.
  Future<void> loadSalons({String? query}) async {
    state = const SalonDiscoveryState.loading();

    final useCase = ref.read(getSalonsUseCaseProvider);
    final result = await useCase(GetSalonsParams(query: query));

    state = result.fold(
      (failure) => SalonDiscoveryState.error(failure.message),
      SalonDiscoveryState.loaded,
    );
  }

  /// Searches salons by query string.
  Future<void> search(String query) async {
    await loadSalons(query: query.isEmpty ? null : query);
  }
}
