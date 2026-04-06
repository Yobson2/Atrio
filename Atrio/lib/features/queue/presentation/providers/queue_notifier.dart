import 'dart:async';

import 'package:flutter_templates/features/queue/presentation/providers/queue_providers.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'queue_notifier.g.dart';

/// Manages the live queue state for a salon.
@riverpod
class QueueNotifier extends _$QueueNotifier {
  StreamSubscription<dynamic>? _subscription;

  @override
  QueueState build() => const QueueState.initial();

  /// Loads the current queue status for a salon.
  Future<void> loadQueue(String salonId) async {
    state = const QueueState.loading();
    try {
      final result =
          await ref.read(getQueueStatusUseCaseProvider).call(salonId);
      state = result.fold(
        (failure) => QueueState.error(failure.message),
        QueueState.live,
      );
    } catch (e) {
      state = QueueState.error(e.toString());
    }
  }

  /// Starts watching real-time queue updates for a salon.
  void startWatching(String salonId) {
    stopWatching();
    state = const QueueState.loading();

    final stream = ref.read(watchQueueStatusUseCaseProvider).call(salonId);

    _subscription = stream.listen(
      (status) {
        state = QueueState.live(status);
      },
      onError: (Object error) {
        state = QueueState.error(error.toString());
      },
    );
  }

  /// Stops watching queue updates.
  void stopWatching() {
    _subscription?.cancel();
    _subscription = null;
  }
}
