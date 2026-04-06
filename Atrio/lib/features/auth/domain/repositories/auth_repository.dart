import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/auth/domain/entities/user.dart';

/// Abstract authentication repository defined in the domain layer.
///
/// Implemented by [AuthRepositoryImpl] in the data layer.

abstract class AuthRepository {
  /// Logs in with [email] and [password].
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Registers a new user with an optional [role] and [phone].
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    String role = 'client',
    String? phone,
  });

  /// Sends a password reset code to [email].
  Future<Either<Failure, void>> forgotPassword({required String email});

  /// Verifies the OTP [code] sent to [email].
  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String code,
  });

  /// Sends an OTP code to [phone].
  Future<Either<Failure, void>> sendOtp({required String phone});

  /// Verifies the OTP [code] sent to [phone] and authenticates the user.
  ///
  /// Works for both new and existing users (backend determines which).
  Future<Either<Failure, User>> verifyPhoneOtp({
    required String phone,
    required String code,
  });

  /// Logs out the current user and clears tokens.
  Future<Either<Failure, void>> logout();

  /// Gets the currently cached user (from local storage).
  Future<Either<Failure, User>> getCachedUser();

  /// Updates the current user's profile.
  Future<Either<Failure, User>> updateProfile({
    required String name,
    String? email,
    String? phone,
    String? avatarImagePath,
  });

  /// Changes the current user's password.
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Whether a valid token exists locally.
  Future<bool> get isAuthenticated;
}
