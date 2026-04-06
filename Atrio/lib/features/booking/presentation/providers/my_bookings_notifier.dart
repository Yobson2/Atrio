import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_bookings_notifier.g.dart';

/// Manages the user's bookings list state.
@riverpod
class MyBookingsNotifier extends _$MyBookingsNotifier {
  @override
  MyBookingsState build() => const MyBookingsState.initial();

  /// Loads all bookings for the current user.
  Future<void> loadBookings() async {
    state = const MyBookingsState.loading();
    try {
      final result =
          await ref.read(getMyBookingsUseCaseProvider).call(const NoParams());
      state = result.fold(
        (failure) => MyBookingsState.error(failure.message),
        MyBookingsState.loaded,
      );
    } catch (e) {
      state = MyBookingsState.error(e.toString());
    }
  }

  /// Cancels a booking and reloads the list.
  Future<void> cancelBooking(String bookingId) async {
    state = const MyBookingsState.loading();
    try {
      final result =
          await ref.read(cancelBookingUseCaseProvider).call(bookingId);
      await result.fold(
        (failure) async {
          state = MyBookingsState.error(failure.message);
        },
        (_) async {
          await loadBookings();
        },
      );
    } catch (e) {
      state = MyBookingsState.error(e.toString());
    }
  }
}
