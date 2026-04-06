import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Advances the queue (marks current as done, moves to next).
class AdvanceQueueUseCase extends UseCase<void, AdvanceQueueParams> {
  /// Creates an [AdvanceQueueUseCase].
  const AdvanceQueueUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, void>> call(AdvanceQueueParams params) {
    return _repository.advanceQueue(params.salonId);
  }
}

/// Parameters for [AdvanceQueueUseCase].
class AdvanceQueueParams {
  /// Creates [AdvanceQueueParams].
  const AdvanceQueueParams({required this.salonId});

  /// The salon ID whose queue to advance.
  final String salonId;
}
