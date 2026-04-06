import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/providers/network_providers.dart';
import 'package:flutter_templates/features/booking/data/datasources/booking_remote_datasource.dart';
// TODO(dev): Remove mock import when switching to the real API.
import 'package:flutter_templates/features/booking/data/datasources/mock_booking_remote_datasource.dart';
import 'package:flutter_templates/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:flutter_templates/features/booking/domain/repositories/booking_repository.dart';
import 'package:flutter_templates/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:flutter_templates/features/booking/domain/usecases/create_booking_usecase.dart';
import 'package:flutter_templates/features/booking/domain/usecases/get_available_slots_usecase.dart';
import 'package:flutter_templates/features/booking/domain/usecases/get_booking_detail_usecase.dart';
import 'package:flutter_templates/features/booking/domain/usecases/get_my_bookings_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_providers.g.dart';

/// Provides the [BookingRemoteDataSource].
///
/// Set `USE_MOCK_BOOKING=true` in `.env` to use mock data for testing.
/// TODO(dev): Remove the mock branch when switching to the real API.
@riverpod
BookingRemoteDataSource bookingRemoteDataSource(Ref ref) {
  final useMock = dotenv.get('USE_MOCK_BOOKING', fallback: 'false') == 'true';
  if (useMock) return MockBookingRemoteDataSource();
  return BookingRemoteDataSourceImpl(ref.watch(dioProvider));
}

/// Provides the [BookingRepository].
@riverpod
BookingRepository bookingRepository(Ref ref) {
  return BookingRepositoryImpl(
    remoteDataSource: ref.watch(bookingRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

/// Provides the [GetAvailableSlotsUseCase].
@riverpod
GetAvailableSlotsUseCase getAvailableSlotsUseCase(Ref ref) {
  return GetAvailableSlotsUseCase(ref.watch(bookingRepositoryProvider));
}

/// Provides the [CreateBookingUseCase].
@riverpod
CreateBookingUseCase createBookingUseCase(Ref ref) {
  return CreateBookingUseCase(ref.watch(bookingRepositoryProvider));
}

/// Provides the [CancelBookingUseCase].
@riverpod
CancelBookingUseCase cancelBookingUseCase(Ref ref) {
  return CancelBookingUseCase(ref.watch(bookingRepositoryProvider));
}

/// Provides the [GetMyBookingsUseCase].
@riverpod
GetMyBookingsUseCase getMyBookingsUseCase(Ref ref) {
  return GetMyBookingsUseCase(ref.watch(bookingRepositoryProvider));
}

/// Provides the [GetBookingDetailUseCase].
@riverpod
GetBookingDetailUseCase getBookingDetailUseCase(Ref ref) {
  return GetBookingDetailUseCase(ref.watch(bookingRepositoryProvider));
}
