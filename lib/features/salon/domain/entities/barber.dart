import 'package:flutter/foundation.dart';

/// Domain entity representing a barber/stylist at a salon.
@immutable
class Barber {
  const Barber({
    required this.id,
    required this.salonId,
    required this.name,
    required this.rating,
    this.photoUrl,
    this.reviewCount = 0,
    this.specialties = const [],
    this.tier,
    this.isAvailable = true,
    this.nextAvailableAt,
  });

  final String id;
  final String salonId;
  final String name;
  final double rating;
  final String? photoUrl;
  final int reviewCount;
  final List<String> specialties;
  final String? tier;
  final bool isAvailable;
  final DateTime? nextAvailableAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Barber && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
