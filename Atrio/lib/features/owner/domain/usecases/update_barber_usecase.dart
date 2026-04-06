import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';

/// Updates an existing barber.
class UpdateBarberUseCase extends UseCase<Barber, UpdateBarberParams> {
  /// Creates an [UpdateBarberUseCase].
  const UpdateBarberUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, Barber>> call(UpdateBarberParams params) {
    return _repository.updateBarber(params.barber);
  }
}

/// Parameters for [UpdateBarberUseCase].
class UpdateBarberParams {
  /// Creates [UpdateBarberParams].
  const UpdateBarberParams({required this.barber});

  /// The barber with updated data.
  final Barber barber;
}
