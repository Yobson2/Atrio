import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_flow_state.freezed.dart';

/// Represents the state of the multi-step booking flow.
@freezed
sealed class BookingFlowState with _$BookingFlowState {
  /// Initial state before the flow starts.
  const factory BookingFlowState.initial() = BookingFlowInitial;

  /// User is selecting a service.
  const factory BookingFlowState.selectingService() =
      BookingFlowSelectingService;

  /// User is selecting a barber.
  const factory BookingFlowState.selectingBarber() = BookingFlowSelectingBarber;

  /// User is selecting a time slot.
  const factory BookingFlowState.selectingTime() = BookingFlowSelectingTime;

  /// User is reviewing and confirming the booking.
  const factory BookingFlowState.confirming() = BookingFlowConfirming;

  /// Booking is being created.
  const factory BookingFlowState.loading() = BookingFlowLoading;

  /// Booking was created successfully.
  const factory BookingFlowState.success(Booking booking) = BookingFlowSuccess;

  /// An error occurred during the flow.
  const factory BookingFlowState.error(String message) = BookingFlowError;
}
