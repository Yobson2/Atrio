import 'package:flutter_templates/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_templates/features/home/presentation/providers/change_password_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_password_notifier.g.dart';

/// Manages the change password form state.
@riverpod
class ChangePasswordNotifier extends _$ChangePasswordNotifier {
  @override
  ChangePasswordState build() => const ChangePasswordState.initial();

  /// Submits the password change.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const ChangePasswordState.loading();
    try {
      final result = await ref.read(changePasswordUseCaseProvider).call(
            ChangePasswordParams(
              currentPassword: currentPassword,
              newPassword: newPassword,
            ),
          );
      state = result.fold(
        (failure) => ChangePasswordState.error(failure.message),
        (_) => const ChangePasswordState.success(),
      );
    } catch (e) {
      state = ChangePasswordState.error(e.toString());
    }
  }
}
