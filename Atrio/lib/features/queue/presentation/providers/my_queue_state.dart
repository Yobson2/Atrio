import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_queue_state.freezed.dart';

/// Represents the state for the current user's queue position.
@freezed
sealed class MyQueueState with _$MyQueueState {
  /// Initial idle state.
  const factory MyQueueState.initial() = MyQueueInitial;

  /// Loading the user's queue position.
  const factory MyQueueState.loading() = MyQueueLoading;

  /// User is currently in the queue.
  const factory MyQueueState.inQueue(QueueEntry entry) = MyQueueInQueue;

  /// User is not in the queue.
  const factory MyQueueState.notInQueue() = MyQueueNotInQueue;

  /// An error occurred.
  const factory MyQueueState.error(String message) = MyQueueError;
}
