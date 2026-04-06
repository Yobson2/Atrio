import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/presentation/widgets/booking_status_chip.dart';
import 'package:intl/intl.dart';

/// A card displaying a summary of a booking with key details.
///
/// Editorial Artisan design: surfaceContainerLowest bg, rounded-3xl,
/// ambient shadow, bento-style layout with tonal sections.
class BookingSummaryCard extends StatelessWidget {
  /// Creates a [BookingSummaryCard].
  const BookingSummaryCard({required this.booking, super.key});

  /// The booking to display.
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.xl)),
        boxShadow: AppShadows.lgLight,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with salon info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.xl),
            color: context.colorScheme.surfaceContainerLow,
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHighest,
                    borderRadius: AppRadius.borderRadiusMd,
                  ),
                  child: Icon(
                    Icons.storefront,
                    color: context.colorScheme.primary,
                  ),
                ),
                AppSpacing.horizontalLg,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YOUR PROFESSIONAL',
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: context.colorScheme.primary,
                          fontSize: 9,
                        ),
                      ),
                      AppSpacing.verticalXs,
                      Text(
                        booking.barberName ?? booking.salonName,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                BookingStatusChip(status: booking.status),
              ],
            ),
          ),

          // Details section
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service
                Text(
                  'SELECTED SERVICE',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 9,
                  ),
                ),
                AppSpacing.verticalMd,
                Row(
                  children: [
                    Icon(
                      Icons.content_cut,
                      size: 20,
                      color: context.colorScheme.primary,
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.serviceName,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${booking.estimatedDurationMinutes} min',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                AppSpacing.verticalXl,

                // Date and time
                if (booking.scheduledAt != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DURATION',
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: context.colorScheme.onSurfaceVariant,
                                fontSize: 9,
                              ),
                            ),
                            AppSpacing.verticalSm,
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: context.colorScheme.onSurface,
                                ),
                                AppSpacing.horizontalXs,
                                Text(
                                  '${booking.estimatedDurationMinutes} Mins',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRICE',
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: context.colorScheme.onSurfaceVariant,
                                fontSize: 9,
                              ),
                            ),
                            AppSpacing.verticalSm,
                            Row(
                              children: [
                                Icon(
                                  Icons.payments_outlined,
                                  size: 16,
                                  color: context.colorScheme.onSurface,
                                ),
                                AppSpacing.horizontalXs,
                                Text(
                                  '\$${booking.price.toStringAsFixed(2)}',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalXl,

                  // Date card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color:
                          context.colorScheme.primary.withValues(alpha: 0.05),
                      borderRadius: AppRadius.borderRadiusLg,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'APPOINTMENT DATE',
                          style: context.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: context.colorScheme.primary,
                            fontSize: 9,
                          ),
                        ),
                        AppSpacing.verticalMd,
                        Text(
                          DateFormat('MMM d')
                              .format(booking.scheduledAt!)
                              .toUpperCase(),
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: context.colorScheme.primary,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE').format(booking.scheduledAt!),
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        AppSpacing.verticalMd,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: AppRadius.borderRadiusMd,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.alarm,
                                size: 16,
                                color: context.colorScheme.onPrimary,
                              ),
                              AppSpacing.horizontalSm,
                              Text(
                                DateFormat('hh:mm a')
                                    .format(booking.scheduledAt!),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
