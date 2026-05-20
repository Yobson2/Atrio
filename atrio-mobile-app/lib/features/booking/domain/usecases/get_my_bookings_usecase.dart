import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Fetches all bookings for the current user.
class GetMyBookingsUseCase extends UseCase<List<Booking>, NoParams> {
  const GetMyBookingsUseCase(this._repository);

  final BookingRepository _repository;

  @override
  Future<Either<Failure, List<Booking>>> call(NoParams params) {
    return _repository.getMyBookings();
  }
}
