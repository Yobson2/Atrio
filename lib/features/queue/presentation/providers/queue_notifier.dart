import 'package:flutter_templates/features/queue/presentation/providers/queue_providers.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'queue_notifier.g.dart';

/// Notifier for managing queue state (shared by client and owner views).
@riverpod
class QueueNotifier extends _$QueueNotifier {
  @override
  QueueState build() => const QueueState.initial();

  /// Loads queue status for a salon.
  Future<void> loadQueue(String salonId) async {
    state = const QueueState.loading();
    final repo = ref.read(queueRepositoryProvider);
    final result = await repo.getQueueStatus(salonId);
    state = result.fold(
      (failure) => QueueState.error(failure.message),
      QueueState.loaded,
    );
  }

  /// Joins the queue (client action).
  Future<void> joinQueue(String salonId) async {
    final repo = ref.read(queueRepositoryProvider);
    await repo.joinQueue(salonId);
    await loadQueue(salonId);
  }

  /// Leaves the queue (client action).
  Future<void> leaveQueue(String salonId) async {
    final repo = ref.read(queueRepositoryProvider);
    await repo.leaveQueue(salonId);
    await loadQueue(salonId);
  }

  /// Marks the user as arrived (client action).
  Future<void> markArrived(String salonId) async {
    final repo = ref.read(queueRepositoryProvider);
    await repo.markArrived(salonId);
    await loadQueue(salonId);
  }

  /// Advances the queue (owner action).
  Future<void> advanceQueue(String salonId) async {
    final repo = ref.read(queueRepositoryProvider);
    await repo.advanceQueue(salonId);
    await loadQueue(salonId);
  }

  /// Skips an entry (owner action).
  Future<void> skipEntry(String salonId, String entryId) async {
    final repo = ref.read(queueRepositoryProvider);
    await repo.skipEntry(salonId, entryId);
    await loadQueue(salonId);
  }
}
