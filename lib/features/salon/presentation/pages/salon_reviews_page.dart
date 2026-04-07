import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/star_rating.dart';
import 'package:flutter_templates/core/widgets/loading/app_progress.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_notifier.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_state.dart';
import 'package:go_router/go_router.dart';

/// Salon reviews page showing aggregated rating and review list.
class SalonReviewsPage extends ConsumerWidget {
  const SalonReviewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salonDetailNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('Reviews'),
      ),
      body: switch (state) {
        SalonDetailLoaded(:final detail) => SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Aggregated rating
                Text(
                  detail.salon.rating.toStringAsFixed(1),
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpacing.verticalSm,
                StarRating(
                  rating: detail.salon.rating,
                  size: 24,
                ),
                AppSpacing.verticalXs,
                Text(
                  'Based on ${detail.salon.reviewCount} Reviews',
                  style: theme.textTheme.bodySmall,
                ),
                AppSpacing.verticalXl,

                // Top rated label
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'TOP RATED',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                AppSpacing.verticalSm,
                Text(
                  'Precision &\nCraftsmanship',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalMd,

                // Write review button
                OutlinedButton.icon(
                  onPressed: () =>
                      context.showSnackBar('Write a review coming soon'),
                  icon: const Icon(Icons.edit_rounded, size: 18),
                  label: const Text('Write a Review'),
                ),
                AppSpacing.verticalXxl,

                // Review list
                ...detail.reviews.map(
                  (review) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _FullReviewCard(review: review),
                  ),
                ),
              ],
            ),
          ),
        _ => const Center(child: AppProgress()),
      },
    );
  }
}

class _FullReviewCard extends StatelessWidget {
  const _FullReviewCard({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
                child: Text(
                  review.clientName[0],
                  style: theme.textTheme.titleSmall,
                ),
              ),
              AppSpacing.horizontalMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.clientName,
                      style: theme.textTheme.titleSmall,
                    ),
                    StarRating(rating: review.rating, size: 12),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,
          Text(
            review.comment,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
