import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/auth/domain/entities/user.dart';
import 'package:flutter_templates/features/auth/domain/repositories/auth_repository.dart';

/// Verifies an OTP code sent to a phone number and authenticates the user.
///
/// Returns a [User] on success. If the user is new (no role set),
/// the caller should redirect to the profile setup flow.
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

  /// The OTP code entered by the user.
  final String code;
}
