import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/notification/domain/repositories/notification_repository.dart';

/// Registers a device FCM token for push notifications.
class RegisterDeviceTokenUseCase
    extends UseCase<void, RegisterDeviceTokenParams> {
  /// Creates a [RegisterDeviceTokenUseCase].
  const RegisterDeviceTokenUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  Future<Either<Failure, void>> call(RegisterDeviceTokenParams params) {
    return _repository.registerDeviceToken(params.fcmToken);
  }
}

/// Parameters for [RegisterDeviceTokenUseCase].
class RegisterDeviceTokenParams {
  /// Creates [RegisterDeviceTokenParams].
  const RegisterDeviceTokenParams({required this.fcmToken});

  /// The FCM device token to register.
  final String fcmToken;
}
