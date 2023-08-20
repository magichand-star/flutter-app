import 'dart:io';

import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';

class AttachPhotoField extends StatelessWidget {
  const AttachPhotoField({
    Key? key,
    this.photoUrl,
    this.photoFile,
    this.onTap,
  }) : super(key: key);

  final String? photoUrl;
  final File? photoFile;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: getMargin(
          left: 15,
          top: 8,
          right: 15,
        ),
        color: ColorConstant.yellow50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Container(
          height: getSize(
            123.00,
          ),
          width: getSize(
            123.00,
          ),
          decoration: AppDecoration.fillYellow50.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: photoUrl != null || photoFile != null
              ? CommonImageView(
                  url: photoUrl,
                  file: photoFile,
                  fit: BoxFit.cover,
                )
              : Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(
                          all: 39,
                        ),
                        child: CommonImageView(
                          svgPath: ImageConstant.imgPlus,
                          height: getSize(
                            44.00,
                          ),
                          width: getSize(
                            44.00,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
