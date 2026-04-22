import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../logger/logger_provider.dart';
import '../notification/local_notification_service.dart';

part 'fcm_service.g.dart';

/// Service for managing Firebase Cloud Messaging (FCM) functionality.
/// Handles FCM token retrieval, refresh, and notification permissions.
class FcmService {
  FcmService(this._logger, this._notificationService);

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // ignore: unused_element
  final dynamic _logger;
  final LocalNotificationService _notificationService;

  /// Requests notification permissions for the app.
  /// Returns true if permission was granted, false otherwise.
  Future<bool> requestPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      final authorizationStatus = settings.authorizationStatus;
      final granted =
          authorizationStatus == AuthorizationStatus.authorized ||
          authorizationStatus == AuthorizationStatus.provisional;

      _logger.i(
        'FCM permission request: ${granted ? "GRANTED" : "DENIED"} '
        '(status: $authorizationStatus)',
      );

      return granted;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to request FCM permissions: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// Gets the current FCM token. Returns null if token cannot be retrieved.
  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        _logger.i('FCM token retrieved successfully');
      } else {
        _logger.w('FCM token is null');
      }
      return token;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to get FCM token: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Returns a stream of FCM token refresh events.
  /// Use this to listen for token changes and update the server accordingly.
  Stream<String?> get onTokenRefresh => _messaging.onTokenRefresh;

  /// Initializes FCM and sets up token refresh listener.
  /// Returns the initial FCM token if available.
  Future<String?> initialize() async {
    try {
      // Disable Firebase auto-init to prevent duplicate notifications
      // We handle notifications manually via local notification service
      await _messaging.setAutoInitEnabled(false);
      _logger.i('FCM auto-init disabled to prevent duplicate notifications');

      // Set up token refresh listener
      onTokenRefresh.listen((newToken) {
        _logger.i('FCM token refreshed. New token available.');
      });

      // Set up foreground message handler
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _logger.i('=== FOREGROUND MESSAGE RECEIVED ===');
        _logger.i('Message ID: ${message.messageId}');
        _logger.i('Has notification payload: ${message.notification != null}');
        _logger.i('Has data payload: ${message.data.isNotEmpty}');
        _logger.i('Data: ${message.data}');

        // Always show local notification in foreground.
        // We strictly use the data payload for the title and body as requested.
        _logger.i(
          '📱 Showing local notification from DATA payload (foreground)',
        );
        if (message.data.isNotEmpty) {
          _logger.i('   Title: ${message.data['title']}');
          _logger.i('   Body: ${message.data['body']}');
          _notificationService.showFromDataMessage(message);
          _logger.i('✅ Local notification shown successfully');
        } else {
          _logger.w('⚠️ Skipping local notification - data payload is empty');
        }
      });

      // Get initial token
      final token = await getToken();
      return token;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to initialize FCM: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Deletes the current FCM token. Useful for testing or forced token refresh.
  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      _logger.i('FCM token deleted successfully');
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to delete FCM token: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

@riverpod
FcmService fcmService(Ref ref) {
  final service = FcmService(
    ref.watch(loggerProvider),
    ref.watch(localNotificationServiceProvider),
  );
  // Auto-initialize to ensure FirebaseMessaging.onMessage is registered for foreground
  service.initialize();
  return service;
}
