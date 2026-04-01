import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/providers/shared_preferences_provider.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true, name: 'themeModeProvider')
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedMode = prefs.getString(_key);

    if (savedMode == null) return ThemeMode.system;

    return ThemeMode.values.firstWhere(
      (e) => e.name == savedMode,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> toggleTheme() async {
    final nextMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setMode(nextMode);
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, mode.name);
  }
}

@Riverpod(keepAlive: true)
class IsTrueBlack extends _$IsTrueBlack {
  static const _key = 'is_true_black';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? false;
  }

  Future<void> set(bool value) async {
    state = value;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key, value);
  }
}

@Riverpod(keepAlive: true)
class FlexSchemeNotifier extends _$FlexSchemeNotifier {
  static const _key = 'flex_scheme';

  @override
  FlexScheme build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedScheme = prefs.getString(_key);

    if (savedScheme == null) return FlexScheme.material;

    return FlexScheme.values.firstWhere(
      (e) => e.name == savedScheme,
      orElse: () => FlexScheme.material,
    );
  }

  Future<void> setScheme(FlexScheme scheme) async {
    state = scheme;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, scheme.name);
  }
}
