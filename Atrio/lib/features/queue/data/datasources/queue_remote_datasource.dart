import 'package:dio/dio.dart';
import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/core/network/api_endpoints.dart';
import 'package:flutter_templates/features/queue/data/models/queue_entry_model.dart';
import 'package:flutter_templates/features/queue/data/models/queue_status_model.dart';

/// Remote data source for queue API calls.
abstract class QueueRemoteDataSource {
  /// Fetches the current queue status for a salon.
  Future<QueueStatusModel> getQueueStatus(String salonId);

  /// Joins the queue for a given booking.
  Future<QueueEntryModel> joinQueue(String bookingId);

  /// Leaves the queue by entry ID.
  Future<void> leaveQueue(String entryId);

  /// Gets the current user's position in a salon queue.
  Future<QueueEntryModel?> getMyQueuePosition(String salonId);
}

/// Implementation of [QueueRemoteDataSource] using [Dio].
class QueueRemoteDataSourceImpl implements QueueRemoteDataSource {
  /// Creates a [QueueRemoteDataSourceImpl].
  const QueueRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<QueueStatusModel> getQueueStatus(String salonId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.queueStatus(salonId),
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return QueueStatusModel.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<QueueEntryModel> joinQueue(String bookingId) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.queueJoin,
        data: {'booking_id': bookingId},
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return QueueEntryModel.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> leaveQueue(String entryId) async {
    try {
      await _dio.post<void>(ApiEndpoints.queueLeave(entryId));
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<QueueEntryModel?> getMyQueuePosition(String salonId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.queueMyPosition(salonId),
      );
      final data = response.data;
      if (data == null) return null;
      return QueueEntryModel.fromJson(data);
    } on DioException catch (e) {
      // 404 means user is not in the queue.
      if (e.response?.statusCode == 404) return null;
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
