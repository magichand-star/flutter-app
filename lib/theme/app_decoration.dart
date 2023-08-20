import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillDeeporange50 => BoxDecoration(
        color: ColorConstant.deepOrange50,
      );
  static BoxDecoration get fillOrange200 => BoxDecoration(
        color: ColorConstant.orange200,
      );
  static BoxDecoration get gradientOrange50Lightgreen100 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0,
            1,
          ),
          end: Alignment(
            1,
            0,
          ),
          colors: [
            ColorConstant.orange50,
            ColorConstant.orange51,
            ColorConstant.lightGreen100,
          ],
        ),
      );
  static BoxDecoration get fillYellow50 => BoxDecoration(
        color: ColorConstant.yellow50,
      );
  static BoxDecoration get fillLime800 => BoxDecoration(
        color: ColorConstant.lime800,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12.00,
    ),
  );

  static BorderRadius customBorderBR26 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        25.00,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        26.00,
      ),
    ),
  );
}
