import 'package:flutter_templates/features/booking/domain/usecases/create_booking_usecase.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_state.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_flow_notifier.g.dart';

/// Notifier managing the multi-step booking flow.
///
/// Accumulates selections across 4 steps: service → barber → time → confirm.
@Riverpod(keepAlive: true)
class BookingFlowNotifier extends _$BookingFlowNotifier {
  @override
  BookingFlowState build() => const BookingFlowState();

  /// Initialize the flow with a salon.
  void startBooking(Salon salon) {
    state = BookingFlowState(salon: salon);
  }

  /// Step 1: Select a service.
  void selectService(SalonService service) {
    state = state.copyWith(selectedService: service, currentStep: 1);
  }

  /// Step 2: Select a barber.
  void selectBarber(Barber? barber) {
    state = state.copyWith(selectedBarber: barber, currentStep: 2);
  }

  /// Step 3: Select date and time.
  void selectDateTime(DateTime date, String timeSlot) {
    state = state.copyWith(
      selectedDate: date,
      selectedTimeSlot: timeSlot,
      currentStep: 3,
    );
  }

  /// Update notes.
  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  /// Step 4: Confirm and submit the booking.
  Future<void> confirmBooking() async {
    if (state.salon == null ||
        state.selectedService == null ||
        state.selectedDate == null ||
        state.selectedTimeSlot == null) {
      return;
    }

    state = state.copyWith(isSubmitting: true, error: null);

    final useCase = ref.read(createBookingUseCaseProvider);
    final result = await useCase(
      CreateBookingParams(
        salonId: state.salon!.id,
        serviceId: state.selectedService!.id,
        barberId: state.selectedBarber?.id ?? 'any',
        date: state.selectedDate!,
        startTime: state.selectedTimeSlot!,
        notes: state.notes,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isSubmitting: false,
        error: failure.message,
      ),
      (booking) => state = state.copyWith(
        isSubmitting: false,
        isCompleted: true,
        confirmedBookingId: booking.id,
      ),
    );
  }

  /// Reset the flow for a new booking.
  void reset() {
    state = const BookingFlowState();
  }
}
