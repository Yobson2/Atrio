import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Card showing the user's queue position and estimated wait time.
///
/// Displays position number, wait time, and action buttons.
class QueuePositionCard extends StatelessWidget {
  const QueuePositionCard({
    required this.position,
    required this.estimatedWaitMinutes,
    super.key,
    this.onImHere,
    this.onLeaveQueue,
  });

  final int position;
  final int estimatedWaitMinutes;
  final VoidCallback? onImHere;
  final VoidCallback? onLeaveQueue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Your Current Position',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
            ),
          ),
          AppSpacing.verticalSm,
          Text(
            '#$position',
            style: theme.textTheme.displayMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'in line',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
            ),
          ),
          AppSpacing.verticalMd,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 14,
                  color: theme.colorScheme.onPrimary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Estimated wait: $estimatedWaitMinutes min',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalXl,
          Row(
            children: [
              if (onImHere != null)
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: onImHere,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.onPrimary,
                        foregroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("I'm Here"),
                    ),
                  ),
                ),
              if (onImHere != null && onLeaveQueue != null)
                AppSpacing.horizontalMd,
              if (onLeaveQueue != null)
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: onLeaveQueue,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.onPrimary,
                        side: BorderSide(
                          color:
                              theme.colorScheme.onPrimary.withValues(alpha: 0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Leave Queue'),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
