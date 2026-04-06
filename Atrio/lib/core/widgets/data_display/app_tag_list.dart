import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Horizontal scrollable tag/chip list with optional selection.
///
/// Displays a row of tags that can optionally be tapped to toggle.
class AppTagList extends StatelessWidget {
  /// Creates an [AppTagList].
  const AppTagList({
    required this.tags,
    super.key,
    this.selectedTags = const {},
    this.onTagTap,
    this.scrollable = true,
    this.spacing = AppSpacing.sm,
  });

  /// List of tag labels.
  final List<String> tags;

  /// Currently selected tag labels.
  final Set<String> selectedTags;

  /// Callback when a tag is tapped.
  final ValueChanged<String>? onTagTap;

  /// Whether the list scrolls horizontally.
  final bool scrollable;

  /// Spacing between tags.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final chips = tags.map((tag) {
      final isSelected = selectedTags.contains(tag);
      return Padding(
        padding: EdgeInsets.only(right: spacing),
        child: onTagTap != null
            ? FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (_) => onTagTap!(tag),
              )
            : Chip(label: Text(tag)),
      );
    }).toList();

    if (scrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: chips),
      );
    }

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: tags.map((tag) {
        final isSelected = selectedTags.contains(tag);
        return onTagTap != null
            ? FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (_) => onTagTap!(tag),
              )
            : Chip(label: Text(tag));
      }).toList(),
    );
  }
}
