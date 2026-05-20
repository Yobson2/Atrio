import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/data_display/barber_card.dart';
import 'package:flutter_templates/core/widgets/data_display/step_indicator.dart';
import 'package:flutter_templates/core/widgets/loading/app_progress.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_notifier.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_notifier.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_state.dart';
import 'package:go_router/go_router.dart';

/// Step 2/4: Choose a barber for the booking.
class SelectBarberPage extends ConsumerStatefulWidget {
  const SelectBarberPage({super.key});

  @override
  ConsumerState<SelectBarberPage> createState() => _SelectBarberPageState();
}

class _SelectBarberPageState extends ConsumerState<SelectBarberPage> {
  Barber? _selectedBarber;
  bool _anyAvailable = false;

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(salonDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(
          'BarberBook',
          style: context.textTheme.titleMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              'STEP 2 OF 4',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.onSurfaceVariantLight,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
      body: switch (detailState) {
        SalonDetailLoaded(:final detail) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StepIndicator(
                      currentStep: 1,
                      labels: ['Service', 'Barber', 'Time', 'Confirm'],
                    ),
                    AppSpacing.verticalXl,
                    Text(
                      context.l10n.bookingSelectBarber,
                      style: context.textTheme.headlineSmall,
                    ),
                    AppSpacing.verticalXs,
                    Text(
                      context.l10n.bookingSelectBarberSubtitle,
                      style: context.textTheme.bodySmall,
                    ),
                    AppSpacing.verticalXl,
                    // Any Available option
                    GestureDetector(
                      onTap: () => setState(() {
                        _anyAvailable = true;
                        _selectedBarber = null;
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _anyAvailable
                              ? AppColors.primaryLight.withValues(alpha: 0.05)
                              : Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: _anyAvailable
                              ? Border.all(
                                  color: AppColors.primaryLight,
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  AppColors.surfaceContainerHighLight,
                              child: const Icon(Icons.groups_rounded),
                            ),
                            AppSpacing.horizontalMd,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.l10n.bookingAnyAvailable,
                                    style: context.textTheme.titleSmall,
                                  ),
                                  Text(
                                    context.l10n.bookingAnyAvailableDesc,
                                    style: context.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalXl,
              // Barber grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: detail.barbers.length,
                  itemBuilder: (context, index) {
                    final barber = detail.barbers[index];
                    return BarberCard(
                      name: barber.name,
                      rating: barber.rating,
                      photoUrl: barber.photoUrl,
                      reviewCount: barber.reviewCount,
                      isSelected: _selectedBarber?.id == barber.id,
                      onTap: () => setState(() {
                        _selectedBarber = barber;
                        _anyAvailable = false;
                      }),
                    );
                  },
                ),
              ),
              // Certified badge
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      size: 16,
                      color: AppColors.primaryLight,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      context.l10n.bookingAllCertified,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalMd,
              // Next button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SafeArea(
                  top: false,
                  child: AppGradientButton(
                    text: context.l10n.commonNext,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: (_selectedBarber != null || _anyAvailable)
                        ? () {
                            ref
                                .read(bookingFlowNotifierProvider.notifier)
                                .selectBarber(_selectedBarber);
                            context.push('/book/time');
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        _ => const Center(child: AppProgress()),
      },
    );
  }
}
