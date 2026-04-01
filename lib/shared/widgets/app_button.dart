import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/design_system/design_system.dart';

enum AppButtonType { primary, secondary, outlined, text, error }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  /// The text to display on the button.
  final String text;

  /// The callback when the button is pressed. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// The style type of the button.
  final AppButtonType type;

  /// Optional icon to display before the text.
  final FaIconData? icon;

  /// If true, shows a loading indicator instead of the text/icon.
  final bool isLoading;

  /// If true, stretches the button to fill the cross axis.
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onPressed == null || isLoading;

    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2.0),
          )
        : Row(
            mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                FaIcon(icon, size: 18),
                AppSpacing.sm.hSpace,
              ],
              Text(
                text,
                style: context.appTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );

    Widget button;

    switch (type) {
      case AppButtonType.primary:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.borderMd,
            ),
          ),
          child: child,
        );
        break;
      case AppButtonType.secondary:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondaryContainer,
            foregroundColor: theme.colorScheme.onSecondaryContainer,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.borderMd,
            ),
          ),
          child: child,
        );
        break;
      case AppButtonType.error:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.error,
            foregroundColor: context.colorScheme.onError,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.borderMd,
            ),
          ),
          child: child,
        );
        break;
      case AppButtonType.outlined:
        button = OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.borderMd,
            ),
          ),
          child: child,
        );
        break;
      case AppButtonType.text:
        button = TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.borderMd,
            ),
          ),
          child: child,
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
