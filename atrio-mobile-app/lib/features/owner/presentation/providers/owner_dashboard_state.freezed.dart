// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OwnerDashboardState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OwnerDashboardState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OwnerDashboardState()';
  }
}

/// @nodoc
class $OwnerDashboardStateCopyWith<$Res> {
  $OwnerDashboardStateCopyWith(
      OwnerDashboardState _, $Res Function(OwnerDashboardState) __);
}

/// @nodoc

class OwnerDashboardInitial implements OwnerDashboardState {
  const OwnerDashboardInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OwnerDashboardInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OwnerDashboardState.initial()';
  }
}

/// @nodoc

class OwnerDashboardLoading implements OwnerDashboardState {
  const OwnerDashboardLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OwnerDashboardLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OwnerDashboardState.loading()';
  }
}

/// @nodoc

class OwnerDashboardLoaded implements OwnerDashboardState {
  const OwnerDashboardLoaded(this.stats);

  final DashboardStats stats;

  /// Create a copy of OwnerDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OwnerDashboardLoadedCopyWith<OwnerDashboardLoaded> get copyWith =>
      _$OwnerDashboardLoadedCopyWithImpl<OwnerDashboardLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OwnerDashboardLoaded &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stats);

  @override
  String toString() {
    return 'OwnerDashboardState.loaded(stats: $stats)';
  }
}

/// @nodoc
abstract mixin class $OwnerDashboardLoadedCopyWith<$Res>
    implements $OwnerDashboardStateCopyWith<$Res> {
  factory $OwnerDashboardLoadedCopyWith(OwnerDashboardLoaded value,
          $Res Function(OwnerDashboardLoaded) _then) =
      _$OwnerDashboardLoadedCopyWithImpl;
  @useResult
  $Res call({DashboardStats stats});
}

/// @nodoc
class _$OwnerDashboardLoadedCopyWithImpl<$Res>
    implements $OwnerDashboardLoadedCopyWith<$Res> {
  _$OwnerDashboardLoadedCopyWithImpl(this._self, this._then);

  final OwnerDashboardLoaded _self;
  final $Res Function(OwnerDashboardLoaded) _then;

  /// Create a copy of OwnerDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stats = null,
  }) {
    return _then(OwnerDashboardLoaded(
      null == stats
          ? _self.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as DashboardStats,
    ));
  }
}

/// @nodoc

class OwnerDashboardError implements OwnerDashboardState {
  const OwnerDashboardError(this.message);

  final String message;

  /// Create a copy of OwnerDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OwnerDashboardErrorCopyWith<OwnerDashboardError> get copyWith =>
      _$OwnerDashboardErrorCopyWithImpl<OwnerDashboardError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OwnerDashboardError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'OwnerDashboardState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $OwnerDashboardErrorCopyWith<$Res>
    implements $OwnerDashboardStateCopyWith<$Res> {
  factory $OwnerDashboardErrorCopyWith(
          OwnerDashboardError value, $Res Function(OwnerDashboardError) _then) =
      _$OwnerDashboardErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$OwnerDashboardErrorCopyWithImpl<$Res>
    implements $OwnerDashboardErrorCopyWith<$Res> {
  _$OwnerDashboardErrorCopyWithImpl(this._self, this._then);

  final OwnerDashboardError _self;
  final $Res Function(OwnerDashboardError) _then;

  /// Create a copy of OwnerDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(OwnerDashboardError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
