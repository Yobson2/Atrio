import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_icon_sizes.dart';
import 'package:flutter_templates/core/theme/app_icons.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Tappable star rating input for submitting reviews.
///
/// Supports half-star and full-star selection via tap position.
class AppRatingInput extends StatelessWidget {
  /// Creates an [AppRatingInput].
  const AppRatingInput({
    required this.value,
    required this.onChanged,
    super.key,
    this.starCount = 5,
    this.size = AppIconSizes.xl,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = false,
  });

  /// Current rating value.
  final double value;

  /// Callback when rating changes.
  final ValueChanged<double> onChanged;

  /// Number of stars to display.
  final int starCount;

  /// Size of each star.
  final double size;

  /// Color for filled stars.
  final Color? activeColor;

  /// Color for empty stars.
  final Color? inactiveColor;

  /// Whether half-star ratings are allowed.
  final bool allowHalfRating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor ?? theme.colorScheme.primary;
    final inactive = inactiveColor ?? theme.colorScheme.outlineVariant;

    return Semantics(
      label: 'Rating: ${value.toStringAsFixed(1)} out of $starCount stars',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(starCount, (index) {
          final starValue = index + 1;
          IconData icon;
          Color color;

          if (value >= starValue) {
            icon = AppIcons.rating;
            color = active;
          } else if (value >= starValue - 0.5 && allowHalfRating) {
            icon = AppIcons.ratingHalf;
            color = active;
          } else {
            icon = AppIcons.ratingOutlined;
            color = inactive;
          }

          return GestureDetector(
            onTapUp: (details) {
              if (allowHalfRating) {
                final isLeftHalf = details.localPosition.dx < size / 2;
                onChanged(isLeftHalf ? starValue - 0.5 : starValue.toDouble());
              } else {
                onChanged(starValue.toDouble());
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: index < starCount - 1 ? AppSpacing.xs : 0,
              ),
              child: Icon(icon, size: size, color: color),
            ),
          );
        }),
      ),
    );
  }
}
