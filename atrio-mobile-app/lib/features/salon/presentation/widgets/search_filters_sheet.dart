import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/buttons/app_secondary_button.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/inputs/range_slider_field.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_filter.dart';

/// Bottom sheet for filtering salon search results.
///
/// Manages filter state locally and returns the applied [SalonFilter]
/// when the user taps "Apply Filters", or `null` if dismissed.
class SearchFiltersSheet extends StatefulWidget {
  const SearchFiltersSheet({
    super.key,
    this.initialFilter,
  });

  /// Initial filter values to populate the sheet.
  final SalonFilter? initialFilter;

  /// Shows the filter sheet and returns the applied filter.
  static Future<SalonFilter?> show(
    BuildContext context, {
    SalonFilter? initialFilter,
  }) {
    return showModalBottomSheet<SalonFilter>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchFiltersSheet(initialFilter: initialFilter),
    );
  }

  @override
  State<SearchFiltersSheet> createState() => _SearchFiltersSheetState();
}

class _SearchFiltersSheetState extends State<SearchFiltersSheet> {
  static const _serviceOptions = [
    'Haircut',
    'Beard',
    'Coloring',
    'Shave',
    'Massage',
  ];

  late RangeValues _distanceRange;
  late int _selectedRating;
  late RangeValues _priceRange;
  late List<String> _selectedServices;
  late bool _availableNow;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter ?? SalonFilter.empty;
    _distanceRange = RangeValues(0, filter.maxDistance ?? 50);
    _selectedRating = filter.minRating?.toInt() ?? 0;
    _priceRange = RangeValues(filter.minPrice ?? 0, filter.maxPrice ?? 200);
    _selectedServices = List<String>.from(filter.serviceTypes);
    _availableNow = filter.availableNow;
  }

  void _reset() {
    setState(() {
      _distanceRange = const RangeValues(0, 50);
      _selectedRating = 0;
      _priceRange = const RangeValues(0, 200);
      _selectedServices = [];
      _availableNow = false;
    });
  }

  void _apply() {
    final filter = SalonFilter(
      maxDistance:
          _distanceRange.end < 50 ? _distanceRange.end : null,
      minRating: _selectedRating > 0 ? _selectedRating.toDouble() : null,
      minPrice: _priceRange.start > 0 ? _priceRange.start : null,
      maxPrice: _priceRange.end < 200 ? _priceRange.end : null,
      serviceTypes: _selectedServices,
      availableNow: _availableNow,
    );
    Navigator.of(context).pop(filter);
  }

  void _toggleService(String service) {
    setState(() {
      if (_selectedServices.contains(service)) {
        _selectedServices.remove(service);
      } else {
        _selectedServices.add(service);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.sm,
              0,
            ),
            child: Row(
              children: [
                Text(
                  context.l10n.filtersTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),

          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Distance
                  SectionLabel(label: context.l10n.filtersDistance),
                  AppSpacing.verticalMd,
                  RangeSliderField(
                    label: '',
                    min: 0,
                    max: 50,
                    values: _distanceRange,
                    divisions: 50,
                    suffix: 'km',
                    onChanged: (values) =>
                        setState(() => _distanceRange = values),
                  ),
                  AppSpacing.verticalXl,

                  // Minimum rating
                  SectionLabel(label: context.l10n.filtersMinimumRating),
                  AppSpacing.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedRating = starIndex),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          child: Icon(
                            starIndex <= _selectedRating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 36,
                            color: starIndex <= _selectedRating
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline,
                          ),
                        ),
                      );
                    }),
                  ),
                  AppSpacing.verticalXl,

                  // Price range
                  SectionLabel(label: context.l10n.filtersPriceRange),
                  AppSpacing.verticalMd,
                  RangeSliderField(
                    label: '',
                    min: 0,
                    max: 200,
                    values: _priceRange,
                    divisions: 40,
                    suffix: r'$',
                    onChanged: (values) =>
                        setState(() => _priceRange = values),
                  ),
                  AppSpacing.verticalXl,

                  // Services
                  SectionLabel(label: context.l10n.filtersServices),
                  AppSpacing.verticalMd,
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: _serviceOptions.map((service) {
                      return PillChip(
                        label: service,
                        isSelected: _selectedServices.contains(service),
                        onTap: () => _toggleService(service),
                      );
                    }).toList(),
                  ),
                  AppSpacing.verticalXl,

                  // Availability
                  SectionLabel(label: context.l10n.filtersAvailability),
                  AppSpacing.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.filtersAvailableNow,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Switch(
                        value: _availableNow,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (value) =>
                            setState(() => _availableNow = value),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom actions
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.lg + bottomPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    text: context.l10n.filtersReset,
                    onPressed: _reset,
                  ),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: AppPrimaryButton(
                    text: context.l10n.filtersApply,
                    onPressed: _apply,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
