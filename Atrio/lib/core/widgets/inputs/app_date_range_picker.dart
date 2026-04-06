import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_icons.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Date range selection widget.
///
/// Displays start and end date fields that open a Material date range picker.
class AppDateRangePicker extends StatelessWidget {
  /// Creates an [AppDateRangePicker].
  const AppDateRangePicker({
    required this.onChanged,
    super.key,
    this.startDate,
    this.endDate,
    this.firstDate,
    this.lastDate,
    this.label,
    this.helpText = 'Select date range',
  });

  /// Currently selected start date.
  final DateTime? startDate;

  /// Currently selected end date.
  final DateTime? endDate;

  /// Earliest selectable date.
  final DateTime? firstDate;

  /// Latest selectable date.
  final DateTime? lastDate;

  /// Optional label above the picker.
  final String? label;

  /// Help text for the date picker dialog.
  final String helpText;

  /// Callback with selected date range.
  final void Function(DateTimeRange range) onChanged;

  String _formatDate(DateTime? date) {
    if (date == null) return '—';
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _showPicker(BuildContext context) async {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? now.subtract(const Duration(days: 365)),
      lastDate: lastDate ?? now.add(const Duration(days: 365)),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
      helpText: helpText,
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme,
          ),
          child: child!,
        );
      },
    );
    if (result != null) {
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: theme.textTheme.labelMedium),
          AppSpacing.verticalSm,
        ],
        GestureDetector(
          onTap: () => _showPicker(context),
          child: Semantics(
            button: true,
            label: 'Date range: ${_formatDate(startDate)} to '
                '${_formatDate(endDate)}',
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                borderRadius: AppRadius.borderRadiusMd,
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: Row(
                children: [
                  Icon(
                    AppIcons.calendar,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  AppSpacing.horizontalSm,
                  Text(
                    _formatDate(startDate),
                    style: theme.textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: AppSpacing.paddingHorizontalLg,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _formatDate(endDate),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Icon(
                    AppIcons.expandMore,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
