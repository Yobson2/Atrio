import 'package:dio/dio.dart';
import 'package:flutter_templates/core/utils/logger.dart';

/// Logs HTTP requests and responses for debugging.
///
/// Only active when logging is enabled (controlled by [Env]).
/// Sensitive fields (passwords, tokens, OTPs) are automatically redacted.
class LoggingInterceptor extends Interceptor {
  static const _sensitiveKeys = {
    'password',
    'token',
    'accessToken',
    'refreshToken',
    'access_token',
    'refresh_token',
    'otp',
    'pin',
    'secret',
    'credit_card',
    'currentPassword',
    'newPassword',
    'confirmPassword',
  };

  static String _redactSensitiveFields(dynamic data) {
    if (data is Map<String, dynamic>) {
      final redacted = Map<String, dynamic>.from(data);
      for (final key in _sensitiveKeys) {
        if (redacted.containsKey(key)) redacted[key] = '***REDACTED***';
      }
      return redacted.toString();
    }
    return data.toString();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.info(
      '--> ${options.method} ${options.uri}',
      tag: 'HTTP',
    );
    if (options.data != null) {
      AppLogger.debug(
        'Body: ${_redactSensitiveFields(options.data)}',
        tag: 'HTTP',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.info(
      '<-- ${response.statusCode} ${response.requestOptions.uri}',
      tag: 'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      '<-- ERROR ${err.response?.statusCode} ${err.requestOptions.uri}',
      tag: 'HTTP',
      error: err.message,
    );
    handler.next(err);
  }
}
