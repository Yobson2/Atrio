import 'package:flutter/foundation.dart';

/// Domain entity representing a salon review.
@immutable
class Review {
  const Review({
    required this.id,
    required this.salonId,
    required this.clientName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.clientPhotoUrl,
  });

  final String id;
  final String salonId;
  final String clientName;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final String? clientPhotoUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Review && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
