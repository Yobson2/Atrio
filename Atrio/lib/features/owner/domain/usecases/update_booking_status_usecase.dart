import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';

/// Updates the status of a booking.
class UpdateBookingStatusUseCase
    extends UseCase<void, UpdateBookingStatusParams> {
  /// Creates an [UpdateBookingStatusUseCase].
  const UpdateBookingStatusUseCase(this._repository);

  final OwnerRepository _repository;

  @override
  Future<Either<Failure, void>> call(UpdateBookingStatusParams params) {
    return _repository.updateBookingStatus(params.bookingId, params.status);
  }
}

/// Parameters for [UpdateBookingStatusUseCase].
class UpdateBookingStatusParams {
  /// Creates [UpdateBookingStatusParams].
  const UpdateBookingStatusParams({
    required this.bookingId,
    required this.status,
  });

  /// The booking ID to update.
  final String bookingId;

  /// The new status.
  final BookingStatus status;
}
