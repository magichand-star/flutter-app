import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/emblem/emblem_widget.dart';
import '../home_screen/controller/home_screen_controller.dart';
import 'controller/emblem_generation_controller.dart';

class EmblemGenerationScreen extends GetWidget<EmblemGenerationController> {
  @override
  Widget build(BuildContext context) {
    double emblemWidth = getHorizontalSize(250),
        emblemHeight = getVerticalSize(260);

    return GetBuilder<EmblemGenerationController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.deepOrange50,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: getPadding(
                    left: 15,
                    top: 82,
                    right: 15,
                  ),
                  child: Text(
                    "lbl27".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoiretOneRegular28,
                  ),
                ),
                Padding(
                  padding: getPadding(left: 10, right: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Герб ${controller.displayName}".tr,
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtCormorantRomanMedium28,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 15,
                    top: 17,
                    right: 15,
                  ),
                  child: EmblemWidget(
                    emblems: controller.emblems ?? [],
                    height: emblemHeight,
                    width: emblemWidth,
                    // emblemType: EmblemType.single,
                    emblemType: controller.emblemType ?? EmblemType.four,
                  ),
                ),
                CustomButton(
                  width: 345,
                  text: "msg27".tr,
                  onTap: () {
                    HomeScreenController homeScreenController =
                        Get.put(HomeScreenController());
                    homeScreenController.changePage(2);
                  },
                  margin: getMargin(
                    left: 15,
                    top: 30,
                    right: 15,
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
