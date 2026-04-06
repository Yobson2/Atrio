import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Glassmorphic fixed header with centered "Atrio" title.
///
/// Used across all auth pages as a replacement for AppBar.
class AuthHeader extends StatelessWidget {
  /// Creates an [AuthHeader].
  const AuthHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.showBackButton = false,
    this.showCloseButton = false,
    this.onBack,
    this.onClose,
    this.centerTitle = false,
  });

  /// Main title text (page heading, shown below the header bar).
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Whether to show a back arrow on the left.
  final bool showBackButton;

  /// Whether to show a close icon on the right.
  final bool showCloseButton;

  /// Callback for back button.
  final VoidCallback? onBack;

  /// Callback for close button.
  final VoidCallback? onClose;

  /// Whether the title/subtitle should be centered.
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment:
          centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        AppSpacing.verticalXl,
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          textAlign: centerTitle ? TextAlign.center : TextAlign.start,
        ),
        if (subtitle != null) ...[
          AppSpacing.verticalSm,
          Text(
            subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: centerTitle ? TextAlign.center : TextAlign.start,
          ),
        ],
        AppSpacing.verticalXxl,
      ],
    );
  }
}

/// Glassmorphic top bar with "Atrio" brand in center.
class AuthTopBar extends StatelessWidget {
  /// Creates an [AuthTopBar].
  const AuthTopBar({
    super.key,
    this.showBackButton = false,
    this.showCloseButton = false,
    this.onBack,
    this.onClose,
  });

  /// Whether to show a back arrow on the left.
  final bool showBackButton;

  /// Whether to show a close icon on the right.
  final bool showCloseButton;

  /// Callback for back button.
  final VoidCallback? onBack;

  /// Callback for close button.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLowest
                .withValues(alpha: AppOpacity.glass),
          ),
          child: Row(
            children: [
              if (showBackButton)
                GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  child: Icon(
                    Icons.arrow_back,
                    color: theme.colorScheme.primary,
                  ),
                )
              else
                const SizedBox(width: 24),
              const Spacer(),
              Text(
                'Atrio',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: theme.colorScheme.primary,
                ),
              ),
              const Spacer(),
              if (showCloseButton)
                GestureDetector(
                  onTap: onClose,
                  child: Icon(
                    Icons.close,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Decorative background with blur circles for auth pages.
class AuthBackground extends StatelessWidget {
  /// Creates an [AuthBackground].
  const AuthBackground({required this.child, super.key});

  /// The content to display on top of the background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        // Top-right decorative blur circle
        Positioned(
          top: -48,
          right: -48,
          child: Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Bottom-left decorative blur circle
        Positioned(
          bottom: -64,
          left: -64,
          child: Container(
            width: 192,
            height: 192,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
