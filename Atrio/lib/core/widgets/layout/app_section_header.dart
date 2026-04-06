import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Section header with title and optional trailing action.
///
/// Common pattern for "See All", "View More" links beside section titles.
class AppSectionHeader extends StatelessWidget {
  /// Creates an [AppSectionHeader].
  const AppSectionHeader({
    required this.title,
    super.key,
    this.onAction,
    this.actionText = 'See All',
    this.padding,
  });

  /// Section title text.
  final String title;

  /// Callback when the action button is tapped.
  final VoidCallback? onAction;

  /// Text for the trailing action button.
  final String actionText;

  /// Optional padding around the header.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (onAction != null) ...[
            AppSpacing.horizontalSm,
            GestureDetector(
              onTap: onAction,
              child: Semantics(
                button: true,
                label: '$actionText for $title',
                child: Text(
                  actionText,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
