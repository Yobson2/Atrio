import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Placeholder map view for salon discovery.
///
/// Replace this with a real Google Maps / Mapbox widget once an API key
/// is configured. For now it shows a styled placeholder.
class SalonMapPage extends ConsumerWidget {
  /// Creates a [SalonMapPage].
  const SalonMapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: context.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 64,
              color: context.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            AppSpacing.verticalLg,
            Text(
              'Map View',
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            AppSpacing.verticalSm,
            Padding(
              padding: AppSpacing.paddingHorizontalXl,
              child: Text(
                'Configure a Google Maps API key to enable the '
                'interactive map view.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
