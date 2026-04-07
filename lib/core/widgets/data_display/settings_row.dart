import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// A single row within a [SettingsCardGroup].
///
/// Displays an icon in a tinted container, a label, and an optional
/// trailing widget (defaults to a chevron). Supports error color variant
/// for destructive actions like logout.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.icon,
    required this.label,
    super.key,
    this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor =
        isDestructive ? theme.colorScheme.error : theme.colorScheme.primary;
    final textColor =
        isDestructive ? theme.colorScheme.error : theme.colorScheme.onSurface;
    final bgColor = isDestructive
        ? theme.colorScheme.error.withValues(alpha: 0.1)
        : theme.colorScheme.primary.withValues(alpha: 0.1);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else if (!isDestructive)
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.outline,
              ),
          ],
        ),
      ),
    );
  }
}
