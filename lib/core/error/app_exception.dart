/// Custom Exception class for the application
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException(this.message, {this.code, this.details});

  @override
  String toString() {
    return '$message${code != null ? ' (Code: $code)' : ''}';
  }
}

class NetworkException extends AppException {
  final int? statusCode;

  NetworkException(super.message, {this.statusCode, super.code, super.details});
}

class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.details});
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = 'Unauthorized access']);
}
