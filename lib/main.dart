import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/strings.g.dart';
import 'core/localization/locale_provider.dart';
import 'core/routing/app_router.dart';
import 'core/providers/shared_preferences_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set default locale before app starts
  LocaleSettings.useDeviceLocale();

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isTrueBlack = ref.watch(isTrueBlackProvider);
    final flexScheme = ref.watch(flexSchemeProvider);

    // Watch Router from Riverpod
    final appRouter = ref.watch(routerConfigProvider);

    // Watch Locale from Riverpod
    final currentLocale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: t.common.appTitle,

      // Theme Configuration
      theme: AppTheme.light(flexScheme),
      darkTheme: AppTheme.dark(flexScheme, isTrueBlack),
      themeMode: themeMode,

      // Routing Configuration
      routerConfig: appRouter,

      // Localization Configuration
      locale: currentLocale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,

      debugShowCheckedModeBanner: false,
    );
  }
}
