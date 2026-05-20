import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';

/// Horizontal step progress indicator for multi-step flows (e.g., booking).
///
/// Shows labeled steps connected by progress lines.
class StepIndicator extends StatelessWidget {
  const StepIndicator({
    required this.currentStep,
    required this.labels,
    super.key,
  });

  /// Current active step (0-indexed).
  final int currentStep;

  /// Labels for each step.
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: List.generate(labels.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Connector line
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex < currentStep;
          return Expanded(
            child: Container(
              height: 2,
              color: isCompleted
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
          );
        }

        final stepIndex = index ~/ 2;
        final isActive = stepIndex == currentStep;
        final isCompleted = stepIndex < currentStep;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              labels[stepIndex].toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: isActive || isCompleted
                    ? theme.colorScheme.primary
                    : AppColors.onSurfaceVariantLight,
                fontWeight:
                    isActive ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.8,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: isActive ? 24 : 16,
              height: 3,
              decoration: BoxDecoration(
                color: isActive || isCompleted
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      }),
    );
  }
}
