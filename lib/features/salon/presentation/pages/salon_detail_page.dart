import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/data_display/barber_card.dart';
import 'package:flutter_templates/core/widgets/data_display/star_rating.dart';
import 'package:flutter_templates/core/widgets/loading/app_progress.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/salon/domain/entities/business_hours.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_salon_detail_usecase.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_notifier.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_state.dart';
import 'package:go_router/go_router.dart';

/// Salon detail page showing full info, services, barbers, hours, and reviews.
class SalonDetailPage extends ConsumerStatefulWidget {
  const SalonDetailPage({required this.salonId, super.key});

  final String salonId;

  @override
  ConsumerState<SalonDetailPage> createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends ConsumerState<SalonDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(salonDetailNotifierProvider.notifier).loadSalon(widget.salonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(salonDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('BarberBook'),
      ),
      body: switch (state) {
        SalonDetailLoading() => const Center(child: AppProgress()),
        SalonDetailError(:final message) => AppErrorState(
            message: message,
            onRetry: () => ref
                .read(salonDetailNotifierProvider.notifier)
                .loadSalon(widget.salonId),
          ),
        SalonDetailLoaded(:final detail) => _SalonDetailContent(detail: detail),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _SalonDetailContent extends StatelessWidget {
  const _SalonDetailContent({required this.detail});

  final SalonDetail detail;

  @override
  Widget build(BuildContext context) {
    final salon = detail.salon;
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero image placeholder
                Container(
                  height: 200,
                  width: double.infinity,
                  color: AppColors.surfaceContainerHighLight,
                  child: Center(
                    child: Icon(
                      Icons.store_rounded,
                      size: 64,
                      color: AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Salon name + rating
                      Text(
                        salon.name,
                        style: theme.textTheme.headlineSmall,
                      ),
                      AppSpacing.verticalXs,
                      Row(
                        children: [
                          StarRating(
                            rating: salon.rating,
                            size: 16,
                            showValue: true,
                            reviewCount: salon.reviewCount,
                          ),
                        ],
                      ),
                      AppSpacing.verticalSm,

                      // Address
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.onSurfaceVariantLight,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              salon.address,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),

                      // Phone
                      if (salon.phone != null) ...[
                        AppSpacing.verticalXs,
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 16,
                              color: AppColors.onSurfaceVariantLight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              salon.phone!,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],

                      // Opening hours
                      if (detail.hours.isNotEmpty) ...[
                        AppSpacing.verticalXxl,
                        Text(
                          'Opening Hours',
                          style: theme.textTheme.titleMedium,
                        ),
                        AppSpacing.verticalMd,
                        _HoursSection(hours: detail.hours),
                      ],

                      // Signature services
                      if (detail.services.isNotEmpty) ...[
                        AppSpacing.verticalXxl,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Signature Services',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.push(
                                '/book/service',
                                extra: salon.id,
                              ),
                              child: Text(context.l10n.commonViewAll),
                            ),
                          ],
                        ),
                        AppSpacing.verticalSm,
                        ...detail.services.take(3).map(
                              (svc) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _ServiceRow(
                                  name: svc.name,
                                  description: svc.description,
                                  price: svc.price,
                                  duration: svc.durationMinutes,
                                ),
                              ),
                            ),
                      ],

                      // Elite barbers
                      if (detail.barbers.isNotEmpty) ...[
                        AppSpacing.verticalXl,
                        Text(
                          'Elite Barbers',
                          style: theme.textTheme.titleMedium,
                        ),
                        AppSpacing.verticalMd,
                        SizedBox(
                          height: 140,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: detail.barbers.length,
                            separatorBuilder: (_, __) =>
                                AppSpacing.horizontalMd,
                            itemBuilder: (context, index) {
                              final barber = detail.barbers[index];
                              return SizedBox(
                                width: 120,
                                child: BarberCard(
                                  name: barber.name,
                                  rating: barber.rating,
                                  photoUrl: barber.photoUrl,
                                  reviewCount: barber.reviewCount,
                                ),
                              );
                            },
                          ),
                        ),
                      ],

                      // Latest reviews
                      if (detail.reviews.isNotEmpty) ...[
                        AppSpacing.verticalXxl,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Latest Reviews',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.go(
                                '/discover/salon/${salon.id}/reviews',
                              ),
                              child: Text(context.l10n.commonViewAll),
                            ),
                          ],
                        ),
                        AppSpacing.verticalSm,
                        ...detail.reviews.take(2).map(
                              (review) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _ReviewCard(
                                  name: review.clientName,
                                  rating: review.rating,
                                  comment: review.comment,
                                ),
                              ),
                            ),
                      ],

                      AppSpacing.verticalXxl,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Book Now CTA
        Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLowest,
          ),
          child: SafeArea(
            top: false,
            child: AppGradientButton(
              text: 'Book Now',
              icon: Icons.calendar_month_rounded,
              onPressed: () =>
                  context.push('/book/service', extra: salon.id),
            ),
          ),
        ),
      ],
    );
  }
}

class _HoursSection extends StatelessWidget {
  const _HoursSection({required this.hours});

  final List<BusinessHours> hours;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Show weekday and weekend ranges
    final weekdays = hours.where((h) => h.dayOfWeek <= 5).toList();
    final weekend = hours.where((h) => h.dayOfWeek > 5).toList();

    return Row(
      children: [
        if (weekdays.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WEEKDAYS',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                    letterSpacing: 0.8,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  '${weekdays.first.openTime} – ${weekdays.first.closeTime}',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        if (weekend.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WEEKEND',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                    letterSpacing: 0.8,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  '${weekend.first.openTime} – ${weekend.first.closeTime}',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({
    required this.name,
    required this.price,
    required this.duration,
    this.description,
  });

  final String name;
  final double price;
  final int duration;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.content_cut_rounded,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleSmall),
                if (description != null)
                  Text(
                    description!,
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${price.toStringAsFixed(0)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$duration min',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.name,
    required this.rating,
    required this.comment,
  });

  final String name;
  final double rating;
  final String comment;

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
                radius: 16,
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
                child: Text(
                  name[0],
                  style: theme.textTheme.labelMedium,
                ),
              ),
              AppSpacing.horizontalSm,
              Expanded(
                child: Text(name, style: theme.textTheme.titleSmall),
              ),
              StarRating(rating: rating, size: 12),
            ],
          ),
          AppSpacing.verticalSm,
          Text(
            comment,
            style: theme.textTheme.bodySmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
