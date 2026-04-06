import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Tonal card showing estimated wait time with a large number,
/// matching the Editorial Artisan stats row pattern.
class EstimatedWaitIndicator extends StatelessWidget {
  /// Creates an [EstimatedWaitIndicator].
  const EstimatedWaitIndicator({
    required this.estimatedMinutes,
    this.maxMinutes = 120,
    this.size = 100,
    super.key,
  });

  /// Estimated wait time in minutes.
  final int estimatedMinutes;

  /// Maximum minutes for the progress ring (100% fill).
  final int maxMinutes;

  /// Size of the circular indicator.
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'EST. WAIT',
            style: context.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${estimatedMinutes}m',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
