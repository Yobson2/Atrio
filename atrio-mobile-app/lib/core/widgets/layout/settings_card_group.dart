import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';

/// Grouped card container for settings rows.
///
/// Uses surfaceContainerLowest background with ambient shadow
/// and no border (per design spec: no 1px solid borders).
class SettingsCardGroup extends StatelessWidget {
  const SettingsCardGroup({
    required this.children,
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.smLight,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
