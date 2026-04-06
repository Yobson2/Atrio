import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_gradients.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry_status.dart';

/// Card showing "You are #N in line" with a gradient primary container,
/// large position number, and action buttons. Editorial Artisan style.
class QueuePositionCard extends StatelessWidget {
  /// Creates a [QueuePositionCard].
  const QueuePositionCard({
    required this.entry,
    this.onLeave,
    super.key,
  });

  /// The current user's queue entry.
  final QueueEntry entry;

  /// Callback when the user taps "Leave Queue".
  final VoidCallback? onLeave;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient =
        isDark ? AppGradients.primaryDark : AppGradients.primaryLight;
    final colorScheme = context.colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: AppRadius.borderRadiusXl,
        boxShadow: isDark ? AppShadows.lgDark : AppShadows.lgLight,
      ),
      child: Stack(
        children: [
          // Abstract texture circles
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _statusTitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color:
                        colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _positionText,
                      style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                    if (entry.status == QueueEntryStatus.waiting) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'in line',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onPrimaryContainer
                              .withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
                if (entry.status == QueueEntryStatus.waiting &&
                    entry.estimatedWaitMinutes > 0) ...[
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: AppRadius.borderRadiusMd,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 18,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Estimated wait: ${entry.estimatedWaitMinutes} min',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                Text(
                  entry.serviceName,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (entry.status == QueueEntryStatus.waiting &&
                    onLeave != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onLeave,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.borderRadiusMd,
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Leave Queue',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _statusTitle => switch (entry.status) {
        QueueEntryStatus.waiting => 'Your Current Position',
        QueueEntryStatus.serving => 'It\'s your turn!',
        QueueEntryStatus.served => 'Service complete',
        QueueEntryStatus.skipped => 'You were skipped',
      };

  String get _positionText => switch (entry.status) {
        QueueEntryStatus.waiting => '#${entry.position}',
        QueueEntryStatus.serving => 'Now serving',
        QueueEntryStatus.served => 'Done',
        QueueEntryStatus.skipped => 'Skipped',
      };
}
