import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';

/// Creates a new salon for the owner.
class CreateSalonUseCase extends UseCase<Salon, Salon> {
  /// Creates a [CreateSalonUseCase].
  const CreateSalonUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, Salon>> call(Salon params) {
    return _repository.createSalon(params);
  }
}
