import 'package:flutter/foundation.dart';

/// Notification type enum.
enum NotificationType {
  bookingConfirmed,
  queueUpdate,
  reminder,
  cancellation,
}

/// Domain entity representing a user notification.
@immutable
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;

  IconForType get iconData {
    return switch (type) {
      NotificationType.bookingConfirmed => IconForType.calendarCheck,
      NotificationType.queueUpdate => IconForType.queue,
      NotificationType.reminder => IconForType.bell,
      NotificationType.cancellation => IconForType.cancel,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppNotification &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Helper to map notification types to icon names (avoids Material dependency).
enum IconForType { calendarCheck, queue, bell, cancel }
