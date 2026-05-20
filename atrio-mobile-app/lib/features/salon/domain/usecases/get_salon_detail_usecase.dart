import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/business_hours.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';

/// Fetches complete salon details including services, barbers, hours, and reviews.
class GetSalonDetailUseCase extends UseCase<SalonDetail, String> {
  const GetSalonDetailUseCase(this._repository);

  final SalonRepository _repository;

  @override
  Future<Either<Failure, SalonDetail>> call(String params) async {
    final salonResult = await _repository.getSalonById(params);

    return salonResult.fold(
      Left.new,
      (salon) async {
        final results = await Future.wait([
          _repository.getSalonServices(params),
          _repository.getSalonBarbers(params),
          _repository.getSalonHours(params),
          _repository.getSalonReviews(params),
        ]);

        final services = results[0] as Either<Failure, List<SalonService>>;
        final barbers = results[1] as Either<Failure, List<Barber>>;
        final hours = results[2] as Either<Failure, List<BusinessHours>>;
        final reviews = results[3] as Either<Failure, List<Review>>;

        return Right(
          SalonDetail(
            salon: salon,
            services: services.getOrElse(() => []),
            barbers: barbers.getOrElse(() => []),
            hours: hours.getOrElse(() => []),
            reviews: reviews.getOrElse(() => []),
          ),
        );
      },
    );
  }
}

/// Aggregated salon detail with all related data.
class SalonDetail {
  const SalonDetail({
    required this.salon,
    this.services = const [],
    this.barbers = const [],
    this.hours = const [],
    this.reviews = const [],
  });

  final Salon salon;
  final List<SalonService> services;
  final List<Barber> barbers;
  final List<BusinessHours> hours;
  final List<Review> reviews;
}
