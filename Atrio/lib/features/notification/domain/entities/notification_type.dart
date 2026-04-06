/// Types of notifications supported by the application.
enum NotificationType {
  /// Queue position has changed.
  queueUpdate,

  /// A booking has been confirmed.
  bookingConfirmed,

  /// The user's turn is coming up soon.
  turnComing,

  /// Reminder for an upcoming booking.
  bookingReminder,

  /// General notification.
  general;

  /// Parses a [NotificationType] from a JSON string [value].
  static NotificationType fromJson(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationType.general,
    );
  }

  /// Converts this [NotificationType] to a JSON string.
  String toJson() => name;
}
