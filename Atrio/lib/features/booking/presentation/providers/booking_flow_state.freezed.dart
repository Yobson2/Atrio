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
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BookingFlowState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BookingFlowState()';
  }
}

/// @nodoc
class $BookingFlowStateCopyWith<$Res> {
  $BookingFlowStateCopyWith(
      BookingFlowState _, $Res Function(BookingFlowState) __);
}

/// @nodoc

class BookingFlowInitial implements BookingFlowState {
  const BookingFlowInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BookingFlowInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BookingFlowState.initial()';
  }
}

/// @nodoc

class BookingFlowSelectingService implements BookingFlowState {
  const BookingFlowSelectingService();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookingFlowSelectingService);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BookingFlowState.selectingService()';
  }
}

/// @nodoc

class BookingFlowSelectingBarber implements BookingFlowState {
  const BookingFlowSelectingBarber();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookingFlowSelectingBarber);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BookingFlowState.selectingBarber()';
  }
}

/// @nodoc

class BookingFlowSelectingTime implements BookingFlowState {
  const BookingFlowSelectingTime();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BookingFlowSelectingTime);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BookingFlowState.selectingTime()';
  }
}

/// @nodoc

class BookingFlowConfirming implements BookingFlowState {
  const BookingFlowConfirming();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BookingFlowConfirming);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BookingFlowState.confirming()';
  }
}

/// @nodoc

class BookingFlowLoading implements BookingFlowState {
  const BookingFlowLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BookingFlowLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BookingFlowState.loading()';
  }
}

/// @nodoc

class BookingFlowSuccess implements BookingFlowState {
  const BookingFlowSuccess(this.booking);

  final Booking booking;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookingFlowSuccessCopyWith<BookingFlowSuccess> get copyWith =>
      _$BookingFlowSuccessCopyWithImpl<BookingFlowSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookingFlowSuccess &&
            (identical(other.booking, booking) || other.booking == booking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, booking);

  @override
  String toString() {
    return 'BookingFlowState.success(booking: $booking)';
  }
}

/// @nodoc
abstract mixin class $BookingFlowSuccessCopyWith<$Res>
    implements $BookingFlowStateCopyWith<$Res> {
  factory $BookingFlowSuccessCopyWith(
          BookingFlowSuccess value, $Res Function(BookingFlowSuccess) _then) =
      _$BookingFlowSuccessCopyWithImpl;
  @useResult
  $Res call({Booking booking});
}

/// @nodoc
class _$BookingFlowSuccessCopyWithImpl<$Res>
    implements $BookingFlowSuccessCopyWith<$Res> {
  _$BookingFlowSuccessCopyWithImpl(this._self, this._then);

  final BookingFlowSuccess _self;
  final $Res Function(BookingFlowSuccess) _then;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? booking = null,
  }) {
    return _then(BookingFlowSuccess(
      null == booking
          ? _self.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as Booking,
    ));
  }
}

/// @nodoc

class BookingFlowError implements BookingFlowState {
  const BookingFlowError(this.message);

  final String message;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BookingFlowErrorCopyWith<BookingFlowError> get copyWith =>
      _$BookingFlowErrorCopyWithImpl<BookingFlowError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BookingFlowError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'BookingFlowState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $BookingFlowErrorCopyWith<$Res>
    implements $BookingFlowStateCopyWith<$Res> {
  factory $BookingFlowErrorCopyWith(
          BookingFlowError value, $Res Function(BookingFlowError) _then) =
      _$BookingFlowErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$BookingFlowErrorCopyWithImpl<$Res>
    implements $BookingFlowErrorCopyWith<$Res> {
  _$BookingFlowErrorCopyWithImpl(this._self, this._then);

  final BookingFlowError _self;
  final $Res Function(BookingFlowError) _then;

  /// Create a copy of BookingFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(BookingFlowError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
