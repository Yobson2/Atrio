import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';

/// Abstract queue repository defined in the domain layer.
abstract class QueueRepository {
  /// Gets the current queue status for a salon.
  Future<Either<Failure, QueueStatus>> getQueueStatus(String salonId);

  /// Watches queue status changes in real-time for a salon.
  Stream<QueueStatus> watchQueueStatus(String salonId);

  /// Joins the queue for a given booking.
  Future<Either<Failure, QueueEntry>> joinQueue(String bookingId);

  /// Leaves the queue by entry ID.
  Future<Either<Failure, void>> leaveQueue(String entryId);

  /// Gets the current user's position in a salon queue, if any.
  Future<Either<Failure, QueueEntry?>> getMyQueuePosition(String salonId);
}
