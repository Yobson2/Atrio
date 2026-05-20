import 'package:dio/dio.dart';
import 'package:flutter_templates/core/error/exceptions.dart';
import 'package:flutter_templates/core/network/api_endpoints.dart';
import 'package:flutter_templates/features/auth/data/models/tokens_model.dart';
import 'package:flutter_templates/features/auth/data/models/user_model.dart';

/// Remote data source for authentication API calls.
abstract class AuthRemoteDataSource {
  /// POST login.
  Future<({UserModel user, TokensModel tokens})> login({
    required String email,
    required String password,
  });

  /// POST register.
  Future<({UserModel user, TokensModel tokens})> register({
    required String name,
    required String email,
    required String password,
  });

  /// POST forgot password.
  Future<void> forgotPassword({required String email});

  /// POST verify OTP.
  Future<void> verifyOtp({required String email, required String code});

  /// POST send OTP to phone number.
  Future<void> sendOtp({required String phone});

  /// POST verify phone OTP and authenticate.
  Future<({UserModel user, TokensModel tokens})> verifyPhoneOtp({
    required String phone,
    required String code,
  });

  /// POST logout.
  Future<void> logout();
}

/// Implementation of [AuthRemoteDataSource] using [Dio].
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  /// Creates an [AuthRemoteDataSourceImpl].
  const AuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<({UserModel user, TokensModel tokens})> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return _parseAuthResponse(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<({UserModel user, TokensModel tokens})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {'name': name, 'email': email, 'password': password},
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return _parseAuthResponse(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _dio.post<void>(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      await _dio.post<void>(
        ApiEndpoints.verifyOtp,
        data: {'email': email, 'code': code},
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> sendOtp({required String phone}) async {
    try {
      await _dio.post<void>(
        ApiEndpoints.sendOtp,
        data: {'phone': phone},
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<({UserModel user, TokensModel tokens})> verifyPhoneOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.verifyPhoneOtp,
        data: {'phone': phone, 'code': code},
      );
      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'Empty response from server');
      }
      return _parseAuthResponse(data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post<void>(ApiEndpoints.logout);
    } on DioException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  ({UserModel user, TokensModel tokens}) _parseAuthResponse(
    Map<String, dynamic> data,
  ) {
    final userData = data['user'];
    final tokensData = data['tokens'];
    if (userData is! Map<String, dynamic>) {
      throw const ServerException(message: 'Invalid user data in response');
    }
    if (tokensData is! Map<String, dynamic>) {
      throw const ServerException(message: 'Invalid tokens data in response');
    }
    return (
      user: UserModel.fromJson(userData),
      tokens: TokensModel.fromJson(tokensData),
    );
  }
}
