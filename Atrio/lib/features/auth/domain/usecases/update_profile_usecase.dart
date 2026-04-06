import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/auth/domain/entities/user.dart';
import 'package:flutter_templates/features/auth/domain/repositories/auth_repository.dart';

/// Updates the current user's profile.
class UpdateProfileUseCase extends UseCase<User, UpdateProfileParams> {
  /// Creates an [UpdateProfileUseCase].
  const UpdateProfileUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(UpdateProfileParams params) {
    return _repository.updateProfile(
      name: params.name,
      email: params.email,
      phone: params.phone,
      avatarImagePath: params.avatarImagePath,
    );
  }
}

/// Parameters for [UpdateProfileUseCase].
class UpdateProfileParams {
  /// Creates [UpdateProfileParams].
  const UpdateProfileParams({
    required this.name,
    this.email,
    this.phone,
    this.avatarImagePath,
  });

  /// Updated display name.
  final String name;

  /// Updated email address.
  final String? email;

  /// Updated phone number.
  final String? phone;

  /// Path to the new avatar image file (null = no change).
  final String? avatarImagePath;
}
