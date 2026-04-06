import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter_templates/features/booking/presentation/widgets/booking_summary_card.dart';
import 'package:go_router/go_router.dart';

/// Success page shown after a booking is created.
///
/// Fetches booking details by [bookingId] and displays a confirmation
/// with a summary card and navigation options.
class BookingConfirmationPage extends ConsumerStatefulWidget {
  /// Creates a [BookingConfirmationPage].
  const BookingConfirmationPage({required this.bookingId, super.key});

  /// The ID of the newly created booking.
  final String bookingId;

  @override
  ConsumerState<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState
    extends ConsumerState<BookingConfirmationPage> {
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

    final useCase = ref.read(getBookingDetailUseCaseProvider);
    final result = await useCase.call(widget.bookingId);

    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _error = failure.message;
        _isLoading = false;
      }),
      (Booking booking) => setState(() {
        _booking = booking;
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: AppSpacing.paddingXl,
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
        ),
      );
    }

    return SingleChildScrollView(
      padding: AppSpacing.paddingXl,
      child: Column(
        children: [
          AppSpacing.verticalXxl,

          // Success icon with glow
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer
                      .withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.secondaryContainer
                          .withValues(alpha: 0.4),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 48,
                  color: context.colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          AppSpacing.verticalXxl,

          // Title
          Text(
            'Booking Confirmed!',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalMd,
          Text(
            'Your precision grooming session is all set. '
            "We've sent a confirmation to your inbox.",
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalXxl,

          // Summary card
          if (_booking != null) BookingSummaryCard(booking: _booking!),
          AppSpacing.verticalXxl,

          // Action buttons
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
                  onTap: () => context.go('/bookings'),
                  borderRadius: AppRadius.borderRadiusMd,
                  child: Center(
                    child: Text(
                      'View My Bookings',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.verticalLg,
          SizedBox(
            width: double.infinity,
            height: 56,
            child: Material(
              color: Colors.transparent,
              borderRadius: AppRadius.borderRadiusMd,
              child: InkWell(
                onTap: () => context.go('/discover'),
                borderRadius: AppRadius.borderRadiusMd,
                child: Center(
                  child: Text(
                    'Back to Home',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.verticalXxl,

          // Help section
          Text(
            'NEED TO RESCHEDULE OR CANCEL?',
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurfaceVariant,
              letterSpacing: 1.5,
              fontSize: 10,
            ),
          ),
          AppSpacing.verticalLg,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _HelpLink(
                icon: Icons.help_outline,
                label: 'Support Center',
              ),
              AppSpacing.horizontalXl,
              const _HelpLink(
                icon: Icons.policy_outlined,
                label: 'Policy',
              ),
            ],
          ),
          AppSpacing.verticalXxl,
        ],
      ),
    );
  }
}

class _HelpLink extends StatelessWidget {
  const _HelpLink({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: context.colorScheme.onSurfaceVariant,
        ),
        AppSpacing.horizontalXs,
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
