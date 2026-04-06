import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';
import 'package:flutter_templates/features/notification/presentation/providers/notification_notifier.dart';
import 'package:flutter_templates/features/notification/presentation/providers/notification_state.dart';
import 'package:flutter_templates/features/notification/presentation/widgets/notification_tile.dart';

/// Page displaying all notifications grouped by date.
/// Editorial Artisan style with tonal cards and time-grouped sections.
class NotificationsPage extends ConsumerStatefulWidget {
  /// Creates a [NotificationsPage].
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    // Load notifications when the page is first opened.
    Future.microtask(
      () => ref.read(notificationNotifierProvider.notifier).loadNotifications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationNotifierProvider);

    return Scaffold(
      appBar: AppAppBar(
        title: 'Notifications',
        actions: [
          if (state is NotificationLoaded &&
              state.notifications.any((n) => !n.isRead))
            TextButton(
              onPressed: () => ref
                  .read(notificationNotifierProvider.notifier)
                  .markAllAsRead(),
              style: TextButton.styleFrom(
                foregroundColor: context.colorScheme.primary,
                textStyle: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.borderRadiusFull,
                ),
              ),
              child: const Text('Read all'),
            ),
        ],
      ),
      body: switch (state) {
        NotificationInitial() ||
        NotificationLoading() =>
          const Center(child: CircularProgressIndicator()),
        NotificationError(:final message) => _ErrorState(
            message: message,
            onRetry: () => ref
                .read(notificationNotifierProvider.notifier)
                .loadNotifications(),
          ),
        NotificationLoaded(:final notifications) => notifications.isEmpty
            ? const _EmptyState()
            : _NotificationsList(
                notifications: notifications,
                onNotificationTap: (notification) {
                  if (!notification.isRead) {
                    ref
                        .read(notificationNotifierProvider.notifier)
                        .markAsRead(notification.id);
                  }
                },
                onRefresh: () => ref
                    .read(notificationNotifierProvider.notifier)
                    .loadNotifications(),
              ),
      },
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList({
    required this.notifications,
    required this.onNotificationTap,
    required this.onRefresh,
  });

  final List<AppNotification> notifications;
  final ValueChanged<AppNotification> onNotificationTap;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByDate(notifications);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: AppSpacing.sm,
          bottom: AppSpacing.xxl,
        ),
        itemCount: grouped.length,
        itemBuilder: (context, index) {
          final group = grouped[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg + AppSpacing.xxs,
                  vertical: AppSpacing.md,
                ),
                child: Text(
                  group.label.toUpperCase(),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    fontSize: 11,
                  ),
                ),
              ),
              ...group.notifications.map(
                (notification) => NotificationTile(
                  notification: notification,
                  onTap: () => onNotificationTap(notification),
                ),
              ),
              if (index < grouped.length - 1)
                const SizedBox(height: AppSpacing.md),
            ],
          );
        },
      ),
    );
  }

  List<_DateGroup> _groupByDate(List<AppNotification> notifications) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<AppNotification>> groups = {};

    for (final notification in notifications) {
      final date = DateTime(
        notification.createdAt.year,
        notification.createdAt.month,
        notification.createdAt.day,
      );

      final String label;
      if (date == today) {
        label = 'Today';
      } else if (date == yesterday) {
        label = 'Yesterday';
      } else {
        label = '${_monthName(date.month)} ${date.day}, ${date.year}';
      }

      groups.putIfAbsent(label, () => []).add(notification);
    }

    return groups.entries
        .map((e) => _DateGroup(label: e.key, notifications: e.value))
        .toList();
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

class _DateGroup {
  const _DateGroup({required this.label, required this.notifications});

  final String label;
  final List<AppNotification> notifications;
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.done_all,
              size: 28,
              color: colorScheme.outline,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No notifications yet',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            "You'll be notified about queue updates and bookings",
            style: context.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 28,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: context.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.tonalIcon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
