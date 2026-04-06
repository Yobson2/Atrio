import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:flutter_templates/features/owner/presentation/providers/salon_setup_state.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'salon_setup_notifier.g.dart';

/// Manages the salon setup/creation flow.
@riverpod
class SalonSetupNotifier extends _$SalonSetupNotifier {
  @override
  SalonSetupState build() => const SalonSetupState.initial();

  /// Creates a new salon with the provided details.
  Future<void> createSalon({
    required String name,
    required String description,
    required String address,
    required String phone,
    required double latitude,
    required double longitude,
    required String ownerId,
  }) async {
    state = const SalonSetupState.loading();
    try {
      final salon = Salon(
        id: '',
        name: name,
        description: description,
        address: address,
        phone: phone,
        latitude: latitude,
        longitude: longitude,
        ownerId: ownerId,
      );

      final result =
          await ref.read(ownerRepositoryProvider).createSalon(salon);
      state = result.fold(
        (failure) => SalonSetupState.error(failure.message),
        SalonSetupState.success,
      );
    } catch (e) {
      state = SalonSetupState.error(e.toString());
    }
  }
}
