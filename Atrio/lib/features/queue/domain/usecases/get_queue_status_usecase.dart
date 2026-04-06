import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';

/// Gets the current queue status for a salon.
class GetQueueStatusUseCase extends UseCase<QueueStatus, String> {
  /// Creates a [GetQueueStatusUseCase].
  const GetQueueStatusUseCase(this._repository);

  final QueueRepository _repository;

  @override
  Future<Either<Failure, QueueStatus>> call(String params) {
    return _repository.getQueueStatus(params);
  }
}
