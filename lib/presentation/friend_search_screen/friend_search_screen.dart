import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import '../../backend/schema/models/search_item_model.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_search_view.dart';
import '../../widgets/search_list/search_item_widget.dart';
import 'controller/friend_search_controller.dart';

class FriendSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FriendSearchController>(
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                      onTap: onTapArrowleft,
                    ),
                    AppbarTitle(
                      text: "lbl35".tr,
                      margin: getMargin(
                        left: 106,
                        top: 10,
                        right: 145,
                        bottom: 13,
                      ),
                    )
                  ],
                ),
              ),
              styleType: Style.bgFillDeeporange50,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomSearchView(
                        width: 345,
                        focusNode: controller.searchFocusNode,
                        controller: controller.searchController,
                        // hintText: "lbl36".tr,
                        margin: getMargin(left: 15, top: 10, right: 15),
                        alignment: Alignment.center,
                        prefix: Container(
                          margin: getMargin(
                              left: 20, top: 12, right: 10, bottom: 13),
                          child: CommonImageView(
                            svgPath: ImageConstant.imgSearchOrange200,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          minWidth: getSize(25.00),
                          minHeight: getSize(25.00),
                        ),
                        onChanged: (_) => EasyDebounce.debounce(
                          'searchController',
                          Duration(milliseconds: 500),
                          () async {
                            await controller.search();
                          },
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
                                iconBool: controller.fromAssociation
                                    ? controller.associationUsersList
                                        .contains(model)
                                    : model.isIn,
                                onIconPressed: () =>
                                    controller.onButtonPressed(index),
                              );
                            },
                          ),
                        ),
                      ),
                      if (controller.associationUsersList.isNotEmpty)
                        SizedBox(
                          height: getVerticalSize(100),
                        ),
                    ],
                  ),
                ),
                if (controller.associationUsersList.isNotEmpty)
                  Positioned(
                    bottom: getVerticalSize(30),
                    left: getHorizontalSize(15),
                    child: CustomButton(
                      width: 345,
                      text: "Подтвердить".tr,
                      margin: getMargin(top: 20),
                      alignment: Alignment.center,
                      onTap: controller.onAssociationButtonTapped,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  onTapArrowleft() {
    Get.back(id: 1);
  }
}
