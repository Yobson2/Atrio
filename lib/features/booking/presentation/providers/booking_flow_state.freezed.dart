// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_flow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingFlowState {
  Salon? get salon;
  SalonService? get selectedService;
  Barber? get selectedBarber;
  DateTime? get selectedDate;
  String? get selectedTimeSlot;
  String? get notes;
  int get currentStep;
  bool get isSubmitting;
  bool get isCompleted;
  String? get error;
  String? get confirmedBookingId;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookingFlowStateCopyWith<BookingFlowState> get copyWith =>
      _$BookingFlowStateCopyWithImpl<BookingFlowState>(
          this as BookingFlowState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookingFlowState &&
            (identical(other.salon, salon) || other.salon == salon) &&
            (identical(other.selectedService, selectedService) ||
                other.selectedService == selectedService) &&
            (identical(other.selectedBarber, selectedBarber) ||
                other.selectedBarber == selectedBarber) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedTimeSlot, selectedTimeSlot) ||
                other.selectedTimeSlot == selectedTimeSlot) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.confirmedBookingId, confirmedBookingId) ||
                other.confirmedBookingId == confirmedBookingId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      salon,
      selectedService,
      selectedBarber,
      selectedDate,
      selectedTimeSlot,
      notes,
      currentStep,
      isSubmitting,
      isCompleted,
      error,
      confirmedBookingId);

  @override
  String toString() {
    return 'BookingFlowState(salon: $salon, selectedService: $selectedService, selectedBarber: $selectedBarber, selectedDate: $selectedDate, selectedTimeSlot: $selectedTimeSlot, notes: $notes, currentStep: $currentStep, isSubmitting: $isSubmitting, isCompleted: $isCompleted, error: $error, confirmedBookingId: $confirmedBookingId)';
  }
}

/// @nodoc
abstract mixin class $BookingFlowStateCopyWith<$Res> {
  factory $BookingFlowStateCopyWith(
          BookingFlowState value, $Res Function(BookingFlowState) _then) =
      _$BookingFlowStateCopyWithImpl;
  @useResult
  $Res call(
      {Salon? salon,
      SalonService? selectedService,
      Barber? selectedBarber,
      DateTime? selectedDate,
      String? selectedTimeSlot,
      String? notes,
      int currentStep,
      bool isSubmitting,
      bool isCompleted,
      String? error,
      String? confirmedBookingId});
}

