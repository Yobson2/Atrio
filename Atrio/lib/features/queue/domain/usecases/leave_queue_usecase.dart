import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';

/// Leaves the queue by entry ID.
class LeaveQueueUseCase extends UseCase<void, String> {
  /// Creates a [LeaveQueueUseCase].
  const LeaveQueueUseCase(this._repository);

  final QueueRepository _repository;

  @override
  Future<Either<Failure, void>> call(String params) {
    return _repository.leaveQueue(params);
  }
}
