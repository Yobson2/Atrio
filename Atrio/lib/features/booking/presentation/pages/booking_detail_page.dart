import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_type.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_notifier.dart';
import 'package:flutter_templates/features/booking/presentation/providers/my_bookings_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Page displaying a single booking's details with cancel option.
class BookingDetailPage extends ConsumerStatefulWidget {
  /// Creates a [BookingDetailPage].
  const BookingDetailPage({required this.bookingId, super.key});

  /// The ID of the booking to display.
  final String bookingId;

  @override
  ConsumerState<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends ConsumerState<BookingDetailPage> {
  Booking? _booking;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBooking();
  }

  Future<void> _loadBooking() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result =
        await ref.read(getBookingDetailUseCaseProvider).call(widget.bookingId);

    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _error = failure.message;
        _isLoading = false;
      }),
      (booking) => setState(() {
        _booking = booking;
        _isLoading = false;
      }),
    );
  }

  bool get _canCancel {
    if (_booking == null) return false;
    return _booking!.status == BookingStatus.pending ||
        _booking!.status == BookingStatus.confirmed;
  }

  Future<void> _cancelBooking() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.xl)),
        ),
        title: const Text('Cancel Booking'),
        content: const Text(
          'Are you sure you want to cancel this booking?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: context.colorScheme.error,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    ref
        .read(myBookingsNotifierProvider.notifier)
        .cancelBooking(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<MyBookingsState>(myBookingsNotifierProvider, (_, state) {
      switch (state) {
        case MyBookingsLoaded():
          context.showSnackBar('Booking cancelled');
          context.pop();
        case MyBookingsError(:final message):
          context.showSnackBar(message, isError: true);
        default:
          break;
      }
    });

    final myBookingsState = ref.watch(myBookingsNotifierProvider);
    final isCancelling = myBookingsState is MyBookingsLoading;

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
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.horizontalLg,
                  Text(
                    'Booking Details',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  if (_booking != null)
                    Icon(
                      Icons.share_outlined,
                      color: context.colorScheme.primary,
                    ),
                ],
              ),
            ),
            // Body
            Expanded(child: _buildBody(isCancelling)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(bool isCancelling) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: context.colorScheme.error,
            ),
            AppSpacing.verticalMd,
            Text(
              _error!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalMd,
            FilledButton(
              onPressed: _loadBooking,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_booking == null) {
      return const Center(child: Text('Booking not found'));
    }

    final booking = _booking!;

    return SingleChildScrollView(
      padding: AppSpacing.paddingHorizontalXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color:
                  context.colorScheme.secondaryContainer.withValues(alpha: 0.3),
              borderRadius: AppRadius.borderRadiusLg,
              boxShadow: AppShadows.smLight,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: context.colorScheme.onSecondary,
                  ),
                ),
                AppSpacing.horizontalLg,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.status.name[0].toUpperCase() +
                            booking.status.name.substring(1),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'Your appointment is scheduled.',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalXl,

          // Service detail card
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: AppRadius.borderRadiusLg,
              boxShadow: AppShadows.lgLight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SERVICE',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
                AppSpacing.verticalSm,
                Text(
                  booking.serviceName,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: context.colorScheme.primary,
                    letterSpacing: -0.5,
                  ),
                ),
                AppSpacing.verticalLg,
                Row(
                  children: [
                    Text(
                      '\$${booking.price.toStringAsFixed(0)}',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSpacing.horizontalSm,
                    Text(
                      '/ ${booking.estimatedDurationMinutes} min',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.verticalLg,

          // Barber card
          if (booking.barberName != null)
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLowest,
                borderRadius: AppRadius.borderRadiusLg,
                boxShadow: AppShadows.lgLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'YOUR ARTISAN',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: context.colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                  AppSpacing.verticalMd,
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                            context.colorScheme.surfaceContainerHighest,
                        child: Text(
                          booking.barberName![0],
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                      AppSpacing.horizontalLg,
                      Expanded(
                        child: Text(
                          booking.barberName!,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          AppSpacing.verticalLg,

          // Date/time card
          if (booking.scheduledAt != null)
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLowest,
                borderRadius: AppRadius.borderRadiusLg,
                boxShadow: AppShadows.lgLight,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color:
                          context.colorScheme.primary.withValues(alpha: 0.05),
                      borderRadius: AppRadius.borderRadiusLg,
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  AppSpacing.horizontalLg,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, MMM d')
                              .format(booking.scheduledAt!),
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          DateFormat('h:mm a').format(booking.scheduledAt!),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          AppSpacing.verticalLg,

          // Salon location card
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: AppRadius.borderRadiusLg,
              boxShadow: AppShadows.lgLight,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLowest,
                    borderRadius: AppRadius.borderRadiusMd,
                    boxShadow: AppShadows.smLight,
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: context.colorScheme.primary,
                  ),
                ),
                AppSpacing.horizontalLg,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.salonName,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'View location',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalXxl,

          // Walk-in queue button
          if (booking.type == BookingType.walkIn) ...[
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
                  borderRadius: AppRadius.borderRadiusLg,
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
                    onTap: () => context.push(
                      '/queue',
                      extra: <String, dynamic>{
                        'salonId': booking.salonId,
                        'salonName': booking.salonName,
                      },
                    ),
                    borderRadius: AppRadius.borderRadiusLg,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.queue_outlined,
                          color: context.colorScheme.onPrimary,
                        ),
                        AppSpacing.horizontalSm,
                        Text(
                          'View Queue',
                          style: context.textTheme.titleSmall?.copyWith(
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
            AppSpacing.verticalLg,
          ],

          // Cancel button
          if (_canCancel) ...[
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Material(
                color: context.colorScheme.surfaceContainerHigh,
                borderRadius: AppRadius.borderRadiusLg,
                child: InkWell(
                  onTap: isCancelling ? null : _cancelBooking,
                  borderRadius: AppRadius.borderRadiusLg,
                  child: Center(
                    child: isCancelling
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Cancel Booking',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: context.colorScheme.tertiary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            AppSpacing.verticalMd,
            Text(
              'Cancellations within 24 hours of the appointment '
              'may incur a fee as per studio policy.',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          AppSpacing.verticalXxl,
        ],
      ),
    );
  }
}
