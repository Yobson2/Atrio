import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/create_service_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/delete_service_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_service_usecase.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:flutter_templates/features/owner/presentation/providers/service_management_state.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_management_notifier.g.dart';

/// Manages service CRUD operations for the owner.
@riverpod
class ServiceManagementNotifier extends _$ServiceManagementNotifier {
  @override
  ServiceManagementState build() {
    return const ServiceManagementState.initial();
  }

  /// Loads services from the salon data.
  Future<void> loadServices() async {
    state = const ServiceManagementState.loading();
    try {
      final result =
          await ref.read(getMySalonUseCaseProvider).call(const NoParams());
      // We get the salon, then fetch services via the salon's services.
      // For this owner module, we re-fetch the salon to get updated services.
      result.fold(
        (failure) => state = ServiceManagementState.error(failure.message),
        (salon) {
          // Services are fetched separately via the datasource; for now we
          // trigger a dashboard reload and keep services from there.
          // In a real app, there'd be a dedicated getServices endpoint.
          state = const ServiceManagementState.loaded([]);
        },
      );
    } catch (e) {
      state = ServiceManagementState.error(e.toString());
    }
  }

  /// Sets the loaded services list directly (called from dashboard data).
  void setServices(List<SalonService> services) {
    state = ServiceManagementState.loaded(services);
  }

  /// Creates a new service.
  Future<void> createService(SalonService service) async {
    state = const ServiceManagementState.loading();
    try {
      final result = await ref
          .read(createServiceUseCaseProvider)
          .call(CreateServiceParams(service: service));
      result.fold(
        (failure) => state = ServiceManagementState.error(failure.message),
        (_) => state = const ServiceManagementState.success('Service created'),
      );
    } catch (e) {
      state = ServiceManagementState.error(e.toString());
    }
  }

  /// Updates an existing service.
  Future<void> updateService(SalonService service) async {
    state = const ServiceManagementState.loading();
    try {
      final result = await ref
          .read(updateServiceUseCaseProvider)
          .call(UpdateServiceParams(service: service));
      result.fold(
        (failure) => state = ServiceManagementState.error(failure.message),
        (_) => state = const ServiceManagementState.success('Service updated'),
      );
    } catch (e) {
      state = ServiceManagementState.error(e.toString());
    }
  }

  /// Deletes a service by ID.
  Future<void> deleteService(String serviceId) async {
    state = const ServiceManagementState.loading();
    try {
      final result = await ref
          .read(deleteServiceUseCaseProvider)
          .call(DeleteServiceParams(serviceId: serviceId));
      result.fold(
        (failure) => state = ServiceManagementState.error(failure.message),
        (_) => state = const ServiceManagementState.success('Service deleted'),
      );
    } catch (e) {
      state = ServiceManagementState.error(e.toString());
    }
  }
}
