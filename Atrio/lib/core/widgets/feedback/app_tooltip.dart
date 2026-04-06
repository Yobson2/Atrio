import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Themed tooltip wrapper.
///
/// Wraps a child with a Material tooltip styled consistently
/// with the app theme.
class AppTooltip extends StatelessWidget {
  /// Creates an [AppTooltip].
  const AppTooltip({
    required this.message,
    required this.child,
    super.key,
    this.preferBelow = true,
  });

  /// Tooltip text.
  final String message;

  /// The widget that triggers the tooltip on long press.
  final Widget child;

  /// Whether the tooltip prefers to appear below the child.
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      decoration: BoxDecoration(
        color: theme.colorScheme.inverseSurface,
        borderRadius: AppRadius.borderRadiusSm,
      ),
      textStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onInverseSurface,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: child,
    );
  }
}
