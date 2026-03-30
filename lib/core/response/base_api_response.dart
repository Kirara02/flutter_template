import '../utils/map_serializable.dart';
import 'api_error.dart';

class BaseApiResponse<T> extends MapSerializable {
  const BaseApiResponse.fromMap(super.data, {this.parser}) : super.fromMap();

  final T Function(Map<String, dynamic>)? parser;

  bool get success => this['success'] as bool? ?? false;
  String? get message => this['message'] as String?;

  /// Parses the `error` field.
  /// Supports both object format `{"code": 401, "detail": "..."}` and
  /// plain string format `"error": "..."`.
  ApiError? get error {
    final raw = this['error'];
    if (raw is Map<String, dynamic>) return ApiError.fromMap(raw);
    if (raw is String) return ApiError(code: 0, detail: raw);
    return null;
  }

  T? get data {
    final rawData = this['data'];
    if (rawData == null) return null;

    // If a parser is provided and the data is a map, map it using the parser
    if (parser != null && rawData is Map<String, dynamic>) {
      return parser!(rawData);
    }

    return rawData as T?;
  }
}
