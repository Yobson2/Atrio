import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/providers/network_providers.dart';
import 'package:flutter_templates/features/owner/data/datasources/mock_owner_remote_datasource.dart';
import 'package:flutter_templates/features/owner/data/datasources/owner_remote_datasource.dart';
import 'package:flutter_templates/features/owner/data/repositories/owner_repository_impl.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:flutter_templates/features/owner/domain/usecases/add_barber_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/advance_queue_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/create_service_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/delete_service_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/get_my_salon_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/get_stats_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/get_today_bookings_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/remove_barber_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/skip_queue_entry_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_barber_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_booking_status_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_salon_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_service_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_providers.g.dart';

/// Provides the [OwnerRemoteDataSource].
///
/// Set `USE_MOCK_OWNER=true` in `.env` to use mock data for testing.
/// TODO(dev): Remove the mock branch when switching to the real API.
@riverpod
OwnerRemoteDataSource ownerRemoteDataSource(Ref ref) {
  final useMock = dotenv.get('USE_MOCK_OWNER', fallback: 'false') == 'true';
  if (useMock) return MockOwnerRemoteDataSource();
  return OwnerRemoteDataSourceImpl(ref.watch(dioProvider));
}

/// Provides the [OwnerRepository].
@riverpod
OwnerRepository ownerRepository(Ref ref) {
  return OwnerRepositoryImpl(
    remoteDataSource: ref.watch(ownerRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

/// Provides the [GetMySalonUseCase].
@riverpod
GetMySalonUseCase getMySalonUseCase(Ref ref) {
  return GetMySalonUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [UpdateSalonUseCase].
@riverpod
UpdateSalonUseCase updateSalonUseCase(Ref ref) {
  return UpdateSalonUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [CreateServiceUseCase].
@riverpod
CreateServiceUseCase createServiceUseCase(Ref ref) {
  return CreateServiceUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [UpdateServiceUseCase].
@riverpod
UpdateServiceUseCase updateServiceUseCase(Ref ref) {
  return UpdateServiceUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [DeleteServiceUseCase].
@riverpod
DeleteServiceUseCase deleteServiceUseCase(Ref ref) {
  return DeleteServiceUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [AddBarberUseCase].
@riverpod
AddBarberUseCase addBarberUseCase(Ref ref) {
  return AddBarberUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [UpdateBarberUseCase].
@riverpod
UpdateBarberUseCase updateBarberUseCase(Ref ref) {
  return UpdateBarberUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [RemoveBarberUseCase].
@riverpod
RemoveBarberUseCase removeBarberUseCase(Ref ref) {
  return RemoveBarberUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [GetStatsUseCase].
@riverpod
GetStatsUseCase getStatsUseCase(Ref ref) {
  return GetStatsUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [GetTodayBookingsUseCase].
@riverpod
GetTodayBookingsUseCase getTodayBookingsUseCase(Ref ref) {
  return GetTodayBookingsUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [AdvanceQueueUseCase].
@riverpod
AdvanceQueueUseCase advanceQueueUseCase(Ref ref) {
  return AdvanceQueueUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [SkipQueueEntryUseCase].
@riverpod
SkipQueueEntryUseCase skipQueueEntryUseCase(Ref ref) {
  return SkipQueueEntryUseCase(ref.watch(ownerRepositoryProvider));
}

/// Provides the [UpdateBookingStatusUseCase].
@riverpod
UpdateBookingStatusUseCase updateBookingStatusUseCase(Ref ref) {
  return UpdateBookingStatusUseCase(ref.watch(ownerRepositoryProvider));
}
