import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kirara_template/core/extensions/build_context_ext.dart';
import 'package:kirara_template/core/extensions/string_ext.dart';
import 'package:kirara_template/core/extensions/widget_ext.dart';
import 'package:kirara_template/core/routing/app_router.dart';
import 'package:kirara_template/core/widgets/app_button.dart';
import 'package:kirara_template/core/widgets/app_dialog.dart';
import 'package:kirara_template/core/widgets/app_text_field.dart';

import '../../providers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;
    context.hideKeyboard();

    ref
        .read(authControllerProvider.notifier)
        .login(_usernameController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to AsyncValue state changes for navigation and snackbars
    ref.listen<AsyncValue<String?>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        data: (message) {
          if (message != null) {
            context.showSnackBar(message);
          }
          const HomeRoute().go(context);
        },
        error: (error, stackTrace) {
          context.showSnackBar(error.toString(), isError: true);
        },
      );
    });

    final isLoading = ref.watch(authControllerProvider).isLoading;
    final t = context.l10n.login;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await AppDialog.show(
          context,
          title: context.l10n.common.dialog.exitTitle,
          description: context.l10n.common.dialog.exitContent,
          onConfirm: () {},
        );

        if (shouldExit == true && context.mounted) {
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: FaIcon(
                        FontAwesomeIcons.lock,
                        size: 70,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    32.vSpace,
                    Text(
                      t.title,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    8.vSpace,
                    Text(
                      t.subtitle,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.theme.hintColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    32.vSpace,
                    AppTextField(
                      controller: _usernameController,
                      label: t.usernameLabel,
                      hintText: t.usernameHint,
                      prefixIcon: const FaIcon(FontAwesomeIcons.user, size: 18),
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val.isNullOrEmpty) return t.errorEmpty;
                        return null;
                      },
                    ),
                    16.vSpace,
                    AppTextField(
                      controller: _passwordController,
                      label: t.passwordLabel,
                      hintText: t.passwordHint,
                      prefixIcon: const FaIcon(FontAwesomeIcons.key, size: 18),
                      obscureText: true,
                      validator: (val) {
                        if (val.isNullOrEmpty) return t.errorEmpty;
                        return null;
                      },
                    ),
                    32.vSpace,
                    AppButton(
                      text: t.button,
                      onPressed: _handleLogin,
                      isLoading: isLoading,
                      isFullWidth: true,
                    ),
                  ],
                ).paddingAll(24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
