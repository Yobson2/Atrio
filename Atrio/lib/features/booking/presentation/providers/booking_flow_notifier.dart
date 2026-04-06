import 'package:flutter_templates/features/booking/domain/entities/booking_type.dart';
import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';
import 'package:flutter_templates/features/booking/domain/usecases/create_booking_usecase.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_state.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_flow_notifier.g.dart';

/// Manages the multi-step booking flow state.
///
/// Tracks the selected service, barber, and time slot as the user
/// progresses through the booking steps.
@riverpod
class BookingFlowNotifier extends _$BookingFlowNotifier {
  String? _selectedSalonId;
  String? _selectedServiceId;
  String? _selectedServiceName;
  String? _selectedBarberId;
  String? _selectedBarberName;
  TimeSlot? _selectedTimeSlot;

  @override
  BookingFlowState build() => const BookingFlowState.initial();

  /// Returns the currently selected salon ID.
  String? get selectedSalonId => _selectedSalonId;

  /// Returns the currently selected service ID.
  String? get selectedServiceId => _selectedServiceId;

  /// Returns the currently selected service name.
  String? get selectedServiceName => _selectedServiceName;

  /// Returns the currently selected barber ID.
  String? get selectedBarberId => _selectedBarberId;

  /// Returns the currently selected barber name.
  String? get selectedBarberName => _selectedBarberName;

  /// Returns the currently selected time slot.
  TimeSlot? get selectedTimeSlot => _selectedTimeSlot;

  /// Starts the booking flow for a given salon.
  void startFlow(String salonId) {
    _selectedSalonId = salonId;
    _selectedServiceId = null;
    _selectedServiceName = null;
    _selectedBarberId = null;
    _selectedBarberName = null;
    _selectedTimeSlot = null;
    state = const BookingFlowState.selectingService();
  }

  /// Selects a service and advances to barber selection.
  void selectService({
    required String serviceId,
    required String serviceName,
  }) {
    _selectedServiceId = serviceId;
    _selectedServiceName = serviceName;
    state = const BookingFlowState.selectingBarber();
  }

  /// Selects a barber and advances to time selection.
  ///
  /// Pass null to skip barber preference.
  void selectBarber({String? barberId, String? barberName}) {
    _selectedBarberId = barberId;
    _selectedBarberName = barberName;
    state = const BookingFlowState.selectingTime();
  }

  /// Selects a time slot and advances to confirmation.
  void selectTime(TimeSlot timeSlot) {
    _selectedTimeSlot = timeSlot;
    state = const BookingFlowState.confirming();
  }

  /// Goes back to the previous step.
  void goBack() {
    switch (state) {
      case BookingFlowSelectingBarber():
        state = const BookingFlowState.selectingService();
      case BookingFlowSelectingTime():
        state = const BookingFlowState.selectingBarber();
      case BookingFlowConfirming():
        state = const BookingFlowState.selectingTime();
      case BookingFlowError():
        state = const BookingFlowState.confirming();
      default:
        break;
    }
  }

  /// Confirms and creates the booking.
  Future<void> confirm() async {
    if (_selectedSalonId == null || _selectedServiceId == null) {
      state = const BookingFlowState.error('Missing required selections');
      return;
    }

    state = const BookingFlowState.loading();
    try {
      final result = await ref.read(createBookingUseCaseProvider).call(
            CreateBookingParams(
              salonId: _selectedSalonId!,
              serviceId: _selectedServiceId!,
              type: _selectedTimeSlot != null
                  ? BookingType.reservation
                  : BookingType.walkIn,
              barberId: _selectedBarberId,
              scheduledAt: _selectedTimeSlot?.startTime,
            ),
          );
      state = result.fold(
        (failure) => BookingFlowState.error(failure.message),
        BookingFlowState.success,
      );
    } catch (e) {
      state = BookingFlowState.error(e.toString());
    }
  }

  /// Resets the flow to initial state.
  void reset() {
    _selectedSalonId = null;
    _selectedServiceId = null;
    _selectedServiceName = null;
    _selectedBarberId = null;
    _selectedBarberName = null;
    _selectedTimeSlot = null;
    state = const BookingFlowState.initial();
  }
}
