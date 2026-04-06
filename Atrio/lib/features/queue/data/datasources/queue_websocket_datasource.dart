import 'package:flutter_templates/core/network/api_endpoints.dart';
import 'package:flutter_templates/core/network/websocket_client.dart';
import 'package:flutter_templates/features/queue/data/models/queue_status_model.dart';

/// WebSocket data source for real-time queue status updates.
abstract class QueueWebSocketDataSource {
  /// Connects and returns a stream of [QueueStatusModel] for a salon.
  Stream<QueueStatusModel> watchQueueStatus(String salonId);

  /// Disconnects the WebSocket.
  void disconnect();
}

/// Implementation of [QueueWebSocketDataSource] using [WebSocketClient].
class QueueWebSocketDataSourceImpl implements QueueWebSocketDataSource {
  /// Creates a [QueueWebSocketDataSourceImpl].
  QueueWebSocketDataSourceImpl(this._webSocketClient);

  final WebSocketClient _webSocketClient;

  @override
  Stream<QueueStatusModel> watchQueueStatus(String salonId) {
    return _webSocketClient
        .connect(ApiEndpoints.queueWebSocket(salonId))
        .map(QueueStatusModel.fromJson);
  }

  @override
  void disconnect() {
    _webSocketClient.disconnect();
  }
}
