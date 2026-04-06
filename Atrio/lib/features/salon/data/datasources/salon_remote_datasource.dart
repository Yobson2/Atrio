import 'package:dio/dio.dart';
import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/core/network/api_endpoints.dart';
import 'package:flutter_templates/features/salon/data/models/barber_model.dart';
import 'package:flutter_templates/features/salon/data/models/review_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_model.dart';
import 'package:flutter_templates/features/salon/data/models/salon_service_model.dart';

/// Remote data source for salon API calls.
abstract class SalonRemoteDataSource {
  /// Fetches nearby salons based on location.
  Future<List<SalonModel>> getNearbySalons({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
    String? query,
    double? minRating,
    bool? isOpenNow,
  });

  /// Fetches a single salon by ID.
  Future<SalonModel> getSalonById(String id);

  /// Fetches services for a salon.
  Future<List<SalonServiceModel>> getSalonServices(String salonId);

  /// Fetches barbers for a salon.
  Future<List<BarberModel>> getSalonBarbers(String salonId);

  /// Fetches reviews for a salon.
  Future<List<ReviewModel>> getSalonReviews(String salonId);

  /// Adds a review for a salon.
  Future<void> addReview({
    required String salonId,
    required double rating,
    String? comment,
  });
}

/// Implementation using [Dio] HTTP client.
class SalonRemoteDataSourceImpl implements SalonRemoteDataSource {
  /// Creates a [SalonRemoteDataSourceImpl].
  const SalonRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<SalonModel>> getNearbySalons({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
    String? query,
    double? minRating,
    bool? isOpenNow,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'radius_km': radiusKm,
        if (query != null) 'query': query,
        if (minRating != null) 'min_rating': minRating,
        if (isOpenNow != null) 'is_open_now': isOpenNow,
      };
      final response = await _dio.get<List<dynamic>>(
        ApiEndpoints.salons,
        queryParameters: queryParams,
      );
      final data = response.data;
      if (data == null) return [];
      return data
          .cast<Map<String, dynamic>>()
          .map(SalonModel.fromJson)
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<SalonModel> getSalonById(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.salons}/$id',
      );
      return SalonModel.fromJson(response.data!);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<SalonServiceModel>> getSalonServices(String salonId) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '${ApiEndpoints.salons}/$salonId/services',
      );
      final data = response.data;
      if (data == null) return [];
      return data
          .cast<Map<String, dynamic>>()
          .map(SalonServiceModel.fromJson)
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BarberModel>> getSalonBarbers(String salonId) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '${ApiEndpoints.salons}/$salonId/barbers',
      );
      final data = response.data;
      if (data == null) return [];
      return data
          .cast<Map<String, dynamic>>()
          .map(BarberModel.fromJson)
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ReviewModel>> getSalonReviews(String salonId) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '${ApiEndpoints.salons}/$salonId/reviews',
      );
      final data = response.data;
      if (data == null) return [];
      return data
          .cast<Map<String, dynamic>>()
          .map(ReviewModel.fromJson)
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> addReview({
    required String salonId,
    required double rating,
    String? comment,
  }) async {
    try {
      await _dio.post<void>(
        '${ApiEndpoints.salons}/$salonId/reviews',
        data: {
          'rating': rating,
          if (comment != null) 'comment': comment,
        },
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
