import 'package:flutter/material.dart';
import 'package:flutter_templates/core/widgets/inputs/app_search_field.dart';

/// Search bar for salon discovery, wrapping [AppSearchField].
class SalonSearchBar extends StatelessWidget {
  /// Creates a [SalonSearchBar].
  const SalonSearchBar({
    required this.onChanged,
    super.key,
    this.controller,
  });

  /// Callback when search text changes (debounced).
  final ValueChanged<String> onChanged;

  /// Optional external controller.
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      hint: 'Search salons...',
      onChanged: onChanged,
      controller: controller,
    );
  }
}
