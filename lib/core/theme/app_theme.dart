import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/design_system.dart';

class AppTheme {
  static ThemeData light(FlexScheme scheme) {
    return FlexThemeData.light(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      textTheme: GoogleFonts.interTextTheme(),
      extensions: [
        AppColorsTheme.light,
        AppSpacingTheme.defaults,
        AppRadiusTheme.defaults,
        AppShadowsTheme.defaults,
        AppDurationsTheme.defaults,
        AppTypographyTheme.defaults,
      ],
    );
  }

  static ThemeData dark(FlexScheme scheme, bool isTrueBlack) {
    return FlexThemeData.dark(
      scheme: scheme,
      darkIsTrueBlack: isTrueBlack,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme,
      ),
      extensions: [
        AppColorsTheme.dark,
        AppSpacingTheme.defaults,
        AppRadiusTheme.defaults,
        AppShadowsTheme.defaults,
        AppDurationsTheme.defaults,
        AppTypographyTheme.defaults,
      ],
    );
  }
}
