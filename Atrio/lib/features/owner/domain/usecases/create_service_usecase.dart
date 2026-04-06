import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';

/// Creates a new service for the salon.
class CreateServiceUseCase extends UseCase<SalonService, CreateServiceParams> {
  /// Creates a [CreateServiceUseCase].
  const CreateServiceUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, SalonService>> call(CreateServiceParams params) {
    return _repository.createService(params.service);
  }
}

/// Parameters for [CreateServiceUseCase].
class CreateServiceParams {
  /// Creates [CreateServiceParams].
  const CreateServiceParams({required this.service});

  /// The service to create.
  final SalonService service;
}
