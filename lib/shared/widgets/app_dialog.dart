import 'package:flutter/material.dart';
import '../../core/design_system/design_system.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.description,
    this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.isDanger = false,
  });

  final String title;
  final String description;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDanger;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String description,
    String? confirmText,
    String? cancelText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    bool isDanger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        description: description,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDanger: isDanger,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: context.radius.borderLg),
      title: Text(title, style: context.appTypography.titleLarge),
      content: Text(
        description,
        style: context.appTypography.bodyMedium.copyWith(
          color: context.appColors.textMuted,
        ),
      ),
      actions: [
        AppButton(
          text: cancelText ?? 'Cancel',
          type: AppButtonType.text,
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop(false);
          },
        ),
        AppButton(
          text: confirmText ?? 'Confirm',
          type: isDanger ? AppButtonType.error : AppButtonType.primary,
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
