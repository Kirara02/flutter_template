import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'shared/i18n/strings.g.dart';
import 'shared/providers/shared_preferences_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set default locale before app starts
  LocaleSettings.useDeviceLocale();

  // Load environment variables for staging
  await dotenv.load(fileName: ".env.staging");

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
