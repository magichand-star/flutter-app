import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'controller/association_profile_controller.dart';

class AssociationProfileScreen extends GetWidget<AssociationProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssociationProfileController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.deepOrange50,
            appBar: CustomAppBar(
              height: getVerticalSize(62.00),
              centerTitle: true,
              title: Container(
                decoration: AppDecoration.fillDeeporange50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppbarImage(
                        height: getSize(25.00),
                        width: getSize(25.00),
                        svgPath: ImageConstant.imgArrowleftGray900,
                        margin: getMargin(left: 15, top: 18, bottom: 19),
                        onTap: onTapArrowleft4),
                    AppbarTitle(
                      text: "lbl49".tr,
                      margin: getMargin(
                        left: 63,
                        top: 11,
                        right: 102,
                        bottom: 12,
                      ),
                    ),
                  ],
                ),
              ),
              styleType: Style.bgFillDeeporange50,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(left: 15, top: 10, right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(getHorizontalSize(25.00)),
                          bottomRight:
                              Radius.circular(getHorizontalSize(26.00))),
                      child: CommonImageView(
                        imagePath: ImageConstant.imgIntersect,
                        height: getSize(171.00),
                        width: getSize(171.00),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(left: 15, top: 12, right: 15),
                    child: Text(
                      controller.association?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtCormorantRomanMedium28,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(left: 15, right: 15),
                    child: Text(
                      "Княжество: ${controller.association?.place ?? ""}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtCormorantRomanRegular20Lime900,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(top: 9),
                    child: CommonImageView(
                      url: controller.association?.logo,
                      imagePath: ImageConstant.imgImage34,
                      height: getVerticalSize(139.00),
                      width: getHorizontalSize(139.00),
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(left: 15, top: 1, right: 15),
                    child: Text(
                      "lbl51".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtCormorantRomanMedium28,
                    ),
                  ),
                ),
                CustomButton(
                  width: 345,
                  text: "msg44".tr,
                  margin: getMargin(left: 15, top: 32, right: 15),
                  variant: ButtonVariant.OutlineGray900,
                  fontStyle: ButtonFontStyle.CormorantRomanMedium24Gray900,
                  alignment: Alignment.center,
                  onTap: controller.onShowMembers,
                ),
                CustomButton(
                    width: 345,
                    text: "msg30".tr,
                    margin: getMargin(left: 15, top: 20, right: 15),
                    alignment: Alignment.center),
              ],
            ),
          ),
        );
      },
    );
  }

  onTapArrowleft4() {
    Get.back();
  }
}
