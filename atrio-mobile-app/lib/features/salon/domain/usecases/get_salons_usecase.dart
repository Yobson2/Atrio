import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Fetches all salons with optional search filtering.
class GetSalonsUseCase extends UseCase<List<Salon>, GetSalonsParams> {
  const GetSalonsUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, List<Salon>>> call(GetSalonsParams params) {
    return _repository.getSalons(query: params.query);
  }
}

/// Parameters for [GetSalonsUseCase].
class GetSalonsParams {
  const GetSalonsParams({this.query});

  final String? query;
}
