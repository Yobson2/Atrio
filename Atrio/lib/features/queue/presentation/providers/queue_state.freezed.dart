// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueueState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is QueueState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'QueueState()';
  }
}

/// @nodoc
class $QueueStateCopyWith<$Res> {
  $QueueStateCopyWith(QueueState _, $Res Function(QueueState) __);
}

/// @nodoc

class QueueInitial implements QueueState {
  const QueueInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is QueueInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'QueueState.initial()';
  }
}

/// @nodoc

class QueueLoading implements QueueState {
  const QueueLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is QueueLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'QueueState.loading()';
  }
}

/// @nodoc

class QueueLive implements QueueState {
  const QueueLive(this.status);

  final QueueStatus status;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QueueLiveCopyWith<QueueLive> get copyWith =>
      _$QueueLiveCopyWithImpl<QueueLive>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QueueLive &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'QueueState.live(status: $status)';
  }
}

/// @nodoc
abstract mixin class $QueueLiveCopyWith<$Res>
    implements $QueueStateCopyWith<$Res> {
  factory $QueueLiveCopyWith(QueueLive value, $Res Function(QueueLive) _then) =
      _$QueueLiveCopyWithImpl;
  @useResult
  $Res call({QueueStatus status});
}

/// @nodoc
class _$QueueLiveCopyWithImpl<$Res> implements $QueueLiveCopyWith<$Res> {
  _$QueueLiveCopyWithImpl(this._self, this._then);

  final QueueLive _self;
  final $Res Function(QueueLive) _then;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
  }) {
    return _then(QueueLive(
      null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueueStatus,
    ));
  }
}

/// @nodoc

class QueueError implements QueueState {
  const QueueError(this.message);

  final String message;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QueueErrorCopyWith<QueueError> get copyWith =>
      _$QueueErrorCopyWithImpl<QueueError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QueueError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'QueueState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $QueueErrorCopyWith<$Res>
    implements $QueueStateCopyWith<$Res> {
  factory $QueueErrorCopyWith(
          QueueError value, $Res Function(QueueError) _then) =
      _$QueueErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$QueueErrorCopyWithImpl<$Res> implements $QueueErrorCopyWith<$Res> {
  _$QueueErrorCopyWithImpl(this._self, this._then);

  final QueueError _self;
  final $Res Function(QueueError) _then;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(QueueError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
