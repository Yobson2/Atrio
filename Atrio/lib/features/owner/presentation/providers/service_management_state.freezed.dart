// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceManagementState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ServiceManagementState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ServiceManagementState()';
  }
}

/// @nodoc
class $ServiceManagementStateCopyWith<$Res> {
  $ServiceManagementStateCopyWith(
      ServiceManagementState _, $Res Function(ServiceManagementState) __);
}

/// @nodoc

class ServiceManagementInitial implements ServiceManagementState {
  const ServiceManagementInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ServiceManagementInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ServiceManagementState.initial()';
  }
}

/// @nodoc

class ServiceManagementLoading implements ServiceManagementState {
  const ServiceManagementLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ServiceManagementLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ServiceManagementState.loading()';
  }
}

/// @nodoc

class ServiceManagementLoaded implements ServiceManagementState {
  const ServiceManagementLoaded(final List<SalonService> services)
      : _services = services;

  final List<SalonService> _services;
  List<SalonService> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  /// Create a copy of ServiceManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceManagementLoadedCopyWith<ServiceManagementLoaded> get copyWith =>
      _$ServiceManagementLoadedCopyWithImpl<ServiceManagementLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceManagementLoaded &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_services));

  @override
  String toString() {
    return 'ServiceManagementState.loaded(services: $services)';
  }
}

/// @nodoc
abstract mixin class $ServiceManagementLoadedCopyWith<$Res>
    implements $ServiceManagementStateCopyWith<$Res> {
  factory $ServiceManagementLoadedCopyWith(ServiceManagementLoaded value,
          $Res Function(ServiceManagementLoaded) _then) =
      _$ServiceManagementLoadedCopyWithImpl;
  @useResult
  $Res call({List<SalonService> services});
}

/// @nodoc
class _$ServiceManagementLoadedCopyWithImpl<$Res>
    implements $ServiceManagementLoadedCopyWith<$Res> {
  _$ServiceManagementLoadedCopyWithImpl(this._self, this._then);

  final ServiceManagementLoaded _self;
  final $Res Function(ServiceManagementLoaded) _then;

  /// Create a copy of ServiceManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? services = null,
  }) {
    return _then(ServiceManagementLoaded(
      null == services
          ? _self._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<SalonService>,
    ));
  }
}

/// @nodoc

class ServiceManagementSuccess implements ServiceManagementState {
  const ServiceManagementSuccess(this.message);

  final String message;

  /// Create a copy of ServiceManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceManagementSuccessCopyWith<ServiceManagementSuccess> get copyWith =>
      _$ServiceManagementSuccessCopyWithImpl<ServiceManagementSuccess>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceManagementSuccess &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ServiceManagementState.success(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ServiceManagementSuccessCopyWith<$Res>
    implements $ServiceManagementStateCopyWith<$Res> {
  factory $ServiceManagementSuccessCopyWith(ServiceManagementSuccess value,
          $Res Function(ServiceManagementSuccess) _then) =
      _$ServiceManagementSuccessCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ServiceManagementSuccessCopyWithImpl<$Res>
    implements $ServiceManagementSuccessCopyWith<$Res> {
  _$ServiceManagementSuccessCopyWithImpl(this._self, this._then);

  final ServiceManagementSuccess _self;
  final $Res Function(ServiceManagementSuccess) _then;

  /// Create a copy of ServiceManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(ServiceManagementSuccess(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ServiceManagementError implements ServiceManagementState {
  const ServiceManagementError(this.message);

  final String message;

  /// Create a copy of ServiceManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceManagementErrorCopyWith<ServiceManagementError> get copyWith =>
      _$ServiceManagementErrorCopyWithImpl<ServiceManagementError>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceManagementError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ServiceManagementState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ServiceManagementErrorCopyWith<$Res>
    implements $ServiceManagementStateCopyWith<$Res> {
  factory $ServiceManagementErrorCopyWith(ServiceManagementError value,
          $Res Function(ServiceManagementError) _then) =
      _$ServiceManagementErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ServiceManagementErrorCopyWithImpl<$Res>
    implements $ServiceManagementErrorCopyWith<$Res> {
  _$ServiceManagementErrorCopyWithImpl(this._self, this._then);

  final ServiceManagementError _self;
  final $Res Function(ServiceManagementError) _then;

  /// Create a copy of ServiceManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(ServiceManagementError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
