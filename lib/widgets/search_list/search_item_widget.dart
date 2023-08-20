import '../../backend/schema/models/search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';

// ignore: must_be_immutable
class SearchItemWidget extends StatelessWidget {
  SearchItemWidget({
    required this.model,
    required this.onIconPressed,
    this.onPressed,
    required this.iconBool,
    this.hideIcon,
  });

  final SearchItemModel model;
  final void Function() onIconPressed;
  final void Function()? onPressed;
  final bool iconBool;
  final bool? hideIcon;

  // var controller = Get.find<FriendSearchController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: getPadding(
            top: 5.0,
            bottom: 5.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              CommonImageView(
                imagePath: ImageConstant.imgImage26,
                url: model.imgUrl,
                height: getHorizontalSize(
                  52.00,
                ),
                width: getHorizontalSize(
                  52.00,
                ),
                borderRadius: BorderRadius.circular(
                  getHorizontalSize(50),
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 1,
                  top: 15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: getHorizontalSize(
                        267.00,
                      ),
                      margin: getMargin(
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
                              bottom: 1,
                            ),
                            child: Text(
                              model.name ?? "Евгений Онегин",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: (model.isPremium ?? false)
                                  ? AppStyle.txtCormorantRomanRegular20Yellow900
                                  : AppStyle.txtCormorantRomanRegular20Black900,
                            ),
                          ),
                          if ((model.isPremium ?? false))
                            Padding(
                              padding: getPadding(
                                top: 3,
                                bottom: 3,
                              ),
                              child: CommonImageView(
                                svgPath: ImageConstant.imgTelevision,
                                height: getSize(
                                  19.00,
                                ),
                                width: getSize(
                                  19.00,
                                ),
                              ),
                            ),

                          if (!(hideIcon ?? false))
                            IconButton(
                              onPressed: onIconPressed,
                              splashRadius: 15,
                              icon: SizedBox(
                                child: Center(
                                  child: Icon(
                                    (iconBool
                                        ? Icons.remove_sharp
                                        : Icons.add_sharp),
                                    color: ColorConstant.lime900,
                                  ),
                                ),
                                height: getSize(
                                  30.00,
                                ),
                                width: getSize(
                                  30.00,
                                ),
                              ),
                              iconSize: getSize(30),
                            ),
                          // if (!(friendSearchItemModelObj.isFriend ?? false))
                          //   Padding(
                          //     padding: getPadding(
                          //       top: 1,
                          //     ),
                          //     child: CommonImageView(
                          //       svgPath: ImageConstant.imgPlus,
                          //       height: getSize(
                          //         25.00,
                          //       ),
                          //       width: getSize(
                          //         25.00,
                          //       ),
                          //     ),
                          //   ),
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
                          top: 15,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.lime900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
