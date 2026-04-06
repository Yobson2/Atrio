// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barber_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BarberManagementState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BarberManagementState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BarberManagementState()';
  }
}

/// @nodoc
class $BarberManagementStateCopyWith<$Res> {
  $BarberManagementStateCopyWith(
      BarberManagementState _, $Res Function(BarberManagementState) __);
}

/// @nodoc

class BarberManagementInitial implements BarberManagementState {
  const BarberManagementInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BarberManagementInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BarberManagementState.initial()';
  }
}

/// @nodoc

class BarberManagementLoading implements BarberManagementState {
  const BarberManagementLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BarberManagementLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BarberManagementState.loading()';
  }
}

/// @nodoc

class BarberManagementLoaded implements BarberManagementState {
  const BarberManagementLoaded(final List<Barber> barbers) : _barbers = barbers;

  final List<Barber> _barbers;
  List<Barber> get barbers {
    if (_barbers is EqualUnmodifiableListView) return _barbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_barbers);
  }

  /// Create a copy of BarberManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BarberManagementLoadedCopyWith<BarberManagementLoaded> get copyWith =>
      _$BarberManagementLoadedCopyWithImpl<BarberManagementLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BarberManagementLoaded &&
            const DeepCollectionEquality().equals(other._barbers, _barbers));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_barbers));

  @override
  String toString() {
    return 'BarberManagementState.loaded(barbers: $barbers)';
  }
}

/// @nodoc
abstract mixin class $BarberManagementLoadedCopyWith<$Res>
    implements $BarberManagementStateCopyWith<$Res> {
  factory $BarberManagementLoadedCopyWith(BarberManagementLoaded value,
          $Res Function(BarberManagementLoaded) _then) =
      _$BarberManagementLoadedCopyWithImpl;
  @useResult
  $Res call({List<Barber> barbers});
}

/// @nodoc
class _$BarberManagementLoadedCopyWithImpl<$Res>
    implements $BarberManagementLoadedCopyWith<$Res> {
  _$BarberManagementLoadedCopyWithImpl(this._self, this._then);

  final BarberManagementLoaded _self;
  final $Res Function(BarberManagementLoaded) _then;

  /// Create a copy of BarberManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? barbers = null,
  }) {
    return _then(BarberManagementLoaded(
      null == barbers
          ? _self._barbers
          : barbers // ignore: cast_nullable_to_non_nullable
              as List<Barber>,
    ));
  }
}

/// @nodoc

class BarberManagementSuccess implements BarberManagementState {
  const BarberManagementSuccess(this.message);

  final String message;

  /// Create a copy of BarberManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BarberManagementSuccessCopyWith<BarberManagementSuccess> get copyWith =>
      _$BarberManagementSuccessCopyWithImpl<BarberManagementSuccess>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BarberManagementSuccess &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'BarberManagementState.success(message: $message)';
  }
}

/// @nodoc
abstract mixin class $BarberManagementSuccessCopyWith<$Res>
    implements $BarberManagementStateCopyWith<$Res> {
  factory $BarberManagementSuccessCopyWith(BarberManagementSuccess value,
          $Res Function(BarberManagementSuccess) _then) =
      _$BarberManagementSuccessCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$BarberManagementSuccessCopyWithImpl<$Res>
    implements $BarberManagementSuccessCopyWith<$Res> {
  _$BarberManagementSuccessCopyWithImpl(this._self, this._then);

  final BarberManagementSuccess _self;
  final $Res Function(BarberManagementSuccess) _then;

  /// Create a copy of BarberManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(BarberManagementSuccess(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class BarberManagementError implements BarberManagementState {
  const BarberManagementError(this.message);

  final String message;

  /// Create a copy of BarberManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BarberManagementErrorCopyWith<BarberManagementError> get copyWith =>
      _$BarberManagementErrorCopyWithImpl<BarberManagementError>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BarberManagementError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'BarberManagementState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $BarberManagementErrorCopyWith<$Res>
    implements $BarberManagementStateCopyWith<$Res> {
  factory $BarberManagementErrorCopyWith(BarberManagementError value,
          $Res Function(BarberManagementError) _then) =
      _$BarberManagementErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$BarberManagementErrorCopyWithImpl<$Res>
    implements $BarberManagementErrorCopyWith<$Res> {
  _$BarberManagementErrorCopyWithImpl(this._self, this._then);

  final BarberManagementError _self;
  final $Res Function(BarberManagementError) _then;

  /// Create a copy of BarberManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(BarberManagementError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
