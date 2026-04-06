import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/salon/domain/entities/review.dart';
import 'package:flutter_templates/features/salon/domain/usecases/add_review_usecase.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_providers.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/rating_stars.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/review_card.dart';

/// Page displaying the full list of reviews for a salon.
class SalonReviewsPage extends ConsumerStatefulWidget {
  /// Creates a [SalonReviewsPage].
  const SalonReviewsPage({
    required this.salonId,
    super.key,
  });

  /// The salon ID to load reviews for.
  final String salonId;

  @override
  ConsumerState<SalonReviewsPage> createState() => _SalonReviewsPageState();
}

class _SalonReviewsPageState extends ConsumerState<SalonReviewsPage> {
  List<Review>? _reviews;
  String? _error;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadReviews());
  }

  Future<void> _loadReviews() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result =
        await ref.read(getSalonReviewsUseCaseProvider).call(widget.salonId);

    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _error = failure.message;
        _isLoading = false;
      }),
      (reviews) => setState(() {
        _reviews = reviews;
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: AppRadius.borderRadiusFull,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Icon(
                          Icons.arrow_back,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.horizontalLg,
                  Text(
                    'Reviews',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(child: _buildContent()),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colorScheme.primary,
              context.colorScheme.primaryContainer,
            ],
          ),
          borderRadius: AppRadius.borderRadiusFull,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.primary.withValues(alpha: 0.2),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showAddReviewSheet(context),
            borderRadius: AppRadius.borderRadiusFull,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit,
                    color: context.colorScheme.onPrimary,
                    size: 20,
                  ),
                  AppSpacing.horizontalSm,
                  Text(
                    'Write a Review',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return AppErrorState(
        message: _error!,
        onRetry: _loadReviews,
      );
    }

    final reviews = _reviews;
    if (reviews == null || reviews.isEmpty) {
      return const AppEmptyState(
        icon: Icons.rate_review_outlined,
        title: 'No reviews yet',
        subtitle: 'Be the first to share your experience',
      );
    }

    // Calculate average rating
    final avgRating =
        reviews.fold<double>(0, (sum, r) => sum + r.rating) / reviews.length;

    return RefreshIndicator(
      onRefresh: _loadReviews,
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.jumbo * 2),
        children: [
          // Rating summary bento
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Row(
              children: [
                // Average rating card
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerLowest,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppRadius.xl),
                      ),
                      boxShadow: AppShadows.smLight,
                    ),
                    child: Column(
                      children: [
                        Text(
                          avgRating.toStringAsFixed(1),
                          style: context.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: context.colorScheme.primary,
                            letterSpacing: -1,
                          ),
                        ),
                        AppSpacing.verticalSm,
                        RatingStars(rating: avgRating, size: 18),
                        AppSpacing.verticalSm,
                        Text(
                          'Based on ${reviews.length} reviews',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.horizontalLg,
                // Highlight card
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppRadius.xl),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOP RATED',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onPrimary
                                .withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            fontSize: 9,
                          ),
                        ),
                        AppSpacing.verticalSm,
                        Text(
                          'Precision & Craftsmanship',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.colorScheme.onPrimary,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalXxl,
          // Review list
          ...reviews.map(
            (review) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.sm,
              ),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadius.xl),
                  ),
                ),
                child: ReviewCard(review: review),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddReviewSheet(BuildContext context) async {
    final result = await showModalBottomSheet<_ReviewInput>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: const _AddReviewSheet(),
      ),
    );

    if (result != null && mounted) {
      final addResult = await ref.read(addReviewUseCaseProvider).call(
            AddReviewParams(
              salonId: widget.salonId,
              rating: result.rating,
              comment: result.comment.isEmpty ? null : result.comment,
            ),
          );

      if (mounted) {
        addResult.fold(
          (failure) => context.showSnackBar(
            failure.message,
            isError: true,
          ),
          (_) {
            context.showSnackBar('Review submitted successfully');
            _loadReviews();
          },
        );
      }
    }
  }
}

/// Internal model for collecting review input from the bottom sheet.
class _ReviewInput {
  const _ReviewInput({required this.rating, required this.comment});
  final double rating;
  final String comment;
}

/// Bottom sheet for adding a new review.
class _AddReviewSheet extends StatefulWidget {
  const _AddReviewSheet();

  @override
  State<_AddReviewSheet> createState() => _AddReviewSheetState();
}

class _AddReviewSheetState extends State<_AddReviewSheet> {
  double _rating = 5;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle indicator
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            AppSpacing.verticalXl,

            Text(
              'Write a Review',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            AppSpacing.verticalXxl,

            // Rating selector
            Text(
              'YOUR RATING',
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                fontSize: 10,
              ),
            ),
            AppSpacing.verticalSm,
            Row(
              children: [
                RatingStars(rating: _rating, size: 28),
                AppSpacing.horizontalMd,
                Text(
                  _rating.toStringAsFixed(0),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Slider(
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              label: _rating.toStringAsFixed(0),
              onChanged: (value) => setState(() => _rating = value),
            ),
            AppSpacing.verticalLg,

            // Comment field
            Text(
              'COMMENT (OPTIONAL)',
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                fontSize: 10,
              ),
            ),
            AppSpacing.verticalSm,
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLow,
                borderRadius: AppRadius.borderRadiusLg,
                border: Border.all(
                  color: context.colorScheme.outlineVariant
                      .withValues(alpha: 0.15),
                ),
              ),
              child: TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your experience...',
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(AppSpacing.lg),
                ),
              ),
            ),
            AppSpacing.verticalXxl,

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.colorScheme.primary,
                      context.colorScheme.primaryContainer,
                    ],
                  ),
                  borderRadius: AppRadius.borderRadiusMd,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(
                        _ReviewInput(
                          rating: _rating,
                          comment: _commentController.text.trim(),
                        ),
                      );
                    },
                    borderRadius: AppRadius.borderRadiusMd,
                    child: Center(
                      child: Text(
                        'Submit Review',
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }
}
