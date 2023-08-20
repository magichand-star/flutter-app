import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/general_armses_controller.dart';

class GeneralArmsesScreen extends GetWidget<GeneralarmsesController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.deepOrange50,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              width: 375,
              text: "lbl32".tr,
              variant: ButtonVariant.FillDeeporange50,
              shape: ButtonShape.Square,
              fontStyle: ButtonFontStyle.PoiretOneRegular32,
              alignment: Alignment.centerLeft,
            ),
            CustomSearchView(
              width: 345,
              focusNode: FocusNode(),
              controller: controller.inputiconleftController,
              hintText: "lbl33".tr,
              margin: getMargin(
                left: 15,
                top: 10,
                right: 15,
              ),
              prefix: Container(
                margin: getMargin(
                  left: 20,
                  top: 12,
                  right: 10,
                  bottom: 13,
                ),
                child: CommonImageView(
                  svgPath: ImageConstant.imgSearchOrange200,
                ),
              ),
              prefixConstraints: BoxConstraints(
                minWidth: getSize(
                  25.00,
                ),
                minHeight: getSize(
                  25.00,
                ),
              ),
              readOnly: true,
              onTap: controller.goToFriendsSearch,
            ),
            CustomButton(
              width: 345,
              text: "lbl34".tr,
              margin: getMargin(
                left: 15,
                top: 145,
                right: 15,
              ),
              hasAddButton: true,
              onTap: () {
                Get.toNamed(AppRoutes.friendsScreen, id: 1);
              },
              onAddButtonPressed: () {
                Get.toNamed(AppRoutes.searchScreen, id: 1);
              },
            ),
            CustomButton(
              width: 345,
              text: "msg31".tr,
              margin: getMargin(
                left: 15,
                top: 20,
                right: 15,
              ),
              hasAddButton: true,
              onTap: () {
                Get.toNamed(AppRoutes.associationsScreen, id: 1);
              },
              onAddButtonPressed: () {
                Get.toNamed(AppRoutes.joinAssociationScreen, id: 1);
              },
            ),
            CustomButton(
              width: 345,
              text: "msg32".tr,
              margin: getMargin(
                left: 15,
                top: 20,
                right: 15,
              ),
              variant: ButtonVariant.OutlineGray900,
              fontStyle: ButtonFontStyle.CormorantRomanMedium24Gray900,
              onTap: controller.generateLink,
            ),
          ],
        ),
      ),
    );
  }
}
