import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';

/// Gets the salon owned by the current user.
class GetMySalonUseCase extends UseCase<Salon, NoParams> {
  /// Creates a [GetMySalonUseCase].
  const GetMySalonUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, Salon>> call(NoParams params) {
    return _repository.getMySalon();
  }
}
