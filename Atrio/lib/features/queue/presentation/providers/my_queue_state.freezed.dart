// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_queue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyQueueState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MyQueueState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MyQueueState()';
  }
}

/// @nodoc
class $MyQueueStateCopyWith<$Res> {
  $MyQueueStateCopyWith(MyQueueState _, $Res Function(MyQueueState) __);
}

/// @nodoc

class MyQueueInitial implements MyQueueState {
  const MyQueueInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MyQueueInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MyQueueState.initial()';
  }
}

/// @nodoc

class MyQueueLoading implements MyQueueState {
  const MyQueueLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MyQueueLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MyQueueState.loading()';
  }
}

/// @nodoc

class MyQueueInQueue implements MyQueueState {
  const MyQueueInQueue(this.entry);

  final QueueEntry entry;

  /// Create a copy of MyQueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyQueueInQueueCopyWith<MyQueueInQueue> get copyWith =>
      _$MyQueueInQueueCopyWithImpl<MyQueueInQueue>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyQueueInQueue &&
            (identical(other.entry, entry) || other.entry == entry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entry);

  @override
  String toString() {
    return 'MyQueueState.inQueue(entry: $entry)';
  }
}

/// @nodoc
abstract mixin class $MyQueueInQueueCopyWith<$Res>
    implements $MyQueueStateCopyWith<$Res> {
  factory $MyQueueInQueueCopyWith(
          MyQueueInQueue value, $Res Function(MyQueueInQueue) _then) =
      _$MyQueueInQueueCopyWithImpl;
  @useResult
  $Res call({QueueEntry entry});
}

/// @nodoc
class _$MyQueueInQueueCopyWithImpl<$Res>
    implements $MyQueueInQueueCopyWith<$Res> {
  _$MyQueueInQueueCopyWithImpl(this._self, this._then);

  final MyQueueInQueue _self;
  final $Res Function(MyQueueInQueue) _then;

  /// Create a copy of MyQueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? entry = null,
  }) {
    return _then(MyQueueInQueue(
      null == entry
          ? _self.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as QueueEntry,
    ));
  }
}

/// @nodoc

class MyQueueNotInQueue implements MyQueueState {
  const MyQueueNotInQueue();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MyQueueNotInQueue);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MyQueueState.notInQueue()';
  }
}

/// @nodoc

class MyQueueError implements MyQueueState {
  const MyQueueError(this.message);

  final String message;

  /// Create a copy of MyQueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyQueueErrorCopyWith<MyQueueError> get copyWith =>
      _$MyQueueErrorCopyWithImpl<MyQueueError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyQueueError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'MyQueueState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $MyQueueErrorCopyWith<$Res>
    implements $MyQueueStateCopyWith<$Res> {
  factory $MyQueueErrorCopyWith(
          MyQueueError value, $Res Function(MyQueueError) _then) =
      _$MyQueueErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$MyQueueErrorCopyWithImpl<$Res> implements $MyQueueErrorCopyWith<$Res> {
  _$MyQueueErrorCopyWithImpl(this._self, this._then);

  final MyQueueError _self;
  final $Res Function(MyQueueError) _then;

  /// Create a copy of MyQueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(MyQueueError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
