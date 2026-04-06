import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Removes a barber by their ID.
class RemoveBarberUseCase extends UseCase<void, RemoveBarberParams> {
  /// Creates a [RemoveBarberUseCase].
  const RemoveBarberUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, void>> call(RemoveBarberParams params) {
    return _repository.removeBarber(params.barberId);
  }
}

/// Parameters for [RemoveBarberUseCase].
class RemoveBarberParams {
  /// Creates [RemoveBarberParams].
  const RemoveBarberParams({required this.barberId});

  /// The ID of the barber to remove.
  final String barberId;
}
