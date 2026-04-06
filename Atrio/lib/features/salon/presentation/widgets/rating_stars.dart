import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Displays a star rating with optional review count.
class RatingStars extends StatelessWidget {
  /// Creates a [RatingStars] widget.
  const RatingStars({
    required this.rating,
    super.key,
    this.size = 16,
    this.reviewCount,
    this.color,
  });

  /// Rating value (0-5).
  final double rating;

  /// Size of each star icon.
  final double size;

  /// Optional review count to display next to the stars.
  final int? reviewCount;

  /// Star color. Defaults to amber.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final starColor = color ?? Colors.amber;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          final starValue = index + 1;
          if (rating >= starValue) {
            return Icon(Icons.star, size: size, color: starColor);
          } else if (rating >= starValue - 0.5) {
            return Icon(Icons.star_half, size: size, color: starColor);
          } else {
            return Icon(Icons.star_border, size: size, color: starColor);
          }
        }),
        if (reviewCount != null) ...[
          AppSpacing.horizontalXs,
          Text(
            '($reviewCount)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
        ],
      ],
    );
  }
}
