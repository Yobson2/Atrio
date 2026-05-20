import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/star_rating.dart';
import 'package:flutter_templates/core/widgets/loading/app_progress.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_notifier.dart';
import 'package:go_router/go_router.dart';

/// Booking detail page with timeline, info, and cancel action.
class BookingDetailPage extends ConsumerStatefulWidget {
  const BookingDetailPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  ConsumerState<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends ConsumerState<BookingDetailPage> {
  Booking? _booking;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooking();
  }

  Future<void> _loadBooking() async {
    final repo = ref.read(bookingRepositoryProvider);
    final result = await repo.getBookingById(widget.bookingId);
    result.fold(
      (failure) => setState(() => _isLoading = false),
      (booking) => setState(() {
        _booking = booking;
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.bookingDetailTitle)),
        body: const Center(child: AppProgress()),
      );
    }

    if (_booking == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.bookingDetailTitle)),
        body: const Center(child: Text('Booking not found')),
      );
    }

    final booking = _booking!;
    final statusColor = switch (booking.status) {
      BookingStatus.confirmed => AppColors.primaryLight,
      BookingStatus.pending => AppColors.tertiaryLight,
      BookingStatus.completed => AppColors.successLight,
      BookingStatus.cancelled => AppColors.errorLight,
      _ => AppColors.onSurfaceVariantLight,
    };

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.bookingDetailTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status timeline
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                AppSpacing.horizontalSm,
                Text(
                  booking.status.name[0].toUpperCase() +
                      booking.status.name.substring(1),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: statusColor,
                  ),
                ),
              ],
            ),
            AppSpacing.verticalXl,

            // Service name + price
            Text(
              booking.serviceName,
              style: theme.textTheme.headlineSmall,
            ),
            AppSpacing.verticalXs,
            Text(
              '\$${booking.totalPrice.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.onSurfaceVariantLight,
              ),
            ),
            if (booking.serviceDuration != null) ...[
              AppSpacing.verticalXs,
              Text(
                '${booking.serviceDuration} min',
                style: theme.textTheme.bodySmall,
              ),
            ],
            AppSpacing.verticalXxl,

            // Barber info
            if (booking.barberName != null) ...[
              Text(
                'YOUR BARBER',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                  letterSpacing: 0.8,
                ),
              ),
              AppSpacing.verticalSm,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.surfaceContainerHighLight,
                      child: Text(
                        booking.barberName![0],
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.barberName!,
                            style: theme.textTheme.titleSmall,
                          ),
                          const StarRating(rating: 4.8, size: 12),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.showSnackBar('Barber profile coming soon'),
                      child: Text(context.l10n.bookingDetailViewProfile),
                    ),
                  ],
                ),
              ),
            ],
            AppSpacing.verticalXxl,

            // Date & venue
            _DetailSection(
              icon: Icons.calendar_today_rounded,
              title:
                  '${booking.date.month}/${booking.date.day}/${booking.date.year}',
              subtitle: booking.startTime,
            ),
            AppSpacing.verticalLg,
            _DetailSection(
              icon: Icons.store_rounded,
              title: booking.salonName,
              subtitle: booking.salonAddress,
            ),
            AppSpacing.verticalXxl,

            // Actions
            if (booking.isUpcoming) ...[
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.showSnackBar('Add to calendar coming soon'),
                  icon: const Icon(Icons.calendar_today_rounded, size: 18),
                  label: Text(context.l10n.bookingDetailAddToCalendar),
                ),
              ),
              AppSpacing.verticalMd,
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () async {
                    await ref
                        .read(myBookingsNotifierProvider.notifier)
                        .cancelBooking(booking.id);
                    if (context.mounted) context.pop();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 18,
                    color: AppColors.errorLight,
                  ),
                  label: Text(
                    context.l10n.bookingDetailCancelBooking,
                    style: TextStyle(color: AppColors.errorLight),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        AppSpacing.horizontalMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleSmall),
              if (subtitle != null)
                Text(subtitle!, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
