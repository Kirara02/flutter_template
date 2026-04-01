import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kirara_template/core/extensions/build_context_ext.dart';

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
          border: const OutlineInputBorder(),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: showSearchBox,
        fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: context.l10n.common.search,
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
