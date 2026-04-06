import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';
import 'package:flutter_templates/features/notification/domain/usecases/mark_notification_read_usecase.dart';
import 'package:flutter_templates/features/notification/presentation/providers/notification_providers.dart';
import 'package:flutter_templates/features/notification/presentation/providers/notification_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_notifier.g.dart';

/// Manages notification state and actions.
@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  NotificationState build() => const NotificationState.initial();

  /// Loads all notifications for the current user.
  Future<void> loadNotifications() async {
    state = const NotificationState.loading();
    try {
      final result = await ref
          .read(getNotificationsUseCaseProvider)
          .call(const NoParams());
      state = result.fold(
        (failure) => NotificationState.error(failure.message),
        NotificationState.loaded,
      );
    } catch (e) {
      state = NotificationState.error(e.toString());
    }
  }

  /// Marks a single notification as read and updates local state.
  Future<void> markAsRead(String notificationId) async {
    try {
      final result = await ref
          .read(markNotificationReadUseCaseProvider)
          .call(MarkNotificationReadParams(notificationId: notificationId));
      result.fold(
        (_) {},
        (_) {
          // Update local state optimistically.
          final current = state;
          if (current is NotificationLoaded) {
            final updated = current.notifications.map((n) {
              if (n.id == notificationId) {
                return AppNotification(
                  id: n.id,
                  title: n.title,
                  body: n.body,
                  type: n.type,
                  data: n.data,
                  createdAt: n.createdAt,
                  isRead: true,
                );
              }
              return n;
            }).toList();
            state = NotificationState.loaded(updated);
          }
        },
      );
    } catch (e) {
      // Silently fail for mark-as-read; not critical.
    }
  }

  /// Marks all notifications as read and updates local state.
  Future<void> markAllAsRead() async {
    try {
      final result =
          await ref.read(markAllAsReadUseCaseProvider).call(const NoParams());
      result.fold(
        (_) {},
        (_) {
          // Update local state optimistically.
          final current = state;
          if (current is NotificationLoaded) {
            final updated = current.notifications
                .map(
                  (n) => AppNotification(
                    id: n.id,
                    title: n.title,
                    body: n.body,
                    type: n.type,
                    data: n.data,
                    createdAt: n.createdAt,
                    isRead: true,
                  ),
                )
                .toList();
            state = NotificationState.loaded(updated);
          }
        },
      );
    } catch (e) {
      // Silently fail for mark-all-as-read; not critical.
    }
  }
}
