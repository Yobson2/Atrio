import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

/// Represents the state for notification operations.
@freezed
sealed class NotificationState with _$NotificationState {
  /// Initial idle state.
  const factory NotificationState.initial() = NotificationInitial;

  /// Loading state during an operation.
  const factory NotificationState.loading() = NotificationLoading;

  /// Notifications loaded successfully.
  const factory NotificationState.loaded(
    List<AppNotification> notifications,
  ) = NotificationLoaded;

  /// An error occurred.
  const factory NotificationState.error(String message) = NotificationError;
}
