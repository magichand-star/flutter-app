import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.prefixWidget,
    this.suffixWidget,
    this.text,
    this.hasAddButton = false,
    this.onAddButtonPressed,
  });

  final ButtonShape? shape;

  final ButtonPadding? padding;

  final ButtonVariant? variant;

  final ButtonFontStyle? fontStyle;

  final Alignment? alignment;

  final VoidCallback? onTap;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? margin;

  final Widget? prefixWidget;

  final Widget? suffixWidget;

  final String? text;

  final bool hasAddButton;
  final void Function()? onAddButtonPressed;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    double iconSize = getHorizontalSize(25);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height == null ? null : getVerticalSize(height!),
        width: getHorizontalSize(width ?? 0),
        margin: margin,
        padding: _setPadding(),
        decoration: _buildDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasAddButton) ...[
              Spacer(),
              SizedBox(
                width: iconSize,
              ),
            ],
            prefixWidget ?? SizedBox(),
            Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: _setFontStyle(),
            ),
            suffixWidget ?? SizedBox(),
            if (hasAddButton) ...[
              Spacer(),
              IconButton(
                style: onAddButtonPressed == null
                    ? null
                    : IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                onPressed: onAddButtonPressed,
                icon: Icon(
                  Icons.add,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll12:
        return getPadding(
          all: 12,
        );
      default:
        return getPadding(
          all: 9,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillWhiteA700:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillOrange200:
        return ColorConstant.orange200;
      case ButtonVariant.FillDeeporange50:
        return ColorConstant.deepOrange50;
      case ButtonVariant.OutlineGray900:
        return null;
      default:
        return ColorConstant.lime800;
    }
  }

  _setBorder() {
    switch (variant) {
      case ButtonVariant.OutlineGray900:
        return Border.all(
          color: ColorConstant.brown80,
          width: getHorizontalSize(
            2.00,
          ),
        );
      case ButtonVariant.FillLime800:
      case ButtonVariant.FillWhiteA700:
      case ButtonVariant.FillOrange200:
      case ButtonVariant.FillDeeporange50:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            12.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.CormorantRomanRegular20:
        return TextStyle(
          color: ColorConstant.orange200,
          fontSize: getFontSize(
            20,
          ),
          fontFamily: 'Cormorant',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.PoiretOneRegular16:
        return TextStyle(
          color: ColorConstant.brown80,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poiret One',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.PoiretOneRegular32:
        return TextStyle(
          color: ColorConstant.brown80,
          fontSize: getFontSize(
            32,
          ),
          fontFamily: 'Poiret One',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.CormorantRomanMedium24Gray900:
        return TextStyle(
          color: ColorConstant.brown80,
          fontSize: getFontSize(
            24,
          ),
          fontFamily: 'Cormorant',
          fontWeight: FontWeight.w500,
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            24,
          ),
          fontFamily: 'Cormorant',
          fontWeight: FontWeight.w500,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder12,
}

enum ButtonPadding {
  PaddingAll9,
  PaddingAll12,
}

enum ButtonVariant {
  FillLime800,
  FillWhiteA700,
  FillOrange200,
  FillDeeporange50,
  OutlineGray900,
}

enum ButtonFontStyle {
  CormorantRomanMedium24,
  CormorantRomanRegular20,
  PoiretOneRegular16,
  PoiretOneRegular32,
  CormorantRomanMedium24Gray900,
}
