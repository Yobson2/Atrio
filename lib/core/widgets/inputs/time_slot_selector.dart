import 'package:flutter/material.dart';

/// Grid of tappable time slot pills for booking flow.
///
/// Available slots are tappable, unavailable are greyed out.
class TimeSlotSelector extends StatelessWidget {
  const TimeSlotSelector({
    required this.slots,
    required this.onSlotSelected,
    super.key,
    this.selectedSlot,
  });

  /// Available time slots.
  final List<TimeSlotData> slots;

  /// Currently selected slot.
  final String? selectedSlot;

  /// Called when a slot is selected.
  final ValueChanged<String> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: slots.map((slot) {
        final isSelected = slot.label == selectedSlot;
        final isAvailable = slot.isAvailable;

        return GestureDetector(
          onTap: isAvailable ? () => onSlotSelected(slot.label) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary
                  : isAvailable
                      ? theme.colorScheme.surfaceContainerLowest
                      : theme.colorScheme.surfaceContainerHigh
                          .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(999),
              border: isAvailable && !isSelected
                  ? Border.all(
                      color: theme.colorScheme.outlineVariant
                          .withValues(alpha: 0.3),
                    )
                  : null,
            ),
            child: Text(
              slot.label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : isAvailable
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurface
                            .withValues(alpha: 0.3),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Data for a single time slot.
class TimeSlotData {
  const TimeSlotData({
    required this.label,
    this.isAvailable = true,
  });

  /// Display label (e.g., "9:00 AM").
  final String label;

  /// Whether this slot can be selected.
  final bool isAvailable;
}
