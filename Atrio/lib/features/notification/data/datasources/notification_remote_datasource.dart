import 'package:dio/dio.dart';
import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/core/network/api_endpoints.dart';
import 'package:flutter_templates/features/notification/data/models/app_notification_model.dart';

/// Remote data source for notification API calls.
abstract class NotificationRemoteDataSource {
  /// POST: Register device FCM token.
  Future<void> registerDeviceToken(String fcmToken);

  /// GET: Fetch all notifications.
  Future<List<AppNotificationModel>> getNotifications();

  /// PUT: Mark a notification as read.
  Future<void> markAsRead(String notificationId);

  /// PUT: Mark all notifications as read.
  Future<void> markAllAsRead();
}

/// Implementation of [NotificationRemoteDataSource] using [Dio].
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  /// Creates a [NotificationRemoteDataSourceImpl].
  const NotificationRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> registerDeviceToken(String fcmToken) async {
    try {
      await _dio.post<void>(
        ApiEndpoints.registerDevice,
        data: {'fcm_token': fcmToken},
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<AppNotificationModel>> getNotifications() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.notifications,
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      final list = data['notifications'];
      if (list is! List) {
        throw const ServerException(
          message: 'Invalid notifications data in response',
        );
      }
      return list
          .cast<Map<String, dynamic>>()
          .map(AppNotificationModel.fromJson)
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _dio.put<void>(
        ApiEndpoints.notificationRead(notificationId),
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await _dio.put<void>(ApiEndpoints.notificationsReadAll);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
