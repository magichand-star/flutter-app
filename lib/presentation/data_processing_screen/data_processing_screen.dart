import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import 'controller/data_processing_controller.dart';

class DataProcessingScreen extends GetWidget<DataProcessingController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataProcessingController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.deepOrange50,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: getPadding(
                    left: 15,
                    top: 185,
                    right: 15,
                  ),
                  child: CommonImageView(
                    imagePath: ImageConstant.imgEasterncrownheraldry,
                    height: getVerticalSize(
                      93.00,
                    ),
                    width: getHorizontalSize(
                      164.00,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 15,
                    top: 15,
                    right: 15,
                  ),
                  child: Text(
                    controller.displayName ?? "Добро пожаловать!",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtCormorantRomanMedium28,
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: getHorizontalSize(345),
                    height: size.height * .06,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          LinearProgressIndicator(
                            color: ColorConstant.orange200,
                            value: controller.percentage,
                            backgroundColor: ColorConstant.lightGreen100,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${(controller.percentage * 100).toInt()}%",
                              style: AppStyle.txtCormorantRomanRegular20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // CustomButton(
                //   width: 345,
                //   text: "lbl_95".tr,
                //   margin: getMargin(
                //     left: 15,
                //     top: 14,
                //     right: 15,
                //   ),
                //   variant: ButtonVariant.FillOrange200,
                //   padding: ButtonPadding.PaddingAll12,
                //   fontStyle: ButtonFontStyle.PoiretOneRegular16,
                // ),
                Padding(
                  padding: getPadding(
                    left: 15,
                    top: 15,
                    right: 15,
                  ),
                  child: Text(
                    "msg24".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtCormorantRomanRegular20,
                  ),
                ),
                Container(
                  width: getHorizontalSize(
                    244.00,
                  ),
                  margin: getMargin(
                    left: 15,
                    top: 43,
                    right: 15,
                    bottom: 5,
                  ),
                  child: Text(
                    "msg25".tr,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: AppStyle.txtPoiretOneRegular28,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
