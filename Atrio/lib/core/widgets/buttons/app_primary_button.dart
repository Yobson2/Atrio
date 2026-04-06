import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_gradients.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Primary gradient-filled button with optional icon and loading state.
///
/// Uses a linear gradient (primary → primary_container) per the
/// "Editorial Artisan" design system. On press, the button lifts
/// with an ambient shadow rather than just changing color.
class AppPrimaryButton extends StatefulWidget {
  /// Creates an [AppPrimaryButton].
  const AppPrimaryButton({
    required this.text,
    super.key,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isExpanded = true,
    this.height = 52,
  });

  /// Button label text.
  final String text;

  /// Callback when pressed. Disabled when `null` or [isLoading].
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Shows a loading spinner and disables the button.
  final bool isLoading;

  /// Whether the button takes full width.
  final bool isExpanded;

  /// Button height.
  final double height;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isPressed = false;

  bool get _isEnabled => !widget.isLoading && widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradient = isDark
        ? AppGradients.primaryButtonDark
        : AppGradients.primaryButtonLight;

    return Semantics(
      button: true,
      enabled: _isEnabled,
      label: widget.isLoading ? '${widget.text}, loading' : widget.text,
      child: GestureDetector(
        onTapDown: _isEnabled ? (_) => setState(() => _isPressed = true) : null,
        onTapUp: _isEnabled
            ? (_) {
                setState(() => _isPressed = false);
                widget.onPressed?.call();
              }
            : null,
        onTapCancel:
            _isEnabled ? () => setState(() => _isPressed = false) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.isExpanded ? double.infinity : null,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: _isEnabled ? gradient : null,
            color: _isEnabled
                ? null
                : theme.colorScheme.primary.withValues(alpha: 0.6),
            borderRadius: AppRadius.borderRadiusMd,
            boxShadow: _isPressed
                ? (isDark ? AppShadows.mdDark : AppShadows.mdLight)
                : (isDark ? AppShadows.smDark : AppShadows.smLight),
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.onPrimary,
                      ),
                    )
                  : Row(
                      mainAxisSize: widget.isExpanded
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            size: 20,
                            color: theme.colorScheme.onPrimary,
                          ),
                          AppSpacing.horizontalSm,
                        ],
                        Text(
                          widget.text,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
