import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../../core/extensions/string_ext.dart';
import '../../../../../core/extensions/widget_ext.dart';
import '../../../../../core/design_system/design_system.dart';
import '../../../../../shared/widgets/app_button.dart';
import '../../../../../shared/widgets/app_text_field.dart';

import '../../providers/change_password_controller.dart';
import '../../providers/auth_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    if (!_formKey.currentState!.validate()) return;
    context.hideKeyboard();

    final user = ref.read(authProvider).value;
    final hasPassword = user?.hasPassword ?? true;

    ref
        .read(changePasswordControllerProvider.notifier)
        .changePassword(
          oldPassword: hasPassword ? _oldPasswordController.text : null,
          newPassword: _newPasswordController.text,
          confirmPassword: _confirmPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String?>>(changePasswordControllerProvider, (
      _,
      state,
    ) {
      state.whenOrNull(
        data: (message) {
          context.showSnackBar(
            message ?? context.l10n.auth.changePasswordSuccess,
          );
          context.pop();
        },
        error: (error, _) {
          context.showSnackBar(error.toString(), isError: true);
        },
      );
    });

    final user = ref.watch(authProvider).value;
    final hasPassword = user?.hasPassword ?? true;
    final isLoading = ref.watch(changePasswordControllerProvider).isLoading;
    final tAuth = context.l10n.auth;
    final tSettings = context.l10n.settings;

    return Scaffold(
      appBar: AppBar(
        title: Text(hasPassword ? tSettings.changePassword : 'Set Password'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hasPassword)
                AppTextField(
                  controller: _oldPasswordController,
                  label: tAuth.oldPasswordLabel,
                  hintText: tAuth.oldPasswordHint,
                  prefixIcon: const FaIcon(FontAwesomeIcons.lock, size: 18),
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isNullOrEmpty) return context.l10n.login.errorEmpty;
                    return null;
                  },
                ),
              if (hasPassword) AppSpacing.md.vSpace,

              AppTextField(
                controller: _newPasswordController,
                label: tAuth.newPasswordLabel,
                hintText: tAuth.newPasswordHint,
                prefixIcon: const FaIcon(FontAwesomeIcons.key, size: 18),
                obscureText: true,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val.isNullOrEmpty) return context.l10n.login.errorEmpty;
                  if (val!.length < 6) return 'Password too short';
                  return null;
                },
              ),
              AppSpacing.md.vSpace,
              AppTextField(
                controller: _confirmPasswordController,
                label: tAuth.confirmPasswordLabel,
                hintText: tAuth.confirmPasswordHint,
                prefixIcon: const FaIcon(FontAwesomeIcons.check, size: 18),
                obscureText: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleChangePassword(),
                validator: (val) {
                  if (val.isNullOrEmpty) return context.l10n.login.errorEmpty;
                  if (val != _newPasswordController.text) {
                    return tAuth.passwordsDoNotMatch;
                  }
                  return null;
                },
              ),
              AppSpacing.xl.vSpace,
              AppButton(
                text: tAuth.changePasswordButton,
                onPressed: _handleChangePassword,
                isLoading: isLoading,
                isFullWidth: true,
              ),
            ],
          ).padAll(AppSpacing.lg),
        ),
      ),
    );
  }
}
