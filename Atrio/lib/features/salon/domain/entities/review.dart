import 'package:flutter/foundation.dart';

/// Domain entity representing a salon review.
@immutable
class Review {
  /// Creates a [Review].
  const Review({
    required this.id,
    required this.salonId,
    required this.userId,
    required this.userName,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  /// Unique identifier.
  final String id;

  /// ID of the reviewed salon.
  final String salonId;

  /// ID of the user who wrote the review.
  final String userId;

  /// Display name of the reviewer.
  final String userName;

  /// Rating (1-5).
  final double rating;

  /// Optional review comment.
  final String? comment;

  /// When the review was created.
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Review && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
