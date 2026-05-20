import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:go_router/go_router.dart';

/// Owner form: add/edit a service.
class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key});

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.ownerServiceFormTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image upload
                  Container(
                    height: 160, width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.surfaceContainerLowLight, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate_rounded, size: 40, color: AppColors.onSurfaceVariantLight),
                        AppSpacing.verticalSm,
                        Text(context.l10n.ownerServiceFormImage, style: theme.textTheme.labelMedium?.copyWith(color: AppColors.primaryLight)),
                        Text(context.l10n.ownerServiceFormImageHint, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  AppSpacing.verticalXl,

                  AppTextField(controller: _nameController, label: context.l10n.ownerServiceFormName, hint: 'e.g. Signature Fade & Beard Trim'),
                  AppSpacing.verticalLg,
                  AppTextField(controller: _descController, label: context.l10n.ownerServiceFormDescription, hint: 'Describe the techniques, tools, and experience...', maxLines: 3),
                  AppSpacing.verticalLg,

                  Row(
                    children: [
                      Expanded(child: AppTextField(controller: _priceController, label: context.l10n.ownerServiceFormPrice, hint: '45.00', keyboardType: TextInputType.number, prefixIcon: const Icon(Icons.attach_money_rounded, size: 18))),
                      AppSpacing.horizontalLg,
                      Expanded(child: AppTextField(controller: _durationController, label: context.l10n.ownerServiceFormDuration, hint: '45', keyboardType: TextInputType.number, suffixIcon: Text('min', style: theme.textTheme.labelMedium))),
                    ],
                  ),
                  AppSpacing.verticalXl,

                  // Active toggle
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.l10n.ownerServiceFormActive, style: theme.textTheme.titleSmall),
                              Text(context.l10n.ownerServiceFormActiveDesc, style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ),
                        Switch(value: _isActive, onChanged: (v) => setState(() => _isActive = v), activeColor: AppColors.primaryLight),
                      ],
                    ),
                  ),
                  AppSpacing.verticalLg,

                  // Advanced settings
                  Center(
                    child: TextButton.icon(
                      onPressed: () => context.showSnackBar('Advanced settings coming soon'),
                      icon: const Icon(Icons.tune_rounded, size: 16),
                      label: Text(context.l10n.ownerServiceFormAdvanced),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SafeArea(top: false, child: AppGradientButton(text: context.l10n.ownerServiceFormSave, icon: Icons.check_rounded, onPressed: () => context.pop())),
          ),
        ],
      ),
    );
  }
}
