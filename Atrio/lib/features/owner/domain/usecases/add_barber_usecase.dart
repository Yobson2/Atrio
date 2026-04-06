import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';

/// Adds a new barber to the salon.
class AddBarberUseCase extends UseCase<Barber, AddBarberParams> {
  /// Creates an [AddBarberUseCase].
  const AddBarberUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, Barber>> call(AddBarberParams params) {
    return _repository.addBarber(params.barber);
  }
}

/// Parameters for [AddBarberUseCase].
class AddBarberParams {
  /// Creates [AddBarberParams].
  const AddBarberParams({required this.barber});

  /// The barber to add.
  final Barber barber;
}
