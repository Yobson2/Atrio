import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/config/env_provider.dart';
import 'package:flutter_templates/core/network/websocket_client.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'websocket_provider.g.dart';

/// Provides a singleton [WebSocketClient].
@Riverpod(keepAlive: true)
WebSocketClient webSocketClient(Ref ref) {
  final env = ref.watch(envProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final client = WebSocketClient(env: env, secureStorage: secureStorage);
  ref.onDispose(client.disconnect);
  return client;
}
