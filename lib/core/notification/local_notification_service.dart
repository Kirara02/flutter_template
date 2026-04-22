import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../logger/logger_provider.dart';

part 'local_notification_service.g.dart';

/// Service for managing local notifications from FCM data messages.
///
/// Extracts `title` and `body` from the FCM data payload (not from the
/// notification payload) to ensure consistency with backend conventions.
class LocalNotificationService {
  LocalNotificationService(this._logger);

  final dynamic _logger;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Whether the notification service has been initialized.
  bool get isInitialized => _isInitialized;

  /// Initializes the local notification service.
  ///
  /// Must be called before showing any notifications.
  /// Sets up Android and iOS notification settings.
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Android initialization settings
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher', // Use app launcher icon
      );

      // iOS initialization settings
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        requestCriticalPermission: false,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _plugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      // Create notification channel for Android
      await _createNotificationChannel();

      _isInitialized = true;
      _logger.i('Local notification service initialized successfully');
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to initialize local notification service: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Creates the default notification channel for Android.
  Future<void> _createNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      'fcm_default_channel',
      'Notifications',
      description: 'Default notification channel for FCM messages',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  /// Handles notification tap events.
  void _onNotificationTapped(NotificationResponse response) {
    _logger.i('Notification tapped: ${response.payload}');
    // TODO: Implement navigation based on payload
  }

  /// Shows a notification from FCM data message.
  ///
  /// Extracts `title` and `body` from the [data] payload of the FCM message.
  /// Falls back to default values if title/body are not present.
  Future<void> showFromDataMessage(RemoteMessage message) async {
    if (!_isInitialized) {
      _logger.w('Notification service not initialized, skipping notification');
      return;
    }

    final data = message.data;

    // Extract title and body from data payload (as per backend convention)
    String title = data['title'] ?? 'Notification';
    String body = data['body'] ?? 'You have a new message';

    _logger.i(
      'Showing notification from data payload - '
      'Title: "$title", Body: "$body"',
    );

    await show(title: title, body: body, payload: jsonEncode(data));
  }

  /// Shows a local notification with the given [title] and [body].
  ///
  /// The [payload] can be used to pass additional data when the
  /// notification is tapped.
  Future<void> show({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) {
      _logger.w('Notification service not initialized, skipping notification');
      return;
    }

    try {
      final int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

      const androidDetails = AndroidNotificationDetails(
        'fcm_default_channel',
        'Notifications',
        channelDescription: 'Default notification channel for FCM messages',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _plugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: details,
        payload: payload,
      );

      _logger.i('Notification shown: $title');
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to show notification: $e',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Cancels a notification by its ID.
  Future<void> cancel(int id) async {
    await _plugin.cancel(id: id);
  }

  /// Cancels all notifications.
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}

@riverpod
LocalNotificationService localNotificationService(Ref ref) {
  final service = LocalNotificationService(ref.watch(loggerProvider));
  // Auto-initialize when provider is accessed
  service.initialize();
  return service;
}
