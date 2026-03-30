import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interceptor that handles:
/// 1. Attaching the access token to every request as a Bearer header.
/// 2. On 401 responses, using the refresh token to fetch a new access token
///    and retrying the original request automatically.
/// 3. If the refresh call also fails (401), clearing all saved tokens and
///    calling [onUnauthenticated] so the app can redirect to the login screen.
class AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;
  final Dio _dio;
  final Logger _logger;

  /// Called when both access and refresh tokens are invalid/expired.
  /// Use this to reset auth state (e.g. set AuthNotifier state to null).
  final void Function()? onUnauthenticated;

  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'auth_refresh_token';
  static const _refreshEndpoint = '/api/auth/refresh';
  static const _loginEndpoint = '/api/auth/login';

  // Guards against concurrent refresh calls when multiple requests 401 at once.
  bool _isRefreshing = false;
  final List<({RequestOptions options, ErrorInterceptorHandler handler})>
  _pendingRequests = [];

  AuthInterceptor(
    this._prefs,
    this._dio,
    this._logger, {
    this.onUnauthenticated,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _prefs.getString(_tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;

    // Skip refresh for: non-401s, the refresh endpoint itself, and the login endpoint
    if (statusCode != 401 ||
        path == _refreshEndpoint ||
        path == _loginEndpoint) {
      return handler.next(err);
    }

    // If a refresh is already in progress, queue this request.
    if (_isRefreshing) {
      _logger.d(
        '🔄 REFRESH IN PROGRESS — queuing [${err.requestOptions.method}] ${err.requestOptions.path}',
      );
      _pendingRequests.add((options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    final refreshToken = _prefs.getString(_refreshTokenKey);

    if (refreshToken == null) {
      // No refresh token → force logout
      _logger.w('🔑 NO REFRESH TOKEN — forcing logout');
      await _clearTokensAndNotify();
      _isRefreshing = false;
      return handler.next(err);
    }

    _logger.i('🔄 TOKEN EXPIRED — attempting refresh...');

    try {
      final response = await _dio.post(
        _refreshEndpoint,
        data: {'refresh_token': refreshToken},
        options: Options(
          // Skip the interceptor for this call to avoid loops
          extra: {'skipAuthInterceptor': true},
        ),
      );

      // Response format: { "success": true, "data": { "access_token": "...", "refresh_token": "..." } }
      final responseBody = response.data as Map<String, dynamic>?;
      final tokenData = responseBody?['data'] as Map<String, dynamic>?;

      final newToken = tokenData?['access_token'] as String?;
      final newRefreshToken = tokenData?['refresh_token'] as String?;

      if (newToken == null) {
        throw Exception('Refresh response missing access_token');
      }

      // Persist the new tokens
      await _prefs.setString(_tokenKey, newToken);
      if (newRefreshToken != null) {
        await _prefs.setString(_refreshTokenKey, newRefreshToken);
      }

      _logger.i(
        '✅ TOKEN REFRESHED — retrying original request and ${_pendingRequests.length} queued request(s)',
      );

      // Retry the original failed request with the new token
      final retried = await _retry(err.requestOptions, newToken);
      handler.resolve(retried);

      // Replay all queued requests
      for (final pending in _pendingRequests) {
        try {
          final retriedPending = await _retry(pending.options, newToken);
          _logger.d(
            '✅ QUEUED RETRY OK — [${pending.options.method}] ${pending.options.path}',
          );
          pending.handler.resolve(retriedPending);
        } catch (e) {
          _logger.e(
            '❌ QUEUED RETRY FAILED — [${pending.options.method}] ${pending.options.path}: $e',
          );
          pending.handler.next(
            DioException(requestOptions: pending.options, error: e),
          );
        }
      }
    } catch (e) {
      // Refresh failed — both tokens are invalid. Clear and force re-login.
      _logger.e(
        '❌ REFRESH FAILED — both tokens invalid. Forcing logout. Error: $e',
      );
      await _clearTokensAndNotify();
      for (final pending in _pendingRequests) {
        pending.handler.next(
          DioException(
            requestOptions: pending.options,
            response: err.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
      handler.next(err);
    } finally {
      _pendingRequests.clear();
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options, String newToken) {
    return _dio.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(
        method: options.method,
        headers: {...options.headers, 'Authorization': 'Bearer $newToken'},
      ),
    );
  }

  Future<void> _clearTokens() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_refreshTokenKey);
  }

  /// Clears tokens and notifies the app that the session is fully expired.
  Future<void> _clearTokensAndNotify() async {
    await _clearTokens();
    onUnauthenticated?.call();
  }
}
