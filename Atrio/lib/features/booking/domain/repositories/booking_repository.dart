import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_type.dart';
import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';

/// Abstract booking repository defined in the domain layer.
///
/// Implemented by [BookingRepositoryImpl] in the data layer.
abstract class BookingRepository {
  /// Gets available time slots for a given salon, service, and date.
  Future<Either<Failure, List<TimeSlot>>> getAvailableSlots({
    required String salonId,
    required String serviceId,
    required DateTime date,
    String? barberId,
  });

  /// Creates a new booking.
  Future<Either<Failure, Booking>> createBooking({
    required String salonId,
    required String serviceId,
    required BookingType type,
    String? barberId,
    DateTime? scheduledAt,
  });

  /// Cancels an existing booking.
  Future<Either<Failure, Booking>> cancelBooking(String bookingId);

  /// Gets all bookings for the current user.
  Future<Either<Failure, List<Booking>>> getMyBookings();

  /// Gets a single booking by ID.
  Future<Either<Failure, Booking>> getBookingById(String id);
}
