import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Gets all reviews for a salon.
class GetSalonReviewsUseCase extends UseCase<List<Review>, String> {
  /// Creates a [GetSalonReviewsUseCase].
  const GetSalonReviewsUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, List<Review>>> call(String params) {
    return _repository.getSalonReviews(params);
  }
}
