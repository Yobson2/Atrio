import 'package:flutter/foundation.dart';

/// Domain entity representing filter criteria for salon search.
@immutable
class SalonFilter {
  /// Creates a [SalonFilter].
  const SalonFilter({
    this.query,
    this.maxDistance,
    this.minRating,
    this.maxPrice,
    this.serviceType,
    this.isOpenNow,
    this.latitude,
    this.longitude,
  });

  /// Free-text search query.
  final String? query;

  /// Maximum distance in kilometers.
  final double? maxDistance;

  /// Minimum rating filter (0-5).
  final double? minRating;

  /// Maximum price filter.
  final double? maxPrice;

  /// Service type filter.
  final String? serviceType;

  /// Whether to filter by currently open salons.
  final bool? isOpenNow;

  /// User latitude for distance calculation.
  final double? latitude;

  /// User longitude for distance calculation.
  final double? longitude;
}
