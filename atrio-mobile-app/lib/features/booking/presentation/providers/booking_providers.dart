import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/features/booking/data/datasources/mock_booking_datasource.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';
import 'package:flutter_templates/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:flutter_templates/features/booking/domain/usecases/create_booking_usecase.dart';
import 'package:flutter_templates/features/booking/domain/usecases/get_available_slots_usecase.dart';
import 'package:flutter_templates/features/booking/domain/usecases/get_my_bookings_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_providers.g.dart';

/// Provides the [BookingRepository] (mock for now).
@riverpod
BookingRepository bookingRepository(Ref ref) {
  return MockBookingRepository();
}

/// Provides the [CreateBookingUseCase].
@riverpod
CreateBookingUseCase createBookingUseCase(Ref ref) {
  return CreateBookingUseCase(ref.watch(bookingRepositoryProvider));
}

/// Provides the [GetMyBookingsUseCase].
@riverpod
GetMyBookingsUseCase getMyBookingsUseCase(Ref ref) {
  return GetMyBookingsUseCase(ref.watch(bookingRepositoryProvider));
}

/// Provides the [GetAvailableSlotsUseCase].
@riverpod
GetAvailableSlotsUseCase getAvailableSlotsUseCase(Ref ref) {
  return GetAvailableSlotsUseCase(ref.watch(bookingRepositoryProvider));
}

/// Provides the [CancelBookingUseCase].
@riverpod
CancelBookingUseCase cancelBookingUseCase(Ref ref) {
  return CancelBookingUseCase(ref.watch(bookingRepositoryProvider));
}
