import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/auth/domain/entities/user.dart';
import 'package:flutter_templates/features/auth/domain/repositories/auth_repository.dart';

/// Verifies a phone OTP and authenticates the user.
///
/// Works for both new and existing users — the backend determines
/// whether to create a new account or log in an existing one.
class VerifyPhoneOtpUseCase extends UseCase<User, VerifyPhoneOtpParams> {
  /// Creates a [VerifyPhoneOtpUseCase].
  const VerifyPhoneOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(VerifyPhoneOtpParams params) {
    return _repository.verifyPhoneOtp(phone: params.phone, code: params.code);
  }
}

/// Parameters for [VerifyPhoneOtpUseCase].
class VerifyPhoneOtpParams {
  /// Creates [VerifyPhoneOtpParams].
  const VerifyPhoneOtpParams({required this.phone, required this.code});

  /// Phone number the OTP was sent to.
  final String phone;

  /// OTP code.
  final String code;
}
