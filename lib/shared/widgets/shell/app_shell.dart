import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_ext.dart';
import '../app_dialog.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  static const _rootPaths = {'/home', '/more'};

  @override
  Widget build(BuildContext context) {
    final isPhone = context.isPhone;
    final isDesktop = context.isDesktop;

    // uri.path gives the actual live path including sub-routes
    final currentPath = GoRouterState.of(context).uri.path;
    final showNavigation = _rootPaths.contains(currentPath);

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
        body: Row(
          children: [
            if (!isPhone && showNavigation) ...[
              _buildNavigationRail(context, isDesktop),
              const VerticalDivider(thickness: 1, width: 1),
            ],
            Expanded(
              key: const ValueKey('navigation_shell_wrapper'),
              child: navigationShell,
            ),
          ],
        ),
        bottomNavigationBar: (isPhone && showNavigation)
            ? _buildBottomNavigationBar(context)
            : null,
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _onTap,
      destinations: [
        NavigationDestination(
          icon: const FaIcon(FontAwesomeIcons.house),
          selectedIcon: const FaIcon(FontAwesomeIcons.house),
          label: context.l10n.home.title,
        ),
        NavigationDestination(
          icon: const FaIcon(FontAwesomeIcons.ellipsis),
          selectedIcon: const FaIcon(FontAwesomeIcons.ellipsis),
          label: context.l10n.more.title,
        ),
      ],
    );
  }

  Widget _buildNavigationRail(BuildContext context, bool isDesktop) {
    final Widget leadingIcon;
    if (isDesktop) {
      leadingIcon = TextButton.icon(
        onPressed: () {},
        icon: const FlutterLogo(size: 40),
        label: Text(
          context.l10n.common.appTitle,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: context.textTheme.bodyLarge?.color,
        ),
      );
    } else {
      leadingIcon = IconButton(
        onPressed: () {},
        icon: const FlutterLogo(size: 32),
      );
    }

    return NavigationRail(
      useIndicator: true,
      elevation: 5,
      extended: isDesktop,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _onTap,
      leading: leadingIcon,
      labelType: isDesktop
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      destinations: [
        NavigationRailDestination(
          icon: const FaIcon(FontAwesomeIcons.house),
          selectedIcon: const FaIcon(FontAwesomeIcons.house),
          label: Text(context.l10n.home.title),
        ),
        NavigationRailDestination(
          icon: const FaIcon(FontAwesomeIcons.ellipsis),
          selectedIcon: const FaIcon(FontAwesomeIcons.ellipsis),
          label: Text(context.l10n.more.title),
        ),
      ],
    );
  }
}
