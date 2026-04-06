import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Deletes a service by its ID.
class DeleteServiceUseCase extends UseCase<void, DeleteServiceParams> {
  /// Creates a [DeleteServiceUseCase].
  const DeleteServiceUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, void>> call(DeleteServiceParams params) {
    return _repository.deleteService(params.serviceId);
  }
}

/// Parameters for [DeleteServiceUseCase].
class DeleteServiceParams {
  /// Creates [DeleteServiceParams].
  const DeleteServiceParams({required this.serviceId});

  /// The ID of the service to delete.
  final String serviceId;
}
