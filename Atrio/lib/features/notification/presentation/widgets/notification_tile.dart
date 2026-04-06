import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';
import 'package:flutter_templates/features/notification/domain/entities/notification_type.dart';

/// A tile displaying a single notification with tonal card styling,
/// icon with primary tint, and no visible borders. Editorial Artisan style.
class NotificationTile extends StatelessWidget {
  /// Creates a [NotificationTile].
  const NotificationTile({
    required this.notification,
    this.onTap,
    super.key,
  });

  /// The notification to display.
  final AppNotification notification;

  /// Called when the tile is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    final colorScheme = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs + 2,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: isUnread
                ? colorScheme.surfaceContainerLowest
                : colorScheme.surfaceContainerLow,
            borderRadius: AppRadius.borderRadiusLg,
            boxShadow: isUnread
                ? (isDark ? AppShadows.smDark : AppShadows.smLight)
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationIcon(
                type: notification.type,
                isUnread: isUnread,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight:
                                  isUnread ? FontWeight.w700 : FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          _formatTimeAgo(notification.createdAt),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      notification.body,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isUnread) ...[
                const SizedBox(width: AppSpacing.sm),
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${(difference.inDays / 7).floor()}w ago';
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({
    required this.type,
    required this.isUnread,
  });

  final NotificationType type;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    final (icon, color) = switch (type) {
      NotificationType.queueUpdate => (
          Icons.hourglass_empty,
          colorScheme.secondary,
        ),
      NotificationType.bookingConfirmed => (
          Icons.event_note,
          colorScheme.primary,
        ),
      NotificationType.turnComing => (
          Icons.notifications_active,
          colorScheme.secondary,
        ),
      NotificationType.bookingReminder => (
          Icons.event_busy,
          colorScheme.tertiary,
        ),
      NotificationType.general => (
          Icons.info_outline,
          colorScheme.onSurfaceVariant,
        ),
    };

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isUnread
            ? color.withValues(alpha: 0.1)
            : colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
        borderRadius: AppRadius.borderRadiusMd,
      ),
      child: Icon(
        icon,
        color: isUnread ? color : colorScheme.onSurfaceVariant,
        size: 22,
      ),
    );
  }
}
