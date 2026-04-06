import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/owner/domain/entities/salon_stats.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';

/// Abstract owner repository defined in the domain layer.
///
/// Implemented by [OwnerRepositoryImpl] in the data layer.
abstract class OwnerRepository {
  /// Creates a new salon for the owner.
  Future<Either<Failure, Salon>> createSalon(Salon salon);

  /// Gets the salon owned by the current user.
  Future<Either<Failure, Salon>> getMySalon();

  /// Updates the salon information.
  Future<Either<Failure, Salon>> updateSalon(Salon salon);

  /// Creates a new service for the salon.
  Future<Either<Failure, SalonService>> createService(SalonService service);

  /// Updates an existing service.
  Future<Either<Failure, SalonService>> updateService(SalonService service);

  /// Deletes a service by its ID.
  Future<Either<Failure, void>> deleteService(String serviceId);

  /// Adds a new barber to the salon.
  Future<Either<Failure, Barber>> addBarber(Barber barber);

  /// Updates an existing barber.
  Future<Either<Failure, Barber>> updateBarber(Barber barber);

  /// Removes a barber by their ID.
  Future<Either<Failure, void>> removeBarber(String barberId);

  /// Gets salon statistics for the given date range.
  Future<Either<Failure, SalonStats>> getStats({
    DateTime? from,
    DateTime? to,
  });

  /// Gets today's bookings for the salon.
  Future<Either<Failure, List<Booking>>> getTodayBookings();

  /// Advances the queue (marks current as done, moves to next).
  Future<Either<Failure, void>> advanceQueue(String salonId);

  /// Skips a specific queue entry.
  Future<Either<Failure, void>> skipQueueEntry(String entryId);

  /// Updates the status of a booking.
  Future<Either<Failure, void>> updateBookingStatus(
    String bookingId,
    BookingStatus status,
  );
}
