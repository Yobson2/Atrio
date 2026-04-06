import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_icon_sizes.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Icon + label + value information row.
///
/// Commonly used for salon info (address, phone, hours).
class AppInfoRow extends StatelessWidget {
  /// Creates an [AppInfoRow].
  const AppInfoRow({
    required this.icon,
    required this.label,
    super.key,
    this.value,
    this.valueWidget,
    this.onTap,
    this.iconColor,
  });

  /// Leading icon.
  final IconData icon;

  /// Label text.
  final String label;

  /// Optional value text.
  final String? value;

  /// Optional custom value widget (takes precedence over [value]).
  final Widget? valueWidget;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Icon color. Defaults to onSurfaceVariant.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? theme.colorScheme.onSurfaceVariant;

    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: AppIconSizes.md, color: effectiveIconColor),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (value != null || valueWidget != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  valueWidget ??
                      Text(
                        value!,
                        style: theme.textTheme.bodyMedium,
                      ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, child: content);
    }

    return content;
  }
}
