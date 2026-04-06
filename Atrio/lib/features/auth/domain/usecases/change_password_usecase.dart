import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/auth/domain/repositories/auth_repository.dart';

/// Changes the current user's password.
class ChangePasswordUseCase extends UseCase<void, ChangePasswordParams> {
  /// Creates a [ChangePasswordUseCase].
  const ChangePasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) {
    return _repository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}

/// Parameters for [ChangePasswordUseCase].
class ChangePasswordParams {
  /// Creates [ChangePasswordParams].
  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });

  /// The user's current password.
  final String currentPassword;

  /// The new password to set.
  final String newPassword;
}
