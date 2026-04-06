import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/providers/network_providers.dart';
import 'package:flutter_templates/features/salon/data/datasources/mock_salon_remote_datasource.dart';
import 'package:flutter_templates/features/salon/data/datasources/salon_remote_datasource.dart';
import 'package:flutter_templates/features/salon/data/repositories/salon_repository_impl.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';
import 'package:flutter_templates/features/salon/domain/usecases/add_review_usecase.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_nearby_salons_usecase.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_salon_barbers_usecase.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_salon_detail_usecase.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_salon_reviews_usecase.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_salon_services_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'salon_providers.g.dart';

/// Provides the [SalonRemoteDataSource].
///
/// Set `USE_MOCK_SALON=true` in `.env` to use mock data.
@riverpod
SalonRemoteDataSource salonRemoteDataSource(Ref ref) {
  final useMock = dotenv.get('USE_MOCK_SALON', fallback: 'false') == 'true';
  if (useMock) return MockSalonRemoteDataSource();
  return SalonRemoteDataSourceImpl(ref.watch(dioProvider));
}

/// Provides the [SalonRepository].
@riverpod
SalonRepository salonRepository(Ref ref) {
  return SalonRepositoryImpl(
    remoteDataSource: ref.watch(salonRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

/// Provides the [GetNearbySalonsUseCase].
@riverpod
GetNearbySalonsUseCase getNearbySalonsUseCase(Ref ref) {
  return GetNearbySalonsUseCase(ref.watch(salonRepositoryProvider));
}

/// Provides the [GetSalonDetailUseCase].
@riverpod
GetSalonDetailUseCase getSalonDetailUseCase(Ref ref) {
  return GetSalonDetailUseCase(ref.watch(salonRepositoryProvider));
}

/// Provides the [GetSalonServicesUseCase].
@riverpod
GetSalonServicesUseCase getSalonServicesUseCase(Ref ref) {
  return GetSalonServicesUseCase(ref.watch(salonRepositoryProvider));
}

/// Provides the [GetSalonBarbersUseCase].
@riverpod
GetSalonBarbersUseCase getSalonBarbersUseCase(Ref ref) {
  return GetSalonBarbersUseCase(ref.watch(salonRepositoryProvider));
}

/// Provides the [GetSalonReviewsUseCase].
@riverpod
GetSalonReviewsUseCase getSalonReviewsUseCase(Ref ref) {
  return GetSalonReviewsUseCase(ref.watch(salonRepositoryProvider));
}

/// Provides the [AddReviewUseCase].
@riverpod
AddReviewUseCase addReviewUseCase(Ref ref) {
  return AddReviewUseCase(ref.watch(salonRepositoryProvider));
}
