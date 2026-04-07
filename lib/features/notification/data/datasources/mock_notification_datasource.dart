// coverage:ignore-file

import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';

/// Mock notification data for the notifications page.
class MockNotificationData {
  const MockNotificationData._();

  static List<AppNotification> get notifications => [
        AppNotification(
          id: 'notif-001',
          type: NotificationType.bookingConfirmed,
          title: 'Booking Confirmed',
          body:
              'Your appointment with Marco "The Blade" Rossi is confirmed for tomorrow at 2:30 PM.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
        ),
        AppNotification(
          id: 'notif-002',
          type: NotificationType.queueUpdate,
          title: "You're next in line!",
          body:
              'Head over to the salon. Your stylist will be ready in approximately 8 minutes.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
        ),
        AppNotification(
          id: 'notif-003',
          type: NotificationType.reminder,
          title: 'Reminder: Hair Care',
          body:
              "It's been 4 weeks since your last visit. Ready for a fresh look?",
          createdAt: DateTime.now().subtract(const Duration(hours: 14)),
          isRead: true,
        ),
        AppNotification(
          id: 'notif-004',
          type: NotificationType.cancellation,
          title: 'Booking Cancelled',
          body:
              'Your booking for Saturday has been cancelled. No charges were applied.',
          createdAt: DateTime.now().subtract(const Duration(hours: 14)),
          isRead: true,
        ),
      ];
}
