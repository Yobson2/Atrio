import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_state.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'salon_detail_notifier.g.dart';

/// Notifier for loading complete salon details.
@riverpod
class SalonDetailNotifier extends _$SalonDetailNotifier {
  @override
  SalonDetailState build() => const SalonDetailState.initial();

  /// Loads salon details by ID.
  Future<void> loadSalon(String salonId) async {
    state = const SalonDetailState.loading();

    final useCase = ref.read(getSalonDetailUseCaseProvider);
    final result = await useCase(salonId);

    state = result.fold(
      (failure) => SalonDetailState.error(failure.message),
      SalonDetailState.loaded,
    );
  }
}
