import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:flutter_templates/features/salon/data/datasources/favorites_local_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_providers.g.dart';

/// Provides the [FavoritesLocalDataSource].
@riverpod
FavoritesLocalDataSource favoritesLocalDataSource(Ref ref) {
  return FavoritesLocalDataSource(ref.watch(sharedPreferencesProvider));
}

/// Manages the set of favorite salon IDs.
///
/// State is a [Set<String>] of salon IDs for O(1) lookups.
@Riverpod(keepAlive: true)
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Set<String> build() {
    final ds = ref.read(favoritesLocalDataSourceProvider);
    return ds.getFavoriteIds().toSet();
  }

  /// Toggles a salon's favorite status. Returns true if added, false if removed.
  Future<bool> toggle(String salonId) async {
    final ds = ref.read(favoritesLocalDataSourceProvider);
    if (state.contains(salonId)) {
      await ds.removeFavorite(salonId);
      state = {...state}..remove(salonId);
      return false;
    } else {
      await ds.addFavorite(salonId);
      state = {...state, salonId};
      return true;
    }
  }

  /// Whether a salon is in favorites.
  bool isFavorite(String salonId) => state.contains(salonId);
}
