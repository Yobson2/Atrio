import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/features/owner/data/datasources/mock_owner_datasource.dart';
import 'package:flutter_templates/features/owner/domain/repositories/owner_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_providers.g.dart';

/// Provides the [OwnerRepository] (mock for now).
@riverpod
OwnerRepository ownerRepository(Ref ref) {
  return MockOwnerRepository();
}
