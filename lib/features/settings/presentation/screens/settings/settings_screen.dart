import '../../../../../core/design_system/design_system.dart';
import '../../../../../core/extensions/string_ext.dart';
import '../../../../../core/extensions/widget_ext.dart';
import '../../../../../shared/i18n/locale_provider.dart';
import '../../../../../shared/i18n/strings.g.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../../../../shared/widgets/app_selection_dialog.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../../shared/widgets/settings_group.dart';
import 'widgets/app_theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final isTrueBlack = ref.watch(isTrueBlackProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings.title)),
      body: ListView(
        children: [
          SettingsGroup(
            title: context.l10n.settings.general,
            children: [
              ListTile(
                title: Text(context.l10n.settings.language),
                subtitle: Text(
                  locale == AppLocale.id
                      ? context.l10n.settings.languageIndonesian
                      : context.l10n.settings.languageEnglish,
                ),
                leading: const FaIcon(FontAwesomeIcons.globe, size: 20),
                onTap: () async {
                  final newLocale = await AppSelectionDialog.show<AppLocale>(
                    context,
                    title: context.l10n.settings.language,
                    selectedValue: locale,
                    options: [
                      AppSelectionOption(
                        value: AppLocale.en,
                        label: context.l10n.settings.languageEnglish,
                      ),
                      AppSelectionOption(
                        value: AppLocale.id,
                        label: context.l10n.settings.languageIndonesian,
                      ),
                    ],
                  );
                  if (newLocale != null) {
                    ref.read(localeProvider.notifier).setLocale(newLocale);
                  }
                },
              ),
            ],
          ),
          SettingsGroup(
            title: context.l10n.settings.appearance,
            children: [
              ListTile(
                title: Text(context.l10n.settings.theme),
                leading: FaIcon(
                  themeMode == ThemeMode.system
                      ? FontAwesomeIcons.wandMagicSparkles
                      : themeMode == ThemeMode.dark
                      ? FontAwesomeIcons.moon
                      : FontAwesomeIcons.sun,
                  size: 20,
                ),
                subtitle: Text(themeMode.name.capitalize),
                onTap: () async {
                  final newMode = await AppSelectionDialog.show<ThemeMode>(
                    context,
                    title: context.l10n.settings.theme,
                    selectedValue: themeMode,
                    options: [
                      AppSelectionOption(
                        value: ThemeMode.system,
                        label: context.l10n.settings.themeSystem,
                        icon: FontAwesomeIcons.wandMagicSparkles,
                      ),
                      AppSelectionOption(
                        value: ThemeMode.light,
                        label: context.l10n.settings.themeLight,
                        icon: FontAwesomeIcons.sun,
                      ),
                      AppSelectionOption(
                        value: ThemeMode.dark,
                        label: context.l10n.settings.themeDark,
                        icon: FontAwesomeIcons.moon,
                      ),
                    ],
                  );
                  if (newMode != null) {
                    ref.read(themeModeProvider.notifier).setMode(newMode);
                  }
                },
              ),
              if (context.isDarkMode) ...[
                SwitchListTile(
                  title: Text(context.l10n.settings.trueBlack),
                  subtitle: Text(context.l10n.settings.trueBlackSubtitle),
                  secondary: const FaIcon(FontAwesomeIcons.moon, size: 20),
                  value: isTrueBlack,
                  onChanged: (value) {
                    ref.read(isTrueBlackProvider.notifier).set(value);
                  },
                ),
              ],
              Text(
                context.l10n.settings.themeScheme,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ).padOnly(
                left: AppSpacing.md,
                top: AppSpacing.md,
                right: AppSpacing.md,
              ),
              const AppThemeSelector(),
            ],
          ),
        ],
      ),
    );
  }
}
