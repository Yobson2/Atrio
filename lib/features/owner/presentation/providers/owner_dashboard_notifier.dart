import 'package:flutter_templates/features/owner/presentation/providers/owner_dashboard_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_dashboard_notifier.g.dart';

/// Notifier for loading owner dashboard data.
@riverpod
class OwnerDashboardNotifier extends _$OwnerDashboardNotifier {
  @override
  OwnerDashboardState build() {
    loadDashboard();
    return const OwnerDashboardState.loading();
  }

  Future<void> loadDashboard() async {
    state = const OwnerDashboardState.loading();
    final repo = ref.read(ownerRepositoryProvider);
    final result = await repo.getDashboardStats();
    state = result.fold(
      (failure) => OwnerDashboardState.error(failure.message),
      OwnerDashboardState.loaded,
    );
  }
}
