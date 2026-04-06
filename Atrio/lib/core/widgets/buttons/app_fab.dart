import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Themed FloatingActionButton with optional extended label.
///
/// Provides consistent FAB styling across the app.
class AppFAB extends StatelessWidget {
  /// Creates a circular [AppFAB] with icon only.
  const AppFAB({
    required this.onPressed,
    required this.icon,
    super.key,
    this.tooltip,
    this.heroTag,
    this.backgroundColor,
    this.foregroundColor,
  })  : label = null,
        isExtended = false;

  /// Creates an extended [AppFAB] with icon and label.
  const AppFAB.extended({
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
    this.tooltip,
    this.heroTag,
    this.backgroundColor,
    this.foregroundColor,
  }) : isExtended = true;

  /// Callback when pressed.
  final VoidCallback? onPressed;

  /// FAB icon.
  final IconData icon;

  /// Optional label for extended variant.
  final String? label;

  /// Whether this is an extended FAB.
  final bool isExtended;

  /// Accessibility tooltip.
  final String? tooltip;

  /// Hero tag for FAB animations.
  final Object? heroTag;

  /// Background color. Defaults to primary container.
  final Color? backgroundColor;

  /// Foreground color. Defaults to on primary container.
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fg = foregroundColor ?? theme.colorScheme.onPrimaryContainer;

    if (isExtended && label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        heroTag: heroTag,
        tooltip: tooltip,
        backgroundColor: bg,
        foregroundColor: fg,
        icon: Icon(icon),
        label: Text(label!),
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      tooltip: tooltip ?? label,
      backgroundColor: bg,
      foregroundColor: fg,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          if (label != null) ...[
            AppSpacing.horizontalSm,
            Text(label!),
          ],
        ],
      ),
    );
  }
}
