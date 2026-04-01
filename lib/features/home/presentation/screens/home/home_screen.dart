import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../../core/extensions/widget_ext.dart';
import '../../../../../core/extensions/date_time_ext.dart';
import '../../../../../core/base/result.dart';
import '../../../../../shared/widgets/app_button.dart';
import '../../../../../core/base/use_case.dart';
import '../../../../auth/domain/usecases/get_profile_usecase.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isRefreshing = false;

  Future<void> _refreshUser() async {
    setState(() => _isRefreshing = true);

    final getProfile = ref.read(getProfileUseCaseProvider);
    final result = await getProfile(NoParams());

    if (!mounted) return;

    switch (result) {
      case Success(data: final user):
        ref.read(authProvider.notifier).setUser(user);
        context.showSnackBar('Profile refreshed');
      case Failure(:final error):
        context.showSnackBar(error.toString(), isError: true);
    }

    setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home.title),
        actions: [
          IconButton(
            tooltip: 'Refresh Profile',
            onPressed: _isRefreshing ? null : _refreshUser,
            icon: _isRefreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const FaIcon(FontAwesomeIcons.arrowsRotate, size: 18),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(FontAwesomeIcons.circleUser, size: 64),
          16.vSpace,
          Text(
            context.l10n.home.greeting(name: user?.name ?? 'User'),
            style: context.textTheme.headlineMedium,
          ),
          8.vSpace,
          if (user != null) ...[
            Text(
              '@${user.username}',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.theme.hintColor,
              ),
            ),
            4.vSpace,
            Chip(label: Text(user.role)),
          ],
          16.vSpace,
          Text(
            'Today is ${DateTime.now().format('EEEE, d MMMM yyyy')}',
            style: context.textTheme.bodyLarge,
          ),
          32.vSpace,
          AppButton(
            text: 'Refresh Profile',
            icon: FontAwesomeIcons.arrowsRotate,
            type: AppButtonType.outlined,
            isLoading: _isRefreshing,
            onPressed: _refreshUser,
          ),
        ],
      ).padAll(24).center,
    );
  }
}
