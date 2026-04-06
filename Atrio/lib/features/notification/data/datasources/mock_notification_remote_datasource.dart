// coverage:ignore-file

import 'package:flutter_templates/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:flutter_templates/features/notification/data/models/app_notification_model.dart';

/// Mock implementation of [NotificationRemoteDataSource] for local testing.
///
/// Returns realistic notification data with an 800ms simulated delay.
///
/// Remove this file and set `USE_MOCK_NOTIFICATION=false` in `.env` to switch
/// to the real API.
class MockNotificationRemoteDataSource implements NotificationRemoteDataSource {
  static const _delay = Duration(milliseconds: 800);

  final List<AppNotificationModel> _notifications = [
    AppNotificationModel(
      id: 'notif-001',
      title: 'Queue Update',
      body: 'You moved to position #2 at Downtown Barber Shop.',
      type: 'queueUpdate',
      data: const {'salon_id': 'salon-001', 'position': 2},
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    AppNotificationModel(
      id: 'notif-002',
      title: 'Booking Confirmed',
      body:
          'Your appointment at Style Studio for Saturday at 10:00 AM has been confirmed.',
      type: 'bookingConfirmed',
      data: const {'booking_id': 'booking-101'},
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    AppNotificationModel(
      id: 'notif-003',
      title: "It's Almost Your Turn!",
      body:
          'You are next in line at Downtown Barber Shop. Please head to the salon.',
      type: 'turnComing',
      data: const {'salon_id': 'salon-001', 'position': 1},
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    AppNotificationModel(
      id: 'notif-004',
      title: 'Booking Reminder',
      body:
          'Reminder: You have an appointment at Fresh Cuts tomorrow at 3:00 PM.',
      type: 'bookingReminder',
      data: const {'booking_id': 'booking-102'},
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    AppNotificationModel(
      id: 'notif-005',
      title: 'Queue Update',
      body: 'The queue at Fresh Cuts has been cleared. Join again when ready.',
      type: 'queueUpdate',
      data: const {'salon_id': 'salon-002'},
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    AppNotificationModel(
      id: 'notif-006',
      title: 'Welcome!',
      body:
          'Thanks for joining BarberQ! Explore nearby salons and book your first appointment.',
      type: 'general',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
    AppNotificationModel(
      id: 'notif-007',
      title: 'Booking Confirmed',
      body:
          'Your appointment at Premium Cuts for Friday at 2:30 PM has been confirmed.',
      type: 'bookingConfirmed',
      data: const {'booking_id': 'booking-103'},
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
    ),
  ];

  @override
  Future<void> registerDeviceToken(String fcmToken) async {
    await Future<void>.delayed(_delay);
  }

  @override
  Future<List<AppNotificationModel>> getNotifications() async {
    await Future<void>.delayed(_delay);
    return List.of(_notifications);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await Future<void>.delayed(_delay);
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    await Future<void>.delayed(_delay);
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }
}
