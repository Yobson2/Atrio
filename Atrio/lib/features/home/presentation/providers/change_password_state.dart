import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

/// State for the change password form.
@freezed
sealed class ChangePasswordState with _$ChangePasswordState {
  /// Initial idle state.
  const factory ChangePasswordState.initial() = ChangePasswordInitial;

  /// Submitting password change.
  const factory ChangePasswordState.loading() = ChangePasswordLoading;

  /// Password changed successfully.
  const factory ChangePasswordState.success() = ChangePasswordSuccess;

  /// An error occurred.
  const factory ChangePasswordState.error(String message) =
      ChangePasswordError;
}
