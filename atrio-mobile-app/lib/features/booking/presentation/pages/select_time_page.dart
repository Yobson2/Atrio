import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/data_display/step_indicator.dart';
import 'package:flutter_templates/core/widgets/inputs/calendar_picker.dart';
import 'package:flutter_templates/core/widgets/inputs/time_slot_selector.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_notifier.dart';
import 'package:go_router/go_router.dart';

/// Step 3/4: Pick a date and time slot.
class SelectTimePage extends ConsumerStatefulWidget {
  const SelectTimePage({super.key});

  @override
  ConsumerState<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends ConsumerState<SelectTimePage> {
  DateTime? _selectedDate;
  String? _selectedSlot;
  bool _isReservation = true;

  static const _mockSlots = [
    TimeSlotData(label: '9:00 AM'),
    TimeSlotData(label: '9:30 AM'),
    TimeSlotData(label: '10:00 AM'),
    TimeSlotData(label: '11:00 AM'),
    TimeSlotData(label: '1:00 PM', isAvailable: false),
    TimeSlotData(label: '12:30 PM'),
    TimeSlotData(label: '2:30 PM'),
    TimeSlotData(label: '4:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('BarberBook'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepIndicator(
                    currentStep: 2,
                    labels: ['Service', 'Barber', 'Time', 'Confirm'],
                  ),
                  AppSpacing.verticalXl,
                  Text(
                    context.l10n.bookingSelectTime,
                    style: context.textTheme.headlineSmall,
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    context.l10n.bookingSelectTimeSubtitle,
                    style: context.textTheme.bodySmall,
                  ),
                  AppSpacing.verticalXl,

                  // Reservation / Walk-in toggle
                  Row(
                    children: [
                      Expanded(
                        child: PillChip(
                          label: context.l10n.bookingReservation,
                          isSelected: _isReservation,
                          onTap: () =>
                              setState(() => _isReservation = true),
                        ),
                      ),
                      AppSpacing.horizontalSm,
                      Expanded(
                        child: PillChip(
                          label: context.l10n.bookingWalkIn,
                          isSelected: !_isReservation,
                          onTap: () =>
                              setState(() => _isReservation = false),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalXl,

                  // Calendar
                  CalendarPicker(
                    selectedDate: _selectedDate,
                    onDateSelected: (date) =>
                        setState(() => _selectedDate = date),
                  ),
                  AppSpacing.verticalXl,

                  // Time slots
                  Row(
                    children: [
                      Text(
                        context.l10n.bookingAvailableSlots,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.onSurfaceVariantLight,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '8 slots left',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalMd,
                  TimeSlotSelector(
                    slots: _mockSlots,
                    selectedSlot: _selectedSlot,
                    onSlotSelected: (slot) =>
                        setState(() => _selectedSlot = slot),
                  ),
                  AppSpacing.verticalXl,

                  // Selected time summary
                  if (_selectedDate != null && _selectedSlot != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            context.l10n.bookingSelectedTime,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.onSurfaceVariantLight,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_selectedDate!.month}/${_selectedDate!.day}, $_selectedSlot',
                            style: context.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  AppSpacing.verticalXl,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SafeArea(
              top: false,
              child: AppGradientButton(
                text: context.l10n.bookingNextStep,
                icon: Icons.arrow_forward_rounded,
                onPressed:
                    (_selectedDate != null && _selectedSlot != null)
                        ? () {
                            ref
                                .read(bookingFlowNotifierProvider.notifier)
                                .selectDateTime(
                                  _selectedDate!,
                                  _selectedSlot!,
                                );
                            context.push('/book/confirm');
                          }
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
