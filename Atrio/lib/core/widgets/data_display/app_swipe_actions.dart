import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Action definition for [AppSwipeActions].
class SwipeAction {
  /// Creates a [SwipeAction].
  const SwipeAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.foregroundColor = Colors.white,
  });

  /// Action icon.
  final IconData icon;

  /// Action label.
  final String label;

  /// Background color.
  final Color color;

  /// Icon/text color.
  final Color foregroundColor;

  /// Callback when action is triggered.
  final VoidCallback onTap;
}

/// Dismissible wrapper with themed swipe action buttons.
///
/// Supports leading (swipe right) and trailing (swipe left) actions.
class AppSwipeActions extends StatelessWidget {
  /// Creates an [AppSwipeActions].
  const AppSwipeActions({
    required this.child,
    super.key,
    this.leadingAction,
    this.trailingAction,
    this.confirmDismiss,
  });

  /// The main content widget.
  final Widget child;

  /// Action revealed when swiping right.
  final SwipeAction? leadingAction;

  /// Action revealed when swiping left.
  final SwipeAction? trailingAction;

  /// Optional confirm callback before dismiss completes.
  final Future<bool> Function(DismissDirection)? confirmDismiss;

  @override
  Widget build(BuildContext context) {
    if (leadingAction == null && trailingAction == null) return child;

    return Dismissible(
      key: ValueKey(child.hashCode),
      direction: _direction,
      confirmDismiss: confirmDismiss ?? _defaultConfirm,
      background: leadingAction != null
          ? _buildBackground(leadingAction!, Alignment.centerLeft)
          : null,
      secondaryBackground: trailingAction != null
          ? _buildBackground(trailingAction!, Alignment.centerRight)
          : null,
      child: child,
    );
  }

  DismissDirection get _direction {
    if (leadingAction != null && trailingAction != null) {
      return DismissDirection.horizontal;
    }
    if (leadingAction != null) return DismissDirection.startToEnd;
    return DismissDirection.endToStart;
  }

  Future<bool> _defaultConfirm(DismissDirection direction) async {
    if (direction == DismissDirection.startToEnd) {
      leadingAction?.onTap();
    } else {
      trailingAction?.onTap();
    }
    return false; // Don't dismiss, just trigger the action
  }

  Widget _buildBackground(SwipeAction action, Alignment alignment) {
    return Container(
      color: action.color,
      alignment: alignment,
      padding: AppSpacing.paddingHorizontalXl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(action.icon, color: action.foregroundColor),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            action.label,
            style: TextStyle(
              color: action.foregroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
