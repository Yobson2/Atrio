import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';

/// Expandable FAQ-style tile for displaying a question and answer pair.
///
/// Uses [ExpansionTile] internally with the app's ambient shadow design.
class AccordionTile extends StatelessWidget {
  /// Creates an [AccordionTile].
  const AccordionTile({
    required this.question,
    required this.answer,
    super.key,
    this.initiallyExpanded = false,
  });

  /// The question / header text.
  final String question;

  /// The answer / body text revealed on expansion.
  final String answer;

  /// Whether the tile starts in the expanded state.
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusMd,
        boxShadow: AppShadows.smLight,
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Text(
          question,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
