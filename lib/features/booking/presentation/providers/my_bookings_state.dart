import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_bookings_state.freezed.dart';

/// State for the my bookings screen.
@freezed
sealed class MyBookingsState with _$MyBookingsState {
  const factory MyBookingsState.initial() = MyBookingsInitial;
  const factory MyBookingsState.loading() = MyBookingsLoading;
  const factory MyBookingsState.loaded(List<Booking> bookings) =
      MyBookingsLoaded;
  const factory MyBookingsState.error(String message) = MyBookingsError;
}
