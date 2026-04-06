import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Horizontal divider with centered text label.
///
/// Commonly used as an "OR" separator between login methods.
class AppDividerWithText extends StatelessWidget {
  /// Creates an [AppDividerWithText].
  const AppDividerWithText({
    required this.text,
    super.key,
    this.color,
    this.thickness = 1,
  });

  /// The text displayed in the center of the divider.
  final String text;

  /// Divider line color. Defaults to the theme divider color.
  final Color? color;

  /// Line thickness.
  final double thickness;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lineColor =
        color ?? theme.colorScheme.outlineVariant.withValues(alpha: 0.15);

    return Row(
      children: [
        Expanded(child: Divider(thickness: thickness, color: lineColor)),
        Padding(
          padding: AppSpacing.paddingHorizontalLg,
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Divider(thickness: thickness, color: lineColor)),
      ],
    );
  }
}
