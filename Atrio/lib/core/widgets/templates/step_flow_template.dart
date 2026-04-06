import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/buttons/app_secondary_button.dart';
import 'package:flutter_templates/core/widgets/data_display/app_progress_steps.dart';

/// Page template for multi-step flows.
///
/// Provides step indicator, content area, and back/next navigation.
class StepFlowTemplate extends StatelessWidget {
  /// Creates a [StepFlowTemplate].
  const StepFlowTemplate({
    required this.totalSteps,
    required this.currentStep,
    required this.body,
    super.key,
    this.appBar,
    this.labels,
    this.nextText = 'Next',
    this.backText = 'Back',
    this.finishText = 'Finish',
    this.onNext,
    this.onBack,
    this.isNextLoading = false,
    this.canGoNext = true,
    this.padding,
  });

  /// Total number of steps.
  final int totalSteps;

  /// Current step (0-indexed).
  final int currentStep;

  /// Step content.
  final Widget body;

  /// Optional app bar.
  final PreferredSizeWidget? appBar;

  /// Optional step labels.
  final List<String>? labels;

  /// Next button text.
  final String nextText;

  /// Back button text.
  final String backText;

  /// Final step button text.
  final String finishText;

  /// Next/finish callback.
  final VoidCallback? onNext;

  /// Back callback. Hidden on first step if null.
  final VoidCallback? onBack;

  /// Whether next action is loading.
  final bool isNextLoading;

  /// Whether the next button is enabled.
  final bool canGoNext;

  /// Content padding.
  final EdgeInsetsGeometry? padding;

  bool get _isLastStep => currentStep >= totalSteps - 1;
  bool get _isFirstStep => currentStep == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: AppProgressSteps(
                totalSteps: totalSteps,
                currentStep: currentStep,
                labels: labels,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: padding ?? AppSpacing.paddingLg,
                child: body,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Row(
                children: [
                  if (!_isFirstStep && onBack != null) ...[
                    Expanded(
                      child: AppSecondaryButton(
                        text: backText,
                        onPressed: onBack,
                      ),
                    ),
                    AppSpacing.horizontalMd,
                  ],
                  Expanded(
                    child: AppPrimaryButton(
                      text: _isLastStep ? finishText : nextText,
                      onPressed: canGoNext ? onNext : null,
                      isLoading: isNextLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
