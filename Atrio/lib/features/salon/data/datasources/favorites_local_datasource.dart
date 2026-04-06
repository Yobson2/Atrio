import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Local datasource for managing favorite salon IDs.
///
/// Stores a simple JSON list of salon IDs in SharedPreferences.
class FavoritesLocalDataSource {
  /// Creates a [FavoritesLocalDataSource].
  const FavoritesLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const _key = 'favorite_salons';

  /// Gets all favorite salon IDs.
  List<String> getFavoriteIds() {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<String>();
  }

  /// Adds a salon to favorites.
  Future<void> addFavorite(String salonId) async {
    final ids = getFavoriteIds();
    if (!ids.contains(salonId)) {
      ids.add(salonId);
      await _prefs.setString(_key, jsonEncode(ids));
    }
  }

  /// Removes a salon from favorites.
  Future<void> removeFavorite(String salonId) async {
    final ids = getFavoriteIds();
    ids.remove(salonId);
    await _prefs.setString(_key, jsonEncode(ids));
  }

  /// Checks if a salon is in favorites.
  bool isFavorite(String salonId) {
    return getFavoriteIds().contains(salonId);
  }
}
