import 'package:flutter/foundation.dart';
import 'package:flutter_templates/features/notification/domain/entities/notification_type.dart';

/// Domain entity representing a user notification.
@immutable
class AppNotification {
  /// Creates an [AppNotification].
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.data = const {},
    required this.createdAt,
    this.isRead = false,
  });

  /// Unique notification identifier.
  final String id;

  /// Notification title.
  final String title;

  /// Notification body text.
  final String body;

  /// The type/category of the notification.
  final NotificationType type;

  /// Optional payload data associated with the notification.
  final Map<String, dynamic> data;

  /// When the notification was created.
  final DateTime createdAt;

  /// Whether the notification has been read.
  final bool isRead;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppNotification && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
