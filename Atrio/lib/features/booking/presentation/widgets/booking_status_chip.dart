import 'package:flutter/material.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';

/// A colored chip that displays the booking status.
class BookingStatusChip extends StatelessWidget {
  /// Creates a [BookingStatusChip].
  const BookingStatusChip({required this.status, super.key});

  /// The booking status to display.
  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = _statusInfo(status);
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide.none,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }

  (String, Color) _statusInfo(BookingStatus status) {
    return switch (status) {
      BookingStatus.pending => ('Pending', Colors.orange),
      BookingStatus.confirmed => ('Confirmed', Colors.blue),
      BookingStatus.inProgress => ('In Progress', Colors.teal),
      BookingStatus.completed => ('Completed', Colors.green),
      BookingStatus.cancelled => ('Cancelled', Colors.red),
      BookingStatus.noShow => ('No Show', Colors.grey),
    };
  }
}
