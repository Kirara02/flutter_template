import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/design_system/design_system.dart';
import '../../core/extensions/context_ext.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.itemAsString,
    this.label,
    this.hintText,
    this.showSearchBox = false,
    this.validator,
    this.enabled = true,
  });

  final List<T> items;
  final T? selectedItem;
  final void Function(T?)? onChanged;
  final String Function(T)? itemAsString;
  final String? label;
  final String? hintText;
  final bool showSearchBox;
  final String? Function(T?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      items: (filter, loadProps) => items, // DropdownSearch 6.x signature
      selectedItem: selectedItem,
      itemAsString: itemAsString,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: context.radius.borderMd),
          enabledBorder: OutlineInputBorder(
            borderRadius: context.radius.borderMd,
            borderSide: BorderSide(color: context.theme.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: context.radius.borderMd,
            borderSide: BorderSide(
              color: context.theme.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: showSearchBox,
        fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: context.l10n.common.search,
            border: OutlineInputBorder(borderRadius: context.radius.borderMd),
            enabledBorder: OutlineInputBorder(
              borderRadius: context.radius.borderMd,
              borderSide: BorderSide(color: context.theme.dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: context.radius.borderMd,
              borderSide: BorderSide(
                color: context.theme.colorScheme.primary,
                width: 2,
              ),
            ),
            prefixIcon: const SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
