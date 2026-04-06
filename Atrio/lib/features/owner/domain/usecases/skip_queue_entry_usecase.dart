import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Skips a specific queue entry.
class SkipQueueEntryUseCase extends UseCase<void, SkipQueueEntryParams> {
  /// Creates a [SkipQueueEntryUseCase].
  const SkipQueueEntryUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, void>> call(SkipQueueEntryParams params) {
    return _repository.skipQueueEntry(params.entryId);
  }
}

/// Parameters for [SkipQueueEntryUseCase].
class SkipQueueEntryParams {
  /// Creates [SkipQueueEntryParams].
  const SkipQueueEntryParams({required this.entryId});

  /// The queue entry ID to skip.
  final String entryId;
}
