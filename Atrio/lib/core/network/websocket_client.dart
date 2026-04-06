import 'dart:async';
import 'dart:convert';

import 'package:flutter_templates/core/config/env.dart';
import 'package:flutter_templates/core/storage/secure_storage.dart';
import 'package:flutter_templates/core/utils/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket client with auto-reconnect and exponential backoff.
class WebSocketClient {
  /// Creates a [WebSocketClient].
  WebSocketClient({required this.env, required this.secureStorage});

  /// Environment configuration.
  final Env env;

  /// Secure storage for reading auth tokens.
  final SecureStorage secureStorage;

  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _controller;
  Timer? _reconnectTimer;
  int _retryCount = 0;
  String? _currentPath;
  bool _disposed = false;

  static const int _maxRetries = 5;
  static const _tag = 'WebSocket';

  /// Whether the WebSocket is currently connected.
  bool get isConnected => _channel != null;

  /// Connects to the given [path] and returns a stream of JSON messages.
  Stream<Map<String, dynamic>> connect(String path) {
    _currentPath = path;
    _disposed = false;
    _controller = StreamController<Map<String, dynamic>>.broadcast(
      onCancel: disconnect,
    );
    _doConnect(path);
    return _controller!.stream;
  }

  Future<void> _doConnect(String path) async {
    if (_disposed) return;

    try {
      final uri = Uri.parse('${env.wsBaseUrl}$path');

      _channel = WebSocketChannel.connect(uri);
      AppLogger.info('Connected to $uri', tag: _tag);

      _retryCount = 0;
      _channel!.stream.listen(
        (data) {
          if (data is String) {
            try {
              final json = jsonDecode(data) as Map<String, dynamic>;
              _controller?.add(json);
            } catch (e) {
              AppLogger.error('Failed to decode message', tag: _tag, error: e);
            }
          }
        },
        onError: (Object error) {
          AppLogger.error('WebSocket error', tag: _tag, error: error);
          _scheduleReconnect();
        },
        onDone: () {
          AppLogger.info('WebSocket closed', tag: _tag);
          _scheduleReconnect();
        },
        cancelOnError: false,
      );
    } catch (e) {
      AppLogger.error('Failed to connect', tag: _tag, error: e);
      _scheduleReconnect();
    }
  }

  /// Sends a JSON message through the WebSocket.
  void send(Map<String, dynamic> message) {
    _channel?.sink.add(jsonEncode(message));
  }

  void _scheduleReconnect() {
    if (_disposed || _retryCount >= _maxRetries) {
      if (_retryCount >= _maxRetries) {
        AppLogger.error('Max retries reached, giving up', tag: _tag);
      }
      return;
    }

    _channel = null;
    _retryCount++;
    final delay = Duration(seconds: 1 << _retryCount); // exponential backoff
    AppLogger.info(
      'Reconnecting in ${delay.inSeconds}s (attempt $_retryCount)',
      tag: _tag,
    );

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (_currentPath != null) {
        _doConnect(_currentPath!);
      }
    });
  }

  /// Disconnects the WebSocket.
  void disconnect() {
    _disposed = true;
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
    _controller?.close();
    _controller = null;
    _retryCount = 0;
    _currentPath = null;
  }
}
