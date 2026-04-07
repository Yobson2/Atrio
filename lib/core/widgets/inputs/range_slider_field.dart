import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// A labeled range slider widget with formatted value display.
///
/// Shows a label above the slider and the current range values
/// formatted with an optional suffix (e.g. "km", "\$").
class RangeSliderField extends StatelessWidget {
  /// Creates a [RangeSliderField].
  const RangeSliderField({
    required this.label,
    required this.min,
    required this.max,
    required this.values,
    required this.onChanged,
    super.key,
    this.suffix,
    this.divisions,
  });

  /// Label text shown above the slider.
  final String label;

  /// Minimum value of the range.
  final double min;

  /// Maximum value of the range.
  final double max;

  /// Current selected range values.
  final RangeValues values;

  /// Called when the range values change.
  final ValueChanged<RangeValues> onChanged;

  /// Optional suffix displayed after values (e.g. "km").
  final String? suffix;

  /// Optional number of discrete divisions.
  final int? divisions;

  String _formatValue(double value) {
    final formatted =
        value == value.roundToDouble() ? value.toInt().toString() : value.toStringAsFixed(1);
    return suffix != null ? '$formatted $suffix' : formatted;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge,
            ),
            Text(
              '${_formatValue(values.start)} – ${_formatValue(values.end)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        AppSpacing.verticalSm,
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: theme.colorScheme.primary,
            inactiveTrackColor:
                theme.colorScheme.surfaceContainerHigh,
            thumbColor: theme.colorScheme.primary,
            overlayColor:
                theme.colorScheme.primary.withValues(alpha: 0.12),
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 10,
            ),
            rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
