import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_bookings_state.freezed.dart';

/// Represents the state for the user's bookings list.
@freezed
sealed class MyBookingsState with _$MyBookingsState {
  /// Initial state before loading.
  const factory MyBookingsState.initial() = MyBookingsInitial;

  /// Loading bookings.
  const factory MyBookingsState.loading() = MyBookingsLoading;

  /// Bookings loaded successfully.
  const factory MyBookingsState.loaded(List<Booking> bookings) =
      MyBookingsLoaded;

  /// An error occurred.
  const factory MyBookingsState.error(String message) = MyBookingsError;
}
