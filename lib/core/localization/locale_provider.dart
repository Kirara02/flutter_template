import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/shared_preferences_provider.dart';
import 'strings.g.dart';

part 'locale_provider.g.dart';

@Riverpod(keepAlive: true, name: 'localeProvider')
class LocaleNotifier extends _$LocaleNotifier {
  static const _key = 'app_locale';

  @override
  AppLocale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedLocale = prefs.getString(_key);

    if (savedLocale != null) {
      final locale = AppLocale.values.firstWhere(
        (e) => e.languageTag == savedLocale,
        orElse: () => _getDeviceLocale(),
      );
      // Synchronize slang with state
      LocaleSettings.setLocale(locale);
      return locale;
    }

    final deviceLocale = _getDeviceLocale();
    LocaleSettings.setLocale(deviceLocale);
    return deviceLocale;
  }

  AppLocale _getDeviceLocale() {
    return LocaleSettings.useDeviceLocaleSync();
  }

  Future<void> setLocale(AppLocale locale) async {
    state = locale;
    LocaleSettings.setLocale(locale);

    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, locale.languageTag);
  }
}
