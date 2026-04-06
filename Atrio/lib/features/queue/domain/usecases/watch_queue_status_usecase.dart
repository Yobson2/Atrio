import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';

/// Watches the queue status in real-time for a salon.
class WatchQueueStatusUseCase extends StreamUseCase<QueueStatus, String> {
  /// Creates a [WatchQueueStatusUseCase].
  const WatchQueueStatusUseCase(this._repository);

  final QueueRepository _repository;

  @override
  Stream<QueueStatus> call(String params) {
    return _repository.watchQueueStatus(params);
  }
}
