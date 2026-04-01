import 'package:dio/dio.dart';
import '../error/app_exception.dart';
import '../response/api_error.dart';
import '../response/base_api_response.dart';
import '../base/result.dart';

/// A helper function to safely execute network calls using Dio
/// and wrap the response in a [Result] object.
Future<Result<T>> safeApiCall<T>(
  Future<Response> Function() apiCall, {
  required T Function(dynamic data) mapper,
}) async {
  try {
    final response = await apiCall();

    // Check if the response matches our standard success format
    final responseData = response.data;
    if (responseData is Map<String, dynamic>) {
      final baseResponse = BaseApiResponse<dynamic>.fromMap(responseData);

      if (!baseResponse.success) {
        final error = baseResponse.error;
        return Result.failure(
          AppException(
            error?.detail ?? 'Unknown API Error',
            code: error != null ? '${error.code}' : 'API_ERROR',
          ),
        );
      }

      if (responseData.containsKey('data')) {
        return Result.success(
          mapper(baseResponse.data),
          message: baseResponse.message,
        );
      }
    }

    // Fallback if not standard enveloped response
    final fallbackMessage = (responseData is Map<String, dynamic>)
        ? responseData['message'] as String?
        : null;

    return Result.success(mapper(responseData), message: fallbackMessage);
  } on DioException catch (e) {
    if (e.response != null) {
      final data = e.response?.data;
      String message = 'Network Error';

      if (data is Map<String, dynamic>) {
        // Try to parse as BaseApiResponse to reuse the ApiError parsing logic
        final errorObj = data['error'];
        if (errorObj is Map<String, dynamic>) {
          message = ApiError.fromMap(errorObj).detail;
        } else if (errorObj is String) {
          message = errorObj;
        } else if (data['message'] is String) {
          message = data['message'] as String;
        }
      }

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        return Result.failure(UnauthorizedException(message));
      } else if (e.response?.statusCode == 422 ||
          e.response?.statusCode == 400) {
        return Result.failure(ValidationException(message));
      }

      return Result.failure(
        NetworkException(message, statusCode: e.response?.statusCode),
      );
    }

    return Result.failure(NetworkException('Connection Failed: ${e.message}'));
  } catch (e) {
    return Result.failure(
      AppException('Unexpected error occurred: $e', code: 'UNEXPECTED'),
    );
  }
}
