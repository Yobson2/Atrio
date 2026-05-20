import 'package:flutter/foundation.dart';

/// Referral program information for a user.
@immutable
class ReferralInfo {
  /// Creates a [ReferralInfo].
  const ReferralInfo({
    required this.referralCode,
    required this.referralLink,
    required this.totalReferrals,
    required this.successfulReferrals,
    required this.pointsEarned,
    required this.pointsPerReferral,
  });

  /// The user's unique referral code.
  final String referralCode;

  /// Shareable referral link.
  final String referralLink;

  /// Total number of referrals sent.
  final int totalReferrals;

  /// Number of referrals that resulted in sign-ups.
  final int successfulReferrals;

  /// Total points earned from referrals.
  final int pointsEarned;

  /// Points awarded per successful referral.
  final int pointsPerReferral;
}
