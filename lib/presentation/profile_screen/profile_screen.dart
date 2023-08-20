import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../core/app_export.dart';
import '../../domain/auth/auth_util.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/emblem/emblem_widget.dart';
import 'controller/profile_controller.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.deepOrange50,
            appBar: CustomAppBar(
              height: getVerticalSize(
                62.00,
              ),
              leadingWidth: 100,
              leading: Row(
                children: [
                  AppbarImage(
                    height: getSize(
                      30.00,
                    ),
                    width: getSize(
                      30.00,
                    ),
                    svgPath: ImageConstant.imgEdit,
                    margin: getMargin(
                      left: 15,
                      top: 14,
                      bottom: 18,
                    ),
                    onTap: () => Get.toNamed(AppRoutes.editProfileScreen),
                  ),
                  AppbarImage(
                    height: getSize(
                      30.00,
                    ),
                    width: getSize(
                      30.00,
                    ),
                    imagePath: ImageConstant.imgBell,
                    margin: getMargin(
                      left: 15,
                      top: 14,
                      bottom: 18,
                    ),
                    onTap: () => Get.toNamed(AppRoutes.chatsScreen, id: 1),
                  ),
                ],
              ),
              centerTitle: true,
              title: AppbarTitle(
                text: "lbl28".tr,
              ),
              actions: [
                AppbarImage(
                  height: getSize(
                    30.00,
                  ),
                  width: getSize(
                    30.00,
                  ),
                  onTap: () {
                    showExitDialog(context);
                  },
                  svgPath: ImageConstant.imgContrast,
                  margin: getMargin(
                    left: 15,
                    top: 14,
                    right: 19,
                    bottom: 18,
                  ),
                ),
              ],
              styleType: Style.bgFillDeeporange50,
            ),
            body: Padding(
              padding: getPadding(
                top: 30,
              ),
              child: SizedBox(
                height: context.height - getHorizontalSize(120),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(
                          left: 15,
                          right: 15,
                        ),
                        child: WidgetsToImage(
                          controller: controller.widgetToImageController,
                          child: Container(
                            color: ColorConstant.deepOrange50,
                            child: EmblemWidget(
                              emblems: controller.generatedEmblems,
                              emblemType: controller.emblemType,
                              height: 180,
                              width: 170,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(20),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 15,
                          top: 10,
                          right: 15,
                        ),
                        child: Text(
                          controller.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtCormorantRomanMedium28,
                        ),
                      ),
                      if (currentUserDocument?.lastName != null)
                        Padding(
                          padding: getPadding(
                            left: 15,
                            top: 1,
                            right: 15,
                          ),
                          child: Text(
                            "Род: ${currentUserDocument?.lastName}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtCormorantRomanRegular20Lime900,
                          ),
                        ),
                      Padding(
                        padding: getPadding(
                          left: 15,
                          right: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonImageView(
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.circular(15),
                              imagePath: ImageConstant.imgImage26,
                              url: currentUserPhoto,
                              height: getVerticalSize(
                                100.00,
                              ),
                              width: getHorizontalSize(
                                100.00,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (controller.city != null)
                                    Padding(
                                      padding: getPadding(
                                        left: 15,
                                        top: 1,
                                      ),
                                      child: Text(
                                        "Княжество: ${controller.city!}",
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtCormorantRomanRegular20Lime900,
                                      ),
                                    ),
                                  if (controller.status != null)
                                    Padding(
                                      padding: getPadding(
                                        left: 15,
                                        top: 1,
                                        right: 15,
                                      ),
                                      child: Text(
                                        "Титул: ${controller.status ?? 'Нет'}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtCormorantRomanRegular20Yellow900,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(20),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 15,
                          top: 17,
                          right: 15,
                        ),
                        child: Text(
                          "msg29".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoiretOneRegular20Gray900,
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(20),
                      ),
                      Card(
                        clipBehavior: Clip.none,
                        elevation: 0,
                        margin: getMargin(
                          left: 15,
                          top: 2,
                          right: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusStyle.roundedBorder12,
                        ),
                        child: Container(
                          height: getVerticalSize(
                            50.00,
                          ),
                          width: getHorizontalSize(
                            345.00,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                12.00,
                              ),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration:
                                    AppDecoration.fillOrange200.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder12,
                                ),
                                child: Center(
                                  child: Text(
                                    controller.rating,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoiretOneRegular16,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: CommonImageView(
                                  imagePath:
                                      ImageConstant.imgEasterncrownheraldry,
                                  height: getVerticalSize(
                                    31.00,
                                  ),
                                  width: getHorizontalSize(
                                    54.00,
                                  ),
                                ),
                                top: getVerticalSize(
                                  -20.00,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        width: 345,
                        text: "msg30".tr,
                        margin: getMargin(
                          left: 15,
                          top: 20,
                          right: 15,
                        ),
                        onTap: controller.shareEmblem,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showExitDialog(BuildContext context) {
    Get.dialog(
      useSafeArea: false,
      AlertDialog(
        backgroundColor: ColorConstant.deepOrange50,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(
          horizontal: getHorizontalSize(10),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: getHorizontalSize(10),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
        ),
        content: Container(
          height: getVerticalSize(320),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: FractionalOffset.topRight,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close_sharp),
                ),
              ),
              Text(
                "Выйти из аккаунта?",
                textAlign: TextAlign.center,
                style: AppStyle.txtPoiretOneRegular32.copyWith(
                  color: ColorConstant.brown80,
                ),
              ),
              SizedBox(
                height: getVerticalSize(10),
              ),
              Text(
                "Мы будем по вам скучать...".tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtCormorantRomanRegular20.copyWith(
                  height: getVerticalSize(1.00),
                ),
              ),
              SizedBox(
                height: getVerticalSize(20),
              ),
              CustomButton(
                width: 345,
                height: 50,
                text: "Да",
                margin: getMargin(
                  left: 15,
                  top: 20,
                  right: 15,
                ),
                onTap: controller.signOut,
                variant: ButtonVariant.OutlineGray900,
                fontStyle: ButtonFontStyle.CormorantRomanMedium24Gray900,
              ),
              CustomButton(
                width: 345,
                height: 50,
                text: "Нет",
                margin: getMargin(
                  left: 15,
                  top: 20,
                  right: 15,
                ),
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
