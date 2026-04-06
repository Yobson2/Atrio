import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';

/// Displays a compact list of today's bookings for the owner dashboard.
///
/// Uses surfaceContainerLowest cards with ambient shadow, pill-shaped status
/// chips, and no visible borders following the Editorial Artisan design system.
class TodayBookingsList extends StatelessWidget {
  /// Creates a [TodayBookingsList].
  const TodayBookingsList({
    required this.bookings,
    super.key,
    this.onBookingTap,
  });

  /// The list of bookings to display.
  final List<Booking> bookings;

  /// Callback when a booking is tapped.
  final void Function(Booking booking)? onBookingTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (bookings.isEmpty) {
      return Padding(
        padding: AppSpacing.paddingLg,
        child: Center(
          child: Text(
            'No bookings today',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => AppSpacing.verticalSm,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _BookingTile(
          booking: booking,
          position: index + 1,
          onTap: onBookingTap != null ? () => onBookingTap!(booking) : null,
        );
      },
    );
  }
}

class _BookingTile extends StatelessWidget {
  const _BookingTile({
    required this.booking,
    required this.position,
    this.onTap,
  });

  final Booking booking;
  final int position;
  final VoidCallback? onTap;

  Color _statusColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (booking.status) {
      BookingStatus.pending => const Color(0xFFF59E0B),
      BookingStatus.confirmed => colorScheme.secondary,
      BookingStatus.inProgress => const Color(0xFF3B82F6),
      BookingStatus.completed => const Color(0xFF6D7A77),
      BookingStatus.cancelled => colorScheme.error,
      BookingStatus.noShow => const Color(0xFF6D7A77),
    };
  }

  Color _statusBgColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (booking.status) {
      BookingStatus.pending => const Color(0xFFFEF3C7),
      BookingStatus.confirmed => colorScheme.secondaryContainer,
      BookingStatus.inProgress => const Color(0xFFDBEAFE),
      BookingStatus.completed => colorScheme.surfaceContainerHigh,
      BookingStatus.cancelled => colorScheme.errorContainer,
      BookingStatus.noShow => colorScheme.surfaceContainerHigh,
    };
  }

  String _statusLabel() {
    return switch (booking.status) {
      BookingStatus.pending => 'Pending',
      BookingStatus.confirmed => 'Confirmed',
      BookingStatus.inProgress => 'In Progress',
      BookingStatus.completed => 'Completed',
      BookingStatus.cancelled => 'Cancelled',
      BookingStatus.noShow => 'No Show',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusColor = _statusColor(context);
    final statusBg = _statusBgColor(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderRadiusLg,
          boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
        ),
        child: Row(
          children: [
            // Position number badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: AppRadius.borderRadiusMd,
              ),
              alignment: Alignment.center,
              child: Text(
                '$position',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            AppSpacing.horizontalLg,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.serviceName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.verticalXs,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: booking.barberName ?? 'Any barber',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (booking.scheduledAt != null)
                  Text(
                    '${booking.scheduledAt!.hour.toString().padLeft(2, '0')}:'
                    '${booking.scheduledAt!.minute.toString().padLeft(2, '0')}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                AppSpacing.verticalXs,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: AppRadius.borderRadiusFull,
                  ),
                  child: Text(
                    _statusLabel().toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 9,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
