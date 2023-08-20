import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/widgets/custom_drop_down.dart';

class TitleDropDown extends StatelessWidget {
  const TitleDropDown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.titleString,
    required this.hintString,
  }) : super(key: key);

  final List<SelectionPopupModel>? items;
  final dynamic Function(SelectionPopupModel) onChanged;
  final String titleString;
  final String hintString;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: getMargin(
        left: 15,
        top: 4,
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
          CustomDropDown(
            width: 345,
            focusNode: FocusNode(),
            icon: Container(
              child: CommonImageView(
                svgPath: ImageConstant.imgIconInputarrow,
              ),
            ),
            hintText: hintString,
            margin: getMargin(
              top: 4,
            ),
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
