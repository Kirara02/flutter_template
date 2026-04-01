import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/design_system/design_system.dart';
import '../../core/extensions/widget_ext.dart';

import '../../core/extensions/context_ext.dart';
import 'app_button.dart';

class AppError extends StatelessWidget {
  const AppError({
    super.key,
    required this.message,
    this.onRetry,
    this.isCentered = true,
  });

  /// The error message to display
  final String message;

  /// Callback to retry the operation that failed. If null, the retry button is hidden.
  final VoidCallback? onRetry;

  /// Whether to center the widget within its parent
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.circleExclamation,
          color: theme.colorScheme.error,
          size: 48,
        ),
        AppSpacing.md.vSpace,
        Text(
          message,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          AppSpacing.lg.vSpace,
          AppButton(
            text: context.l10n.common.retry,
            onPressed: onRetry,
            type: AppButtonType.outlined,
            icon: FontAwesomeIcons.rotate,
          ),
        ],
      ],
    );

    return isCentered ? content.center : content;
  }
}
