import 'package:flutter/material.dart';

/// Displays a 1-5 star rating with optional numeric value.
///
/// Supports both read-only display and interactive selection modes.
class StarRating extends StatelessWidget {
  const StarRating({
    required this.rating,
    super.key,
    this.size = 16,
    this.color,
    this.maxRating = 5,
    this.showValue = false,
    this.onRatingChanged,
    this.reviewCount,
  });

  /// Current rating value (0.0 to [maxRating]).
  final double rating;

  /// Icon size.
  final double size;

  /// Star color. Defaults to theme's tertiary or amber.
  final Color? color;

  /// Maximum rating (default 5).
  final int maxRating;

  /// Whether to show the numeric value next to stars.
  final bool showValue;

  /// Callback for interactive mode. If null, the widget is read-only.
  final ValueChanged<double>? onRatingChanged;

  /// Optional review count to display.
  final int? reviewCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final starColor = color ?? const Color(0xFFF59E0B);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(maxRating, (index) {
          final starValue = index + 1;
          IconData icon;
          if (rating >= starValue) {
            icon = Icons.star_rounded;
          } else if (rating >= starValue - 0.5) {
            icon = Icons.star_half_rounded;
          } else {
            icon = Icons.star_outline_rounded;
          }

          final star = Icon(
            icon,
            size: size,
            color: rating >= starValue - 0.5 ? starColor : theme.colorScheme.outlineVariant,
          );

          if (onRatingChanged != null) {
            return GestureDetector(
              onTap: () => onRatingChanged!(starValue.toDouble()),
              child: star,
            );
          }
          return star;
        }),
        if (showValue) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount)',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
