import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// A time slot definition.
class TimeSlot {
  /// Creates a [TimeSlot].
  const TimeSlot({
    required this.time,
    this.isAvailable = true,
  });

  /// The time value (e.g., "09:00", "09:30").
  final String time;

  /// Whether this slot is available for booking.
  final bool isAvailable;
}

/// Grid of selectable time slot chips.
///
/// Displays available time slots in a wrap layout for booking flows.
class AppTimeSlotPicker extends StatelessWidget {
  /// Creates an [AppTimeSlotPicker].
  const AppTimeSlotPicker({
    required this.slots,
    required this.onSelected,
    super.key,
    this.selectedSlot,
    this.crossAxisCount = 3,
    this.spacing = AppSpacing.sm,
  });

  /// Available time slots.
  final List<TimeSlot> slots;

  /// Currently selected slot.
  final String? selectedSlot;

  /// Callback when a slot is tapped.
  final ValueChanged<String> onSelected;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Spacing between chips.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Time slot picker',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: 2.5,
        ),
        itemCount: slots.length,
        itemBuilder: (context, index) {
          final slot = slots[index];
          final isSelected = slot.time == selectedSlot;
          return _TimeSlotChip(
            slot: slot,
            isSelected: isSelected,
            onTap: slot.isAvailable ? () => onSelected(slot.time) : null,
          );
        },
      ),
    );
  }
}

class _TimeSlotChip extends StatelessWidget {
  const _TimeSlotChip({
    required this.slot,
    required this.isSelected,
    this.onTap,
  });

  final TimeSlot slot;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = !slot.isAvailable;

    Color bgColor;
    Color textColor;

    if (isSelected) {
      bgColor = theme.colorScheme.primary;
      textColor = theme.colorScheme.onPrimary;
    } else if (isDisabled) {
      bgColor = theme.colorScheme.surfaceContainerHighest;
      textColor = theme.colorScheme.onSurface.withValues(alpha: 0.38);
    } else {
      bgColor = theme.colorScheme.surfaceContainerLow;
      textColor = theme.colorScheme.onSurface;
    }

    return Semantics(
      button: true,
      enabled: !isDisabled,
      selected: isSelected,
      label: '${slot.time}${isDisabled ? ', unavailable' : ''}',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: AppRadius.borderRadiusSm,
          ),
          child: Text(
            slot.time,
            style: theme.textTheme.labelLarge?.copyWith(
              color: textColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
