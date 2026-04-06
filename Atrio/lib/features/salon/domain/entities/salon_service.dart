import 'package:flutter/foundation.dart';

/// Domain entity representing a service offered by a salon.
@immutable
class SalonService {
  /// Creates a [SalonService].
  const SalonService({
    required this.id,
    required this.salonId,
    required this.name,
    this.description,
    required this.price,
    required this.durationMinutes,
    this.imageUrl,
    this.isActive = true,
  });

  /// Unique identifier.
  final String id;

  /// ID of the salon offering this service.
  final String salonId;

  /// Service name.
  final String name;

  /// Optional description.
  final String? description;

  /// Price in local currency.
  final double price;

  /// Duration in minutes.
  final int durationMinutes;

  /// Optional image URL.
  final String? imageUrl;

  /// Whether the service is currently active.
  final bool isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SalonService && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
