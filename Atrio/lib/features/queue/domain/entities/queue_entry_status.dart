/// Possible statuses for a queue entry.
enum QueueEntryStatus {
  /// Waiting in the queue.
  waiting,

  /// Currently being served.
  serving,

  /// Service completed.
  served,

  /// Skipped by the salon.
  skipped,
}
