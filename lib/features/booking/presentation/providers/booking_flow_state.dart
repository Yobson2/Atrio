import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_flow_state.freezed.dart';

/// State tracking progress through the 4-step booking flow.
@freezed
abstract class BookingFlowState with _$BookingFlowState {
  const factory BookingFlowState({
    Salon? salon,
    SalonService? selectedService,
    Barber? selectedBarber,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    String? notes,
    @Default(0) int currentStep,
    @Default(false) bool isSubmitting,
    @Default(false) bool isCompleted,
    String? error,
    String? confirmedBookingId,
  }) = _BookingFlowState;
}
