// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salon_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalonListState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonListState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonListState()';
  }
}

/// @nodoc
class $SalonListStateCopyWith<$Res> {
  $SalonListStateCopyWith(SalonListState _, $Res Function(SalonListState) __);
}

/// @nodoc

class SalonListInitial implements SalonListState {
  const SalonListInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonListInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonListState.initial()';
  }
}

/// @nodoc

class SalonListLoading implements SalonListState {
  const SalonListLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SalonListLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SalonListState.loading()';
  }
}

/// @nodoc

class SalonListLoaded implements SalonListState {
  const SalonListLoaded(final List<Salon> salons) : _salons = salons;

  final List<Salon> _salons;
  List<Salon> get salons {
    if (_salons is EqualUnmodifiableListView) return _salons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_salons);
  }

  /// Create a copy of SalonListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonListLoadedCopyWith<SalonListLoaded> get copyWith =>
      _$SalonListLoadedCopyWithImpl<SalonListLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonListLoaded &&
            const DeepCollectionEquality().equals(other._salons, _salons));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_salons));

  @override
  String toString() {
    return 'SalonListState.loaded(salons: $salons)';
  }
}

/// @nodoc
abstract mixin class $SalonListLoadedCopyWith<$Res>
    implements $SalonListStateCopyWith<$Res> {
  factory $SalonListLoadedCopyWith(
          SalonListLoaded value, $Res Function(SalonListLoaded) _then) =
      _$SalonListLoadedCopyWithImpl;
  @useResult
  $Res call({List<Salon> salons});
}

/// @nodoc
class _$SalonListLoadedCopyWithImpl<$Res>
    implements $SalonListLoadedCopyWith<$Res> {
  _$SalonListLoadedCopyWithImpl(this._self, this._then);

  final SalonListLoaded _self;
  final $Res Function(SalonListLoaded) _then;

  /// Create a copy of SalonListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? salons = null,
  }) {
    return _then(SalonListLoaded(
      null == salons
          ? _self._salons
          : salons // ignore: cast_nullable_to_non_nullable
              as List<Salon>,
    ));
  }
}

/// @nodoc

class SalonListError implements SalonListState {
  const SalonListError(this.message);

  final String message;

  /// Create a copy of SalonListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonListErrorCopyWith<SalonListError> get copyWith =>
      _$SalonListErrorCopyWithImpl<SalonListError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonListError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SalonListState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SalonListErrorCopyWith<$Res>
    implements $SalonListStateCopyWith<$Res> {
  factory $SalonListErrorCopyWith(
          SalonListError value, $Res Function(SalonListError) _then) =
      _$SalonListErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SalonListErrorCopyWithImpl<$Res>
    implements $SalonListErrorCopyWith<$Res> {
  _$SalonListErrorCopyWithImpl(this._self, this._then);

  final SalonListError _self;
  final $Res Function(SalonListError) _then;

  /// Create a copy of SalonListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SalonListError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
