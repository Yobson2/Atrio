import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/config/env_provider.dart';
import 'package:flutter_templates/core/providers/network_providers.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:flutter_templates/core/network/websocket_client.dart';
import 'package:flutter_templates/features/queue/data/datasources/mock_queue_remote_datasource.dart';
import 'package:flutter_templates/features/queue/data/datasources/queue_remote_datasource.dart';
import 'package:flutter_templates/features/queue/data/datasources/queue_websocket_datasource.dart';
import 'package:flutter_templates/features/queue/data/repositories/queue_repository_impl.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';
import 'package:flutter_templates/features/queue/domain/usecases/get_queue_status_usecase.dart';
import 'package:flutter_templates/features/queue/domain/usecases/join_queue_usecase.dart';
import 'package:flutter_templates/features/queue/domain/usecases/leave_queue_usecase.dart';
import 'package:flutter_templates/features/queue/domain/usecases/watch_queue_status_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'queue_providers.g.dart';

/// Provides the [QueueRemoteDataSource].
///
/// Set `USE_MOCK_QUEUE=true` in `.env` to use mock data for testing.
@riverpod
QueueRemoteDataSource queueRemoteDataSource(Ref ref) {
  final useMock = dotenv.get('USE_MOCK_QUEUE', fallback: 'false') == 'true';
  if (useMock) return MockQueueRemoteDataSource();
  return QueueRemoteDataSourceImpl(ref.watch(dioProvider));
}

/// Provides the [QueueWebSocketDataSource].
///
/// Uses mock WebSocket datasource when `USE_MOCK_QUEUE=true`.
@riverpod
QueueWebSocketDataSource queueWebSocketDataSource(Ref ref) {
  final useMock = dotenv.get('USE_MOCK_QUEUE', fallback: 'false') == 'true';
  if (useMock) {
    final mockRemote =
        ref.watch(queueRemoteDataSourceProvider) as MockQueueRemoteDataSource;
    return MockQueueWebSocketDataSource(mockRemote);
  }
  final wsClient = WebSocketClient(
    env: ref.watch(envProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
  return QueueWebSocketDataSourceImpl(wsClient);
}

/// Provides the [QueueRepository].
@riverpod
QueueRepository queueRepository(Ref ref) {
  return QueueRepositoryImpl(
    remoteDataSource: ref.watch(queueRemoteDataSourceProvider),
    webSocketDataSource: ref.watch(queueWebSocketDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

/// Provides the [GetQueueStatusUseCase].
@riverpod
GetQueueStatusUseCase getQueueStatusUseCase(Ref ref) {
  return GetQueueStatusUseCase(ref.watch(queueRepositoryProvider));
}

/// Provides the [WatchQueueStatusUseCase].
@riverpod
WatchQueueStatusUseCase watchQueueStatusUseCase(Ref ref) {
  return WatchQueueStatusUseCase(ref.watch(queueRepositoryProvider));
}

/// Provides the [JoinQueueUseCase].
@riverpod
JoinQueueUseCase joinQueueUseCase(Ref ref) {
  return JoinQueueUseCase(ref.watch(queueRepositoryProvider));
}

/// Provides the [LeaveQueueUseCase].
@riverpod
LeaveQueueUseCase leaveQueueUseCase(Ref ref) {
  return LeaveQueueUseCase(ref.watch(queueRepositoryProvider));
}
