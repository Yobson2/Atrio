import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_filter.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';

/// Abstract salon repository defined in the domain layer.
abstract class SalonRepository {
  /// Gets nearby salons based on location and optional filters.
  Future<Either<Failure, List<Salon>>> getNearbySalons({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
    SalonFilter? filter,
  });

  /// Gets a single salon by ID.
  Future<Either<Failure, Salon>> getSalonById(String id);

  /// Gets all services offered by a salon.
  Future<Either<Failure, List<SalonService>>> getSalonServices(String salonId);

  /// Gets all barbers working at a salon.
  Future<Either<Failure, List<Barber>>> getSalonBarbers(String salonId);

  /// Gets all reviews for a salon.
  Future<Either<Failure, List<Review>>> getSalonReviews(String salonId);

  /// Adds a review for a salon.
  Future<Either<Failure, void>> addReview({
    required String salonId,
    required double rating,
    String? comment,
  });
}
