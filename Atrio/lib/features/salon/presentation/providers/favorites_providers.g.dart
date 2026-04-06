// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesLocalDataSourceHash() =>
    r'332e477591058041cc7962bf30c634e7705c32c9';

/// Provides the [FavoritesLocalDataSource].
///
/// Copied from [favoritesLocalDataSource].
@ProviderFor(favoritesLocalDataSource)
final favoritesLocalDataSourceProvider =
    AutoDisposeProvider<FavoritesLocalDataSource>.internal(
  favoritesLocalDataSource,
  name: r'favoritesLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoritesLocalDataSourceRef
    = AutoDisposeProviderRef<FavoritesLocalDataSource>;
String _$favoritesNotifierHash() => r'197e06a7d94005c55c0880cc204a94341be7859c';

/// Manages the set of favorite salon IDs.
///
/// State is a [Set<String>] of salon IDs for O(1) lookups.
///
/// Copied from [FavoritesNotifier].
@ProviderFor(FavoritesNotifier)
final favoritesNotifierProvider =
    NotifierProvider<FavoritesNotifier, Set<String>>.internal(
  FavoritesNotifier.new,
  name: r'favoritesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoritesNotifier = Notifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
