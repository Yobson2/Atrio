// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salon_setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalonSetupState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonSetupState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonSetupState()';
  }
}

/// @nodoc
class $SalonSetupStateCopyWith<$Res> {
  $SalonSetupStateCopyWith(
      SalonSetupState _, $Res Function(SalonSetupState) __);
}

/// @nodoc

class SalonSetupInitial implements SalonSetupState {
  const SalonSetupInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonSetupInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonSetupState.initial()';
  }
}

/// @nodoc

class SalonSetupLoading implements SalonSetupState {
  const SalonSetupLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonSetupLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonSetupState.loading()';
  }
}

/// @nodoc

class SalonSetupSuccess implements SalonSetupState {
  const SalonSetupSuccess(this.salon);

  final Salon salon;

  /// Create a copy of SalonSetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonSetupSuccessCopyWith<SalonSetupSuccess> get copyWith =>
      _$SalonSetupSuccessCopyWithImpl<SalonSetupSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonSetupSuccess &&
            (identical(other.salon, salon) || other.salon == salon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, salon);

  @override
  String toString() {
    return 'SalonSetupState.success(salon: $salon)';
  }
}

/// @nodoc
abstract mixin class $SalonSetupSuccessCopyWith<$Res>
    implements $SalonSetupStateCopyWith<$Res> {
  factory $SalonSetupSuccessCopyWith(
          SalonSetupSuccess value, $Res Function(SalonSetupSuccess) _then) =
      _$SalonSetupSuccessCopyWithImpl;
  @useResult
  $Res call({Salon salon});
}

/// @nodoc
class _$SalonSetupSuccessCopyWithImpl<$Res>
    implements $SalonSetupSuccessCopyWith<$Res> {
  _$SalonSetupSuccessCopyWithImpl(this._self, this._then);

  final SalonSetupSuccess _self;
  final $Res Function(SalonSetupSuccess) _then;

  /// Create a copy of SalonSetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? salon = null,
  }) {
    return _then(SalonSetupSuccess(
      null == salon
          ? _self.salon
          : salon // ignore: cast_nullable_to_non_nullable
              as Salon,
    ));
  }
}

/// @nodoc

class SalonSetupError implements SalonSetupState {
  const SalonSetupError(this.message);

  final String message;

  /// Create a copy of SalonSetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonSetupErrorCopyWith<SalonSetupError> get copyWith =>
      _$SalonSetupErrorCopyWithImpl<SalonSetupError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonSetupError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SalonSetupState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SalonSetupErrorCopyWith<$Res>
    implements $SalonSetupStateCopyWith<$Res> {
  factory $SalonSetupErrorCopyWith(
          SalonSetupError value, $Res Function(SalonSetupError) _then) =
      _$SalonSetupErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SalonSetupErrorCopyWithImpl<$Res>
    implements $SalonSetupErrorCopyWith<$Res> {
  _$SalonSetupErrorCopyWithImpl(this._self, this._then);

  final SalonSetupError _self;
  final $Res Function(SalonSetupError) _then;

  /// Create a copy of SalonSetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SalonSetupError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
