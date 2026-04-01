import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/design_system/design_system.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../../core/extensions/widget_ext.dart';
import '../../../../../shared/widgets/app_button.dart';
import '../../../../../shared/widgets/app_dialog.dart';
import '../../../../auth/presentation/providers/auth_controller.dart';
import '../../../../../core/router/app_router.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<String?>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        data: (message) {
          if (message != null) {
            context.showSnackBar(message);
          }
        },
        error: (error, stackTrace) {
          context.showSnackBar(error.toString(), isError: true);
        },
      );
    });

    final isLogoutLoading = ref.watch(authControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.more.title)),
      body: ListView(
        children: [
          ListTile(
            title: Text(context.l10n.more.settings),
            subtitle: Text(context.l10n.more.settingsSubtitle),
            leading: const FaIcon(FontAwesomeIcons.gear, size: 20),
            onTap: () => const SettingsRoute().go(context),
          ),
          ListTile(
            title: Text(context.l10n.more.about),
            subtitle: Text(context.l10n.more.aboutSubtitle),
            leading: const FaIcon(FontAwesomeIcons.circleInfo, size: 20),
            onTap: () => const AboutRoute().go(context),
          ),
          const Divider(),
          AppButton(
            type: AppButtonType.outlined,
            text: context.l10n.common.logout,
            isFullWidth: true,
            isLoading: isLogoutLoading,
            onPressed: () {
              AppDialog.show(
                context,
                title: context.l10n.common.dialog.logoutTitle,
                description: context.l10n.common.dialog.logoutContent,
                confirmText: context.l10n.common.logout,
                isDanger: true,
                onConfirm: () {
                  ref.read(authControllerProvider.notifier).logout();
                },
              );
            },
          ).padAll(AppSpacing.md),
        ],
      ),
    );
  }
}
