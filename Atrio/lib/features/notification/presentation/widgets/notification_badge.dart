import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/features/notification/presentation/providers/notification_notifier.dart';
import 'package:flutter_templates/features/notification/presentation/providers/notification_state.dart';

/// Badge widget displaying the count of unread notifications.
///
/// Wraps a [child] widget with a Material [Badge] showing the unread count.
/// Hides the badge when there are no unread notifications.
/// Uses primary color tint for the badge per Editorial Artisan design system.
class NotificationBadge extends ConsumerWidget {
  /// Creates a [NotificationBadge].
  const NotificationBadge({
    required this.child,
    super.key,
  });

  /// The widget to wrap with the badge.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationNotifierProvider);
    final unreadCount = switch (state) {
      NotificationLoaded(:final notifications) =>
        notifications.where((n) => !n.isRead).length,
      _ => 0,
    };

    if (unreadCount == 0) return child;

    return Badge(
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.onPrimary,
      label: Text(
        unreadCount > 99 ? '99+' : '$unreadCount',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
      child: child,
    );
  }
}
