import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';

/// Reusable form widget for creating or editing a salon service.
class ServiceFormWidget extends StatefulWidget {
  /// Creates a [ServiceFormWidget].
  const ServiceFormWidget({
    super.key,
    this.service,
    this.isLoading = false,
    this.onSubmit,
  });

  /// Existing service to edit, or null for creating a new one.
  final SalonService? service;

  /// Whether the form is in a loading state.
  final bool isLoading;

  /// Callback with the form data when submitted.
  final void Function(SalonService service)? onSubmit;

  @override
  State<ServiceFormWidget> createState() => _ServiceFormWidgetState();
}

class _ServiceFormWidgetState extends State<ServiceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _durationController;

  bool get _isEditing => widget.service != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.service?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.service?.description ?? '');
    _priceController = TextEditingController(
      text: widget.service != null
          ? widget.service!.price.toStringAsFixed(2)
          : '',
    );
    _durationController = TextEditingController(
      text: widget.service != null
          ? widget.service!.durationMinutes.toString()
          : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final service = SalonService(
      id: widget.service?.id ?? '',
      salonId: widget.service?.salonId ?? '',
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      durationMinutes: int.tryParse(_durationController.text.trim()) ?? 0,
      isActive: widget.service?.isActive ?? true,
    );

    widget.onSubmit?.call(service);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _nameController,
            label: 'Service Name',
            hint: 'e.g., Classic Haircut',
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Service name is required';
              }
              return null;
            },
          ),
          AppSpacing.verticalLg,
          AppTextField(
            controller: _descriptionController,
            label: 'Description',
            hint: 'Describe the service...',
            textInputAction: TextInputAction.next,
            maxLines: 3,
          ),
          AppSpacing.verticalLg,
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _priceController,
                  label: 'Price (\$)',
                  hint: '25.00',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    if (double.tryParse(value.trim()) == null) {
                      return 'Invalid price';
                    }
                    return null;
                  },
                ),
              ),
              AppSpacing.horizontalLg,
              Expanded(
                child: AppTextField(
                  controller: _durationController,
                  label: 'Duration (min)',
                  hint: '30',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return 'Invalid';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          AppSpacing.verticalXl,
          AppPrimaryButton(
            text: _isEditing ? 'Update Service' : 'Create Service',
            isLoading: widget.isLoading,
            onPressed: _onSubmit,
          ),
        ],
      ),
    );
  }
}
