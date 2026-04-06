import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_filter.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Gets nearby salons based on location and optional filters.
class GetNearbySalonsUseCase
    extends UseCase<List<Salon>, GetNearbySalonsParams> {
  /// Creates a [GetNearbySalonsUseCase].
  const GetNearbySalonsUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, List<Salon>>> call(GetNearbySalonsParams params) {
    return _repository.getNearbySalons(
      latitude: params.latitude,
      longitude: params.longitude,
      radiusKm: params.radiusKm,
      filter: params.filter,
    );
  }
}

/// Parameters for [GetNearbySalonsUseCase].
class GetNearbySalonsParams {
  /// Creates [GetNearbySalonsParams].
  const GetNearbySalonsParams({
    required this.latitude,
    required this.longitude,
    this.radiusKm = 10,
    this.filter,
  });

  /// User latitude.
  final double latitude;

  /// User longitude.
  final double longitude;

  /// Search radius in kilometers.
  final double radiusKm;

  /// Optional filter criteria.
  final SalonFilter? filter;
}
