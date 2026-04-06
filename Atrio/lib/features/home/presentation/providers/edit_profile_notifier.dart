import 'package:flutter_templates/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/home/presentation/providers/edit_profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_profile_notifier.g.dart';

/// Manages the edit profile form state.
@riverpod
class EditProfileNotifier extends _$EditProfileNotifier {
  @override
  EditProfileState build() => const EditProfileState.initial();

  /// Submits profile changes.
  Future<void> updateProfile({
    required String name,
    String? email,
    String? phone,
    String? avatarImagePath,
  }) async {
    state = const EditProfileState.loading();
    try {
      final result = await ref.read(updateProfileUseCaseProvider).call(
            UpdateProfileParams(
              name: name,
              email: email,
              phone: phone,
              avatarImagePath: avatarImagePath,
            ),
          );
      state = result.fold(
        (failure) => EditProfileState.error(failure.message),
        (user) {
          // Sync updated user back into auth state.
          ref.read(authNotifierProvider.notifier).state =
              AuthState.authenticated(user);
          return EditProfileState.success(user);
        },
      );
    } catch (e) {
      state = EditProfileState.error(e.toString());
    }
  }
}
