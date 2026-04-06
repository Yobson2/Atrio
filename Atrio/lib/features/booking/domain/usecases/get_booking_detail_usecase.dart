import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';

/// Gets a single booking by ID.
class GetBookingDetailUseCase extends UseCase<Booking, String> {
  /// Creates a [GetBookingDetailUseCase].
  const GetBookingDetailUseCase(this._repository);

  final BookingRepository _repository;

  @override
  Future<Either<Failure, Booking>> call(String params) {
    return _repository.getBookingById(params);
  }
}
