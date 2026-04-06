import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';

/// Joins the queue for a given booking.
class JoinQueueUseCase extends UseCase<QueueEntry, String> {
  /// Creates a [JoinQueueUseCase].
  const JoinQueueUseCase(this._repository);

  final QueueRepository _repository;

  @override
  Future<Either<Failure, QueueEntry>> call(String params) {
    return _repository.joinQueue(params);
  }
}
