import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Top-level function for handling background FCM messages.
///
/// This MUST be a top-level function (not a method or closure) to work
/// with Flutter's background message handling.
@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessageHandler(RemoteMessage message) async {
  if (message.data.isEmpty) {
    log('⚠️ Skipping local notification - data payload is empty');
    return;
  }

  // Initialize local notifications
  final plugin = FlutterLocalNotificationsPlugin();

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  await plugin.initialize(
    settings: const InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    ),
  );

  // Create notification channel for Android
  const channel = AndroidNotificationChannel(
    'fcm_default_channel',
    'Notifications',
    description: 'Default notification channel for FCM messages',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );

  await plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  // Extract exactly from data payload!
  final data = message.data;
  final title = data['title'] ?? 'Notification';
  final body = data['body'] ?? 'You have a new message';

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

  const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

  final int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

  await plugin.show(
    id: id,
    title: title,
    body: body,
    notificationDetails: details,
    payload: jsonEncode(data),
  );

  log('✅ Local notification shown successfully from data payload (background)');
}
