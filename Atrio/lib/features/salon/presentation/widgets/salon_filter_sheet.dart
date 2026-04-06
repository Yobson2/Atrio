import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/feedback/app_bottom_sheet.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_filter.dart';

/// Shows a bottom sheet with salon filter options.
Future<SalonFilter?> showSalonFilterSheet(
  BuildContext context, {
  SalonFilter? currentFilter,
}) {
  return showAppBottomSheet<SalonFilter>(
    context,
    builder: (ctx) => _SalonFilterContent(currentFilter: currentFilter),
  );
}

class _SalonFilterContent extends StatefulWidget {
  const _SalonFilterContent({this.currentFilter});
  final SalonFilter? currentFilter;

  @override
  State<_SalonFilterContent> createState() => _SalonFilterContentState();
}

class _SalonFilterContentState extends State<_SalonFilterContent> {
  double _minRating = 0;
  bool _isOpenNow = false;
  double _maxDistance = 10;

  @override
  void initState() {
    super.initState();
    _minRating = widget.currentFilter?.minRating ?? 0;
    _isOpenNow = widget.currentFilter?.isOpenNow ?? false;
    _maxDistance = widget.currentFilter?.maxDistance ?? 10;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter Salons',
          style: context.textTheme.titleLarge,
        ),
        AppSpacing.verticalXl,

        // Minimum rating slider
        Text(
          'Minimum Rating: ${_minRating.toStringAsFixed(1)}',
          style: context.textTheme.titleSmall,
        ),
        Slider(
          value: _minRating,
          max: 5,
          divisions: 10,
          label: _minRating.toStringAsFixed(1),
          onChanged: (value) => setState(() => _minRating = value),
        ),
        AppSpacing.verticalMd,

        // Max distance slider
        Text(
          'Max Distance: ${_maxDistance.toStringAsFixed(0)} km',
          style: context.textTheme.titleSmall,
        ),
        Slider(
          value: _maxDistance,
          max: 50,
          divisions: 10,
          label: '${_maxDistance.toStringAsFixed(0)} km',
          onChanged: (value) => setState(() => _maxDistance = value),
        ),
        AppSpacing.verticalMd,

        // Open now toggle
        SwitchListTile(
          title: const Text('Open Now'),
          value: _isOpenNow,
          onChanged: (value) => setState(() => _isOpenNow = value),
          contentPadding: EdgeInsets.zero,
        ),
        AppSpacing.verticalXl,

        // Apply button
        SizedBox(
          width: double.infinity,
          child: AppPrimaryButton(
            text: 'Apply Filters',
            onPressed: () {
              Navigator.of(context).pop(
                SalonFilter(
                  minRating: _minRating > 0 ? _minRating : null,
                  maxDistance: _maxDistance,
                  isOpenNow: _isOpenNow ? true : null,
                ),
              );
            },
          ),
        ),
        AppSpacing.verticalMd,

        // Reset button
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(const SalonFilter());
            },
            child: const Text('Reset Filters'),
          ),
        ),
      ],
    );
  }
}
