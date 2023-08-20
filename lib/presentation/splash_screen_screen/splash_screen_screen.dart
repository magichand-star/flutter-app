import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreenScreen extends GetWidget<SplashscreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 1),
              end: Alignment(1, 0),
              colors: [
                ColorConstant.orange50,
                ColorConstant.orange51,
                ColorConstant.lightGreen100
              ],
            ),
          ),
          child: Center(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            // children: [
            child: CommonImageView(
              imagePath: 'assets/images/splash.png',
              height: getVerticalSize(200.00),
              width: getHorizontalSize(200.00),
            ),
            // Padding(
            //   padding: getPadding(left: 61, top: 14, right: 61, bottom: 5),
            //   child: Text(
            //     "lbl".tr,
            //     overflow: TextOverflow.ellipsis,
            //     textAlign: TextAlign.left,
            //     style: AppStyle.txtPoiretOneRegular48,
            //   ),
            // ),
            // ],
          ),
        ),
      ),
    );
  }
}
