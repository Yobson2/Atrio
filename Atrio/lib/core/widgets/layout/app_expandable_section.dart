import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_durations.dart';
import 'package:flutter_templates/core/theme/app_icons.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Collapsible section with animated expand/collapse.
///
/// Displays a tappable header that toggles the visibility
/// of the content below with a smooth animation.
class AppExpandableSection extends StatefulWidget {
  /// Creates an [AppExpandableSection].
  const AppExpandableSection({
    required this.title,
    required this.child,
    super.key,
    this.initiallyExpanded = false,
    this.titleStyle,
    this.leading,
  });

  /// Section title.
  final String title;

  /// The expandable content.
  final Widget child;

  /// Whether the section starts expanded.
  final bool initiallyExpanded;

  /// Optional custom title text style.
  final TextStyle? titleStyle;

  /// Optional leading widget before the title.
  final Widget? leading;

  @override
  State<AppExpandableSection> createState() => _AppExpandableSectionState();
}

class _AppExpandableSectionState extends State<AppExpandableSection>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late final AnimationController _controller;
  late final Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.normal,
    );
    _iconRotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: AppDurations.defaultCurve),
    );
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = widget.titleStyle ??
        theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _toggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  AppSpacing.horizontalSm,
                ],
                Expanded(
                  child: Semantics(
                    header: true,
                    button: true,
                    expanded: _isExpanded,
                    child: Text(widget.title, style: style),
                  ),
                ),
                RotationTransition(
                  turns: _iconRotation,
                  child: Icon(
                    AppIcons.expandMore,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: widget.child,
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: AppDurations.normal,
        ),
      ],
    );
  }
}
