import 'package:flutter/foundation.dart';

/// Domain entity representing a salon/barbershop.
@immutable
class Salon {
  const Salon({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
    this.description,
    this.imageUrl,
    this.galleryUrls = const [],
    this.phone,
    this.email,
    this.latitude,
    this.longitude,
    this.isActive = true,
    this.tags = const [],
    this.tier,
  });

  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewCount;
  final String? description;
  final String? imageUrl;
  final List<String> galleryUrls;
  final String? phone;
  final String? email;
  final double? latitude;
  final double? longitude;
  final bool isActive;
  final List<String> tags;
  final String? tier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Salon && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
