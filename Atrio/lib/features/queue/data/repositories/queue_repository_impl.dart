import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/network/network_info.dart';
import 'package:flutter_templates/core/utils/logger.dart';
import 'package:flutter_templates/features/queue/data/datasources/queue_remote_datasource.dart';
import 'package:flutter_templates/features/queue/data/datasources/queue_websocket_datasource.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';

/// Repository implementation for queue operations.
///
/// [watchQueueStatus] tries WebSocket first, falls back to polling.
class QueueRepositoryImpl implements QueueRepository {
  /// Creates a [QueueRepositoryImpl].
  const QueueRepositoryImpl({
    required QueueRemoteDataSource remoteDataSource,
    required QueueWebSocketDataSource webSocketDataSource,
    required NetworkInfo networkInfo,
  })  : _remote = remoteDataSource,
        _webSocket = webSocketDataSource,
        _networkInfo = networkInfo;

  final QueueRemoteDataSource _remote;
  final QueueWebSocketDataSource _webSocket;
  final NetworkInfo _networkInfo;

  static const _tag = 'QueueRepository';
  static const _pollInterval = Duration(seconds: 10);

  @override
  Future<Either<Failure, QueueStatus>> getQueueStatus(String salonId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final model = await _remote.getQueueStatus(salonId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException {
      return const Left(NetworkFailure());
    }
  }

  @override
  Stream<QueueStatus> watchQueueStatus(String salonId) {
    // Try WebSocket first, fall back to polling on error.
    return _webSocket.watchQueueStatus(salonId).map((model) {
      return model.toEntity();
    }).handleError(
      (Object error) {
        AppLogger.warning(
          'WebSocket failed, falling back to polling: $error',
          tag: _tag,
        );
      },
    ).transform(_WebSocketWithPollingFallback(
      pollFn: () => _remote.getQueueStatus(salonId),
      interval: _pollInterval,
    ));
  }

  @override
  Future<Either<Failure, QueueEntry>> joinQueue(String bookingId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final model = await _remote.joinQueue(bookingId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> leaveQueue(String entryId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      await _remote.leaveQueue(entryId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, QueueEntry?>> getMyQueuePosition(
    String salonId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final model = await _remote.getMyQueuePosition(salonId);
      return Right(model?.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException {
      return const Left(NetworkFailure());
    }
  }
}

/// StreamTransformer that passes through WebSocket events but starts
/// a polling fallback if the upstream closes or errors without emitting.
class _WebSocketWithPollingFallback
    extends StreamTransformerBase<QueueStatus, QueueStatus> {
  _WebSocketWithPollingFallback({
    required this.pollFn,
    required this.interval,
  });

  final Future<dynamic> Function() pollFn;
  final Duration interval;

  @override
  Stream<QueueStatus> bind(Stream<QueueStatus> stream) {
    late StreamController<QueueStatus> controller;
    StreamSubscription<QueueStatus>? upstreamSub;
    Timer? pollTimer;
    var hasReceivedData = false;

    void startPolling() {
      pollTimer?.cancel();
      pollTimer = Timer.periodic(interval, (_) async {
        try {
          final model = await pollFn();
          if (model != null) {
            // ignore: avoid_dynamic_calls
            controller.add(model.toEntity() as QueueStatus);
          }
        } catch (e) {
          AppLogger.debug(
            'Poll failed: $e',
            tag: 'QueueRepository',
          );
        }
      });
    }

    controller = StreamController<QueueStatus>(
      onListen: () {
        upstreamSub = stream.listen(
          (data) {
            hasReceivedData = true;
            controller.add(data);
          },
          onError: (Object error) {
            if (!hasReceivedData) {
              startPolling();
            } else {
              controller.addError(error);
            }
          },
          onDone: () {
            if (!hasReceivedData) {
              startPolling();
            } else {
              controller.close();
            }
          },
        );
      },
      onCancel: () {
        pollTimer?.cancel();
        return upstreamSub?.cancel() ?? Future<void>.value();
      },
    );

    return controller.stream;
  }
}
