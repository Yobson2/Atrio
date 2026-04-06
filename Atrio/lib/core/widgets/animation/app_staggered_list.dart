import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_durations.dart';

/// Staggered entrance animation for a list of children.
///
/// Each child fades and slides in with a delay offset.
/// Respects reduced-motion settings.
class AppStaggeredList extends StatelessWidget {
  /// Creates an [AppStaggeredList].
  const AppStaggeredList({
    required this.children,
    super.key,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.duration = AppDurations.normal,
    this.offset = 16.0,
  });

  /// The widgets to stagger-animate in.
  final List<Widget> children;

  /// Delay between each child's animation start.
  final Duration staggerDelay;

  /// Duration for each child's animation.
  final Duration duration;

  /// Vertical offset to slide from.
  final double offset;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    if (reduceMotion) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(children.length, (index) {
        return _StaggeredChild(
          delay: staggerDelay * index,
          duration: duration,
          offset: offset,
          child: children[index],
        );
      }),
    );
  }
}

class _StaggeredChild extends StatefulWidget {
  const _StaggeredChild({
    required this.child,
    required this.delay,
    required this.duration,
    required this.offset,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  @override
  State<_StaggeredChild> createState() => _StaggeredChildState();
}

class _StaggeredChildState extends State<_StaggeredChild>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppDurations.enterCurve,
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    _position = Tween<Offset>(
      begin: Offset(0, widget.offset),
      end: Offset.zero,
    ).animate(curved);

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _position.value,
          child: Opacity(
            opacity: _opacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
