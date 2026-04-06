import 'dart:ui';

import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// Manages the app [Locale] and persists the user's preference.
///
/// Supports English and French. Persists choice via
/// [LocalStorage] so it survives app restarts.
/// A null state means "follow system default".
@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale? build() {
    final stored = ref.read(localStorageProvider).getLocale();
    if (stored == null) return null;
    return Locale(stored);
  }

  /// Sets the locale and persists it.
  Future<void> setLocale(String languageCode) async {
    state = Locale(languageCode);
    await ref.read(localStorageProvider).setLocale(languageCode);
  }

  /// Resets to system default.
  Future<void> clearLocale() async {
    state = null;
    await ref.read(localStorageProvider).setLocale('');
  }
}
