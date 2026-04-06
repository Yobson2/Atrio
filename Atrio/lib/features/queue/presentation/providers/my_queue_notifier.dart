import 'package:flutter_templates/features/queue/presentation/providers/my_queue_state.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_queue_notifier.g.dart';

/// Manages the current user's queue position state.
@riverpod
class MyQueueNotifier extends _$MyQueueNotifier {
  @override
  MyQueueState build() => const MyQueueState.initial();

  /// Joins the queue for a given booking.
  Future<void> joinQueue(String bookingId) async {
    state = const MyQueueState.loading();
    try {
      final result = await ref.read(joinQueueUseCaseProvider).call(bookingId);
      state = result.fold(
        (failure) => MyQueueState.error(failure.message),
        MyQueueState.inQueue,
      );
    } catch (e) {
      state = MyQueueState.error(e.toString());
    }
  }

  /// Leaves the queue by entry ID.
  Future<void> leaveQueue(String entryId) async {
    state = const MyQueueState.loading();
    try {
      final result = await ref.read(leaveQueueUseCaseProvider).call(entryId);
      state = result.fold(
        (failure) => MyQueueState.error(failure.message),
        (_) => const MyQueueState.notInQueue(),
      );
    } catch (e) {
      state = MyQueueState.error(e.toString());
    }
  }

  /// Checks the current user's position in a salon queue.
  Future<void> checkPosition(String salonId) async {
    state = const MyQueueState.loading();
    try {
      final repository = ref.read(queueRepositoryProvider);
      final result = await repository.getMyQueuePosition(salonId);
      state = result.fold(
        (failure) => MyQueueState.error(failure.message),
        (entry) => entry != null
            ? MyQueueState.inQueue(entry)
            : const MyQueueState.notInQueue(),
      );
    } catch (e) {
      state = MyQueueState.error(e.toString());
    }
  }
}
