import 'package:flutter/foundation.dart';

/// Domain entity representing a service offered by a salon.
@immutable
class SalonService {
  const SalonService({
    required this.id,
    required this.salonId,
    required this.name,
    required this.price,
    required this.durationMinutes,
    this.description,
    this.imageUrl,
    this.category,
    this.tier,
    this.isActive = true,
    this.isPopular = false,
  });

  final String id;
  final String salonId;
  final String name;
  final double price;
  final int durationMinutes;
  final String? description;
  final String? imageUrl;
  final String? category;
  final String? tier;
  final bool isActive;
  final bool isPopular;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalonService &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
