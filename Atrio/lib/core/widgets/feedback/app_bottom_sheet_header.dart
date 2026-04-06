import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_icons.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Title bar with close button for bottom sheets.
///
/// Provides a consistent header layout with title text,
/// optional subtitle, and a close button.
class AppBottomSheetHeader extends StatelessWidget {
  /// Creates an [AppBottomSheetHeader].
  const AppBottomSheetHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.onClose,
    this.trailing,
  });

  /// Header title.
  final String title;

  /// Optional subtitle below the title.
  final String? subtitle;

  /// Close button callback. Uses Navigator.pop when null.
  final VoidCallback? onClose;

  /// Optional trailing widget (e.g., action button).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.lg,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
          IconButton(
            onPressed: onClose ?? () => Navigator.of(context).pop(),
            icon: const Icon(AppIcons.close),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}
