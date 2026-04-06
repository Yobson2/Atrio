import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Adds a review for a salon.
class AddReviewUseCase extends UseCase<void, AddReviewParams> {
  /// Creates an [AddReviewUseCase].
  const AddReviewUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, void>> call(AddReviewParams params) {
    return _repository.addReview(
      salonId: params.salonId,
      rating: params.rating,
      comment: params.comment,
    );
  }
}

/// Parameters for [AddReviewUseCase].
class AddReviewParams {
  /// Creates [AddReviewParams].
  const AddReviewParams({
    required this.salonId,
    required this.rating,
    this.comment,
  });

  /// ID of the salon to review.
  final String salonId;

  /// Rating value (1-5).
  final double rating;

  /// Optional review comment.
  final String? comment;
}
