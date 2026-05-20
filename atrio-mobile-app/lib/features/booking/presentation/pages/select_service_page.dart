import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/data_display/service_card.dart';
import 'package:flutter_templates/core/widgets/data_display/step_indicator.dart';
import 'package:flutter_templates/core/widgets/loading/app_progress.dart';
import 'package:flutter_templates/features/booking/presentation/providers/booking_flow_notifier.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_notifier.dart';
import 'package:flutter_templates/features/salon/presentation/providers/salon_detail_state.dart';
import 'package:go_router/go_router.dart';

/// Step 1/4: Select a service for the booking.
class SelectServicePage extends ConsumerStatefulWidget {
  const SelectServicePage({super.key});

  @override
  ConsumerState<SelectServicePage> createState() => _SelectServicePageState();
}

class _SelectServicePageState extends ConsumerState<SelectServicePage> {
  String _selectedCategory = 'All Services';
  SalonService? _selectedService;

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(salonDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.bookingTitle),
      ),
      body: switch (detailState) {
        SalonDetailLoaded(:final detail) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const StepIndicator(
                      currentStep: 0,
                      labels: ['Service', 'Barber', 'Time', 'Confirm'],
                    ),
                    AppSpacing.verticalLg,
                    // Category chips
                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          'All Services',
                          'Haircut',
                          'Beard',
                        ]
                            .map(
                              (cat) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: PillChip(
                                  label: cat,
                                  isSelected: _selectedCategory == cat,
                                  onTap: () => setState(
                                    () => _selectedCategory = cat,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalLg,
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _filteredServices(detail.services).length,
                  separatorBuilder: (_, __) => AppSpacing.verticalMd,
                  itemBuilder: (context, index) {
                    final svc = _filteredServices(detail.services)[index];
                    return ServiceCard(
                      name: svc.name,
                      price: svc.price,
                      duration: svc.durationMinutes,
                      description: svc.description,
                      isSelected: _selectedService?.id == svc.id,
                      isPopular: svc.isPopular,
                      onTap: () => setState(() => _selectedService = svc),
                    );
                  },
                ),
              ),
              // Promo banner
              Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryLight.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.tertiaryLight.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.bookingSpecialOffer,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.tertiaryLight,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          AppSpacing.verticalXs,
                          Text(
                            context.l10n.bookingFirstTimeMember,
                            style: context.textTheme.titleSmall,
                          ),
                          AppSpacing.verticalXs,
                          Text(
                            context.l10n.bookingFirstTimeDesc,
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.showSnackBar('More details coming soon'),
                      child: Text(context.l10n.bookingLearnMore),
                    ),
                  ],
                ),
              ),
              // Next button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SafeArea(
                  top: false,
                  child: AppGradientButton(
                    text: context.l10n.commonNext,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _selectedService != null
                        ? () {
                            ref
                                .read(bookingFlowNotifierProvider.notifier)
                                .selectService(_selectedService!);
                            context.push('/book/barber');
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

  List<SalonService> _filteredServices(List<SalonService> services) {
    if (_selectedCategory == 'All Services') return services;
    return services.where((s) => s.category == _selectedCategory).toList();
  }
}
