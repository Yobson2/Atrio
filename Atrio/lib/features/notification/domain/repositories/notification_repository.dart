import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';

/// Abstract notification repository defined in the domain layer.
///
/// Implemented by [NotificationRepositoryImpl] in the data layer.
abstract class NotificationRepository {
  /// Registers a device FCM token for push notifications.
  Future<Either<Failure, void>> registerDeviceToken(String fcmToken);

  /// Fetches all notifications for the current user.
  Future<Either<Failure, List<AppNotification>>> getNotifications();

  /// Marks a single notification as read.
  Future<Either<Failure, void>> markAsRead(String notificationId);

  /// Marks all notifications as read.
  Future<Either<Failure, void>> markAllAsRead();
}
