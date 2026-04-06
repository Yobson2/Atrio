import 'package:flutter/foundation.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_type.dart';

/// Domain entity representing a booking.
@immutable
class Booking {
  /// Creates a [Booking].
  const Booking({
    required this.id,
    required this.salonId,
    required this.salonName,
    required this.userId,
    required this.serviceId,
    required this.serviceName,
    required this.type,
    required this.status,
    required this.estimatedDurationMinutes,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.barberId,
    this.barberName,
    this.scheduledAt,
  });

  /// Unique identifier.
  final String id;

  /// ID of the salon.
  final String salonId;

  /// Display name of the salon.
  final String salonName;

  /// ID of the user who made the booking.
  final String userId;

  /// ID of the booked service.
  final String serviceId;

  /// Display name of the booked service.
  final String serviceName;

  /// Optional barber ID (null for walk-ins without preference).
  final String? barberId;

  /// Optional barber display name.
  final String? barberName;

  /// Type of booking (walk-in or reservation).
  final BookingType type;

  /// Current status of the booking.
  final BookingStatus status;

  /// Scheduled date and time (null for walk-ins).
  final DateTime? scheduledAt;

  /// Estimated duration in minutes.
  final int estimatedDurationMinutes;

  /// Price of the service.
  final double price;

  /// When the booking was created.
  final DateTime createdAt;

  /// When the booking was last updated.
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Booking && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Booking(id: $id, service: $serviceName, '
      'status: $status, type: $type)';
}
