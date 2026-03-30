part of '../app_router.dart';

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorHomeKey;
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}
