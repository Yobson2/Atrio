import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_state.freezed.dart';

/// Represents the state for the live queue view.
@freezed
sealed class QueueState with _$QueueState {
  /// Initial idle state.
  const factory QueueState.initial() = QueueInitial;

  /// Loading the queue status.
  const factory QueueState.loading() = QueueLoading;

  /// Live queue status is available.
  const factory QueueState.live(QueueStatus status) = QueueLive;

  /// An error occurred.
  const factory QueueState.error(String message) = QueueError;
}
