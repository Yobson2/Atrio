import 'package:flutter/material.dart';

/// Small colored indicator dot for status display.
///
/// Used for online/offline, open/closed, and other binary status indicators.
class AppStatusDot extends StatelessWidget {
  /// Creates an [AppStatusDot].
  const AppStatusDot({
    super.key,
    this.color,
    this.size = 8,
    this.label,
  });

  /// Dot color. Defaults to the theme's primary color.
  final Color? color;

  /// Dot diameter.
  final double size;

  /// Semantic label for accessibility.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final dotColor = color ?? Theme.of(context).colorScheme.primary;

    return Semantics(
      label: label,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: dotColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
