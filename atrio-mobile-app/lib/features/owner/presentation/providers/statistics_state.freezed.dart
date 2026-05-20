// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatisticsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StatisticsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StatisticsState()';
  }
}

/// @nodoc
class $StatisticsStateCopyWith<$Res> {
  $StatisticsStateCopyWith(
      StatisticsState _, $Res Function(StatisticsState) __);
}

/// @nodoc

class StatisticsInitial implements StatisticsState {
  const StatisticsInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StatisticsInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StatisticsState.initial()';
  }
}

/// @nodoc

class StatisticsLoading implements StatisticsState {
  const StatisticsLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StatisticsLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StatisticsState.loading()';
  }
}

/// @nodoc

class StatisticsLoaded implements StatisticsState {
  const StatisticsLoaded(this.stats);

  final PerformanceStats stats;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticsLoadedCopyWith<StatisticsLoaded> get copyWith =>
      _$StatisticsLoadedCopyWithImpl<StatisticsLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticsLoaded &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stats);

  @override
  String toString() {
    return 'StatisticsState.loaded(stats: $stats)';
  }
}

/// @nodoc
abstract mixin class $StatisticsLoadedCopyWith<$Res>
    implements $StatisticsStateCopyWith<$Res> {
  factory $StatisticsLoadedCopyWith(
          StatisticsLoaded value, $Res Function(StatisticsLoaded) _then) =
      _$StatisticsLoadedCopyWithImpl;
  @useResult
  $Res call({PerformanceStats stats});
}

/// @nodoc
class _$StatisticsLoadedCopyWithImpl<$Res>
    implements $StatisticsLoadedCopyWith<$Res> {
  _$StatisticsLoadedCopyWithImpl(this._self, this._then);

  final StatisticsLoaded _self;
  final $Res Function(StatisticsLoaded) _then;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stats = null,
  }) {
    return _then(StatisticsLoaded(
      null == stats
          ? _self.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as PerformanceStats,
    ));
  }
}

/// @nodoc

class StatisticsError implements StatisticsState {
  const StatisticsError(this.message);

  final String message;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatisticsErrorCopyWith<StatisticsError> get copyWith =>
      _$StatisticsErrorCopyWithImpl<StatisticsError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatisticsError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'StatisticsState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $StatisticsErrorCopyWith<$Res>
    implements $StatisticsStateCopyWith<$Res> {
  factory $StatisticsErrorCopyWith(
          StatisticsError value, $Res Function(StatisticsError) _then) =
      _$StatisticsErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$StatisticsErrorCopyWithImpl<$Res>
    implements $StatisticsErrorCopyWith<$Res> {
  _$StatisticsErrorCopyWithImpl(this._self, this._then);

  final StatisticsError _self;
  final $Res Function(StatisticsError) _then;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(StatisticsError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
