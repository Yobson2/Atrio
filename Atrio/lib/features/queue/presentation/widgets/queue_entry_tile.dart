import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry_status.dart';

/// A single entry tile in the queue list, using tonal surfaces
/// and no visible borders. Editorial Artisan style.
class QueueEntryTile extends StatelessWidget {
  /// Creates a [QueueEntryTile].
  const QueueEntryTile({
    required this.entry,
    this.isCurrentUser = false,
    super.key,
  });

  /// The queue entry to display.
  final QueueEntry entry;

  /// Whether this tile represents the current user.
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isServing = entry.status == QueueEntryStatus.serving;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lgx),
      decoration: BoxDecoration(
        color: isServing
            ? colorScheme.surfaceContainerLowest
            : colorScheme.surfaceContainerLow,
        borderRadius: AppRadius.borderRadiusLg,
        boxShadow: isServing
            ? (isDark ? AppShadows.smDark : AppShadows.smLight)
            : null,
        border: isServing
            ? Border.all(
                color: colorScheme.primary
                    .withValues(alpha: AppOpacity.ghostBorder),
              )
            : null,
      ),
      child: Row(
        children: [
          // Position circle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isServing
                  ? colorScheme.secondaryContainer
                  : colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isServing
                  ? Icon(
                      Icons.content_cut,
                      size: 20,
                      color: colorScheme.onSecondaryContainer,
                    )
                  : Text(
                      '#${entry.position}',
                      style: context.textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          // Name and status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface.withValues(
                            alpha: isServing ? 1.0 : 0.8,
                          ),
                        ),
                      ),
                    ),
                    if (isCurrentUser)
                      Container(
                        margin: const EdgeInsets.only(left: AppSpacing.sm),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: AppRadius.borderRadiusFull,
                        ),
                        child: Text(
                          'You',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  _subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isServing
                        ? colorScheme.secondary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: isServing ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          // Service info
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'SERVICE',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  entry.serviceName,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface.withValues(
                      alpha: isServing ? 1.0 : 0.8,
                    ),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _subtitle => switch (entry.status) {
        QueueEntryStatus.serving => 'Currently Serving',
        QueueEntryStatus.waiting when entry.estimatedWaitMinutes > 0 =>
          'In Line \u2022 ${entry.estimatedWaitMinutes}m wait',
        QueueEntryStatus.waiting => 'In Line',
        QueueEntryStatus.served => 'Served',
        QueueEntryStatus.skipped => 'Skipped',
      };
}
