import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:go_router/go_router.dart';

/// Page displaying the user's saved/bookmarked salons.
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const favorites = _mockFavorites;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.favoritesTitle),
      ),
      body: favorites.isEmpty
          ? AppEmptyState(
              icon: Icons.favorite_border_rounded,
              title: context.l10n.favoritesEmpty,
              subtitle: context.l10n.favoritesEmptyDesc,
            )
          : ListView.separated(
              padding: AppSpacing.paddingXl,
              itemCount: favorites.length,
              separatorBuilder: (_, __) => AppSpacing.verticalMd,
              itemBuilder: (context, index) {
                final salon = favorites[index];
                return _FavoriteItem(
                  salon: salon,
                  onRemove: () {
                    // In a real app, this would remove from favorites
                  },
                );
              },
            ),
    );
  }
}

class _FavoriteItem extends StatelessWidget {
  const _FavoriteItem({
    required this.salon,
    required this.onRemove,
  });

  final _FavoriteSalon salon;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusMd,
        boxShadow: AppShadows.smLight,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppRadius.borderRadiusSm,
            child: Container(
              width: 80,
              height: 80,
              color: theme.colorScheme.surfaceContainerHigh,
              child: Icon(
                Icons.store_rounded,
                size: 32,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  salon.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  salon.address,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.verticalXs,
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      salon.rating.toStringAsFixed(1),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${salon.reviewCount})',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.favorite_rounded,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mock Data ─────────────────────────────────────────────────────

class _FavoriteSalon {
  const _FavoriteSalon({
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
  });

  final String name;
  final String address;
  final double rating;
  final int reviewCount;
}

const _mockFavorites = [
  _FavoriteSalon(
    name: 'The Artisan Barber',
    address: '123 Main Street, Downtown',
    rating: 4.8,
    reviewCount: 127,
  ),
  _FavoriteSalon(
    name: 'Precision Cuts Studio',
    address: '456 Oak Avenue, Midtown',
    rating: 4.6,
    reviewCount: 89,
  ),
  _FavoriteSalon(
    name: 'Urban Edge Grooming',
    address: '789 Elm Boulevard, West End',
    rating: 4.9,
    reviewCount: 203,
  ),
  _FavoriteSalon(
    name: 'Classic & Co. Barbers',
    address: '321 Pine Road, East Side',
    rating: 4.5,
    reviewCount: 64,
  ),
];
