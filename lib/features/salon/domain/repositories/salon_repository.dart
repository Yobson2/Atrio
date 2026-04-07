import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/business_hours.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';

/// Abstract salon repository defined in the domain layer.
abstract class SalonRepository {
  /// Gets all salons, optionally filtered by search query.
  Future<Either<Failure, List<Salon>>> getSalons({String? query});

  /// Gets a single salon by ID.
  Future<Either<Failure, Salon>> getSalonById(String id);

  /// Gets services offered by a salon.
  Future<Either<Failure, List<SalonService>>> getSalonServices(String salonId);

  /// Gets barbers working at a salon.
  Future<Either<Failure, List<Barber>>> getSalonBarbers(String salonId);

  /// Gets business hours for a salon.
  Future<Either<Failure, List<BusinessHours>>> getSalonHours(String salonId);

  /// Gets reviews for a salon.
  Future<Either<Failure, List<Review>>> getSalonReviews(String salonId);
}
