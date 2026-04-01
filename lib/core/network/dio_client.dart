import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../auth/session_manager.dart';
import '../auth/token_manager.dart';
import '../logger/logger_provider.dart';
import 'auth_interceptor.dart';
// ignore: implementation_imports
import '../../features/auth/presentation/providers/auth_provider.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.example.com/';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  final tokenManager = ref.watch(tokenManagerProvider);
  final sessionManager = ref.watch(sessionManagerProvider);
  final logger = ref.watch(loggerProvider);

  // Auth interceptor: attaches Bearer token, handles 401 refresh + retry,
  // and resets auth state when both tokens are fully expired.
  dio.interceptors.add(
    AuthInterceptor(
      tokenManager,
      sessionManager,
      dio,
      logger,
      onUnauthenticated: () {
        // Lazily read authProvider to avoid circular dependency at build time.
        // This will reset the in-memory user state and trigger GoRouter redirect.
        try {
          ref.read(authProvider.notifier).logout();
        } catch (_) {
          // Provider may already be disposed during app teardown — safe to ignore.
        }
      },
    ),
  );

  // Logging interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = options.headers['Authorization'] as String?;
        final tokenPreview = token != null
            ? '${token.substring(0, token.length.clamp(0, 30))}...'
            : 'none';
        logger.i(
          '➡️ REQUEST [${options.method}] => PATH: ${options.path}\n'
          'Auth: $tokenPreview\n'
          'Body: ${options.data}',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.i(
          '⬅️ RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.path}\n'
          'Body: ${response.data}',
        );
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        logger.e(
          '❌ ERROR [${e.response?.statusCode}] => PATH: ${e.requestOptions.path}\n'
          'Message: ${e.message}\n'
          'Data: ${e.response?.data}',
        );
        return handler.next(e);
      },
    ),
  );

  return dio;
}
