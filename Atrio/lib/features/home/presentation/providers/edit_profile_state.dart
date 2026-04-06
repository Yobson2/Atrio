import 'package:flutter_templates/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_state.freezed.dart';

/// State for the edit profile form.
@freezed
sealed class EditProfileState with _$EditProfileState {
  /// Initial idle state.
  const factory EditProfileState.initial() = EditProfileInitial;

  /// Submitting profile changes.
  const factory EditProfileState.loading() = EditProfileLoading;

  /// Profile updated successfully.
  const factory EditProfileState.success(User user) = EditProfileSuccess;

  /// An error occurred.
  const factory EditProfileState.error(String message) = EditProfileError;
}
