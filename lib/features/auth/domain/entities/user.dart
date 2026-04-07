import 'package:flutter/foundation.dart';

/// The role a user has within the app.
enum UserRole {
  /// Client who discovers salons and books appointments.
  client,

  /// Salon owner who manages their salon, barbers, and bookings.
  owner,
}

/// Domain entity representing an authenticated user.
///
/// This is a pure domain object with no framework dependencies.
@immutable
class User {
  /// Creates a [User].
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.avatarUrl,
    this.phone,
  });

  /// Unique identifier.
  final String id;

  /// User email address.
  final String email;

  /// Display name.
  final String name;

  /// The user's role (client or owner).
  final UserRole role;

  /// Optional avatar image URL.
  final String? avatarUrl;

  /// Optional phone number.
  final String? phone;

  /// Whether this user is a salon owner.
  bool get isOwner => role == UserRole.owner;

  /// Whether this user is a client.
  bool get isClient => role == UserRole.client;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          role == other.role &&
          avatarUrl == other.avatarUrl &&
          phone == other.phone;

  @override
  int get hashCode => Object.hash(id, email, name, role, avatarUrl, phone);

  @override
  String toString() =>
      'User(id: $id, email: $email, name: $name, role: $role)';
}
