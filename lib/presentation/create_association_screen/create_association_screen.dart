import 'package:monarchium/core/utils/validation_functions.dart';
import 'package:monarchium/presentation/data_form_screen/widgets/attach_photo_field.dart';
import 'package:monarchium/presentation/data_form_screen/widgets/title_text_form_field.dart';

import 'controller/create_association_controller.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/widgets/app_bar/appbar_image.dart';
import 'package:monarchium/widgets/app_bar/appbar_title.dart';
import 'package:monarchium/widgets/app_bar/custom_app_bar.dart';
import 'package:monarchium/widgets/custom_button.dart';

class CreateAssociationScreen extends GetWidget<CreateAssociationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<CreateAssociationController>(
        builder: (controller) {
          return Scaffold(
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
                      onTap: onTapArrowleft3,
                    ),
                    AppbarTitle(
                      text: "lbl46".tr,
                      margin: getMargin(
                        left: 36,
                        top: 10,
                        right: 74,
                        bottom: 13,
                      ),
                    )
                  ],
                ),
              ),
              styleType: Style.bgFillDeeporange50,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: context.height - getVerticalSize(120.00),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(left: 56, right: 55),
                        child: Text(
                          "msg38".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtCormorantRomanRegular20,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AttachPhotoField(
                          photoUrl: controller.photoUrlLocal,
                          photoFile: controller.photoFile,
                          onTap: () async => controller.pickImage(),
                        ),
                      ),
                      TitleTextFormField(
                          textEditingController: controller.titleController,
                          titleString: controller.titleLabel,
                          hintString: 'lbl47'.tr,
                          validator: (String? val) {
                            if (!isFilled(val)) {
                              return 'Поле обязательно';
                            }
                            return null;
                          }),
                      TitleTextFormField(
                          textEditingController: controller.locationController,
                          titleString: controller.locationLabel,
                          hintString: 'Город или населённый пункт',
                          validator: (String? val) {
                            if (!isFilled(val)) {
                              return 'Поле обязательно';
                            }
                            return null;
                          }),
                      if (controller.associationType ==
                          AssociationType.corporate)
                        TitleTextFormField(
                          textEditingController: controller.weburlController,
                          titleString: controller.weburlLabel,
                          hintString: 'lbl_example_ru'.tr,
                        ),
                      if (controller.associationType == AssociationType.friends)
                        TitleTextFormField(
                          textEditingController:
                              controller.activitiesAndHobbiesController,
                          titleString: controller.activitiesAndHobbiesLabel,
                          hintString: 'msg42'.tr,
                          dropdownSelectedItems: controller.selectedHobbies,
                          // dropdownKey: hobbiesDropdownKey,
                          dropdownValidator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Поле обязательно';
                            }
                            return null;
                          },
                          isDropdownSearch: true,
                          dropdownItems: controller.hobbies,
                        ),
                      if (controller.associationType ==
                          AssociationType.corporate)
                        TitleTextFormField(
                            textEditingController:
                                controller.activitiesAndHobbiesController,
                            titleString: controller.activitiesAndHobbiesLabel,
                            hintString: 'msg42'.tr,
                            validator: (String? val) {
                              if (!isFilled(val)) {
                                return 'Поле обязательно';
                              }
                              return null;
                            }),
                      // Spacer(),
                      CustomButton(
                        width: 345,
                        text: "msg43".tr,
                        margin: getMargin(top: 20),
                        variant: ButtonVariant.OutlineGray900,
                        fontStyle:
                            ButtonFontStyle.CormorantRomanMedium24Gray900,
                        alignment: Alignment.center,
                        onTap: controller.addMemeber,
                      ),
                      CustomButton(
                        width: 345,
                        text: "lbl25".tr,
                        margin: getMargin(top: 20),
                        alignment: Alignment.center,
                        onTap: controller.createAssociation,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  onTapArrowleft3() {
    Get.back();
  }
}
