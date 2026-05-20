import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/data_display/step_indicator.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_notifier.dart';
import 'package:go_router/go_router.dart';

/// Step 4/4: Review and confirm the booking.
class ConfirmBookingPage extends ConsumerStatefulWidget {
  const ConfirmBookingPage({super.key});

  @override
  ConsumerState<ConfirmBookingPage> createState() =>
      _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends ConsumerState<ConfirmBookingPage> {
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flow = ref.watch(bookingFlowNotifierProvider);

    ref.listen(bookingFlowNotifierProvider, (_, next) {
      if (next.isCompleted) {
        context.go('/book/confirmed');
      }
      if (next.error != null) {
        context.showSnackBar(next.error!, isError: true);
      }
    });

    final monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.bookingTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              context.l10n.bookingReadyToFinalize,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepIndicator(
                    currentStep: 3,
                    labels: ['Service', 'Barber', 'Time', 'Confirm'],
                  ),
                  AppSpacing.verticalXl,
                  Text(
                    context.l10n.bookingConfirmTitle,
                    style: context.textTheme.headlineSmall,
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    context.l10n.bookingConfirmSubtitle,
                    style: context.textTheme.bodySmall,
                  ),
                  AppSpacing.verticalXl,

                  // Salon info
                  if (flow.salon != null)
                    _InfoRow(
                      icon: Icons.store_rounded,
                      label: 'SALON',
                      value: flow.salon!.name,
                      subtitle: flow.salon!.address,
                    ),
                  AppSpacing.verticalLg,

                  // Service
                  if (flow.selectedService != null)
                    _InfoRow(
                      icon: Icons.content_cut_rounded,
                      label: 'SERVICE',
                      value: flow.selectedService!.name,
                      subtitle:
                          '${flow.selectedService!.durationMinutes} min • Wash & Style incl.',
                    ),
                  AppSpacing.verticalLg,

                  // Barber
                  _InfoRow(
                    icon: Icons.person_rounded,
                    label: 'BARBER',
                    value: flow.selectedBarber?.name ?? 'Any Available',
                    subtitle: flow.selectedBarber?.tier ?? 'Senior Stylist',
                  ),
                  AppSpacing.verticalLg,

                  // Date & time
                  if (flow.selectedDate != null)
                    _InfoRow(
                      icon: Icons.calendar_today_rounded,
                      label: 'DATE & TIME',
                      value:
                          '${monthNames[flow.selectedDate!.month - 1]} ${flow.selectedDate!.day}, ${flow.selectedDate!.year}',
                      subtitle:
                          '${weekdays[flow.selectedDate!.weekday - 1]} • ${flow.selectedTimeSlot}',
                    ),
                  AppSpacing.verticalXl,

                  // Price
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Total Price',
                          style: context.textTheme.titleSmall,
                        ),
                        const Spacer(),
                        Text(
                          '\$${flow.selectedService?.price.toStringAsFixed(2) ?? '0.00'}',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Notes field
                  Text(
                    context.l10n.bookingNotes,
                    style: context.textTheme.titleSmall,
                  ),
                  AppSpacing.verticalSm,
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: context.l10n.bookingNotesHint,
                    ),
                    onChanged: (value) => ref
                        .read(bookingFlowNotifierProvider.notifier)
                        .updateNotes(value),
                  ),
                  AppSpacing.verticalXl,

                  // Cancellation policy
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: AppColors.onSurfaceVariantLight,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          context.l10n.bookingRescheduleNote,
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SafeArea(
              top: false,
              child: AppGradientButton(
                text: context.l10n.bookingConfirmButton,
                icon: Icons.check_rounded,
                isLoading: flow.isSubmitting,
                onPressed: () => ref
                    .read(bookingFlowNotifierProvider.notifier)
                    .confirmBooking(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        AppSpacing.horizontalMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                  letterSpacing: 0.8,
                ),
              ),
              AppSpacing.verticalXs,
              Text(value, style: theme.textTheme.titleSmall),
              if (subtitle != null) ...[
                AppSpacing.verticalXs,
                Text(subtitle!, style: theme.textTheme.bodySmall),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
