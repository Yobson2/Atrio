import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/app_network_image.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';

/// Card widget displaying a salon preview in the discovery list.
///
/// Editorial Artisan design: surfaceContainerLowest bg, ambient shadow,
/// no visible borders, rounded-2xl, generous padding.
class SalonCard extends StatelessWidget {
  /// Creates a [SalonCard].
  const SalonCard({
    required this.salon,
    required this.onTap,
    super.key,
  });

  /// The salon to display.
  final Salon salon;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusXl,
        boxShadow: AppShadows.lgLight,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.borderRadiusXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image with status badge overlay
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: salon.coverImageUrl != null
                        ? AppNetworkImage(
                            imageUrl: salon.coverImageUrl!,
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.zero,
                          )
                        : ColoredBox(
                            color: context.colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Icons.storefront,
                              size: 48,
                              color: context.colorScheme.onSurface
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                  ),
                  // Open/Closed badge
                  Positioned(
                    top: AppSpacing.lg,
                    right: AppSpacing.lg,
                    child: _OpenStatusBadge(isOpen: salon.isOpen),
                  ),
                ],
              ),
              // Info section
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lgx),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and rating row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            salon.name,
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AppSpacing.horizontalSm,
                        // Rating pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainer,
                            borderRadius: AppRadius.borderRadiusSm,
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
                                salon.rating.toStringAsFixed(1),
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '(${_formatCount(salon.reviewCount)})',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalMd,
                    // Address
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        AppSpacing.horizontalSm,
                        Expanded(
                          child: Text(
                            salon.address,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

class _OpenStatusBadge extends StatelessWidget {
  const _OpenStatusBadge({required this.isOpen});
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isOpen
            ? context.colorScheme.secondaryContainer
            : context.colorScheme.errorContainer,
        borderRadius: AppRadius.borderRadiusFull,
      ),
      child: Text(
        isOpen ? 'OPEN NOW' : 'CLOSED',
        style: context.textTheme.labelSmall?.copyWith(
          color: isOpen
              ? context.colorScheme.onSecondaryContainer
              : context.colorScheme.onErrorContainer,
          fontWeight: FontWeight.w700,
          fontSize: 9,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
