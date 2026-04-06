import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_durations.dart';

/// Tap-down scale effect for interactive cards and surfaces.
///
/// Wraps a child with a subtle press-down animation (scales to 0.97)
/// that provides tactile feedback. Respects reduced-motion settings.
class AppAnimatedScale extends StatefulWidget {
  /// Creates an [AppAnimatedScale].
  const AppAnimatedScale({
    required this.child,
    super.key,
    this.onTap,
    this.scaleValue = 0.97,
    this.duration = AppDurations.fast,
  });

  /// The child widget to animate.
  final Widget child;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Scale factor when pressed.
  final double scaleValue;

  /// Animation duration.
  final Duration duration;

  @override
  State<AppAnimatedScale> createState() => _AppAnimatedScaleState();
}

class _AppAnimatedScaleState extends State<AppAnimatedScale> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed && !reduceMotion ? widget.scaleValue : 1.0,
        duration: reduceMotion ? Duration.zero : widget.duration,
        curve: AppDurations.defaultCurve,
        child: widget.child,
      ),
    );
  }
}
