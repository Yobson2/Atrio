import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Fetches available time slots for a given salon, date, and optional barber.
class GetAvailableSlotsUseCase
    extends UseCase<List<TimeSlot>, GetAvailableSlotsParams> {
  const GetAvailableSlotsUseCase(this._repository);

  final BookingRepository _repository;

  @override
  Future<Either<Failure, List<TimeSlot>>> call(
    GetAvailableSlotsParams params,
  ) {
    return _repository.getAvailableSlots(
      salonId: params.salonId,
      date: params.date,
      barberId: params.barberId,
    );
  }
}

/// Parameters for [GetAvailableSlotsUseCase].
class GetAvailableSlotsParams {
  const GetAvailableSlotsParams({
    required this.salonId,
    required this.date,
    this.barberId,
  });

  final String salonId;
  final DateTime date;
  final String? barberId;
}
