import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_password_field.dart';
import 'package:go_router/go_router.dart';

/// Page for changing the user's password.
class ChangePasswordPage extends ConsumerStatefulWidget {
  /// Creates a [ChangePasswordPage].
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _currentController;
  late final TextEditingController _newController;
  late final TextEditingController _confirmController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentController = TextEditingController();
    _newController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Call change password use case
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() => _isLoading = false);
    context.showSnackBar(context.l10n.changePasswordSuccess);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.changePasswordTitle),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // ── Current password ──
                AppPasswordField(
                  label: context.l10n.changePasswordCurrentLabel,
                  controller: _currentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.changePasswordCurrentRequired;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalLg,

                // ── New password ──
                AppPasswordField(
                  label: context.l10n.changePasswordNewLabel,
                  controller: _newController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.changePasswordNewRequired;
                    }
                    if (value.length < 8) {
                      return context.l10n.changePasswordMinLength;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalLg,

                // ── Confirm password ──
                AppPasswordField(
                  label: context.l10n.changePasswordConfirmLabel,
                  controller: _confirmController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.changePasswordConfirmRequired;
                    }
                    if (value != _newController.text) {
                      return context.l10n.changePasswordMismatch;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalXxl,

                // ── Submit button ──
                AppPrimaryButton(
                  text: context.l10n.changePasswordSubmit,
                  onPressed: _submit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
