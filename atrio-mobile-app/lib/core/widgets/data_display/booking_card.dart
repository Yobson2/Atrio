import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Card displaying a booking summary with status badge.
///
/// Used in my bookings list (client) and all bookings list (owner).
class BookingCard extends StatelessWidget {
  const BookingCard({
    required this.serviceName,
    required this.salonName,
    required this.date,
    required this.time,
    required this.price,
    required this.status,
    super.key,
    this.barberName,
    this.imageUrl,
    this.onTap,
  });

  final String serviceName;
  final String salonName;
  final String date;
  final String time;
  final double price;
  final BookingCardStatus status;
  final String? barberName;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge + service name
            Row(
              children: [
                Expanded(
                  child: Text(
                    serviceName,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _StatusBadge(status: status),
              ],
            ),
            AppSpacing.verticalSm,

            // Barber + salon
            if (barberName != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    barberName!,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              AppSpacing.verticalXs,
            ],
            Row(
              children: [
                Icon(
                  Icons.store_outlined,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    salonName,
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            AppSpacing.verticalMd,

            // Date, time, price
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(date, style: theme.textTheme.labelMedium),
                AppSpacing.horizontalMd,
                Icon(
                  Icons.schedule_rounded,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(time, style: theme.textTheme.labelMedium),
                const Spacer(),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
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

/// Booking status for display purposes.
enum BookingCardStatus { active, confirmed, pending, completed, cancelled }

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final BookingCardStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final (String label, Color bgColor, Color textColor) = switch (status) {
      BookingCardStatus.active => (
          'Active',
          theme.colorScheme.primary.withValues(alpha: 0.1),
          theme.colorScheme.primary,
        ),
      BookingCardStatus.confirmed => (
          'Confirmed',
          theme.colorScheme.secondary.withValues(alpha: 0.1),
          theme.colorScheme.secondary,
        ),
      BookingCardStatus.pending => (
          'Pending',
          theme.colorScheme.tertiary.withValues(alpha: 0.1),
          theme.colorScheme.tertiary,
        ),
      BookingCardStatus.completed => (
          'Completed',
          theme.colorScheme.surfaceContainerHigh,
          theme.colorScheme.onSurfaceVariant,
        ),
      BookingCardStatus.cancelled => (
          'Cancelled',
          theme.colorScheme.error.withValues(alpha: 0.1),
          theme.colorScheme.error,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
