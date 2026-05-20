// coverage:ignore-file

import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';

/// Mock implementation of [QueueRepository] with sample data.
class MockQueueRepository implements QueueRepository {
  static const _delay = Duration(milliseconds: 500);

  bool _isInQueue = true;

  @override
  Future<Either<Failure, QueueStatus>> getQueueStatus(String salonId) async {
    await Future<void>.delayed(_delay);
    return Right(
      QueueStatus(
        salonId: salonId,
        totalInQueue: 14,
        currentlyServing: 3,
        averageWaitMinutes: 42,
        salonName: 'The Precision Studio',
        salonAddress: '12 2nd Avenue, Brooklyn, NY 11215',
        salonPhone: '+1 (718) 555-0142',
        userPosition: _isInQueue ? 5 : null,
        userEstimatedWait: _isInQueue ? 15 : null,
        dailyRevenue: 480,
        entries: [
          QueueEntry(
            id: 'qe-001',
            salonId: salonId,
            clientName: 'Marcus Holloway',
            serviceName: 'Signature Sculpt',
            position: 1,
            status: QueueEntryStatus.serving,
            joinedAt: DateTime.now().subtract(const Duration(minutes: 35)),
            estimatedWaitMinutes: 0,
          ),
          QueueEntry(
            id: 'qe-002',
            salonId: salonId,
            clientName: 'Jordan Smith',
            serviceName: 'Beard Trim & Shape + Trim',
            position: 2,
            status: QueueEntryStatus.waiting,
            joinedAt: DateTime.now().subtract(const Duration(minutes: 25)),
            estimatedWaitMinutes: 8,
          ),
          QueueEntry(
            id: 'qe-003',
            salonId: salonId,
            clientName: 'Ethan Wright',
            serviceName: 'Staff Cut',
            position: 3,
            status: QueueEntryStatus.waiting,
            joinedAt: DateTime.now().subtract(const Duration(minutes: 15)),
            estimatedWaitMinutes: 15,
          ),
          QueueEntry(
            id: 'qe-004',
            salonId: salonId,
            clientName: 'David Chen',
            serviceName: 'Full Beard Shave',
            position: 4,
            status: QueueEntryStatus.waiting,
            joinedAt: DateTime.now().subtract(const Duration(minutes: 8)),
            estimatedWaitMinutes: 22,
          ),
          QueueEntry(
            id: 'qe-005',
            salonId: salonId,
            clientName: 'Sarah K.',
            serviceName: 'Fade + Lineup',
            position: 5,
            status: QueueEntryStatus.waiting,
            joinedAt: DateTime.now().subtract(const Duration(minutes: 5)),
            estimatedWaitMinutes: 30,
          ),
          QueueEntry(
            id: 'qe-006',
            salonId: salonId,
            clientName: 'James R.',
            serviceName: 'Hot Towel Shave',
            position: 6,
            status: QueueEntryStatus.waiting,
            joinedAt: DateTime.now(),
            estimatedWaitMinutes: 38,
          ),
        ],
      ),
    );
  }

  @override
  Future<Either<Failure, void>> joinQueue(String salonId) async {
    await Future<void>.delayed(_delay);
    _isInQueue = true;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> leaveQueue(String salonId) async {
    await Future<void>.delayed(_delay);
    _isInQueue = false;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> markArrived(String salonId) async {
    await Future<void>.delayed(_delay);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> advanceQueue(String salonId) async {
    await Future<void>.delayed(_delay);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> skipEntry(
    String salonId,
    String entryId,
  ) async {
    await Future<void>.delayed(_delay);
    return const Right(null);
  }
}
