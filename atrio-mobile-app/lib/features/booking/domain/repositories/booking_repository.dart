import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';

/// Abstract booking repository defined in the domain layer.
abstract class BookingRepository {
  /// Gets available time slots for a salon/barber on a given date.
  Future<Either<Failure, List<TimeSlot>>> getAvailableSlots({
    required String salonId,
    required DateTime date,
    String? barberId,
  });

  /// Creates a new booking.
  Future<Either<Failure, Booking>> createBooking({
    required String salonId,
    required String serviceId,
    required String barberId,
    required DateTime date,
    required String startTime,
    String? notes,
  });

  /// Gets all bookings for the current user.
  Future<Either<Failure, List<Booking>>> getMyBookings();

  /// Gets a single booking by ID.
  Future<Either<Failure, Booking>> getBookingById(String id);

  /// Cancels a booking.
  Future<Either<Failure, void>> cancelBooking(String id);
}
