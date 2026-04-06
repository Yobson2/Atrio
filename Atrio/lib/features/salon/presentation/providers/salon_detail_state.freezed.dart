// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salon_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalonDetailState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonDetailState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonDetailState()';
  }
}

/// @nodoc
class $SalonDetailStateCopyWith<$Res> {
  $SalonDetailStateCopyWith(
      SalonDetailState _, $Res Function(SalonDetailState) __);
}

/// @nodoc

class SalonDetailInitial implements SalonDetailState {
  const SalonDetailInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonDetailInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonDetailState.initial()';
  }
}

/// @nodoc

class SalonDetailLoading implements SalonDetailState {
  const SalonDetailLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonDetailLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonDetailState.loading()';
  }
}

/// @nodoc

class SalonDetailLoaded implements SalonDetailState {
  const SalonDetailLoaded(
      {required this.salon,
      required final List<SalonService> services,
      required final List<Barber> barbers})
      : _services = services,
        _barbers = barbers;

  final Salon salon;
  final List<SalonService> _services;
  List<SalonService> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  final List<Barber> _barbers;
  List<Barber> get barbers {
    if (_barbers is EqualUnmodifiableListView) return _barbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_barbers);
  }

  /// Create a copy of SalonDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonDetailLoadedCopyWith<SalonDetailLoaded> get copyWith =>
      _$SalonDetailLoadedCopyWithImpl<SalonDetailLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonDetailLoaded &&
            (identical(other.salon, salon) || other.salon == salon) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            const DeepCollectionEquality().equals(other._barbers, _barbers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      salon,
      const DeepCollectionEquality().hash(_services),
      const DeepCollectionEquality().hash(_barbers));

  @override
  String toString() {
    return 'SalonDetailState.loaded(salon: $salon, services: $services, barbers: $barbers)';
  }
}

/// @nodoc
abstract mixin class $SalonDetailLoadedCopyWith<$Res>
    implements $SalonDetailStateCopyWith<$Res> {
  factory $SalonDetailLoadedCopyWith(
          SalonDetailLoaded value, $Res Function(SalonDetailLoaded) _then) =
      _$SalonDetailLoadedCopyWithImpl;
  @useResult
  $Res call({Salon salon, List<SalonService> services, List<Barber> barbers});
}

/// @nodoc
class _$SalonDetailLoadedCopyWithImpl<$Res>
    implements $SalonDetailLoadedCopyWith<$Res> {
  _$SalonDetailLoadedCopyWithImpl(this._self, this._then);

  final SalonDetailLoaded _self;
  final $Res Function(SalonDetailLoaded) _then;

  /// Create a copy of SalonDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? salon = null,
    Object? services = null,
    Object? barbers = null,
  }) {
    return _then(SalonDetailLoaded(
      salon: null == salon
          ? _self.salon
          : salon // ignore: cast_nullable_to_non_nullable
              as Salon,
      services: null == services
          ? _self._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<SalonService>,
      barbers: null == barbers
          ? _self._barbers
          : barbers // ignore: cast_nullable_to_non_nullable
              as List<Barber>,
    ));
  }
}

/// @nodoc

class SalonDetailError implements SalonDetailState {
  const SalonDetailError(this.message);

  final String message;

  /// Create a copy of SalonDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonDetailErrorCopyWith<SalonDetailError> get copyWith =>
      _$SalonDetailErrorCopyWithImpl<SalonDetailError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonDetailError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SalonDetailState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SalonDetailErrorCopyWith<$Res>
    implements $SalonDetailStateCopyWith<$Res> {
  factory $SalonDetailErrorCopyWith(
          SalonDetailError value, $Res Function(SalonDetailError) _then) =
      _$SalonDetailErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SalonDetailErrorCopyWithImpl<$Res>
    implements $SalonDetailErrorCopyWith<$Res> {
  _$SalonDetailErrorCopyWithImpl(this._self, this._then);

  final SalonDetailError _self;
  final $Res Function(SalonDetailError) _then;

  /// Create a copy of SalonDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SalonDetailError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
