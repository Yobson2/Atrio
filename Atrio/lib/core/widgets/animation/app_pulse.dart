import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_durations.dart';

/// Pulsing animation for live indicators and attention-drawing elements.
///
/// Repeats a scale pulse between 1.0 and [minScale].
/// Respects reduced-motion settings.
class AppPulse extends StatefulWidget {
  /// Creates an [AppPulse].
  const AppPulse({
    required this.child,
    super.key,
    this.duration = AppDurations.slower,
    this.minScale = 0.85,
  });

  /// The child widget to pulse.
  final Widget child;

  /// Duration of one full pulse cycle.
  final Duration duration;

  /// Minimum scale during the pulse.
  final double minScale;

  @override
  State<AppPulse> createState() => _AppPulseState();
}

class _AppPulseState extends State<AppPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scale = Tween<double>(begin: 1, end: widget.minScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    if (reduceMotion) return widget.child;

    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}
