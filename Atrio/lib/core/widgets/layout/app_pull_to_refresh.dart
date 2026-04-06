import 'package:flutter/material.dart';

/// Themed pull-to-refresh wrapper.
///
/// Wraps a scrollable child with a [RefreshIndicator] styled
/// to match the app theme.
class AppPullToRefresh extends StatelessWidget {
  /// Creates an [AppPullToRefresh].
  const AppPullToRefresh({
    required this.onRefresh,
    required this.child,
    super.key,
    this.color,
    this.displacement = 40,
    this.edgeOffset = 0,
  });

  /// Callback triggered on pull-to-refresh. Must return a [Future].
  final Future<void> Function() onRefresh;

  /// The scrollable child widget.
  final Widget child;

  /// Indicator color. Defaults to the primary color.
  final Color? color;

  /// Distance from the top before the indicator shows.
  final double displacement;

  /// Offset from the edge of the screen.
  final double edgeOffset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.surface,
      displacement: displacement,
      edgeOffset: edgeOffset,
      child: child,
    );
  }
}
