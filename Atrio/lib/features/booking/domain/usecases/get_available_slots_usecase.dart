import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Gets available time slots for a salon service on a given date.
class GetAvailableSlotsUseCase
    extends UseCase<List<TimeSlot>, GetAvailableSlotsParams> {
  /// Creates a [GetAvailableSlotsUseCase].
  const GetAvailableSlotsUseCase(this._repository);

  final BookingRepository _repository;

  @override
  Future<Either<Failure, List<TimeSlot>>> call(
    GetAvailableSlotsParams params,
  ) {
    return _repository.getAvailableSlots(
      salonId: params.salonId,
      serviceId: params.serviceId,
      date: params.date,
      barberId: params.barberId,
    );
  }
}

/// Parameters for [GetAvailableSlotsUseCase].
class GetAvailableSlotsParams {
  /// Creates [GetAvailableSlotsParams].
  const GetAvailableSlotsParams({
    required this.salonId,
    required this.serviceId,
    required this.date,
    this.barberId,
  });

  /// Salon ID.
  final String salonId;

  /// Service ID.
  final String serviceId;

  /// Date to check availability.
  final DateTime date;

  /// Optional barber ID.
  final String? barberId;
}
