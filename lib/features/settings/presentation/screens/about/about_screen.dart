import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../core/design_system/design_system.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../../core/extensions/widget_ext.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.about.title), centerTitle: true),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator().center;
          }

          final info = snapshot.data;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  64.vSpace,
                  // App Logo with Hero-like feel
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer.withValues(
                        alpha: 0.2,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        width: 2,
                      ),
                    ),
                    child: FlutterLogo(
                      size: 100,
                      style: FlutterLogoStyle.markOnly,
                      textColor: context.colorScheme.primary,
                    ),
                  ),
                  32.vSpace,
                  Text(
                    info?.appName ?? 'Example App',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.vSpace,
                  Text(
                    context.l10n.about.version(
                      version: info?.version ?? '1.0.0',
                      build: info?.buildNumber ?? '1',
                    ),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.hintColor,
                    ),
                  ),
                  48.vSpace,
                  // Modern Information Card
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: context.radius.borderLg,
                      side: BorderSide(
                        color: context.theme.dividerColor.withValues(
                          alpha: 0.1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildAboutTile(
                          context,
                          icon: FontAwesomeIcons.circleInfo,
                          title: context.l10n.about.descriptionTitle,
                          subtitle: context.l10n.about.descriptionSubtitle,
                        ),
                        const Divider(indent: 56),
                        _buildAboutTile(
                          context,
                          icon: FontAwesomeIcons.code,
                          title: context.l10n.about.developedByTitle,
                          subtitle: context.l10n.about.developedBySubtitle,
                        ),
                        const Divider(indent: 56),
                        _buildAboutTile(
                          context,
                          icon: FontAwesomeIcons.copyright,
                          title: context.l10n.about.copyrightTitle,
                          subtitle: context.l10n.about.copyrightSubtitle,
                        ),
                      ],
                    ),
                  ).padSymmetric(horizontal: AppSpacing.lg),
                  32.vSpace,
                  TextButton(
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationName: info?.appName,
                        applicationVersion: info?.version,
                        applicationIcon: const FlutterLogo(),
                        applicationLegalese: context.l10n.about.legalese,
                      );
                    },
                    child: Text(context.l10n.about.viewLicenses),
                  ),
                  64.vSpace,
                ],
              ),
            ).center,
          );
        },
      ),
    );
  }

  Widget _buildAboutTile(
    BuildContext context, {
    required FaIconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(icon, color: context.colorScheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle, style: context.textTheme.bodyMedium),
    );
  }
}
