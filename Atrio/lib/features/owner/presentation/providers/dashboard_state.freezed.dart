// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DashboardState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DashboardState()';
  }
}

/// @nodoc
class $DashboardStateCopyWith<$Res> {
  $DashboardStateCopyWith(DashboardState _, $Res Function(DashboardState) __);
}

/// @nodoc

class DashboardInitial implements DashboardState {
  const DashboardInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DashboardInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DashboardState.initial()';
  }
}

/// @nodoc

class DashboardLoading implements DashboardState {
  const DashboardLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DashboardLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DashboardState.loading()';
  }
}

/// @nodoc

class DashboardLoaded implements DashboardState {
  const DashboardLoaded(
      {required this.salon,
      required this.stats,
      required final List<Booking> todayBookings})
      : _todayBookings = todayBookings;

  final Salon salon;
  final SalonStats stats;
  final List<Booking> _todayBookings;
  List<Booking> get todayBookings {
    if (_todayBookings is EqualUnmodifiableListView) return _todayBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayBookings);
  }

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardLoadedCopyWith<DashboardLoaded> get copyWith =>
      _$DashboardLoadedCopyWithImpl<DashboardLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardLoaded &&
            (identical(other.salon, salon) || other.salon == salon) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            const DeepCollectionEquality()
                .equals(other._todayBookings, _todayBookings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, salon, stats,
      const DeepCollectionEquality().hash(_todayBookings));

  @override
  String toString() {
    return 'DashboardState.loaded(salon: $salon, stats: $stats, todayBookings: $todayBookings)';
  }
}

/// @nodoc
abstract mixin class $DashboardLoadedCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory $DashboardLoadedCopyWith(
          DashboardLoaded value, $Res Function(DashboardLoaded) _then) =
      _$DashboardLoadedCopyWithImpl;
  @useResult
  $Res call({Salon salon, SalonStats stats, List<Booking> todayBookings});
}

/// @nodoc
class _$DashboardLoadedCopyWithImpl<$Res>
    implements $DashboardLoadedCopyWith<$Res> {
  _$DashboardLoadedCopyWithImpl(this._self, this._then);

  final DashboardLoaded _self;
  final $Res Function(DashboardLoaded) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? salon = null,
    Object? stats = null,
    Object? todayBookings = null,
  }) {
    return _then(DashboardLoaded(
      salon: null == salon
          ? _self.salon
          : salon // ignore: cast_nullable_to_non_nullable
              as Salon,
      stats: null == stats
          ? _self.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as SalonStats,
      todayBookings: null == todayBookings
          ? _self._todayBookings
          : todayBookings // ignore: cast_nullable_to_non_nullable
              as List<Booking>,
    ));
  }
}

/// @nodoc

class DashboardError implements DashboardState {
  const DashboardError(this.message);

  final String message;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardErrorCopyWith<DashboardError> get copyWith =>
      _$DashboardErrorCopyWithImpl<DashboardError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DashboardState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $DashboardErrorCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory $DashboardErrorCopyWith(
          DashboardError value, $Res Function(DashboardError) _then) =
      _$DashboardErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$DashboardErrorCopyWithImpl<$Res>
    implements $DashboardErrorCopyWith<$Res> {
  _$DashboardErrorCopyWithImpl(this._self, this._then);

  final DashboardError _self;
  final $Res Function(DashboardError) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(DashboardError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
