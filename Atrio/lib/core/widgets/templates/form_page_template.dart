import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';

/// Page template for form screens with sticky submit button.
///
/// Provides a scrollable form layout with keyboard avoidance
/// and a fixed bottom submit button.
class FormPageTemplate extends StatelessWidget {
  /// Creates a [FormPageTemplate].
  const FormPageTemplate({
    required this.body,
    super.key,
    this.appBar,
    this.formKey,
    this.submitText = 'Submit',
    this.onSubmit,
    this.isSubmitting = false,
    this.padding,
  });

  /// The form content.
  final Widget body;

  /// Optional app bar.
  final PreferredSizeWidget? appBar;

  /// Optional form key for validation.
  final GlobalKey<FormState>? formKey;

  /// Submit button text.
  final String submitText;

  /// Submit callback. Button is disabled when null.
  final VoidCallback? onSubmit;

  /// Whether the form is currently submitting.
  final bool isSubmitting;

  /// Content padding.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: padding ?? AppSpacing.paddingLg,
                child: formKey != null ? Form(key: formKey, child: body) : body,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: AppPrimaryButton(
                text: submitText,
                onPressed: onSubmit,
                isLoading: isSubmitting,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
