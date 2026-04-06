import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Gets all barbers working at a salon.
class GetSalonBarbersUseCase extends UseCase<List<Barber>, String> {
  /// Creates a [GetSalonBarbersUseCase].
  const GetSalonBarbersUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, List<Barber>>> call(String params) {
    return _repository.getSalonBarbers(params);
  }
}
