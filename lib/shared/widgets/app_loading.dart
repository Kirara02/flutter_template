import 'package:flutter/material.dart';
import '../../core/design_system/design_system.dart';
import '../../core/extensions/widget_ext.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key, this.message, this.isCentered = true});

  /// Optional text to show below the loading indicator
  final String? message;

  /// Whether to center the widget within its parent
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        if (message != null) ...[
          AppSpacing.md.vSpace,
          Text(
            message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    return isCentered ? content.center : content;
  }
}
