import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/notification_card.dart';
import 'package:flutter_templates/features/notification/data/datasources/mock_notification_datasource.dart';
import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';
import 'package:go_router/go_router.dart';

/// Notifications page grouped by Today/Yesterday.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  IconData _iconForType(NotificationType type) {
    return switch (type) {
      NotificationType.bookingConfirmed => Icons.calendar_today_rounded,
      NotificationType.queueUpdate => Icons.people_rounded,
      NotificationType.reminder => Icons.notifications_rounded,
      NotificationType.cancellation => Icons.cancel_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notifications = MockNotificationData.notifications;

    final now = DateTime.now();
    final today = notifications
        .where((n) => n.createdAt.day == now.day)
        .toList();
    final yesterday = notifications
        .where((n) => n.createdAt.day != now.day)
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.notificationsTitle),
        actions: [
          TextButton(
            onPressed: () => context.showSnackBar('Mark all read coming soon'),
            child: Text(context.l10n.notificationsReadAll),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (today.isNotEmpty) ...[
              Text(
                context.l10n.notificationsToday,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                  letterSpacing: 0.8,
                ),
              ),
              AppSpacing.verticalMd,
              ...today.map(
                (n) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: NotificationCard(
                    title: n.title,
                    body: n.body,
                    timeAgo: _timeAgo(n.createdAt),
                    icon: _iconForType(n.type),
                    isRead: n.isRead,
                  ),
                ),
              ),
              AppSpacing.verticalXl,
            ],
            if (yesterday.isNotEmpty) ...[
              Text(
                context.l10n.notificationsYesterday,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                  letterSpacing: 0.8,
                ),
              ),
              AppSpacing.verticalMd,
              ...yesterday.map(
                (n) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: NotificationCard(
                    title: n.title,
                    body: n.body,
                    timeAgo: _timeAgo(n.createdAt),
                    icon: _iconForType(n.type),
                    isRead: n.isRead,
                  ),
                ),
              ),
            ],
            AppSpacing.verticalXxl,
            Center(
              child: Text(
                context.l10n.notificationsAllSeen,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
