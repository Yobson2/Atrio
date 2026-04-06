import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_notifier.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_state.dart';
import 'package:flutter_templates/features/booking/presentation/widgets/barber_selection_step.dart';
import 'package:flutter_templates/features/booking/presentation/widgets/service_selection_step.dart';
import 'package:flutter_templates/features/booking/presentation/widgets/time_selection_step.dart';
import 'package:go_router/go_router.dart';

/// Multi-step booking flow page.
///
/// Guides the user through: service -> barber -> time -> confirm.
class BookingFlowPage extends ConsumerStatefulWidget {
  /// Creates a [BookingFlowPage].
  const BookingFlowPage({
    required this.salonId,
    this.salonName = '',
    super.key,
  });

  /// The salon to book at.
  final String salonId;

  /// Display name of the salon.
  final String salonName;

  @override
  ConsumerState<BookingFlowPage> createState() => _BookingFlowPageState();
}

class _BookingFlowPageState extends ConsumerState<BookingFlowPage> {
  @override
  void initState() {
    super.initState();
    // Start the flow when the page is first shown.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingFlowNotifierProvider.notifier).startFlow(widget.salonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(bookingFlowNotifierProvider);
    final notifier = ref.read(bookingFlowNotifierProvider.notifier);

    ref.listen<BookingFlowState>(bookingFlowNotifierProvider, (_, state) {
      switch (state) {
        case BookingFlowSuccess(:final booking):
          context.go(
            '/booking/confirmation',
            extra: booking.id,
          );
        case BookingFlowError(:final message):
          context.showSnackBar(message, isError: true);
        default:
          break;
      }
    });

    return PopScope(
      canPop: flowState is BookingFlowSelectingService ||
          flowState is BookingFlowInitial,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          notifier.goBack();
        }
      },
      child: Scaffold(
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
                        onTap: () {
                          if (flowState is BookingFlowSelectingService ||
                              flowState is BookingFlowInitial) {
                            context.pop();
                          } else {
                            notifier.goBack();
                          }
                        },
                        borderRadius: AppRadius.borderRadiusFull,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Icon(
                            Icons.arrow_back,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          _appBarTitle(flowState),
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        Text(
                          'STEP ${_currentStep(flowState) + 1} OF 4',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.6),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              // Progress bar
              _StepIndicator(state: flowState),
              AppSpacing.verticalXl,
              // Step content
              Expanded(child: _buildStep(flowState, notifier)),
            ],
          ),
        ),
      ),
    );
  }

  String _appBarTitle(BookingFlowState state) {
    return switch (state) {
      BookingFlowSelectingService() => 'Book Appointment',
      BookingFlowSelectingBarber() => 'Book Appointment',
      BookingFlowSelectingTime() => 'Book Appointment',
      BookingFlowConfirming() => 'Book Appointment',
      BookingFlowLoading() => 'Creating Booking...',
      _ => 'Book Appointment',
    };
  }

  int _currentStep(BookingFlowState state) {
    return switch (state) {
      BookingFlowInitial() || BookingFlowSelectingService() => 0,
      BookingFlowSelectingBarber() => 1,
      BookingFlowSelectingTime() => 2,
      BookingFlowConfirming() || BookingFlowLoading() => 3,
      BookingFlowSuccess() || BookingFlowError() => 3,
    };
  }

  Widget _buildStep(BookingFlowState state, BookingFlowNotifier notifier) {
    return switch (state) {
      BookingFlowInitial() ||
      BookingFlowSelectingService() =>
        ServiceSelectionStep(
          onServiceSelected: (id, name) =>
              notifier.selectService(serviceId: id, serviceName: name),
        ),
      BookingFlowSelectingBarber() => BarberSelectionStep(
          onBarberSelected: (id, name) =>
              notifier.selectBarber(barberId: id, barberName: name),
        ),
      BookingFlowSelectingTime() => TimeSelectionStep(
          onTimeSelected: notifier.selectTime,
        ),
      BookingFlowConfirming() => _ConfirmationStep(notifier: notifier),
      BookingFlowLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      BookingFlowSuccess() || BookingFlowError() => const SizedBox.shrink(),
    };
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.state});

  final BookingFlowState state;

  int get _currentStep {
    return switch (state) {
      BookingFlowInitial() || BookingFlowSelectingService() => 0,
      BookingFlowSelectingBarber() => 1,
      BookingFlowSelectingTime() => 2,
      BookingFlowConfirming() || BookingFlowLoading() => 3,
      BookingFlowSuccess() || BookingFlowError() => 3,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingHorizontalXl,
      child: Column(
        children: [
          // Step labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StepLabel(
                label: 'Service',
                isActive: _currentStep >= 0,
              ),
              _StepLabel(
                label: 'Barber',
                isActive: _currentStep >= 1,
              ),
              _StepLabel(
                label: 'Time',
                isActive: _currentStep >= 2,
              ),
              _StepLabel(
                label: 'Confirm',
                isActive: _currentStep >= 3,
              ),
            ],
          ),
          AppSpacing.verticalSm,
          // Progress bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHigh,
              borderRadius: AppRadius.borderRadiusFull,
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: List.generate(4, (index) {
                final isActive = index <= _currentStep;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: index < 3 ? 2 : 0,
                    ),
                    color: isActive
                        ? context.colorScheme.primary
                        : Colors.transparent,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepLabel extends StatelessWidget {
  const _StepLabel({required this.label, required this.isActive});
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: context.textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        fontSize: 10,
        color: isActive
            ? context.colorScheme.primary
            : context.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
      ),
    );
  }
}

