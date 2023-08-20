import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'controller/join_association_controller.dart';

class JoinAssociationScreen extends GetWidget<JoinassociationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.deepOrange50,
        appBar: CustomAppBar(
            height: getVerticalSize(99.00),
            leadingWidth: 40,
            leading: AppbarImage(
              height: getSize(25.00),
              width: getSize(25.00),
              svgPath: ImageConstant.imgArrowleftGray900,
              margin: getMargin(left: 15, top: 18, bottom: 56),
              onTap: onTapArrowleft2,
            ),
            centerTitle: true,
            title: AppbarTitle(text: "msg37".tr),
            styleType: Style.bgFillDeeporange50),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              width: 345,
              text: "lbl42".tr,
              margin: getMargin(
                left: 15,
                top: 145,
                right: 15,
              ),
              hasAddButton: true,
              onTap: () {
                Get.toNamed(
                  AppRoutes.createAssociationScreen,
                  arguments: ['Семейно-родовое'],
                );
              },
              // onAddButtonPressed: () {
              //   Get.toNamed(AppRoutes.searchScreen);
              // },
            ),
            CustomButton(
              width: 345,
              text: "lbl43".tr,
              margin: getMargin(
                left: 15,
                top: 20,
                right: 15,
              ),
              hasAddButton: true,
              onTap: () {
                Get.toNamed(
                  AppRoutes.createAssociationScreen,
                  arguments: ['Корпоративное'],
                );
              },
              // onAddButtonPressed: () {
              //   Get.toNamed(AppRoutes.createAssociationScreen);
              // },
            ),
            CustomButton(
              width: 345,
              text: "lbl44".tr,
              margin: getMargin(
                left: 15,
                top: 20,
                right: 15,
              ),
              hasAddButton: true,
              onTap: () {
                Get.toNamed(
                  AppRoutes.createAssociationScreen,
                  arguments: ['Земельное'],
                );
              },
              // onAddButtonPressed: () {
              //   Get.toNamed(AppRoutes.createAssociationScreen);
              // },
            ),
            CustomButton(
              width: 345,
              text: "lbl58".tr,
              margin: getMargin(
                left: 15,
                top: 20,
                right: 15,
              ),
              hasAddButton: true,
              onTap: () {
                Get.toNamed(
                  AppRoutes.createAssociationScreen,
                  arguments: ['Товарищеское'],
                );
              },
              // onAddButtonPressed: () {
              //   Get.toNamed(AppRoutes.createAssociationScreen);
              // },
            ),
            // Container(
            //   margin: getMargin(left: 15, top: 133, right: 15),
            //   decoration: AppDecoration.fillLime800
            //       .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Padding(
            //           padding: getPadding(top: 12, bottom: 7),
            //           child: Text("lbl42".tr,
            //               overflow: TextOverflow.ellipsis,
            //               textAlign: TextAlign.left,
            //               style: AppStyle.txtCormorantRomanMedium24)),
            //       Padding(
            //         padding: getPadding(left: 25, top: 13, bottom: 12),
            //         child: CommonImageView(
            //           svgPath: ImageConstant.imgPlus25x25,
            //           height: getSize(25.00),
            //           width: getSize(25.00),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: getMargin(left: 15, top: 20, right: 15),
            //   decoration: AppDecoration.fillLime800
            //       .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Padding(
            //         padding: getPadding(top: 12, bottom: 7),
            //         child: Text(
            //           "lbl43".tr,
            //           overflow: TextOverflow.ellipsis,
            //           textAlign: TextAlign.left,
            //           style: AppStyle.txtCormorantRomanMedium24,
            //         ),
            //       ),
            //       Padding(
            //         padding: getPadding(left: 35, top: 13, bottom: 12),
            //         child: CommonImageView(
            //           svgPath: ImageConstant.imgPlus25x25,
            //           height: getSize(25.00),
            //           width: getSize(25.00),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: getMargin(left: 15, top: 20, right: 15),
            //   decoration: AppDecoration.fillLime800
            //       .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Padding(
            //           padding: getPadding(top: 9, bottom: 10),
            //           child: Text("lbl44".tr,
            //               overflow: TextOverflow.ellipsis,
            //               textAlign: TextAlign.left,
            //               style: AppStyle.txtCormorantRomanMedium24)),
            //       Padding(
            //         padding:
            //             getPadding(left: 61, top: 13, right: 35, bottom: 12),
            //         child: CommonImageView(
            //           svgPath: ImageConstant.imgPlus25x25,
            //           height: getSize(25.00),
            //           width: getSize(25.00),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  onTapArrowleft2() {
    Get.back(id: 1);
  }
}
