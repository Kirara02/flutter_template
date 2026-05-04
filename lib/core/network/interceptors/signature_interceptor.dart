import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Interceptor that signs every request with an HMAC-SHA256 signature.
///
/// Required headers:
/// - x-api-time: Current Unix Timestamp (seconds).
/// - x-api-key: Application Access Key.
/// - x-api-signature: HMAC-SHA256 of (timestamp + method + path + accessKey + secretKey).
class SignatureInterceptor extends Interceptor {
  final String _accessKey;
  final String _secretKey;

  SignatureInterceptor()
    : _accessKey = dotenv.env['API_ACCESS_KEY'] ?? '',
      _secretKey = dotenv.env['API_SECRET_KEY'] ?? '';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_accessKey.isEmpty || _secretKey.isEmpty) {
      return handler.next(options);
    }

    final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
        .toString();
    final method = options.method.toUpperCase();

    // Use the path from the URI to ensure consistency (includes leading slash)
    final path = options.uri.path;

    // String to sign: timestamp + method + path + accessKey + secretKey
    final stringToSign = '$timestamp$method$path$_accessKey$_secretKey';

    // Match Postman logic:
    // const message = "api-request";
    // const key = timestamp + method + path + accessKey + secretKey;
    // const hash = CryptoJS.HmacSHA256(message, key);
    const message = "api-request";
    final hmacSha256 = Hmac(sha256, utf8.encode(stringToSign));
    final signature = hmacSha256.convert(utf8.encode(message)).toString();

    // Inject headers
    options.headers['x-api-time'] = timestamp;
    options.headers['x-api-key'] = _accessKey;
    options.headers['x-api-signature'] = signature;

    handler.next(options);
  }
}
