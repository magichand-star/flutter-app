import 'package:easy_debounce/easy_debounce.dart';
import '../../backend/schema/models/search_item_model.dart';
import 'package:monarchium/widgets/search_list/search_item_widget.dart';

import 'controller/associations_controller.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/widgets/app_bar/appbar_image.dart';
import 'package:monarchium/widgets/app_bar/appbar_title.dart';
import 'package:monarchium/widgets/app_bar/custom_app_bar.dart';
import 'package:monarchium/widgets/custom_search_view.dart';

class AssociationsScreen extends GetWidget<AssociationsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssociationsController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.deepOrange50,
            appBar: CustomAppBar(
              height: getVerticalSize(62.00),
              centerTitle: true,
              title: Container(
                decoration: AppDecoration.fillDeeporange50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppbarImage(
                      height: getSize(25.00),
                      width: getSize(25.00),
                      svgPath: ImageConstant.imgArrowleftGray900,
                      margin: getMargin(left: 15, top: 18, bottom: 19),
                      onTap: onTapArrowleft5,
                    ),
                    AppbarTitle(
                      text: "lbl52".tr,
                      margin:
                          getMargin(left: 56, top: 10, right: 94, bottom: 13),
                    ),
                  ],
                ),
              ),
              styleType: Style.bgFillDeeporange50,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSearchView(
                  width: 345,
                  focusNode: FocusNode(),
                  controller: controller.searchController,
                  onChanged: (_) => EasyDebounce.debounce(
                    'searchController',
                    Duration(milliseconds: 500),
                    () async {
                      await controller.search();
                    },
                  ),
                  hintText: "lbl33".tr,
                  margin: getMargin(left: 15, top: 10, right: 15),
                  alignment: Alignment.center,
                  prefix: Container(
                      margin:
                          getMargin(left: 20, top: 12, right: 10, bottom: 13),
                      child: CommonImageView(
                          svgPath: ImageConstant.imgSearchOrange200)),
                  prefixConstraints: BoxConstraints(
                    minWidth: getSize(25.00),
                    minHeight: getSize(25.00),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(left: 15, top: 15, right: 15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.searchItemList.length,
                      itemBuilder: (context, index) {
                        SearchItemModel model =
                            controller.searchItemList[index];
                        return SearchItemWidget(
                          model: model,
                          iconBool: model.isIn,
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.associationProfileScreen,
                              arguments: [model.reference],
                              // id: 1,
                            );
                          },
                          // hideIcon: controller.userInAssociation(index),
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
    );
  }

  onTapArrowleft5() {
    Get.back(id: 1);
  }
}
