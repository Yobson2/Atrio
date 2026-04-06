import 'package:dio/dio.dart';
import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/core/network/api_endpoints.dart';
import 'package:flutter_templates/features/booking/data/models/booking_model.dart';
import 'package:flutter_templates/features/booking/data/models/time_slot_model.dart';

/// Remote data source for booking API calls.
abstract class BookingRemoteDataSource {
  /// GET available time slots.
  Future<List<TimeSlotModel>> getAvailableSlots({
    required String salonId,
    required String serviceId,
    required DateTime date,
    String? barberId,
  });

  /// POST create a new booking.
  Future<BookingModel> createBooking({
    required String salonId,
    required String serviceId,
    required String type,
    String? barberId,
    DateTime? scheduledAt,
  });

  /// PUT cancel a booking.
  Future<BookingModel> cancelBooking(String bookingId);

  /// GET all bookings for the current user.
  Future<List<BookingModel>> getMyBookings();

  /// GET a single booking by ID.
  Future<BookingModel> getBookingById(String id);
}

/// Implementation of [BookingRemoteDataSource] using [Dio].
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  /// Creates a [BookingRemoteDataSourceImpl].
  const BookingRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<TimeSlotModel>> getAvailableSlots({
    required String salonId,
    required String serviceId,
    required DateTime date,
    String? barberId,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.bookings}/slots',
        queryParameters: {
          'salon_id': salonId,
          'service_id': serviceId,
          'date': date.toIso8601String(),
          if (barberId != null) 'barber_id': barberId,
        },
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      final slots = data['slots'] as List<dynamic>? ?? [];
      return slots
          .cast<Map<String, dynamic>>()
          .map(TimeSlotModel.fromJson)
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<BookingModel> createBooking({
    required String salonId,
    required String serviceId,
    required String type,
    String? barberId,
    DateTime? scheduledAt,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.bookings,
        data: {
          'salon_id': salonId,
          'service_id': serviceId,
          'type': type,
          if (barberId != null) 'barber_id': barberId,
          if (scheduledAt != null)
            'scheduled_at': scheduledAt.toIso8601String(),
        },
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return BookingModel.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<BookingModel> cancelBooking(String bookingId) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '${ApiEndpoints.bookings}/$bookingId/cancel',
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return BookingModel.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BookingModel>> getMyBookings() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.bookings}/mine',
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      final bookings = data['bookings'] as List<dynamic>? ?? [];
      return bookings
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
  Future<BookingModel> getBookingById(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.bookings}/$id',
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return BookingModel.fromJson(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
