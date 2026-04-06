import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// A step widget for selecting a service during the booking flow.
///
/// Displays a list of available services to choose from.
class ServiceSelectionStep extends StatelessWidget {
  /// Creates a [ServiceSelectionStep].
  const ServiceSelectionStep({required this.onServiceSelected, super.key});

  /// Callback when a service is selected.
  /// Receives (serviceId, serviceName).
  final void Function(String serviceId, String serviceName) onServiceSelected;

  // Mock services for UI demonstration.
  static const _mockServices = [
    _ServiceItem(
      id: 'service-001',
      name: 'Classic Haircut',
      description: 'Precision clipper work with a meticulous scissor finish.',
      duration: 30,
      price: 35,
      isPopular: true,
    ),
    _ServiceItem(
      id: 'service-002',
      name: 'Hair + Beard Combo',
      description:
          'Full beard shaping followed by a revitalizing hot towel steam.',
      duration: 45,
      price: 50,
    ),
    _ServiceItem(
      id: 'service-003',
      name: 'Beard Trim',
      description: 'Full beard grooming and edge refinement.',
      duration: 15,
      price: 15,
    ),
    _ServiceItem(
      id: 'service-004',
      name: 'Deluxe Package',
      description: 'Haircut, Beard Trim, Face Mask and Scalp Massage.',
      duration: 60,
      price: 75,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingHorizontalXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Service',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Choose your preferred grooming service.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.verticalXl,
        Expanded(
          child: ListView.separated(
            padding: AppSpacing.paddingHorizontalXl,
            itemCount: _mockServices.length,
            separatorBuilder: (_, __) => AppSpacing.verticalLg,
            itemBuilder: (context, index) {
              final service = _mockServices[index];
              return _ServiceCard(
                service: service,
                onTap: () => onServiceSelected(service.id, service.name),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.service,
    required this.onTap,
  });

  final _ServiceItem service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerLowest,
      borderRadius: AppRadius.borderRadiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderRadiusMd,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lgx),
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderRadiusMd,
            boxShadow: AppShadows.smLight,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + badge
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            service.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        if (service.isPopular) ...[
                          AppSpacing.horizontalMd,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary,
                              borderRadius: AppRadius.borderRadiusXs,
                            ),
                            child: Text(
                              'POPULAR',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.onPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 8,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    AppSpacing.verticalSm,
                    // Description
                    Text(
                      service.description,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.verticalMd,
                    // Duration and price
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainerLow,
                            borderRadius: AppRadius.borderRadiusFull,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 14,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                              AppSpacing.horizontalXs,
                              Text(
                                '${service.duration} min',
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.horizontalLg,
                        Text(
                          '\$${service.price.toStringAsFixed(0)}.00',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalMd,
              // Circle indicator
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    this.description = '',
    this.isPopular = false,
  });

  final String id;
  final String name;
  final String description;
  final int duration;
  final double price;
  final bool isPopular;
}
