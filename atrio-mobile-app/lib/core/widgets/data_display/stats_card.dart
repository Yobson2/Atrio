import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Card displaying a metric value with label and optional trend indicator.
///
/// Used in owner dashboard and statistics screens.
class StatsCard extends StatelessWidget {
  const StatsCard({
    required this.label,
    required this.value,
    super.key,
    this.icon,
    this.trend,
    this.trendIsPositive,
    this.suffix,
  });

  /// Metric label (e.g., "Total Bookings").
  final String label;

  /// Metric value (e.g., "1,284").
  final String value;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional trend text (e.g., "+8%").
  final String? trend;

  /// Whether the trend is positive (green) or negative (red).
  final bool? trendIsPositive;

  /// Optional suffix (e.g., "min", "$").
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                AppSpacing.horizontalSm,
              ],
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSm,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    suffix!,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: (trendIsPositive ?? true)
                        ? theme.colorScheme.secondary.withValues(alpha: 0.1)
                        : theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    trend!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: (trendIsPositive ?? true)
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
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
