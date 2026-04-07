import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_state.freezed.dart';

/// State for the queue screens (both client and owner).
@freezed
sealed class QueueState with _$QueueState {
  const factory QueueState.initial() = QueueInitial;
  const factory QueueState.loading() = QueueLoading;
  const factory QueueState.loaded(QueueStatus status) = QueueLoaded;
  const factory QueueState.error(String message) = QueueError;
}
