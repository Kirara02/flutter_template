import 'package:flutter/material.dart';
import '../../shared/i18n/strings.g.dart';

/// Extension methods for BuildContext to reduce boilerplate
extension BuildContextExt on BuildContext {
  // Theme & Colors
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // Localization (Slang)
  Translations get l10n => Translations.of(this);

  // Responsiveness & Media Query
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  bool get isPhone => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  // Utilities
  void hideKeyboard() => FocusScope.of(this).unfocus();

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
