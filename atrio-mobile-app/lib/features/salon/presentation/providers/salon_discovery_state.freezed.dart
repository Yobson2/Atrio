// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salon_discovery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalonDiscoveryState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonDiscoveryState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonDiscoveryState()';
  }
}

/// @nodoc
class $SalonDiscoveryStateCopyWith<$Res> {
  $SalonDiscoveryStateCopyWith(
      SalonDiscoveryState _, $Res Function(SalonDiscoveryState) __);
}

/// @nodoc

class SalonDiscoveryInitial implements SalonDiscoveryState {
  const SalonDiscoveryInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonDiscoveryInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonDiscoveryState.initial()';
  }
}

/// @nodoc

class SalonDiscoveryLoading implements SalonDiscoveryState {
  const SalonDiscoveryLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonDiscoveryLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonDiscoveryState.loading()';
  }
}

/// @nodoc

class SalonDiscoveryLoaded implements SalonDiscoveryState {
  const SalonDiscoveryLoaded(final List<Salon> salons) : _salons = salons;

  final List<Salon> _salons;
  List<Salon> get salons {
    if (_salons is EqualUnmodifiableListView) return _salons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_salons);
  }

  /// Create a copy of SalonDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonDiscoveryLoadedCopyWith<SalonDiscoveryLoaded> get copyWith =>
      _$SalonDiscoveryLoadedCopyWithImpl<SalonDiscoveryLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonDiscoveryLoaded &&
            const DeepCollectionEquality().equals(other._salons, _salons));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_salons));

  @override
  String toString() {
    return 'SalonDiscoveryState.loaded(salons: $salons)';
  }
}

/// @nodoc
abstract mixin class $SalonDiscoveryLoadedCopyWith<$Res>
    implements $SalonDiscoveryStateCopyWith<$Res> {
  factory $SalonDiscoveryLoadedCopyWith(SalonDiscoveryLoaded value,
          $Res Function(SalonDiscoveryLoaded) _then) =
      _$SalonDiscoveryLoadedCopyWithImpl;
  @useResult
  $Res call({List<Salon> salons});
}

/// @nodoc
class _$SalonDiscoveryLoadedCopyWithImpl<$Res>
    implements $SalonDiscoveryLoadedCopyWith<$Res> {
  _$SalonDiscoveryLoadedCopyWithImpl(this._self, this._then);

  final SalonDiscoveryLoaded _self;
  final $Res Function(SalonDiscoveryLoaded) _then;

  /// Create a copy of SalonDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? salons = null,
  }) {
    return _then(SalonDiscoveryLoaded(
      null == salons
          ? _self._salons
          : salons // ignore: cast_nullable_to_non_nullable
              as List<Salon>,
    ));
  }
}

/// @nodoc

class SalonDiscoveryError implements SalonDiscoveryState {
  const SalonDiscoveryError(this.message);

  final String message;

  /// Create a copy of SalonDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonDiscoveryErrorCopyWith<SalonDiscoveryError> get copyWith =>
      _$SalonDiscoveryErrorCopyWithImpl<SalonDiscoveryError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonDiscoveryError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SalonDiscoveryState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SalonDiscoveryErrorCopyWith<$Res>
    implements $SalonDiscoveryStateCopyWith<$Res> {
  factory $SalonDiscoveryErrorCopyWith(
          SalonDiscoveryError value, $Res Function(SalonDiscoveryError) _then) =
      _$SalonDiscoveryErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SalonDiscoveryErrorCopyWithImpl<$Res>
    implements $SalonDiscoveryErrorCopyWith<$Res> {
  _$SalonDiscoveryErrorCopyWithImpl(this._self, this._then);

  final SalonDiscoveryError _self;
  final $Res Function(SalonDiscoveryError) _then;

  /// Create a copy of SalonDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SalonDiscoveryError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
