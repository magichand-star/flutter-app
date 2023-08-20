import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/widgets/custom_text_form_field.dart';
import 'package:searchfield/searchfield.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({
    Key? key,
    required this.textEditingController,
    required this.titleString,
    required this.hintString,
    this.validator,
    this.onTap,
    this.readOnly,
    this.isSearchField,
    this.isDropdownSearch,
    this.onSuggestionTap,
    this.onDropdownChanged,
    this.dropdownValidator,
    this.suggestions,
    this.dropdownItems,
    this.dropdownSelectedItems,
    this.onChanged,
    this.dropdownKey,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.prefix,
    this.prefixConstraints,
    this.alignment,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String titleString;
  final String hintString;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final bool? isSearchField;
  final bool? isDropdownSearch;
  final List<SearchFieldListItem<Object?>>? suggestions;
  final List<String>? dropdownItems;
  final dynamic Function(SearchFieldListItem<Object?>)? onSuggestionTap;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(List<dynamic>)? onDropdownChanged;
  final String? Function(List<dynamic>?)? dropdownValidator;
  final List? dropdownSelectedItems;
  final GlobalKey<DropdownSearchState>? dropdownKey;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: getMargin(
        left: 15,
        top: 9,
        right: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            12.00,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: getPadding(
              right: 10,
            ),
            child: Text(
              titleString,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtCormorantRomanRegular20,
            ),
          ),
          CustomTextFormField(
            keyboardType: keyboardType,
            dropdownKey: dropdownKey,
            readOnly: readOnly,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            onTap: onTap,
            width: 345,
            // focusNode: FocusNode(),
            controller: textEditingController,
            hintText: hintString,
            validator: validator,
            dropdownItems: dropdownItems,
            margin: getMargin(
              top: 4,
            ),
            alignment: alignment,
            prefix: prefix,
            prefixConstraints: prefixConstraints,
            onDropdownChanged: onDropdownChanged,
            dropdownValidator: dropdownValidator,
            dropdownSelectedItems: dropdownSelectedItems,
            isSearchField: isSearchField ?? false,
            isDropdownSearch: isDropdownSearch ?? false,
            suggestions: suggestions,
            onSuggestionTap: onSuggestionTap,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
