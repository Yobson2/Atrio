// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_bookings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyBookingsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MyBookingsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MyBookingsState()';
  }
}

/// @nodoc
class $MyBookingsStateCopyWith<$Res> {
  $MyBookingsStateCopyWith(
      MyBookingsState _, $Res Function(MyBookingsState) __);
}

/// @nodoc

class MyBookingsInitial implements MyBookingsState {
  const MyBookingsInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MyBookingsInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MyBookingsState.initial()';
  }
}

/// @nodoc

class MyBookingsLoading implements MyBookingsState {
  const MyBookingsLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MyBookingsLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MyBookingsState.loading()';
  }
}

/// @nodoc

class MyBookingsLoaded implements MyBookingsState {
  const MyBookingsLoaded(final List<Booking> bookings) : _bookings = bookings;

  final List<Booking> _bookings;
  List<Booking> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  /// Create a copy of MyBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyBookingsLoadedCopyWith<MyBookingsLoaded> get copyWith =>
      _$MyBookingsLoadedCopyWithImpl<MyBookingsLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyBookingsLoaded &&
            const DeepCollectionEquality().equals(other._bookings, _bookings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_bookings));

  @override
  String toString() {
    return 'MyBookingsState.loaded(bookings: $bookings)';
  }
}

/// @nodoc
abstract mixin class $MyBookingsLoadedCopyWith<$Res>
    implements $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsLoadedCopyWith(
          MyBookingsLoaded value, $Res Function(MyBookingsLoaded) _then) =
      _$MyBookingsLoadedCopyWithImpl;
  @useResult
  $Res call({List<Booking> bookings});
}

/// @nodoc
class _$MyBookingsLoadedCopyWithImpl<$Res>
    implements $MyBookingsLoadedCopyWith<$Res> {
  _$MyBookingsLoadedCopyWithImpl(this._self, this._then);

  final MyBookingsLoaded _self;
  final $Res Function(MyBookingsLoaded) _then;

  /// Create a copy of MyBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bookings = null,
  }) {
    return _then(MyBookingsLoaded(
      null == bookings
          ? _self._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<Booking>,
    ));
  }
}

/// @nodoc

class MyBookingsError implements MyBookingsState {
  const MyBookingsError(this.message);

  final String message;

  /// Create a copy of MyBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyBookingsErrorCopyWith<MyBookingsError> get copyWith =>
      _$MyBookingsErrorCopyWithImpl<MyBookingsError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyBookingsError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'MyBookingsState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $MyBookingsErrorCopyWith<$Res>
    implements $MyBookingsStateCopyWith<$Res> {
  factory $MyBookingsErrorCopyWith(
          MyBookingsError value, $Res Function(MyBookingsError) _then) =
      _$MyBookingsErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$MyBookingsErrorCopyWithImpl<$Res>
    implements $MyBookingsErrorCopyWith<$Res> {
  _$MyBookingsErrorCopyWithImpl(this._self, this._then);

  final MyBookingsError _self;
  final $Res Function(MyBookingsError) _then;

  /// Create a copy of MyBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(MyBookingsError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
