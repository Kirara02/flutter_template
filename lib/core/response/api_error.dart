/// Represents the structured error object returned by the API.
/// e.g. `"error": { "code": 401, "detail": "invalid username or password" }`
class ApiError {
  const ApiError({required this.code, required this.detail});

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      code: map['code'] as int? ?? 0,
      detail: map['detail'] as String? ?? map['message'] as String? ?? 'Unknown error',
    );
  }

  /// HTTP-like error code returned by the server (e.g. 401, 422).
  final int code;

  /// Human-readable error detail message.
  final String detail;

  @override
  String toString() => 'ApiError(code: $code, detail: $detail)';
}
