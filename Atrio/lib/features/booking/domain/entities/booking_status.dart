/// The status of a booking.
enum BookingStatus {
  /// Booking is pending confirmation.
  pending,

  /// Booking has been confirmed.
  confirmed,

  /// Service is currently in progress.
  inProgress,

  /// Service has been completed.
  completed,

  /// Booking was cancelled.
  cancelled,

  /// Client did not show up.
  noShow,
}
