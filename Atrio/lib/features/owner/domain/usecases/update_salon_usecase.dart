import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';

/// Updates the salon information.
class UpdateSalonUseCase extends UseCase<Salon, UpdateSalonParams> {
  /// Creates an [UpdateSalonUseCase].
  const UpdateSalonUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, Salon>> call(UpdateSalonParams params) {
    return _repository.updateSalon(params.salon);
  }
}

/// Parameters for [UpdateSalonUseCase].
class UpdateSalonParams {
  /// Creates [UpdateSalonParams].
  const UpdateSalonParams({required this.salon});

  /// The salon with updated data.
  final Salon salon;
}
