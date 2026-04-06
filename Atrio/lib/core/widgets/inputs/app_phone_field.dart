import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_templates/core/theme/app_icons.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Phone number input field with country code prefix.
///
/// Provides a formatted phone input with a selectable country code.
class AppPhoneField extends StatelessWidget {
  /// Creates an [AppPhoneField].
  const AppPhoneField({
    super.key,
    this.controller,
    this.label,
    this.hint = 'Phone number',
    this.countryCode = '+1',
    this.onCountryCodeTap,
    this.validator,
    this.onChanged,
    this.errorText,
    this.enabled = true,
  });

  /// Text editing controller.
  final TextEditingController? controller;

  /// Label above the field.
  final String? label;

  /// Hint text.
  final String hint;

  /// Current country code.
  final String countryCode;

  /// Callback to change country code (opens picker).
  final VoidCallback? onCountryCodeTap;

  /// Form validation.
  final String? Function(String?)? validator;

  /// Called on text change.
  final ValueChanged<String>? onChanged;

  /// Error text to display below the field.
  final String? errorText;

  /// Whether the field is interactive.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: theme.textTheme.labelMedium),
          AppSpacing.verticalSm,
        ],
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: TextInputType.phone,
          validator: validator,
          onChanged: onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(15),
          ],
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: GestureDetector(
              onTap: onCountryCodeTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      AppIcons.phone,
                      size: 20,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    AppSpacing.horizontalXs,
                    Text(
                      countryCode,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      AppIcons.expandMore,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    SizedBox(
                      height: 24,
                      child: VerticalDivider(
                        width: 1,
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          autofillHints: const [AutofillHints.telephoneNumber],
        ),
      ],
    );
  }
}
