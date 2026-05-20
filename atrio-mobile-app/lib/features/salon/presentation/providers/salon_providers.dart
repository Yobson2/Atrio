import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/features/salon/data/datasources/mock_salon_datasource.dart';
import 'package:flutter_templates/features/salon/domain/repositories/salon_repository.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_salon_detail_usecase.dart';
import 'package:flutter_templates/features/salon/domain/usecases/get_salons_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'salon_providers.g.dart';

/// Provides the [SalonRepository] (mock for now).
@riverpod
SalonRepository salonRepository(Ref ref) {
  return MockSalonRepository();
}

/// Provides the [GetSalonsUseCase].
@riverpod
GetSalonsUseCase getSalonsUseCase(Ref ref) {
  return GetSalonsUseCase(ref.watch(salonRepositoryProvider));
}

/// Provides the [GetSalonDetailUseCase].
@riverpod
GetSalonDetailUseCase getSalonDetailUseCase(Ref ref) {
  return GetSalonDetailUseCase(ref.watch(salonRepositoryProvider));
}
