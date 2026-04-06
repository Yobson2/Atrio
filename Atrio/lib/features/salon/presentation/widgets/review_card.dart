import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/rating_stars.dart';
import 'package:intl/intl.dart';

/// Card widget displaying a salon review.
class ReviewCard extends StatelessWidget {
  /// Creates a [ReviewCard].
  const ReviewCard({
    required this.review,
    super.key,
  });

  /// The review to display.
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingMd,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: user name, rating, date
          Row(
            children: [
              // User avatar placeholder
              CircleAvatar(
                radius: 16,
                backgroundColor: context.colorScheme.primaryContainer,
                child: Text(
                  review.userName.isNotEmpty
                      ? review.userName[0].toUpperCase()
                      : '?',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              AppSpacing.horizontalSm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RatingStars(rating: review.rating, size: 12),
                  ],
                ),
              ),
              Text(
                DateFormat.yMMMd().format(review.createdAt),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          // Comment
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            AppSpacing.verticalSm,
            Text(
              review.comment!,
              style: context.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}
