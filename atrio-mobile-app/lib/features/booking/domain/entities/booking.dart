import 'package:flutter/foundation.dart';

/// Booking status enum.
enum BookingStatus {
  pending,
  confirmed,
  completed,
  cancelled,
  rescheduled,
}

/// Domain entity representing a booking/appointment.
@immutable
class Booking {
  const Booking({
    required this.id,
    required this.salonId,
    required this.salonName,
    required this.serviceId,
    required this.serviceName,
    required this.clientId,
    required this.date,
    required this.startTime,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.barberId,
    this.barberName,
    this.endTime,
    this.notes,
    this.salonAddress,
    this.serviceDuration,
  });

  final String id;
  final String salonId;
  final String salonName;
  final String serviceId;
  final String serviceName;
  final String clientId;
  final DateTime date;
  final String startTime;
  final double totalPrice;
  final BookingStatus status;
  final DateTime createdAt;
  final String? barberId;
  final String? barberName;
  final String? endTime;
  final String? notes;
  final String? salonAddress;
  final int? serviceDuration;

  bool get isUpcoming =>
      status == BookingStatus.confirmed || status == BookingStatus.pending;

  bool get isPast =>
      status == BookingStatus.completed || status == BookingStatus.cancelled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Booking && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
