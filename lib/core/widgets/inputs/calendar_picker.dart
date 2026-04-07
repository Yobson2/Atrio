import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Month-view calendar for date selection in booking flow.
///
/// Shows a month grid with selectable dates. Unavailable dates are greyed out.
class CalendarPicker extends StatefulWidget {
  const CalendarPicker({
    required this.onDateSelected,
    super.key,
    this.selectedDate,
    this.availableDates,
    this.initialMonth,
  });

  /// Called when a date is selected.
  final ValueChanged<DateTime> onDateSelected;

  /// Currently selected date.
  final DateTime? selectedDate;

  /// Dates that are available for booking. If null, all future dates are available.
  final Set<DateTime>? availableDates;

  /// Initial month to display.
  final DateTime? initialMonth;

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth ?? DateTime.now();
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  bool _isAvailable(DateTime date) {
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return false;
    }
    if (widget.availableDates != null) {
      return widget.availableDates!.any((d) =>
          d.year == date.year && d.month == date.month && d.day == date.day);
    }
    return true;
  }

  bool _isSelected(DateTime date) {
    if (widget.selectedDate == null) return false;
    return widget.selectedDate!.year == date.year &&
        widget.selectedDate!.month == date.month &&
        widget.selectedDate!.day == date.day;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstWeekday =
        DateTime(_currentMonth.year, _currentMonth.month, 1).weekday;
    // Monday = 1, so offset is firstWeekday - 1
    final offset = firstWeekday - 1;

    const weekdays = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return Column(
      children: [
        // Month nav
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: _previousMonth,
              iconSize: 20,
            ),
            Text(
              '${monthNames[_currentMonth.month - 1]} ${_currentMonth.year}',
              style: theme.textTheme.titleSmall,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: _nextMonth,
              iconSize: 20,
            ),
          ],
        ),
        AppSpacing.verticalSm,

        // Weekday headers
        Row(
          children: weekdays
              .map(
                (d) => Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        AppSpacing.verticalSm,

        // Day grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: offset + daysInMonth,
          itemBuilder: (context, index) {
            if (index < offset) return const SizedBox.shrink();

            final day = index - offset + 1;
            final date = DateTime(_currentMonth.year, _currentMonth.month, day);
            final available = _isAvailable(date);
            final selected = _isSelected(date);
            final today = _isToday(date);

            return GestureDetector(
              onTap: available ? () => widget.onDateSelected(date) : null,
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: selected
                      ? theme.colorScheme.primary
                      : today
                          ? theme.colorScheme.primary.withValues(alpha: 0.1)
                          : null,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: selected
                          ? theme.colorScheme.onPrimary
                          : available
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurface
                                  .withValues(alpha: 0.3),
                      fontWeight:
                          selected || today ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
