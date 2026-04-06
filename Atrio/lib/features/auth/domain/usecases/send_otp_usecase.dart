import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/auth/domain/repositories/auth_repository.dart';

/// Sends an OTP code to the given phone number.
class SendOtpUseCase extends UseCase<void, SendOtpParams> {
  /// Creates a [SendOtpUseCase].
  const SendOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(SendOtpParams params) {
    return _repository.sendOtp(phone: params.phone);
  }
}

/// Parameters for [SendOtpUseCase].
class SendOtpParams {
  /// Creates [SendOtpParams].
  const SendOtpParams({required this.phone});

  /// Phone number to send OTP to.
  final String phone;
}
