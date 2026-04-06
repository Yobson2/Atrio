import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';
import 'package:flutter_templates/features/notification/domain/repositories/notification_repository.dart';

/// Fetches all notifications for the current user.
class GetNotificationsUseCase extends UseCase<List<AppNotification>, NoParams> {
  /// Creates a [GetNotificationsUseCase].
  const GetNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  Future<Either<Failure, List<AppNotification>>> call(NoParams params) {
    return _repository.getNotifications();
  }
}
