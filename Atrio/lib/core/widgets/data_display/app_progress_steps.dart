import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Horizontal step indicator with optional labels.
///
/// Displays progress through a multi-step flow (e.g., booking).
class AppProgressSteps extends StatelessWidget {
  /// Creates an [AppProgressSteps].
  const AppProgressSteps({
    required this.totalSteps,
    required this.currentStep,
    super.key,
    this.labels,
    this.activeColor,
    this.inactiveColor,
    this.height = 4,
  }) : assert(
          labels == null || labels.length == totalSteps,
          'Labels length must match totalSteps',
        );

  /// Total number of steps.
  final int totalSteps;

  /// Current active step (0-indexed).
  final int currentStep;

  /// Optional labels for each step.
  final List<String>? labels;

  /// Color for completed and active steps.
  final Color? activeColor;

  /// Color for future steps.
  final Color? inactiveColor;

  /// Height of the progress bar segments.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor ?? theme.colorScheme.primary;
    final inactive = inactiveColor ?? theme.colorScheme.outlineVariant;

    return Semantics(
      label: 'Step ${currentStep + 1} of $totalSteps',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              final isActive = index <= currentStep;
              return Expanded(
                child: Container(
                  height: height,
                  margin: EdgeInsets.only(
                    right: index < totalSteps - 1 ? AppSpacing.xs : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? active : inactive,
                    borderRadius: AppRadius.borderRadiusFull,
                  ),
                ),
              );
            }),
          ),
          if (labels != null) ...[
            AppSpacing.verticalSm,
            Row(
              children: List.generate(totalSteps, (index) {
                final isActive = index <= currentStep;
                return Expanded(
                  child: Text(
                    labels![index],
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isActive
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}
