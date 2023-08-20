import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';

import '../core/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.prefixText,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.onChanged,
      this.inputFormatters,
      this.keyboardType,
      this.validator,
      this.maxLength,
      this.readOnly,
      this.isSearchField = false,
      this.isDropdownSearch = false,
      this.suggestions,
      this.dropdownItems,
      this.dropdownSelectedItems,
      this.onDropdownChanged,
      this.onSuggestionTap,
      this.dropdownValidator,
      this.onTap,
      this.dropdownKey,
      super.key});

  final TextFormFieldShape? shape;

  final TextFormFieldPadding? padding;

  final TextFormFieldVariant? variant;

  final TextFormFieldFontStyle? fontStyle;

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? isObscureText;

  final TextInputAction? textInputAction;

  final int? maxLines;

  final String? hintText;

  final Widget? prefix;

  final String? prefixText;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final FormFieldValidator<String>? validator;

  final void Function(String)? onChanged;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  final int? maxLength;

  final bool? readOnly;

  final bool isSearchField;
  final bool isDropdownSearch;

  final List<SearchFieldListItem<Object?>>? suggestions;
  final List<String>? dropdownItems;
  final List? dropdownSelectedItems;
  final void Function(List<dynamic>)? onDropdownChanged;
  final String? Function(List<dynamic>?)? dropdownValidator;
  final dynamic Function(SearchFieldListItem<Object?>)? onSuggestionTap;
  final GlobalKey<DropdownSearchState>? dropdownKey;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    late Widget formField;

    if (isSearchField) {
      formField = _buildSearchFieldWidget();
    } else if (isDropdownSearch) {
      formField = _buildDropdownSearch();
    } else {
      formField = _buildTextFormFieldWidget();
    }

    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: formField,
          )
        : formField;
  }

  _buildDropdownSearch() {
    return Container(
      width: getHorizontalSize(width ?? 0),
      margin: margin,
      child: DropdownSearch.multiSelection(
        items: dropdownItems ?? [],
        key: dropdownKey,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: _setFontStyle(isHint: false),
          dropdownSearchDecoration: _buildDecoration(),
        ),
        dropdownButtonProps: DropdownButtonProps(
          icon: Container(
            child: CommonImageView(
              svgPath: ImageConstant.imgIconInputarrow,
            ),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          if (selectedItems.isEmpty)
            return Text(
              hintText ?? '',
              style: _setFontStyle(isHint: true),
            );
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: getHorizontalSize(10),
            children: selectedItems.map((e) {
              return Chip(
                backgroundColor: ColorConstant.orange200,
                label: Text(
                  e.toString(),
                  style: _setFontStyle(isHint: false).copyWith(
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          );
        },
        onBeforeChange: (prevItems, nextItems) async {
          // debugger();
          if (maxLength != null) {
            if (prevItems.length == maxLength ||
                nextItems.length > maxLength!) {
              Get.snackbar(
                'Ошибка',
                'В данной категории возможно выбрать только $maxLength элемента',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: ColorConstant.lime800,
                colorText: Colors.white,
              );
              return false;
            } else {
              return true;
            }
          }
          return null;
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          emptyBuilder: (context, searchEntry) => Center(
            child: Text(
              "Упс, что-то пошло не так...",
              style: _setFontStyle(isHint: false).copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          searchFieldProps: TextFieldProps(
            decoration: _buildDecoration(),
            style: _setFontStyle(isHint: false),
          ),
          selectionWidget: (context, item, isSelected) {
            return Checkbox(
              side: BorderSide(color: ColorConstant.gray600),
              value: isSelected,
              onChanged: (val) =>
                  dropdownKey!.currentState!.changeSelectedItem(item),
              activeColor: ColorConstant.lime800,
            );
          },
          validationWidgetBuilder: (ctx, selectedItems) {
            return Container(
              color: ColorConstant.lime800,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.lime800,
                ),
                child: Text(
                  'Выбрать',
                  style: _setFontStyle(
                    isHint: false,
                  ).copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  dropdownKey!.currentState?.popupOnValidate();
                },
              ),
            );
          },
          itemBuilder: (context, item, isSelected) {
            return Container(
              // color: Colors.white,
              child: ListTile(
                title: Text(
                  item.toString(),
                  style: _setFontStyle(isHint: false).copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
          dialogProps: DialogProps(
            backgroundColor: ColorConstant.deepOrange50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        selectedItems: dropdownSelectedItems ?? [],
        onChanged: onDropdownChanged,
        validator: dropdownValidator,
      ),
    );
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: getHorizontalSize(width ?? 0),
      margin: margin,
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly ?? false,
        inputFormatters: inputFormatters,
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        focusNode: focusNode,
        style: _setFontStyle(isHint: false),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildSearchFieldWidget() {
    return Container(
      width: getHorizontalSize(width ?? 0),
      margin: margin,
      child: SearchField(
        suggestions: suggestions ?? [],
        onSuggestionTap: onSuggestionTap,
        // hasOverlay: false,
        suggestionStyle: _setFontStyle(
          isHint: false,
        ),
        // suggestionAction: SuggestionAction.next,
        emptyWidget: Container(),
        offset: Offset(10, 10),
        itemHeight: getVerticalSize(50),
        suggestionState: Suggestion.hidden,
        suggestionsDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        suggestionItemDecoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
        ),
        hint: hintText,
        searchInputDecoration: _buildDecoration(),
        inputFormatters: inputFormatters,
        controller: controller,
        focusNode: focusNode,
        searchStyle: _setFontStyle(isHint: false),
        textInputAction: textInputAction,
        inputType: keyboardType,
        validator: validator,
        maxSuggestionsInViewPort: 3,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(isHint: true),
      border: _setBorderStyle(),
      counterText: '',
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixText: prefixText,
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle({required bool isHint}) {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: isHint ? ColorConstant.orange200 : ColorConstant.orangeSolid,
          fontSize: getFontSize(
            20,
          ),
          fontFamily: 'Cormorant',
          fontWeight: FontWeight.w400,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            12.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      default:
        return getPadding(
          all: 10,
        );
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder12,
}

enum TextFormFieldPadding {
  PaddingAll10,
}

enum TextFormFieldVariant {
  None,
  FillWhiteA700,
}

enum TextFormFieldFontStyle {
  CormorantRomanRegular20,
}
