import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Cancels a booking by ID.
class CancelBookingUseCase extends UseCase<void, String> {
  const CancelBookingUseCase(this._repository);

  final BookingRepository _repository;

  @override
  Future<Either<Failure, void>> call(String params) {
    return _repository.cancelBooking(params);
  }
}
