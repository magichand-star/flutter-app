import 'controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/widgets/custom_button.dart';

class OnboardingScreen extends GetWidget<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.deepOrange50,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: controller.goToLogin,
                child: Container(
                  margin: getMargin(left: 15, top: 19, right: 15),
                  width: getHorizontalSize(49.00),
                  child: Text(
                    "lbl2".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstant.lime900,
                      fontSize: getFontSize(20),
                      fontFamily: 'Poiret One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: getHorizontalSize(
                  263.00,
                ),
                margin: getMargin(
                  left: 15,
                  top: 17,
                  right: 15,
                ),
                child: Text(
                  "msg".tr,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtCormorantRomanMedium32,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: getPadding(
                  left: 15,
                  top: 27,
                  right: 15,
                ),
                child: CommonImageView(
                  imagePath: ImageConstant.imgIntersect,
                  height: getSize(
                    177.00,
                  ),
                  width: getSize(
                    177.00,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: getHorizontalSize(
                  184.00,
                ),
                margin: getMargin(
                  left: 15,
                  top: 18,
                  right: 15,
                ),
                child: Text(
                  "msg2".tr,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtPoiretOneRegular20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: getHorizontalSize(
                  179.00,
                ),
                margin: getMargin(
                  left: 15,
                  top: 14,
                  right: 15,
                ),
                child: Text(
                  "msg3".tr,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtPoiretOneRegular20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: getHorizontalSize(
                  196.00,
                ),
                margin: getMargin(
                  left: 15,
                  top: 14,
                  right: 15,
                ),
                child: Text(
                  "msg4".tr,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtPoiretOneRegular20,
                ),
              ),
            ),
            CustomButton(
              width: 345,
              text: "lbl3".tr,
              margin: getMargin(
                left: 15,
                top: 45,
                right: 15,
                bottom: 5,
              ),
              alignment: Alignment.center,
              onTap: controller.goToRegister,
            ),
          ],
        ),
      ),
    );
  }
}
