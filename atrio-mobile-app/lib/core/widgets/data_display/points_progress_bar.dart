import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Animated progress bar showing loyalty tier progress.
///
/// Displays a label, current/target points, and a gradient fill bar.
class PointsProgressBar extends StatelessWidget {
  /// Creates a [PointsProgressBar].
  const PointsProgressBar({
    required this.currentPoints,
    required this.targetPoints,
    required this.label,
    super.key,
  });

  /// Current points earned toward the target.
  final int currentPoints;

  /// Target points for the next tier.
  final int targetPoints;

  /// Descriptive label (e.g. "150 pts to Platinum").
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress =
        (currentPoints / targetPoints).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            Text(
              '$currentPoints/$targetPoints',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        AppSpacing.verticalSm,
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: AppRadius.borderRadiusFull,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppRadius.borderRadiusFull,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primaryContainer,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
