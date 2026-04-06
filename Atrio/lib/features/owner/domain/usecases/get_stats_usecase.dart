import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/owner/domain/entities/salon_stats.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Gets salon statistics for a given date range.
class GetStatsUseCase extends UseCase<SalonStats, GetStatsParams> {
  /// Creates a [GetStatsUseCase].
  const GetStatsUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, SalonStats>> call(GetStatsParams params) {
    return _repository.getStats(from: params.from, to: params.to);
  }
}

/// Parameters for [GetStatsUseCase].
class GetStatsParams {
  /// Creates [GetStatsParams].
  const GetStatsParams({this.from, this.to});

  /// Start date for the statistics range.
  final DateTime? from;

  /// End date for the statistics range.
  final DateTime? to;
}
