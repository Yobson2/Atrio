import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Labeled switch row for boolean settings.
///
/// Displays a label, optional subtitle, and a Material switch.
class AppToggleSwitch extends StatelessWidget {
  /// Creates an [AppToggleSwitch].
  const AppToggleSwitch({
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
    this.subtitle,
    this.enabled = true,
  });

  /// Whether the switch is on.
  final bool value;

  /// Callback when toggled.
  final ValueChanged<bool>? onChanged;

  /// Primary label text.
  final String label;

  /// Optional description text below the label.
  final String? subtitle;

  /// Whether the switch is interactive.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnChanged = enabled ? onChanged : null;

    return Semantics(
      toggled: value,
      enabled: enabled,
      label: label,
      child: InkWell(
        onTap: effectiveOnChanged != null
            ? () => effectiveOnChanged(!value)
            : null,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: enabled
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurface.withValues(
                                alpha: 0.38,
                              ),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AppSpacing.horizontalMd,
              Switch(
                value: value,
                onChanged: effectiveOnChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
