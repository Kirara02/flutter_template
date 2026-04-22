import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/notification/firebase_background_handler.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'shared/i18n/strings.g.dart';
import 'shared/providers/shared_preferences_provider.dart';

/// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await firebaseBackgroundMessageHandler(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set default locale before app starts
  LocaleSettings.useDeviceLocale();

  // Initialize Firebase with generated options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    // Riverpod initialization
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      // Slang translation initialization
      child: TranslationProvider(child: const MyApp()),
    ),
  );
}
