import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Item definition for [AppSegmentedControl].
class SegmentItem<T> {
  /// Creates a [SegmentItem].
  const SegmentItem({
    required this.value,
    required this.label,
    this.icon,
  });

  /// The value this segment represents.
  final T value;

  /// Display label.
  final String label;

  /// Optional leading icon.
  final IconData? icon;
}

/// Tab-like segmented control for filtering and selection.
///
/// Generic type [T] ensures type-safe selection handling.
class AppSegmentedControl<T> extends StatelessWidget {
  /// Creates an [AppSegmentedControl].
  const AppSegmentedControl({
    required this.items,
    required this.selected,
    required this.onChanged,
    super.key,
    this.isExpanded = true,
  });

  /// Segment definitions.
  final List<SegmentItem<T>> items;

  /// Currently selected value.
  final T selected;

  /// Callback when selection changes.
  final ValueChanged<T> onChanged;

  /// Whether the control takes full width.
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: 'Segmented control',
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: AppRadius.borderRadiusLg,
        ),
        child: Row(
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          children: items.map((item) {
            final isSelected = item.value == selected;
            return isExpanded
                ? Expanded(
                    child: _buildSegment(context, item, isSelected),
                  )
                : _buildSegment(context, item, isSelected);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context,
    SegmentItem<T> item,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onChanged(item.value),
      child: Semantics(
        selected: isSelected,
        button: true,
        label: item.label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.surfaceContainerLowest
                : Colors.transparent,
            borderRadius: AppRadius.borderRadiusMd,
            boxShadow: isSelected ? AppShadows.smLight : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: 16,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                item.label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
