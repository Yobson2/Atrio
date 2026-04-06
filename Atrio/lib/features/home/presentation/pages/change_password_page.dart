import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/inputs/app_password_field.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/core/widgets/templates/form_page_template.dart';
import 'package:flutter_templates/features/home/presentation/providers/change_password_notifier.dart';
import 'package:flutter_templates/features/home/presentation/providers/change_password_state.dart';

/// Page for changing the current user's password.
class ChangePasswordPage extends ConsumerStatefulWidget {
  /// Creates a [ChangePasswordPage].
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ref.read(changePasswordNotifierProvider.notifier).changePassword(
          currentPassword: _currentController.text,
          newPassword: _newController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordNotifierProvider);
    final l10n = context.l10n;

    ref.listen(changePasswordNotifierProvider, (_, next) {
      if (next is ChangePasswordSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileChangePassword)),
        );
        Navigator.of(context).pop();
      } else if (next is ChangePasswordError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final isLoading = state is ChangePasswordLoading;

    return FormPageTemplate(
      appBar: AppAppBar(title: l10n.profileChangePassword),
      formKey: _formKey,
      submitText: l10n.commonSave,
      isSubmitting: isLoading,
      onSubmit: isLoading ? null : _submit,
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.lg),

          // Current password
          AppPasswordField(
            controller: _currentController,
            label: l10n.authPassword,
            hint: 'Current password',
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.validationRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          // New password
          AppPasswordField(
            controller: _newController,
            label: l10n.authPassword,
            hint: 'New password',
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.validationRequired;
              }
              if (value.length < 8) {
                return l10n.validationPasswordLength;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          // Confirm new password
          AppPasswordField(
            controller: _confirmController,
            label: l10n.authConfirmPassword,
            hint: 'Confirm new password',
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value != _newController.text) {
                return l10n.validationPasswordMatch;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
