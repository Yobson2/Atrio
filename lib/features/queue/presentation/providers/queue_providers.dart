import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/features/queue/data/datasources/mock_queue_datasource.dart';
import 'package:flutter_templates/features/queue/domain/repositories/queue_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'queue_providers.g.dart';

/// Provides the [QueueRepository] (mock for now).
@riverpod
QueueRepository queueRepository(Ref ref) {
  return MockQueueRepository();
}
