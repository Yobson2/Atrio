import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// A bento-style stat card with large value, label, and optional progress bar.
///
/// Uses surfaceContainerLowest background with ambient shadow and no borders,
/// following the Editorial Artisan design system.
class StatsSummaryCard extends StatelessWidget {
  /// Creates a [StatsSummaryCard].
  const StatsSummaryCard({
    required this.label,
    required this.value,
    super.key,
    this.icon,
    this.iconColor,
    this.subtitle,
    this.onTap,
    this.progress,
  });

  /// The statistic label (e.g., "Today's Revenue").
  final String label;

  /// The statistic value (e.g., "\$320").
  final String value;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional icon color override.
  final Color? iconColor;

  /// Optional subtitle text below the value.
  final String? subtitle;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Optional progress value (0.0 to 1.0) for the bottom progress bar.
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lgx),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderRadiusLg,
          boxShadow: isDark ? AppShadows.smDark : AppShadows.lgLight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label
            Text(
              label.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            AppSpacing.verticalSm,
            // Large value
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
                letterSpacing: -0.5,
              ),
            ),
            if (subtitle != null) ...[
              AppSpacing.verticalXs,
              Text(
                subtitle!,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: iconColor ?? theme.colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            // Progress bar
            if (progress != null) ...[
              const Spacer(),
              ClipRRect(
                borderRadius: AppRadius.borderRadiusFull,
                child: LinearProgressIndicator(
                  value: progress!.clamp(0.0, 1.0),
                  minHeight: 4,
                  backgroundColor: theme.colorScheme.surfaceContainerHigh,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    iconColor ?? theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
