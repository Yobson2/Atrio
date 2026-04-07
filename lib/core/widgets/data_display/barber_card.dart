import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/star_rating.dart';

/// Grid card displaying a barber with circular photo, name, and rating.
///
/// Used in salon details, booking barber selection, and owner management.
class BarberCard extends StatelessWidget {
  const BarberCard({
    required this.name,
    required this.rating,
    super.key,
    this.photoUrl,
    this.reviewCount,
    this.isSelected = false,
    this.isAvailable = true,
    this.onTap,
  });

  final String name;
  final double rating;
  final String? photoUrl;
  final int? reviewCount;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: theme.colorScheme.primary, width: 2)
              : null,
        ),
        child: Opacity(
          opacity: isAvailable ? 1.0 : 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
                backgroundImage:
                    photoUrl != null ? NetworkImage(photoUrl!) : null,
                child: photoUrl == null
                    ? Icon(
                        Icons.person_rounded,
                        size: 32,
                        color: theme.colorScheme.onSurfaceVariant,
                      )
                    : null,
              ),
              AppSpacing.verticalSm,
              Text(
                name,
                style: theme.textTheme.titleSmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              AppSpacing.verticalXs,
              StarRating(
                rating: rating,
                size: 12,
                showValue: true,
                reviewCount: reviewCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
