import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_bookings_notifier.g.dart';

/// Notifier for loading and managing user bookings.
@riverpod
class MyBookingsNotifier extends _$MyBookingsNotifier {
  @override
  MyBookingsState build() {
    loadBookings();
    return const MyBookingsState.loading();
  }

  /// Loads all bookings for the current user.
  Future<void> loadBookings() async {
    state = const MyBookingsState.loading();

    final useCase = ref.read(getMyBookingsUseCaseProvider);
    final result = await useCase(const NoParams());

    state = result.fold(
      (failure) => MyBookingsState.error(failure.message),
      MyBookingsState.loaded,
    );
  }

  /// Cancels a booking and reloads the list.
  Future<void> cancelBooking(String bookingId) async {
    final useCase = ref.read(cancelBookingUseCaseProvider);
    await useCase(bookingId);
    await loadBookings();
  }
}
