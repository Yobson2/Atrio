import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// A step widget for selecting a barber during the booking flow.
///
/// Displays a grid of available barbers with an option to skip.
class BarberSelectionStep extends StatelessWidget {
  /// Creates a [BarberSelectionStep].
  const BarberSelectionStep({required this.onBarberSelected, super.key});

  /// Callback when a barber is selected.
  /// Pass (null, null) for "Any Available" option.
  final void Function(String? barberId, String? barberName) onBarberSelected;

  // Mock barbers for UI demonstration.
  static const _mockBarbers = [
    _BarberItem(id: 'barber-001', name: 'James Wilson', rating: 4.8),
    _BarberItem(id: 'barber-002', name: 'Carlos Rivera', rating: 4.6),
    _BarberItem(id: 'barber-003', name: 'David Kim', rating: 4.9),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingHorizontalXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Text(
            'Choose a Barber',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.verticalSm,
          Text(
            'Select your preferred professional or choose any '
            'available to get the earliest slot.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          AppSpacing.verticalXxl,

          // "Any Available" option
          Material(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: AppRadius.borderRadiusLg,
            child: InkWell(
              onTap: () => onBarberSelected(null, null),
              borderRadius: AppRadius.borderRadiusLg,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer
                            .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shuffle,
                        size: 28,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    AppSpacing.horizontalLg,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Any Available Barber',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppSpacing.verticalXs,
                          Text(
                            'Faster booking, same quality',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: context.colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppSpacing.verticalXxl,

          // Barber grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.lg,
              childAspectRatio: 0.78,
            ),
            itemCount: _mockBarbers.length,
            itemBuilder: (context, index) {
              final barber = _mockBarbers[index];
              return _BarberCard(
                barber: barber,
                onTap: () => onBarberSelected(barber.id, barber.name),
              );
            },
          ),

          AppSpacing.verticalXl,

          // Info chip
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color:
                  context.colorScheme.secondaryContainer.withValues(alpha: 0.2),
              borderRadius: AppRadius.borderRadiusLg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                AppSpacing.horizontalSm,
                Text(
                  'ALL BARBERS ARE CERTIFIED MASTERS',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    fontSize: 10,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalXxl,
        ],
      ),
    );
  }
}

class _BarberCard extends StatelessWidget {
  const _BarberCard({
    required this.barber,
    required this.onTap,
  });

  final _BarberItem barber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerLow,
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.xl)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.xl)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 40,
                backgroundColor: context.colorScheme.surfaceContainerHighest,
                child: Text(
                  barber.name[0],
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              AppSpacing.verticalLg,
              // Name
              Text(
                barber.name,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              AppSpacing.verticalSm,
              // Rating
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLowest
                      .withValues(alpha: 0.5),
                  borderRadius: AppRadius.borderRadiusFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: context.colorScheme.tertiary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      barber.rating.toStringAsFixed(1),
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarberItem {
  const _BarberItem({
    required this.id,
    required this.name,
    required this.rating,
  });

  final String id;
  final String name;
  final double rating;
}
