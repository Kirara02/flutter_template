import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/design_system/design_system.dart';
import '../../../../../../core/extensions/context_ext.dart';
import '../../../../../../core/extensions/widget_ext.dart';
import '../../../../../../core/theme/theme_provider.dart';

class AppThemeSelector extends ConsumerStatefulWidget {
  const AppThemeSelector({super.key});

  @override
  ConsumerState<AppThemeSelector> createState() => _AppThemeSelectorState();
}

class _AppThemeSelectorState extends ConsumerState<AppThemeSelector> {
  late final ScrollController _scrollController;
  late final List<FlexScheme> _flexSchemaList;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _flexSchemaList = FlexColor.schemes.keys.toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedTheme(animate: false);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedTheme({bool animate = true}) {
    if (!_scrollController.hasClients) return;

    final selectedAppTheme = ref.read(flexSchemeProvider);
    final selectedIndex = _flexSchemaList.indexOf(selectedAppTheme);

    if (selectedIndex != -1) {
      final offset = selectedIndex * (32.0 + 8.0); // width + horizontal padding
      if (animate) {
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(offset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedAppTheme = ref.watch(flexSchemeProvider);

    ref.listen(flexSchemeProvider, (previous, next) {
      if (previous != next) {
        _scrollToSelectedTheme();
      }
    });

    return SizedBox(
      height: 200,
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        notificationPredicate: (notification) =>
            notification.metrics.axis == Axis.horizontal,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          itemCount: _flexSchemaList.length,
          itemBuilder: (context, index) {
            final scheme = _flexSchemaList[index];
            final flexSchemeColor = FlexColor.schemes[scheme];
            if (flexSchemeColor == null) return const SizedBox.shrink();

            final isDesktop = MediaQuery.sizeOf(context).width > 800;
            final buttonWidth = isDesktop ? 52.0 : 44.0;
            final buttonHeight = isDesktop ? 80.0 : 72.0;

            return Tooltip(
              message: scheme.name.toUpperCase(),
              child: FlexThemeModeOptionButton(
                height: buttonHeight,
                width: buttonWidth,
                optionButtonBorderRadius: 12,
                flexSchemeColor: context.isDarkMode
                    ? flexSchemeColor.dark
                    : flexSchemeColor.light,
                borderRadius: 10,
                selected: selectedAppTheme == scheme,
                onSelect: () =>
                    ref.read(flexSchemeProvider.notifier).setScheme(scheme),
              ),
            ).padSymmetric(horizontal: AppSpacing.xs);
          },
        ),
      ),
    ).padSymmetric(vertical: AppSpacing.md);
  }
}
