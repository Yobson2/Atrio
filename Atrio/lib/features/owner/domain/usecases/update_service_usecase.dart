import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';

/// Updates an existing service.
class UpdateServiceUseCase extends UseCase<SalonService, UpdateServiceParams> {
  /// Creates an [UpdateServiceUseCase].
  const UpdateServiceUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, SalonService>> call(UpdateServiceParams params) {
    return _repository.updateService(params.service);
  }
}

/// Parameters for [UpdateServiceUseCase].
class UpdateServiceParams {
  /// Creates [UpdateServiceParams].
  const UpdateServiceParams({required this.service});

  /// The service with updated data.
  final SalonService service;
}
