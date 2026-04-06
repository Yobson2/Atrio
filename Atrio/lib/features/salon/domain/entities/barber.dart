import 'package:flutter/foundation.dart';

/// Domain entity representing a barber working at a salon.
@immutable
class Barber {
  /// Creates a [Barber].
  const Barber({
    required this.id,
    required this.salonId,
    required this.name,
    this.avatarUrl,
    this.rating = 0.0,
    this.isAvailable = true,
    this.serviceIds = const [],
  });

  /// Unique identifier.
  final String id;

  /// ID of the salon where this barber works.
  final String salonId;

  /// Barber display name.
  final String name;

  /// Avatar image URL.
  final String? avatarUrl;

  /// Average rating (0-5).
  final double rating;

  /// Whether the barber is currently available.
  final bool isAvailable;

  /// IDs of services this barber can perform.
  final List<String> serviceIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Barber && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
