import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Creates a new booking.
class CreateBookingUseCase extends UseCase<Booking, CreateBookingParams> {
  const CreateBookingUseCase(this._repository);

  final BookingRepository _repository;

  @override
  Future<Either<Failure, Booking>> call(CreateBookingParams params) {
    return _repository.createBooking(
      salonId: params.salonId,
      serviceId: params.serviceId,
      barberId: params.barberId,
      date: params.date,
      startTime: params.startTime,
      notes: params.notes,
    );
  }
}

/// Parameters for [CreateBookingUseCase].
class CreateBookingParams {
  const CreateBookingParams({
    required this.salonId,
    required this.serviceId,
    required this.barberId,
    required this.date,
    required this.startTime,
    this.notes,
  });

  final String salonId;
  final String serviceId;
  final String barberId;
  final DateTime date;
  final String startTime;
  final String? notes;
}
