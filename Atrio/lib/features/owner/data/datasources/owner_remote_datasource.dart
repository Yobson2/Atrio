import 'package:dio/dio.dart';
import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/features/booking/data/models/booking_model.dart';
import 'package:flutter_templates/features/owner/data/models/salon_stats_model.dart';
import 'package:flutter_templates/features/salon/data/models/barber_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_service_model.dart';

/// Remote data source for owner API calls.
abstract class OwnerRemoteDataSource {
  /// GET: Fetches the salon owned by the current user.
  Future<SalonModel> getMySalon();

  /// PUT: Updates the salon information.
  Future<SalonModel> updateSalon(SalonModel salon);

  /// POST: Creates a new service.
  Future<SalonServiceModel> createService(SalonServiceModel service);

  /// PUT: Updates an existing service.
  Future<SalonServiceModel> updateService(SalonServiceModel service);

  /// DELETE: Deletes a service.
  Future<void> deleteService(String serviceId);

  /// POST: Adds a new barber.
  Future<BarberModel> addBarber(BarberModel barber);

  /// PUT: Updates an existing barber.
  Future<BarberModel> updateBarber(BarberModel barber);

  /// DELETE: Removes a barber.
  Future<void> removeBarber(String barberId);

  /// GET: Fetches salon statistics.
  Future<SalonStatsModel> getStats({DateTime? from, DateTime? to});

  /// GET: Fetches today's bookings.
  Future<List<BookingModel>> getTodayBookings();

  /// POST: Advances the queue for a salon.
  Future<void> advanceQueue(String salonId);

  /// POST: Skips a queue entry.
  Future<void> skipQueueEntry(String entryId);

  /// PATCH: Updates a booking status.
  Future<void> updateBookingStatus(String bookingId, String status);
}

/// Implementation of [OwnerRemoteDataSource] using [Dio].
class OwnerRemoteDataSourceImpl implements OwnerRemoteDataSource {
  /// Creates an [OwnerRemoteDataSourceImpl].
  const OwnerRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<SalonModel> getMySalon() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/owner/salon',
      );
      return SalonModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<SalonModel> updateSalon(SalonModel salon) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/owner/salon',
        data: salon.toJson(),
      );
      return SalonModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<SalonServiceModel> createService(SalonServiceModel service) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/owner/services',
        data: service.toJson(),
      );
      return SalonServiceModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<SalonServiceModel> updateService(SalonServiceModel service) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/owner/services/${service.id}',
        data: service.toJson(),
      );
      return SalonServiceModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteService(String serviceId) async {
    try {
      await _dio.delete<void>('/owner/services/$serviceId');
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<BarberModel> addBarber(BarberModel barber) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/owner/barbers',
        data: barber.toJson(),
      );
      return BarberModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<BarberModel> updateBarber(BarberModel barber) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/owner/barbers/${barber.id}',
        data: barber.toJson(),
      );
      return BarberModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> removeBarber(String barberId) async {
    try {
      await _dio.delete<void>('/owner/barbers/$barberId');
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<SalonStatsModel> getStats({DateTime? from, DateTime? to}) async {
    try {
      final queryParams = <String, dynamic>{
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
      };
      final response = await _dio.get<Map<String, dynamic>>(
        '/owner/stats',
        queryParameters: queryParams,
      );
      return SalonStatsModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BookingModel>> getTodayBookings() async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/owner/bookings/today',
      );
      final data = response.data;
      if (data == null) return [];
      return data
          .cast<Map<String, dynamic>>()
          .map(BookingModel.fromJson)
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> advanceQueue(String salonId) async {
    try {
      await _dio.post<void>('/owner/queue/$salonId/advance');
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> skipQueueEntry(String entryId) async {
    try {
      await _dio.post<void>('/owner/queue/entries/$entryId/skip');
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateBookingStatus(String bookingId, String status) async {
    try {
      await _dio.patch<void>(
        '/owner/bookings/$bookingId/status',
        data: {'status': status},
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
