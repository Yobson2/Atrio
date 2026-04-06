import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Gets a single salon by its ID.
class GetSalonDetailUseCase extends UseCase<Salon, String> {
  /// Creates a [GetSalonDetailUseCase].
  const GetSalonDetailUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, Salon>> call(String params) {
    return _repository.getSalonById(params);
  }
}
