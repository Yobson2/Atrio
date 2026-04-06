import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';

/// Reusable form widget for adding or editing a barber.
class BarberFormWidget extends StatefulWidget {
  /// Creates a [BarberFormWidget].
  const BarberFormWidget({
    super.key,
    this.barber,
    this.isLoading = false,
    this.onSubmit,
  });

  /// Existing barber to edit, or null for adding a new one.
  final Barber? barber;

  /// Whether the form is in a loading state.
  final bool isLoading;

  /// Callback with the form data when submitted.
  final void Function(Barber barber)? onSubmit;

  @override
  State<BarberFormWidget> createState() => _BarberFormWidgetState();
}

class _BarberFormWidgetState extends State<BarberFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _avatarUrlController;
  late bool _isAvailable;

  bool get _isEditing => widget.barber != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.barber?.name ?? '');
    _avatarUrlController =
        TextEditingController(text: widget.barber?.avatarUrl ?? '');
    _isAvailable = widget.barber?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final barber = Barber(
      id: widget.barber?.id ?? '',
      salonId: widget.barber?.salonId ?? '',
      name: _nameController.text.trim(),
      avatarUrl: _avatarUrlController.text.trim().isNotEmpty
          ? _avatarUrlController.text.trim()
          : null,
      rating: widget.barber?.rating ?? 0,
      isAvailable: _isAvailable,
      serviceIds: widget.barber?.serviceIds ?? const [],
    );

    widget.onSubmit?.call(barber);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _nameController,
            label: 'Barber Name',
            hint: 'e.g., James Wilson',
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.person_outline),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Barber name is required';
              }
              return null;
            },
          ),
          AppSpacing.verticalLg,
          AppTextField(
            controller: _avatarUrlController,
            label: 'Avatar URL (optional)',
            hint: 'https://example.com/avatar.jpg',
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.image_outlined),
          ),
          AppSpacing.verticalLg,
          SwitchListTile(
            title: Text(
              'Available',
              style: theme.textTheme.bodyLarge,
            ),
            subtitle: Text(
              _isAvailable
                  ? 'Barber is available for bookings'
                  : 'Barber is currently unavailable',
              style: theme.textTheme.bodySmall,
            ),
            value: _isAvailable,
            onChanged: (value) => setState(() => _isAvailable = value),
          ),
          AppSpacing.verticalXl,
          AppPrimaryButton(
            text: _isEditing ? 'Update Barber' : 'Add Barber',
            isLoading: widget.isLoading,
            onPressed: _onSubmit,
          ),
        ],
      ),
    );
  }
}
