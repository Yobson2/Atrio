import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';

/// Abstract queue repository defined in the domain layer.
abstract class QueueRepository {
  /// Gets the current queue status for a salon.
  Future<Either<Failure, QueueStatus>> getQueueStatus(String salonId);

  /// Joins the queue at a salon.
  Future<Either<Failure, void>> joinQueue(String salonId);

  /// Leaves the queue at a salon.
  Future<Either<Failure, void>> leaveQueue(String salonId);

  /// Marks the user as arrived at the salon.
  Future<Either<Failure, void>> markArrived(String salonId);

  /// Advances the queue (owner action).
  Future<Either<Failure, void>> advanceQueue(String salonId);

  /// Skips a queue entry (owner action).
  Future<Either<Failure, void>> skipEntry(String salonId, String entryId);
}
