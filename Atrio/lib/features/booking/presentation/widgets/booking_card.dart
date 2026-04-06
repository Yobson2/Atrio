import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/booking/presentation/widgets/booking_status_chip.dart';
import 'package:intl/intl.dart';

/// A compact card for displaying a booking in a list.
///
/// Editorial Artisan design: rounded-[2rem], surfaceContainerLowest bg,
/// ambient shadow, no visible borders, tonal differentiation.
class BookingCard extends StatelessWidget {
  /// Creates a [BookingCard].
  const BookingCard({
    required this.booking,
    required this.onTap,
    super.key,
  });

  /// The booking to display.
  final Booking booking;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  bool get _isInProgress => booking.status == BookingStatus.inProgress;

  @override
  Widget build(BuildContext context) {
    // In-progress bookings use primary bg for highlight
    if (_isInProgress) {
      return _buildHighlightCard(context);
    }
    return _buildDefaultCard(context);
  }

  Widget _buildDefaultCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        boxShadow: AppShadows.lgLight,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status + icon row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookingStatusChip(status: booking.status),
                          AppSpacing.verticalMd,
                          Text(
                            booking.serviceName,
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.horizontalMd,
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLow,
                        borderRadius: AppRadius.borderRadiusLg,
                      ),
                      child: Icon(
                        Icons.content_cut,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalLg,

                // Barber row
                if (booking.barberName != null)
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            context.colorScheme.surfaceContainerHighest,
                        child: Text(
                          booking.barberName![0],
                          style: context.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                      AppSpacing.horizontalMd,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BARBER',
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: context.colorScheme.onSurfaceVariant,
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              booking.barberName!,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                AppSpacing.verticalLg,

                // Date/time and location
                Divider(
                  color: context.colorScheme.surfaceContainerHigh
                      .withValues(alpha: 0.2),
                  height: 1,
                ),
                AppSpacing.verticalLg,
                Row(
                  children: [
                    if (booking.scheduledAt != null) ...[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DATE',
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                color: context.colorScheme.onSurfaceVariant,
                                fontSize: 9,
                              ),
                            ),
                            AppSpacing.verticalXs,
                            Text(
                              DateFormat('MMM d, yyyy')
                                  .format(booking.scheduledAt!),
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TIME',
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                color: context.colorScheme.onSurfaceVariant,
                                fontSize: 9,
                              ),
                            ),
                            AppSpacing.verticalXs,
                            Text(
                              DateFormat('h:mm a').format(booking.scheduledAt!),
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(alpha: 0.2),
            blurRadius: 48,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          child: Stack(
            children: [
              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        context.colorScheme.primaryContainer
                            .withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: AppRadius.borderRadiusFull,
                                ),
                                child: Text(
                                  'IN PROGRESS',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              AppSpacing.verticalMd,
                              Text(
                                booking.serviceName,
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.horizontalMd,
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: AppRadius.borderRadiusLg,
                          ),
                          child: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalXl,
                    // View details button
                    SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: Colors.white,
                        borderRadius: AppRadius.borderRadiusMd,
                        child: InkWell(
                          onTap: onTap,
                          borderRadius: AppRadius.borderRadiusMd,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                            child: Center(
                              child: Text(
                                'View Details',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