class _ConfirmationStep extends StatelessWidget {
  const _ConfirmationStep({required this.notifier});

  final BookingFlowNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingHorizontalXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirm Booking',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          AppSpacing.verticalSm,
          Text(
            'Please review your appointment details below.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          AppSpacing.verticalXxl,

          // Summary card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.xl)),
              boxShadow: AppShadows.lgLight,
            ),
            child: Column(
              children: [
                // Salon header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLow,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.xl),
                      topRight: Radius.circular(AppRadius.xl),
                    ),
                  ),
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
                        child: Text(
                          'Your Booking',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Details
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    children: [
                      _SummaryDetail(
                        label: 'SERVICE',
                        icon: Icons.content_cut,
                        value: notifier.selectedServiceName ?? 'Not selected',
                      ),
                      AppSpacing.verticalXl,
                      _SummaryDetail(
                        label: 'BARBER',
                        icon: Icons.person_outline,
                        value: notifier.selectedBarberName ?? 'Any Available',
                      ),
                      if (notifier.selectedTimeSlot != null) ...[
                        AppSpacing.verticalXl,
                        _SummaryDetail(
                          label: 'DATE & TIME',
                          icon: Icons.event,
                          value: _formatDateTime(
                            notifier.selectedTimeSlot!.startTime,
                          ),
                        ),
                      ],
                      AppSpacing.verticalXl,
                      _SummaryDetail(
                        label: 'TYPE',
                        icon: Icons.info_outline,
                        value: notifier.selectedTimeSlot != null
                            ? 'Reservation'
                            : 'Walk-in',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalXxl,

          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 64,
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
                  onTap: notifier.confirm,
                  borderRadius: AppRadius.borderRadiusLg,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Confirm Booking',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppSpacing.horizontalSm,
                      Icon(
                        Icons.check_circle,
                        color: context.colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.verticalLg,
          Text(
            'By confirming, you agree to our Cancellation Policy. '
            'A confirmation email will be sent to your registered address.',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalXxl,
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '${months[dateTime.month - 1]} ${dateTime.day}, '
        '${dateTime.year} at $hour:$minute $period';
  }
}

class _SummaryDetail extends StatelessWidget {
  const _SummaryDetail({
    required this.label,
    required this.icon,
    required this.value,
  });

  final String label;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            fontSize: 10,
          ),
        ),
        AppSpacing.verticalSm,
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm + 2),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: AppRadius.borderRadiusMd,
              ),
              child: Icon(
                icon,
                size: 20,
                color: context.colorScheme.primary,
              ),
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Text(
                value,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
