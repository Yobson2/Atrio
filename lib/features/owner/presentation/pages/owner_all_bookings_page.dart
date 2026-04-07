import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/booking_card.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';

/// Owner view: all bookings with filter chips.
class OwnerAllBookingsPage extends ConsumerStatefulWidget {
  const OwnerAllBookingsPage({super.key});

  @override
  ConsumerState<OwnerAllBookingsPage> createState() => _OwnerAllBookingsPageState();
}

class _OwnerAllBookingsPageState extends ConsumerState<OwnerAllBookingsPage> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BarberBook', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
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
                Text(context.l10n.ownerAllBookingsTitle, style: theme.textTheme.headlineSmall),
                AppSpacing.verticalXs,
                Text(context.l10n.ownerAllBookingsSubtitle, style: theme.textTheme.bodySmall),
                AppSpacing.verticalLg,
                Row(
                  children: ['All', 'Pending', 'Confirmed'].map((f) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: PillChip(label: f, isSelected: _filter == f, onTap: () => setState(() => _filter = f)),
                  )).toList(),
                ),
                AppSpacing.verticalSm,
                Text(
                  '${context.l10n.ownerSortedByDate} • Showing 24 entries',
                  style: theme.textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariantLight),
                ),
              ],
            ),
          ),
          AppSpacing.verticalMd,
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _mockBookings.length,
              separatorBuilder: (_, __) => AppSpacing.verticalMd,
              itemBuilder: (context, index) {
                final b = _mockBookings[index];
                return BookingCard(
                  serviceName: b.service,
                  salonName: 'Alex Precision',
                  date: b.date,
                  time: b.time,
                  price: b.price,
                  status: b.status,
                  barberName: b.barber,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static final _mockBookings = [
    (service: 'Signature Fade & Beard Sculpt', barber: 'Alex Precision', date: 'Oct 12', time: '09:30 AM', price: 65.0, status: BookingCardStatus.confirmed),
    (service: 'Executive Grooming Pack', barber: 'Marcus T.', date: 'Oct 12', time: '10:00 AM', price: 30.0, status: BookingCardStatus.pending),
    (service: 'Shaving, Beard & Grooming', barber: 'Julian S.', date: 'Oct 12', time: '12:00 PM', price: 70.0, status: BookingCardStatus.confirmed),
    (service: 'Classic Hot Towel Shave', barber: 'Alex Precision', date: 'Oct 11', time: '2:00 PM', price: 45.0, status: BookingCardStatus.completed),
  ];
}
