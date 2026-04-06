import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';

/// Reusable page for displaying legal content (Terms of Service, Privacy Policy).
///
/// Loads markdown/text content from an asset file and displays it
/// in a scrollable view.
class LegalPage extends StatelessWidget {
  /// Creates a [LegalPage].
  const LegalPage({
    required this.title,
    required this.assetPath,
    super.key,
  });

  /// Page title shown in the app bar.
  final String title;

  /// Path to the text asset file (e.g. 'assets/legal/terms.md').
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      appBar: AppAppBar(title: title),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: rootBundle.loadString(assetPath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Could not load content.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                snapshot.data ?? '',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.6,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
