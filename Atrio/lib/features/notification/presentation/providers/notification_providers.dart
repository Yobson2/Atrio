import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/error/failures.dart';
import 'package:flutter_templates/core/providers/network_providers.dart';
import 'package:flutter_templates/core/usecase/usecase.dart';
import 'package:flutter_templates/features/notification/data/datasources/mock_notification_remote_datasource.dart';
import 'package:flutter_templates/features/notification/data/datasources/notification_remote_datasource.dart';
import 'package:flutter_templates/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:flutter_templates/features/notification/domain/repositories/notification_repository.dart';
import 'package:flutter_templates/features/notification/domain/usecases/get_notifications_usecase.dart';
import 'package:flutter_templates/features/notification/domain/usecases/mark_notification_read_usecase.dart';
import 'package:flutter_templates/features/notification/domain/usecases/register_device_token_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_providers.g.dart';

/// Provides the [NotificationRemoteDataSource].
///
/// Set `USE_MOCK_NOTIFICATION=true` in `.env` to use mock data for testing.
/// TODO(dev): Remove the mock branch when switching to the real API.
@riverpod
NotificationRemoteDataSource notificationRemoteDataSource(Ref ref) {
  final useMock =
      dotenv.get('USE_MOCK_NOTIFICATION', fallback: 'false') == 'true';
  if (useMock) return MockNotificationRemoteDataSource();
  return NotificationRemoteDataSourceImpl(ref.watch(dioProvider));
}

/// Provides the [NotificationRepository].
@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(
    remoteDataSource: ref.watch(notificationRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

/// Provides the [RegisterDeviceTokenUseCase].
@riverpod
RegisterDeviceTokenUseCase registerDeviceTokenUseCase(Ref ref) {
  return RegisterDeviceTokenUseCase(ref.watch(notificationRepositoryProvider));
}

/// Provides the [GetNotificationsUseCase].
@riverpod
GetNotificationsUseCase getNotificationsUseCase(Ref ref) {
  return GetNotificationsUseCase(ref.watch(notificationRepositoryProvider));
}

/// Provides the [MarkNotificationReadUseCase].
@riverpod
MarkNotificationReadUseCase markNotificationReadUseCase(Ref ref) {
  return MarkNotificationReadUseCase(
    ref.watch(notificationRepositoryProvider),
  );
}

/// Provides a use case to mark all notifications as read.
@riverpod
MarkAllAsReadUseCase markAllAsReadUseCase(Ref ref) {
  return MarkAllAsReadUseCase(ref.watch(notificationRepositoryProvider));
}

/// Use case for marking all notifications as read.
class MarkAllAsReadUseCase extends UseCase<void, NoParams> {
  /// Creates a [MarkAllAsReadUseCase].
  const MarkAllAsReadUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.markAllAsRead();
  }
}
