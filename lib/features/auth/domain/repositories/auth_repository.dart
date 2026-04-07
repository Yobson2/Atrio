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

  /// Registers a new user.
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Sends a password reset code to [email].
  Future<Either<Failure, void>> forgotPassword({required String email});

  /// Verifies the OTP [code] sent to [email].
  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String code,
  });

  /// Sends an OTP to the given [phone] number.
  Future<Either<Failure, void>> sendOtp({required String phone});

  /// Verifies the OTP [code] sent to [phone] and authenticates the user.
  Future<Either<Failure, User>> verifyPhoneOtp({
    required String phone,
    required String code,
  });

  /// Logs out the current user and clears tokens.
  Future<Either<Failure, void>> logout();

  /// Gets the currently cached user (from local storage).
  Future<Either<Failure, User>> getCachedUser();

  /// Whether a valid token exists locally.
  Future<bool> get isAuthenticated;
}
