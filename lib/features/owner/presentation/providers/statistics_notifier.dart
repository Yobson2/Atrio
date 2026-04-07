import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:flutter_templates/features/owner/presentation/providers/statistics_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistics_notifier.g.dart';

/// Notifier for loading performance statistics.
@riverpod
class StatisticsNotifier extends _$StatisticsNotifier {
  @override
  StatisticsState build() {
    loadStats();
    return const StatisticsState.loading();
  }

  Future<void> loadStats({bool isMonthly = true}) async {
    state = const StatisticsState.loading();
    final repo = ref.read(ownerRepositoryProvider);
    final result = await repo.getPerformanceStats(isMonthly: isMonthly);
    state = result.fold(
      (failure) => StatisticsState.error(failure.message),
      StatisticsState.loaded,
    );
  }
}
