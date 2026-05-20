import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/booking_card.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_notifier.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_state.dart';
import 'package:go_router/go_router.dart';

/// My bookings page showing upcoming and past bookings.
class MyBookingsPage extends ConsumerStatefulWidget {
  const MyBookingsPage({super.key});

  @override
  ConsumerState<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends ConsumerState<MyBookingsPage> {
  bool _showUpcoming = true;

  BookingCardStatus _mapStatus(BookingStatus status) {
    return switch (status) {
      BookingStatus.confirmed => BookingCardStatus.confirmed,
      BookingStatus.pending => BookingCardStatus.pending,
      BookingStatus.completed => BookingCardStatus.completed,
      BookingStatus.cancelled => BookingCardStatus.cancelled,
      BookingStatus.rescheduled => BookingCardStatus.active,
    };
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myBookingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BarberBook',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.myBookingsTitle,
                  style: context.textTheme.headlineSmall,
                ),
                AppSpacing.verticalXs,
                Text(
                  context.l10n.myBookingsSubtitle,
                  style: context.textTheme.bodySmall,
                ),
                AppSpacing.verticalLg,
                Row(
                  children: [
                    PillChip(
                      label: context.l10n.myBookingsUpcoming,
                      isSelected: _showUpcoming,
                      onTap: () => setState(() => _showUpcoming = true),
                    ),
                    AppSpacing.horizontalSm,
                    PillChip(
                      label: context.l10n.myBookingsPast,
                      isSelected: !_showUpcoming,
                      onTap: () => setState(() => _showUpcoming = false),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.verticalLg,
          Expanded(
            child: switch (state) {
              MyBookingsLoading() => const AppShimmerList(),
              MyBookingsError(:final message) => AppErrorState(
                  message: message,
                  onRetry: () => ref
                      .read(myBookingsNotifierProvider.notifier)
                      .loadBookings(),
                ),
              MyBookingsLoaded(:final bookings) => _buildList(bookings),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Booking> bookings) {
    final filtered = bookings
        .where((b) => _showUpcoming ? b.isUpcoming : b.isPast)
        .toList();

    if (filtered.isEmpty) {
      return AppEmptyState(
        title: context.l10n.emptyStateTitle,
        subtitle: context.l10n.emptyStateSubtitle,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => AppSpacing.verticalMd,
      itemBuilder: (context, index) {
        final booking = filtered[index];
        return BookingCard(
          serviceName: booking.serviceName,
          salonName: booking.salonName,
          date: '${booking.date.month}/${booking.date.day}/${booking.date.year}',
          time: booking.startTime,
          price: booking.totalPrice,
          status: _mapStatus(booking.status),
          barberName: booking.barberName,
          onTap: () => context.go('/bookings/detail/${booking.id}'),
        );
      },
    );
  }
}
