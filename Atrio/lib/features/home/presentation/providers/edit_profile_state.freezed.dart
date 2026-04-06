// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditProfileState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EditProfileState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EditProfileState()';
  }
}

/// @nodoc
class $EditProfileStateCopyWith<$Res> {
  $EditProfileStateCopyWith(
      EditProfileState _, $Res Function(EditProfileState) __);
}

/// @nodoc

class EditProfileInitial implements EditProfileState {
  const EditProfileInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EditProfileInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EditProfileState.initial()';
  }
}

/// @nodoc

class EditProfileLoading implements EditProfileState {
  const EditProfileLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EditProfileLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EditProfileState.loading()';
  }
}

/// @nodoc

class EditProfileSuccess implements EditProfileState {
  const EditProfileSuccess(this.user);

  final User user;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditProfileSuccessCopyWith<EditProfileSuccess> get copyWith =>
      _$EditProfileSuccessCopyWithImpl<EditProfileSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditProfileSuccess &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'EditProfileState.success(user: $user)';
  }
}

/// @nodoc
abstract mixin class $EditProfileSuccessCopyWith<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  factory $EditProfileSuccessCopyWith(
          EditProfileSuccess value, $Res Function(EditProfileSuccess) _then) =
      _$EditProfileSuccessCopyWithImpl;
  @useResult
  $Res call({User user});
}

/// @nodoc
class _$EditProfileSuccessCopyWithImpl<$Res>
    implements $EditProfileSuccessCopyWith<$Res> {
  _$EditProfileSuccessCopyWithImpl(this._self, this._then);

  final EditProfileSuccess _self;
  final $Res Function(EditProfileSuccess) _then;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
  }) {
    return _then(EditProfileSuccess(
      null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class EditProfileError implements EditProfileState {
  const EditProfileError(this.message);

  final String message;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditProfileErrorCopyWith<EditProfileError> get copyWith =>
      _$EditProfileErrorCopyWithImpl<EditProfileError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditProfileError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'EditProfileState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $EditProfileErrorCopyWith<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  factory $EditProfileErrorCopyWith(
          EditProfileError value, $Res Function(EditProfileError) _then) =
      _$EditProfileErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$EditProfileErrorCopyWithImpl<$Res>
    implements $EditProfileErrorCopyWith<$Res> {
  _$EditProfileErrorCopyWithImpl(this._self, this._then);

  final EditProfileError _self;
  final $Res Function(EditProfileError) _then;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(EditProfileError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
