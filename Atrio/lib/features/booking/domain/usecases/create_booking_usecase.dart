import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_type.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Creates a new booking (walk-in or reservation).
class CreateBookingUseCase extends UseCase<Booking, CreateBookingParams> {
  /// Creates a [CreateBookingUseCase].
  const CreateBookingUseCase(this._repository);

  final BookingRepository _repository;

  @override
  Future<Either<Failure, Booking>> call(CreateBookingParams params) {
    return _repository.createBooking(
      salonId: params.salonId,
      serviceId: params.serviceId,
      type: params.type,
      barberId: params.barberId,
      scheduledAt: params.scheduledAt,
    );
  }
}

/// Parameters for [CreateBookingUseCase].
class CreateBookingParams {
  /// Creates [CreateBookingParams].
  const CreateBookingParams({
    required this.salonId,
    required this.serviceId,
    required this.type,
    this.barberId,
    this.scheduledAt,
  });

  /// Salon ID.
  final String salonId;

  /// Service ID.
  final String serviceId;

  /// Booking type (walk-in or reservation).
  final BookingType type;

  /// Optional barber ID.
  final String? barberId;

  /// Optional scheduled date/time (required for reservations).
  final DateTime? scheduledAt;
}
