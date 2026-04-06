import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/app_network_image.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/rating_stars.dart';

/// Card widget displaying a barber with avatar, name, and rating.
class BarberCard extends StatelessWidget {
  /// Creates a [BarberCard].
  const BarberCard({
    required this.barber,
    super.key,
    this.onTap,
  });

  /// The barber to display.
  final Barber barber;

  /// Optional tap callback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderRadiusMd,
      child: Container(
        width: 100,
        padding: AppSpacing.paddingSm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            if (barber.avatarUrl != null)
              ClipOval(
                child: AppNetworkImage(
                  imageUrl: barber.avatarUrl!,
                  width: 60,
                  height: 60,
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            else
              CircleAvatar(
                radius: 30,
                backgroundColor: context.colorScheme.primaryContainer,
                child: Text(
                  barber.name.isNotEmpty ? barber.name[0].toUpperCase() : '?',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            AppSpacing.verticalSm,
            // Name
            Text(
              barber.name,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXs,
            // Rating
            RatingStars(rating: barber.rating, size: 12),
            // Availability badge
            if (!barber.isAvailable) ...[
              AppSpacing.verticalXs,
              Text(
                'Unavailable',
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
