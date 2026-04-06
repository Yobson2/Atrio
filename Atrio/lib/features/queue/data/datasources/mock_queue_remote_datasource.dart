// coverage:ignore-file

import 'dart:async';
import 'dart:math';

import 'package:flutter_templates/features/queue/data/datasources/queue_remote_datasource.dart';
import 'package:flutter_templates/features/queue/data/datasources/queue_websocket_datasource.dart';
import 'package:flutter_templates/features/queue/data/models/queue_entry_model.dart';
import 'package:flutter_templates/features/queue/data/models/queue_status_model.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry_status.dart';

/// Mock implementation of [QueueRemoteDataSource] for local testing.
///
/// Generates fake queue data with periodic updates.
/// Remove this file and set `USE_MOCK_QUEUE=false` in `.env` to switch
/// to the real API.
class MockQueueRemoteDataSource implements QueueRemoteDataSource {
  static const _delay = Duration(milliseconds: 800);
  static final _random = Random();

  final List<QueueEntryModel> _entries = [];
  QueueEntryModel? _myEntry;
  int _nextId = 1;

  @override
  Future<QueueStatusModel> getQueueStatus(String salonId) async {
    await Future<void>.delayed(_delay);
    _ensureEntries(salonId);
    return _buildStatus(salonId);
  }

  @override
  Future<QueueEntryModel> joinQueue(String bookingId) async {
    await Future<void>.delayed(_delay);

    final salonId = 'salon-001';
    _ensureEntries(salonId);

    _myEntry = QueueEntryModel(
      id: 'entry-${_nextId++}',
      salonId: salonId,
      bookingId: bookingId,
      userId: 'mock-user-001',
      userName: 'Test User',
      serviceName: 'Haircut',
      position: _entries.length + 1,
      joinedAt: DateTime.now(),
      estimatedWaitMinutes: (_entries.length + 1) * 10,
    );

    _entries.add(_myEntry!);
    return _myEntry!;
  }

  @override
  Future<void> leaveQueue(String entryId) async {
    await Future<void>.delayed(_delay);
    _entries.removeWhere((e) => e.id == entryId);
    if (_myEntry?.id == entryId) _myEntry = null;
    _reindex();
  }

  @override
  Future<QueueEntryModel?> getMyQueuePosition(String salonId) async {
    await Future<void>.delayed(_delay);
    return _myEntry;
  }

  void _ensureEntries(String salonId) {
    if (_entries.isNotEmpty) return;

    final count = _random.nextInt(4) + 2;
    final names = [
      'Alice',
      'Bob',
      'Charlie',
      'Diana',
      'Eve',
      'Frank',
    ];
    final services = [
      'Haircut',
      'Beard Trim',
      'Hair Color',
      'Shave',
      'Styling',
    ];

    for (var i = 0; i < count; i++) {
      _entries.add(
        QueueEntryModel(
          id: 'entry-${_nextId++}',
          salonId: salonId,
          bookingId: 'booking-${_nextId}',
          userId: 'user-$i',
          userName: names[i % names.length],
          serviceName: services[i % services.length],
          position: i + 1,
          status: i == 0 ? QueueEntryStatus.serving : QueueEntryStatus.waiting,
          joinedAt: DateTime.now().subtract(Duration(minutes: (count - i) * 8)),
          estimatedWaitMinutes: i * 10,
        ),
      );
    }
  }

  void _reindex() {
    for (var i = 0; i < _entries.length; i++) {
      _entries[i] = QueueEntryModel(
        id: _entries[i].id,
        salonId: _entries[i].salonId,
        bookingId: _entries[i].bookingId,
        userId: _entries[i].userId,
        userName: _entries[i].userName,
        serviceName: _entries[i].serviceName,
        position: i + 1,
        status: i == 0 ? QueueEntryStatus.serving : _entries[i].status,
        joinedAt: _entries[i].joinedAt,
        estimatedWaitMinutes: i * 10,
      );
    }
  }

  QueueStatusModel _buildStatus(String salonId) {
    final waiting =
        _entries.where((e) => e.status == QueueEntryStatus.waiting).length;
    final serving =
        _entries.where((e) => e.status == QueueEntryStatus.serving).length;

    return QueueStatusModel(
      salonId: salonId,
      totalWaiting: waiting,
      estimatedWaitMinutes: waiting * 10,
      currentlyServing: serving,
      entries: List.unmodifiable(_entries),
      lastUpdatedAt: DateTime.now(),
    );
  }
}

/// Mock implementation of [QueueWebSocketDataSource] that emits
/// fake [QueueStatusModel] updates every 5 seconds.
class MockQueueWebSocketDataSource implements QueueWebSocketDataSource {
  /// Creates a [MockQueueWebSocketDataSource].
  MockQueueWebSocketDataSource(this._mockRemote);

  final MockQueueRemoteDataSource _mockRemote;
  StreamController<QueueStatusModel>? _controller;
  Timer? _timer;

  @override
  Stream<QueueStatusModel> watchQueueStatus(String salonId) {
    disconnect();

    _controller = StreamController<QueueStatusModel>.broadcast(
      onCancel: disconnect,
    );

    // Emit initial status immediately.
    _mockRemote.getQueueStatus(salonId).then((status) {
      if (_controller != null && !_controller!.isClosed) {
        _controller!.add(status);
      }
    });

    // Emit updated status every 5 seconds.
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _mockRemote.getQueueStatus(salonId).then((status) {
        if (_controller != null && !_controller!.isClosed) {
          _controller!.add(status);
        }
      });
    });

    return _controller!.stream;
  }

  @override
  void disconnect() {
    _timer?.cancel();
    _timer = null;
    _controller?.close();
    _controller = null;
  }
}
