import '../controller/associations_controller.dart';
import '../models/associations_item_model.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';

// ignore: must_be_immutable
class AssociationsItemWidget extends StatelessWidget {
  AssociationsItemWidget(this.associationsItemModelObj);

  AssociationsItemModel associationsItemModelObj;

  var controller = Get.find<AssociationsController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: getVerticalSize(
          57.00,
        ),
        width: getHorizontalSize(
          345.00,
        ),
        margin: getMargin(
          top: 5.0,
          bottom: 5.0,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(
                  right: 10,
                ),
                child: CommonImageView(
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(50),
                  ),
                  imagePath: ImageConstant.imgImage34,
                  fit: BoxFit.cover,
                  height: getHorizontalSize(
                    54.00,
                  ),
                  width: getHorizontalSize(
                    54.00,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: getHorizontalSize(
                  292.00,
                ),
                margin: getMargin(
                  left: 10,
                  top: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getPadding(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: getPadding(
                              top: 1,
                            ),
                            child: Text(
                              "lbl50".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtCormorantRomanRegular20,
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              bottom: 1,
                            ),
                            child: CommonImageView(
                              svgPath: ImageConstant.imgPlus,
                              height: getSize(
                                25.00,
                              ),
                              width: getSize(
                                25.00,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: getVerticalSize(
                          1.00,
                        ),
                        width: getHorizontalSize(
                          292.00,
                        ),
                        margin: getMargin(
                          top: 14,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.lime900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
