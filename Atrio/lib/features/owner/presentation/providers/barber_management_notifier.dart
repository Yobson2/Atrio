import 'package:flutter_templates/features/owner/domain/usecases/add_barber_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/remove_barber_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_barber_usecase.dart';
import 'package:flutter_templates/features/owner/presentation/providers/barber_management_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barber_management_notifier.g.dart';

/// Manages barber CRUD operations for the owner.
@riverpod
class BarberManagementNotifier extends _$BarberManagementNotifier {
  @override
  BarberManagementState build() {
    return const BarberManagementState.initial();
  }

  /// Sets the loaded barbers list directly.
  void setBarbers(List<Barber> barbers) {
    state = BarberManagementState.loaded(barbers);
  }

  /// Adds a new barber.
  Future<void> addBarber(Barber barber) async {
    state = const BarberManagementState.loading();
    try {
      final result = await ref
          .read(addBarberUseCaseProvider)
          .call(AddBarberParams(barber: barber));
      result.fold(
        (failure) => state = BarberManagementState.error(failure.message),
        (_) => state = const BarberManagementState.success('Barber added'),
      );
    } catch (e) {
      state = BarberManagementState.error(e.toString());
    }
  }

  /// Updates an existing barber.
  Future<void> updateBarber(Barber barber) async {
    state = const BarberManagementState.loading();
    try {
      final result = await ref
          .read(updateBarberUseCaseProvider)
          .call(UpdateBarberParams(barber: barber));
      result.fold(
        (failure) => state = BarberManagementState.error(failure.message),
        (_) => state = const BarberManagementState.success('Barber updated'),
      );
    } catch (e) {
      state = BarberManagementState.error(e.toString());
    }
  }

  /// Removes a barber by ID.
  Future<void> removeBarber(String barberId) async {
    state = const BarberManagementState.loading();
    try {
      final result = await ref
          .read(removeBarberUseCaseProvider)
          .call(RemoveBarberParams(barberId: barberId));
      result.fold(
        (failure) => state = BarberManagementState.error(failure.message),
        (_) => state = const BarberManagementState.success('Barber removed'),
      );
    } catch (e) {
      state = BarberManagementState.error(e.toString());
    }
  }
}
