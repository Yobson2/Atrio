import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:go_router/go_router.dart';

/// Owner form: add/edit a barber profile.
class BarberFormPage extends StatefulWidget {
  const BarberFormPage({super.key});

  @override
  State<BarberFormPage> createState() => _BarberFormPageState();
}

class _BarberFormPageState extends State<BarberFormPage> {
  final _nameController = TextEditingController();
  bool _availableForBooking = true;
  final _selectedServices = <String>{'Classic Cut'};

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.ownerBarberFormTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo upload
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.surfaceContainerLowLight,
                    child: Icon(Icons.person_rounded, size: 40, color: AppColors.onSurfaceVariantLight),
                  ),
                  AppSpacing.verticalSm,
                  Text('Profile Photo', style: theme.textTheme.labelMedium?.copyWith(color: AppColors.primaryLight)),
                ],
              ),
            ),
            AppSpacing.verticalXl,

            AppTextField(controller: _nameController, label: context.l10n.ownerBarberFormName, hint: 'e.g. Marcus Vance'),
            AppSpacing.verticalXl,

            // Service assignment
            Row(
              children: [
                Text(context.l10n.ownerBarberFormServices, style: theme.textTheme.titleSmall),
                const Spacer(),
                Text(context.l10n.ownerBarberFormSelectMultiple, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.primaryLight, letterSpacing: 0.5)),
              ],
            ),
            AppSpacing.verticalMd,
            Wrap(
              spacing: 8, runSpacing: 8,
              children: ['Classic Cut', 'Beard Grooming', 'Hot Towel Shave', 'Fades & Tapers', 'Scalp Treatment'].map((s) =>
                PillChip(
                  label: s,
                  isSelected: _selectedServices.contains(s),
                  icon: _selectedServices.contains(s) ? Icons.check_rounded : null,
                  onTap: () => setState(() => _selectedServices.contains(s) ? _selectedServices.remove(s) : _selectedServices.add(s)),
                ),
              ).toList(),
            ),
            AppSpacing.verticalXl,

            // Available toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.l10n.ownerBarberFormAvailable, style: theme.textTheme.titleSmall),
                        Text(context.l10n.ownerBarberFormAvailableDesc, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Switch(value: _availableForBooking, onChanged: (v) => setState(() => _availableForBooking = v), activeColor: AppColors.primaryLight),
                ],
              ),
            ),
            AppSpacing.verticalLg,

            // Professional tier
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.workspace_premium_rounded, size: 18, color: AppColors.primaryLight),
                    AppSpacing.horizontalSm,
                    Text(context.l10n.ownerBarberFormProfessionalTier, style: theme.textTheme.titleSmall),
                  ]),
                  AppSpacing.verticalXs,
                  Text(context.l10n.ownerBarberFormProfessionalTierDesc, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            AppSpacing.verticalLg,

            // Shift patterns
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.schedule_rounded, size: 18, color: AppColors.primaryLight),
                    AppSpacing.horizontalSm,
                    Text(context.l10n.ownerBarberFormShiftPatterns, style: theme.textTheme.titleSmall),
                  ]),
                  AppSpacing.verticalXs,
                  Text(context.l10n.ownerBarberFormShiftPatternsDesc, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            AppSpacing.verticalXxl,

            // Actions
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.commonCancel))),
                AppSpacing.horizontalMd,
                Expanded(child: AppGradientButton(text: context.l10n.ownerBarberFormSave, onPressed: () => context.pop(), height: 48)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
