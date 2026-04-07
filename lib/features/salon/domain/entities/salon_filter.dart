import 'package:flutter/foundation.dart';

/// Immutable filter criteria for salon search.
@immutable
class SalonFilter {
  const SalonFilter({
    this.maxDistance,
    this.minRating,
    this.minPrice,
    this.maxPrice,
    this.serviceTypes = const [],
    this.availableNow = false,
  });

  /// Maximum distance in km.
  final double? maxDistance;

  /// Minimum star rating.
  final double? minRating;

  /// Minimum price.
  final double? minPrice;

  /// Maximum price.
  final double? maxPrice;

  /// Selected service type filters.
  final List<String> serviceTypes;

  /// Whether to show only currently available salons.
  final bool availableNow;

  /// An empty filter with no criteria active.
  static const empty = SalonFilter();

  /// Whether any filter criteria is active.
  bool get isActive =>
      maxDistance != null ||
      minRating != null ||
      minPrice != null ||
      maxPrice != null ||
      serviceTypes.isNotEmpty ||
      availableNow;

  /// Creates a copy with the given fields replaced.
  SalonFilter copyWith({
    double? maxDistance,
    double? minRating,
    double? minPrice,
    double? maxPrice,
    List<String>? serviceTypes,
    bool? availableNow,
  }) {
    return SalonFilter(
      maxDistance: maxDistance ?? this.maxDistance,
      minRating: minRating ?? this.minRating,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      serviceTypes: serviceTypes ?? this.serviceTypes,
      availableNow: availableNow ?? this.availableNow,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalonFilter &&
          runtimeType == other.runtimeType &&
          maxDistance == other.maxDistance &&
          minRating == other.minRating &&
          minPrice == other.minPrice &&
          maxPrice == other.maxPrice &&
          listEquals(serviceTypes, other.serviceTypes) &&
          availableNow == other.availableNow;

  @override
  int get hashCode => Object.hash(
        maxDistance,
        minRating,
        minPrice,
        maxPrice,
        Object.hashAll(serviceTypes),
        availableNow,
      );
}
