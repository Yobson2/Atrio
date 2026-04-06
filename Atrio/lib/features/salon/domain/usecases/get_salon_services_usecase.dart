import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Gets all services offered by a salon.
class GetSalonServicesUseCase extends UseCase<List<SalonService>, String> {
  /// Creates a [GetSalonServicesUseCase].
  const GetSalonServicesUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, List<SalonService>>> call(String params) {
    return _repository.getSalonServices(params);
  }
}
