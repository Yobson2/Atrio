import 'package:flutter/foundation.dart';

/// Categories of redeemable rewards.
enum RewardType { discount, freeService, product }

/// A reward that can be redeemed with loyalty points.
@immutable
class Reward {
  /// Creates a [Reward].
  const Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsCost,
    required this.type,
    this.imageUrl,
    this.expiresAt,
    this.isAvailable = true,
  });

  /// Unique identifier.
  final String id;

  /// Reward title.
  final String title;

  /// Reward description.
  final String description;

  /// Points required to redeem.
  final int pointsCost;

  /// Optional image URL.
  final String? imageUrl;

  /// Category of the reward.
  final RewardType type;

  /// Optional expiration date.
  final DateTime? expiresAt;

  /// Whether the reward is currently available for redemption.
  final bool isAvailable;
}
