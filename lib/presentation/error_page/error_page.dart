import 'package:monarchium/core/app_export.dart';

import 'package:flutter/material.dart';
import 'package:monarchium/presentation/error_page/controller/error_page_controller.dart';
import 'package:monarchium/widgets/custom_button.dart';

class ErrorPage extends GetWidget<ErrorPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.deepOrange50,
        // appBar: CustomAppBar(
        //   height: getVerticalSize(62.00),
        //   // centerTitle: true,
        //   // title: Container(
        //   //   decoration: AppDecoration.fillDeeporange50,
        //   //   child: Row(
        //   //     mainAxisAlignment: MainAxisAlignment.start,
        //   //     crossAxisAlignment: CrossAxisAlignment.center,
        //   //     mainAxisSize: MainAxisSize.max,
        //   //     children: [
        //   //       AppbarImage(
        //   //         height: getSize(25.00),
        //   //         width: getSize(25.00),
        //   //         svgPath: ImageConstant.imgArrowleftGray900,
        //   //         margin: getMargin(left: 15, top: 18, bottom: 19),
        //   //         onTap: () {
        //   //           Get.back();
        //   //         },
        //   //       ),
        //   //       AppbarTitle(
        //   //         text: "lbl46".tr,
        //   //         margin: getMargin(
        //   //           left: 36,
        //   //           top: 10,
        //   //           right: 74,
        //   //           bottom: 13,
        //   //         ),
        //   //       )
        //   //     ],
        //   //   ),
        //   // ),
        //   // styleType: Style.bgFillDeeporange50,
        // ),
        body: Container(
          width: size.width,
          padding: getPadding(all: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: getPadding(top: 251),
                  child: Text("oops".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoiretOneRegular32)),
              Padding(
                padding: getPadding(top: 8),
                child: Text(
                  "msg_something_went_wrong".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtCormorantRomanRegular20,
                ),
              ),
              CustomButton(
                onTap: () => Get.back(id: controller.id),
                height: 50,
                width: 345,
                text: "try_again".tr,
                margin: getMargin(top: 19, bottom: 5),
              )
            ],
          ),
        ),
      ),
    );
  }

  onTapImgArrowleft() {
    Get.back();
  }
}
