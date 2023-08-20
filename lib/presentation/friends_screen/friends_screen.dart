import 'package:flutter/material.dart';

import '../../backend/schema/models/search_item_model.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import '../../widgets/search_list/search_item_widget.dart';
import 'controller/friends_controller.dart';

class FriendsScreen extends GetWidget<FriendsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FriendsController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorConstant.deepOrange50,
            appBar: CustomAppBar(
              height: getVerticalSize(45.00),
              leadingWidth: 40,
              leading: AppbarImage(
                height: getSize(40.00),
                width: getSize(40.00),
                svgPath: ImageConstant.imgArrowleftGray900,
                margin: getPadding(left: 10, top: 5),
                onTap: () => Get.back(id: 1),
              ),
              centerTitle: true,
              title: AppbarTitle(
                text: "msg36".tr,
              ),
              styleType: Style.bgFillDeeporange50,
            ),
            body: SizedBox(
              height: context.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'имения ${controller.displayName}',
                      textAlign: TextAlign.center,
                      style: AppStyle.txtPoiretOneRegular32.copyWith(
                        color: ColorConstant.brown80,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getVerticalSize(20),
                  ),
                  CustomSearchView(
                    width: 345,
                    focusNode: FocusNode(),
                    controller: controller.inputiconleftController,
                    // hintText: "lbl41".tr,
                    margin: getMargin(left: 15, top: 10, right: 15),
                    alignment: Alignment.center,
                    prefix: Container(
                      margin:
                          getMargin(left: 20, top: 12, right: 10, bottom: 13),
                      child: CommonImageView(
                          svgPath: ImageConstant.imgSearchOrange200),
                    ),
                    prefixConstraints: BoxConstraints(
                      minWidth: getSize(25.00),
                      minHeight: getSize(25.00),
                    ),
                  ),
                  controller.friendsList.isEmpty
                      ? SizedBox(
                          height: context.height * 0.6,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'К сожалению тут пока никого нет...',
                              style: AppStyle.txtCormorantRomanRegular20,
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: getPadding(left: 15, top: 15, right: 15),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.friendsList.length,
                              itemBuilder: (context, index) {
                                SearchItemModel model =
                                    controller.friendsList[index];
                                return SearchItemWidget(
                                  model: model,
                                  iconBool: model.isIn,
                                  onIconPressed: () =>
                                      controller.onButtonPressed(index),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  onTapArrowleft1() {
    Get.back(id: 1);
  }
}
