import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Gets today's bookings for the salon.
class GetTodayBookingsUseCase extends UseCase<List<Booking>, NoParams> {
  /// Creates a [GetTodayBookingsUseCase].
  const GetTodayBookingsUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, List<Booking>>> call(NoParams params) {
    return _repository.getTodayBookings();
  }
}
