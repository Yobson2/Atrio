import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/features/salon/presentation/providers/favorites_providers.dart';
import 'package:flutter_templates/features/salon/presentation/widgets/favorite_button.dart';
import 'package:go_router/go_router.dart';

/// Page displaying the user's favorite/saved salons.
class FavoritesPage extends ConsumerWidget {
  /// Creates a [FavoritesPage].
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesNotifierProvider);
    final colorScheme = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const AppAppBar(title: 'Saved Salons'),
      body: favoriteIds.isEmpty
          ? const AppEmptyState(
              title: 'Nothing here yet',
              subtitle: 'Heart a salon to save it here.',
              icon: Icons.favorite_border,
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: favoriteIds.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final salonId = favoriteIds.elementAt(index);
                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: AppRadius.borderRadiusXl,
                    boxShadow:
                        isDark ? AppShadows.smDark : AppShadows.smLight,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: AppRadius.borderRadiusMd,
                      ),
                      child: Icon(
                        Icons.store,
                        color: colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      'Salon',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      salonId,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: FavoriteButton(salonId: salonId, size: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.borderRadiusXl,
                    ),
                    onTap: () => context.push(
                      '${RouteNames.discover}/${RouteNames.salonDetail}',
                      extra: salonId,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
