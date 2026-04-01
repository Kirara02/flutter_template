import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared/i18n/strings.g.dart';
import 'shared/i18n/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

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
