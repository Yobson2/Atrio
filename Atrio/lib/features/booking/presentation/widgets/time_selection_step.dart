import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/booking/domain/entities/time_slot.dart';
import 'package:flutter_templates/features/booking/domain/usecases/get_available_slots_usecase.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_notifier.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_providers.dart';
import 'package:intl/intl.dart';

/// A step widget for selecting a time slot during the booking flow.
///
/// Fetches available slots from the repository and displays them in a grid.
class TimeSelectionStep extends ConsumerStatefulWidget {
  /// Creates a [TimeSelectionStep].
  const TimeSelectionStep({required this.onTimeSelected, super.key});

  /// Callback when a time slot is selected.
  final void Function(TimeSlot slot) onTimeSelected;

  @override
  ConsumerState<TimeSelectionStep> createState() => _TimeSelectionStepState();
}

class _TimeSelectionStepState extends ConsumerState<TimeSelectionStep> {
  DateTime _selectedDate = DateTime.now();
  List<TimeSlot> _slots = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  Future<void> _loadSlots() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final notifier = ref.read(bookingFlowNotifierProvider.notifier);
    final salonId = notifier.selectedSalonId;
    final serviceId = notifier.selectedServiceId;

    if (salonId == null || serviceId == null) {
      setState(() {
        _error = 'Missing salon or service selection';
        _isLoading = false;
      });
      return;
    }

    final result = await ref.read(getAvailableSlotsUseCaseProvider).call(
          GetAvailableSlotsParams(
            salonId: salonId,
            serviceId: serviceId,
            date: _selectedDate,
            barberId: notifier.selectedBarberId,
          ),
        );

    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _error = failure.message;
        _isLoading = false;
      }),
      (slots) => setState(() {
        _slots = slots;
        _isLoading = false;
      }),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
      _loadSlots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingHorizontalXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick a Time',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'Select your preferred date and available slot.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.verticalXl,

        // Date picker card
        Padding(
          padding: AppSpacing.paddingHorizontalXl,
          child: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.xl)),
              boxShadow: AppShadows.smLight,
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.xl)),
              child: InkWell(
                onTap: _pickDate,
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadius.xl)),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary
                              .withValues(alpha: 0.05),
                          borderRadius: AppRadius.borderRadiusMd,
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      AppSpacing.horizontalLg,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEEE').format(_selectedDate),
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            DateFormat('MMM d, yyyy').format(_selectedDate),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        AppSpacing.verticalXxl,

        // Available slots header
        Padding(
          padding: AppSpacing.paddingHorizontalXl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AVAILABLE SLOTS',
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              if (_slots.isNotEmpty)
                Text(
                  '${_slots.where((s) => s.isAvailable).length} slots left',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.secondary,
                  ),
                ),
            ],
          ),
        ),
        AppSpacing.verticalLg,

        // Slots grid
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
            AppSpacing.verticalMd,
            FilledButton(
              onPressed: _loadSlots,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_slots.isEmpty) {
      return Center(
        child: Text(
          'No available slots for this date',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 2,
      ),
      itemCount: _slots.length,
      itemBuilder: (context, index) {
        final slot = _slots[index];
        final timeText = DateFormat('h:mm a').format(slot.startTime);

        return Material(
          color: slot.isAvailable
              ? context.colorScheme.surfaceContainerLow
              : context.colorScheme.surfaceContainerHigh,
          borderRadius: AppRadius.borderRadiusLg,
          child: InkWell(
            onTap: slot.isAvailable ? () => widget.onTimeSelected(slot) : null,
            borderRadius: AppRadius.borderRadiusLg,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppRadius.borderRadiusLg,
              ),
              alignment: Alignment.center,
              child: Text(
                timeText,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: slot.isAvailable
                      ? context.colorScheme.onSurface
                      : context.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.4),
                  fontWeight:
                      slot.isAvailable ? FontWeight.w600 : FontWeight.normal,
                  decoration:
                      slot.isAvailable ? null : TextDecoration.lineThrough,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
