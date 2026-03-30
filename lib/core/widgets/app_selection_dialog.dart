import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_button.dart';

class AppSelectionOption<T> {
  final T value;
  final String label;
  final FaIconData? icon;

  const AppSelectionOption({
    required this.value,
    required this.label,
    this.icon,
  });
}

class AppSelectionDialog<T> extends StatefulWidget {
  const AppSelectionDialog({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    this.confirmText,
    this.cancelText,
  });

  final String title;
  final List<AppSelectionOption<T>> options;
  final T selectedValue;
  final String? confirmText;
  final String? cancelText;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<AppSelectionOption<T>> options,
    required T selectedValue,
    String? confirmText,
    String? cancelText,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AppSelectionDialog<T>(
        title: title,
        options: options,
        selectedValue: selectedValue,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
  }

  @override
  State<AppSelectionDialog<T>> createState() => _AppSelectionDialogState<T>();
}

class _AppSelectionDialogState<T> extends State<AppSelectionDialog<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      content: SingleChildScrollView(
        child: RadioGroup<T>(
          groupValue: _currentValue,
          onChanged: (val) {
            if (val != null) {
              setState(() => _currentValue = val);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.options.map((option) {
              return ListTile(
                title: Text(option.label),
                leading: option.icon != null ? FaIcon(option.icon) : null,
                trailing: Radio<T>(value: option.value),
                onTap: () {
                  setState(() => _currentValue = option.value);
                },
              );
            }).toList(),
          ),
        ),
      ),
      actions: [
        AppButton(
          text: widget.cancelText ?? 'Cancel',
          type: AppButtonType.text,
          onPressed: () => Navigator.of(context).pop(),
        ),
        AppButton(
          text: widget.confirmText ?? 'Confirm',
          type: AppButtonType.primary,
          onPressed: () => Navigator.of(context).pop(_currentValue),
        ),
      ],
    );
  }
}
