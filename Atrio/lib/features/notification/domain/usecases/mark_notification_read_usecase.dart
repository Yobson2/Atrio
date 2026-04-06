import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/notification/domain/repositories/notification_repository.dart';

/// Marks a single notification as read.
class MarkNotificationReadUseCase
    extends UseCase<void, MarkNotificationReadParams> {
  /// Creates a [MarkNotificationReadUseCase].
  const MarkNotificationReadUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  Future<Either<Failure, void>> call(MarkNotificationReadParams params) {
    return _repository.markAsRead(params.notificationId);
  }
}

/// Parameters for [MarkNotificationReadUseCase].
class MarkNotificationReadParams {
  /// Creates [MarkNotificationReadParams].
  const MarkNotificationReadParams({required this.notificationId});

  /// The ID of the notification to mark as read.
  final String notificationId;
}