/// @nodoc
class _$BookingFlowStateCopyWithImpl<$Res>
    implements $BookingFlowStateCopyWith<$Res> {
  _$BookingFlowStateCopyWithImpl(this._self, this._then);

  final BookingFlowState _self;
  final $Res Function(BookingFlowState) _then;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salon = freezed,
    Object? selectedService = freezed,
    Object? selectedBarber = freezed,
    Object? selectedDate = freezed,
    Object? selectedTimeSlot = freezed,
    Object? notes = freezed,
    Object? currentStep = null,
    Object? isSubmitting = null,
    Object? isCompleted = null,
    Object? error = freezed,
    Object? confirmedBookingId = freezed,
  }) {
    return _then(_self.copyWith(
      salon: freezed == salon
          ? _self.salon
          : salon // ignore: cast_nullable_to_non_nullable
              as Salon?,
      selectedService: freezed == selectedService
          ? _self.selectedService
          : selectedService // ignore: cast_nullable_to_non_nullable
              as SalonService?,
      selectedBarber: freezed == selectedBarber
          ? _self.selectedBarber
          : selectedBarber // ignore: cast_nullable_to_non_nullable
              as Barber?,
      selectedDate: freezed == selectedDate
          ? _self.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedTimeSlot: freezed == selectedTimeSlot
          ? _self.selectedTimeSlot
          : selectedTimeSlot // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedBookingId: freezed == confirmedBookingId
          ? _self.confirmedBookingId
          : confirmedBookingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _BookingFlowState implements BookingFlowState {
  const _BookingFlowState(
      {this.salon,
      this.selectedService,
      this.selectedBarber,
      this.selectedDate,
      this.selectedTimeSlot,
      this.notes,
      this.currentStep = 0,
      this.isSubmitting = false,
      this.isCompleted = false,
      this.error,
      this.confirmedBookingId});

  @override
  final Salon? salon;
  @override
  final SalonService? selectedService;
  @override
  final Barber? selectedBarber;
  @override
  final DateTime? selectedDate;
  @override
  final String? selectedTimeSlot;
  @override
  final String? notes;
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final String? error;
  @override
  final String? confirmedBookingId;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BookingFlowStateCopyWith<_BookingFlowState> get copyWith =>
      __$BookingFlowStateCopyWithImpl<_BookingFlowState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookingFlowState &&
            (identical(other.salon, salon) || other.salon == salon) &&
            (identical(other.selectedService, selectedService) ||
                other.selectedService == selectedService) &&
            (identical(other.selectedBarber, selectedBarber) ||
                other.selectedBarber == selectedBarber) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedTimeSlot, selectedTimeSlot) ||
                other.selectedTimeSlot == selectedTimeSlot) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.confirmedBookingId, confirmedBookingId) ||
                other.confirmedBookingId == confirmedBookingId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      salon,
      selectedService,
      selectedBarber,
      selectedDate,
      selectedTimeSlot,
      notes,
      currentStep,
      isSubmitting,
      isCompleted,
      error,
      confirmedBookingId);

  @override
  String toString() {
    return 'BookingFlowState(salon: $salon, selectedService: $selectedService, selectedBarber: $selectedBarber, selectedDate: $selectedDate, selectedTimeSlot: $selectedTimeSlot, notes: $notes, currentStep: $currentStep, isSubmitting: $isSubmitting, isCompleted: $isCompleted, error: $error, confirmedBookingId: $confirmedBookingId)';
  }
}

/// @nodoc
abstract mixin class _$BookingFlowStateCopyWith<$Res>
    implements $BookingFlowStateCopyWith<$Res> {
  factory _$BookingFlowStateCopyWith(
          _BookingFlowState value, $Res Function(_BookingFlowState) _then) =
      __$BookingFlowStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Salon? salon,
      SalonService? selectedService,
      Barber? selectedBarber,
      DateTime? selectedDate,
      String? selectedTimeSlot,
      String? notes,
      int currentStep,
      bool isSubmitting,
      bool isCompleted,
      String? error,
      String? confirmedBookingId});
}

/// @nodoc
class __$BookingFlowStateCopyWithImpl<$Res>
    implements _$BookingFlowStateCopyWith<$Res> {
  __$BookingFlowStateCopyWithImpl(this._self, this._then);

  final _BookingFlowState _self;
  final $Res Function(_BookingFlowState) _then;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? salon = freezed,
    Object? selectedService = freezed,
    Object? selectedBarber = freezed,
    Object? selectedDate = freezed,
    Object? selectedTimeSlot = freezed,
    Object? notes = freezed,
    Object? currentStep = null,
    Object? isSubmitting = null,
    Object? isCompleted = null,
    Object? error = freezed,
    Object? confirmedBookingId = freezed,
  }) {
    return _then(_BookingFlowState(
      salon: freezed == salon
          ? _self.salon
          : salon // ignore: cast_nullable_to_non_nullable
              as Salon?,
      selectedService: freezed == selectedService
          ? _self.selectedService
          : selectedService // ignore: cast_nullable_to_non_nullable
              as SalonService?,
      selectedBarber: freezed == selectedBarber
          ? _self.selectedBarber
          : selectedBarber // ignore: cast_nullable_to_non_nullable
              as Barber?,
      selectedDate: freezed == selectedDate
          ? _self.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedTimeSlot: freezed == selectedTimeSlot
          ? _self.selectedTimeSlot
          : selectedTimeSlot // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedBookingId: freezed == confirmedBookingId
          ? _self.confirmedBookingId
          : confirmedBookingId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
