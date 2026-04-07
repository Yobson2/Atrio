import 'package:flutter/foundation.dart';

/// Loyalty tier levels available to users.
enum LoyaltyTier { bronze, silver, gold, platinum }

/// A user's loyalty program profile with points and activity history.
@immutable
class LoyaltyProfile {
  /// Creates a [LoyaltyProfile].
  const LoyaltyProfile({
    required this.currentPoints,
    required this.currentTier,
    required this.pointsToNextTier,
    required this.totalPointsEarned,
    required this.recentActivity,
  });

  /// Current available points balance.
  final int currentPoints;

  /// Current loyalty tier.
  final LoyaltyTier currentTier;

  /// Points needed to reach the next tier.
  final int pointsToNextTier;

  /// Lifetime total points earned.
  final int totalPointsEarned;

  /// Recent points activity entries.
  final List<PointsActivity> recentActivity;
}

/// A single points activity entry (earned or redeemed).
@immutable
class PointsActivity {
  /// Creates a [PointsActivity].
  const PointsActivity({
    required this.id,
    required this.description,
    required this.points,
    required this.isEarned,
    required this.date,
  });

  /// Unique identifier.
  final String id;

  /// Human-readable description of the activity.
  final String description;

  /// Number of points involved.
  final int points;

  /// Whether points were earned (`true`) or redeemed (`false`).
  final bool isEarned;

  /// When the activity occurred.
  final DateTime date;
}
