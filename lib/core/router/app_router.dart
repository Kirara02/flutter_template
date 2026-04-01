import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/widgets/shell/app_shell.dart';
import '../../features/home/presentation/screens/home/home_screen.dart';
import '../../features/settings/presentation/screens/more/more_screen.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/settings/presentation/screens/about/about_screen.dart';
import '../../features/settings/presentation/screens/settings/settings_screen.dart';

part 'app_router.g.dart';
part 'sub_routes/auth_routes.dart';
part 'sub_routes/shell_routes.dart';
part 'sub_routes/home_routes.dart';
part 'sub_routes/more_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final shellNavigatorProfileKey = GlobalKey<NavigatorState>(
  debugLabel: 'profile',
);

abstract class Routes {
  static const root = '/';
  static const login = 'login';
  static const home = 'home';
  static const more = 'more';
  static const about = 'about';
  static const settings = 'settings';
}

@riverpod
GoRouter routerConfig(Ref ref) {
  final authNotifier = ValueNotifier(ref.read(authProvider));

  ref.listen(authProvider, (_, next) {
    authNotifier.value = next;
  });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: const RootRoute().location,
    refreshListenable: authNotifier,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    redirect: (context, state) {
      final authState = ref.read(authProvider);

      if (authState.isLoading) {
        if (state.matchedLocation != const RootRoute().location) {
          return const RootRoute().location;
        }
        return null;
      }

      final isAuthenticated = authState.value != null;
      final isGoingToLogin =
          state.matchedLocation == const LoginRoute().location;
      final isAtRoot = state.matchedLocation == const RootRoute().location;

      if (!isAuthenticated && !isGoingToLogin) {
        return const LoginRoute().location;
      }

      if (isAuthenticated && (isGoingToLogin || isAtRoot)) {
        return const HomeRoute().location;
      }

      return null;
    },
  );
}

@TypedGoRoute<RootRoute>(
  path: Routes.root,
  routes: [
    TypedGoRoute<LoginRoute>(path: Routes.login),
    TypedStatefulShellRoute<ShellRouteData>(
      branches: [
        TypedStatefulShellBranch<HomeBranch>(
          routes: [TypedGoRoute<HomeRoute>(path: Routes.home)],
        ),
        TypedStatefulShellBranch<MoreBranch>(
          routes: [
            TypedGoRoute<MoreRoute>(
              path: Routes.more,
              routes: [
                TypedGoRoute<AboutRoute>(path: Routes.about),
                TypedGoRoute<SettingsRoute>(path: Routes.settings),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
class RootRoute extends GoRouteData with $RootRoute {
  const RootRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
