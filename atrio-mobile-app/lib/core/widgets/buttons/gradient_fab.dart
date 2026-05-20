import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';

/// Custom floating action button with a primary-to-primaryContainer gradient.
///
/// Matches the design spec: rounded-2xl, lgLight shadow, white icon.
class GradientFab extends StatelessWidget {
  const GradientFab({
    required this.onPressed,
    super.key,
    this.icon = Icons.add,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.lgLight,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}
