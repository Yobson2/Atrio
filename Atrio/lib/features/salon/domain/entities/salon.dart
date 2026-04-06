import 'package:flutter/foundation.dart';
import 'package:flutter_templates/features/salon/domain/entities/opening_hours.dart';

/// Domain entity representing a salon.
@immutable
class Salon {
  /// Creates a [Salon].
  const Salon({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    this.coverImageUrl,
    this.photoUrls = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isOpen = false,
    required this.ownerId,
    this.openingHours = const [],
  });

  /// Unique identifier.
  final String id;

  /// Salon display name.
  final String name;

  /// Description of the salon.
  final String description;

  /// Street address.
  final String address;

  /// Geographic latitude.
  final double latitude;

  /// Geographic longitude.
  final double longitude;

  /// Phone number.
  final String phone;

  /// Cover image URL.
  final String? coverImageUrl;

  /// Gallery photo URLs.
  final List<String> photoUrls;

  /// Average rating (0-5).
  final double rating;

  /// Total number of reviews.
  final int reviewCount;

  /// Whether the salon is currently open.
  final bool isOpen;

  /// Owner user ID.
  final String ownerId;

  /// Weekly opening hours.
  final List<OpeningHours> openingHours;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Salon && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
