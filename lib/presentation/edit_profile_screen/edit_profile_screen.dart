import 'package:monarchium/core/utils/validation_functions.dart';
import 'package:monarchium/presentation/data_form_screen/widgets/attach_photo_field.dart';
import 'package:monarchium/presentation/data_form_screen/widgets/title_text_form_field.dart';
import 'package:monarchium/widgets/app_bar/appbar_image.dart';
import 'package:monarchium/widgets/custom_button.dart';

import 'controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class EditProfileScreen extends GetWidget<EditProfileController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: GetBuilder<EditProfileController>(
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorConstant.deepOrange50,
              appBar: CustomAppBar(
                height: getVerticalSize(100.00),
                leadingWidth: 40,
                leading: AppbarImage(
                  height: getSize(40.00),
                  width: getSize(40.00),
                  svgPath: ImageConstant.imgArrowleftGray900,
                  margin: getPadding(left: 10, bottom: 35),
                  onTap: () => Get.back(),
                ),
                centerTitle: true,
                title: Container(
                  width: getHorizontalSize(248.00),
                  child: Text(
                    "Отредактировать\nпрофиль".tr,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: AppStyle.txtPoiretOneRegular32.copyWith(
                      height: getVerticalSize(1.00),
                    ),
                  ),
                ),
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ваш портрет".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtCormorantRomanRegular20.copyWith(
                            height: getVerticalSize(1.00),
                          ),
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
                        textEditingController: controller.lastNameController,
                        titleString: "lbl13".tr,
                        hintString: "lbl14".tr,
                        validator: (val) {
                          if (!isFilled(val)) {
                            return 'Поле обязательно';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      TitleTextFormField(
                        textEditingController: controller.firstNameController,
                        titleString: "lbl15".tr,
                        hintString: "lbl16".tr,
                        validator: (val) {
                          if (!isFilled(val)) {
                            return 'Поле обязательно';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      TitleTextFormField(
                        textEditingController: controller.fathersNameController,
                        titleString: "lbl17".tr,
                        hintString: "lbl18".tr,
                        validator: (val) {
                          if (!isFilled(val)) {
                            return 'Поле обязательно';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      TitleTextFormField(
                        textEditingController: controller.birthdayController,
                        readOnly: true,
                        onTap: controller.birthdayPicker,
                        titleString: "Дата рождения".tr,
                        hintString: "Например 01.10.1977".tr,
                      ),
                      // TitleTextFormField(
                      //   textEditingController: controller.mobileNoController,
                      //   onChanged: controller.onPhoneChanged,
                      //   titleString: "lbl5".tr,
                      //   hintString: "lbl_71234567890".tr,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.digitsOnly,
                      //   ],
                      //   maxLength: 12,
                      //   keyboardType: TextInputType.phone,
                      //   // prefixText: '+',
                      //   prefix: Padding(
                      //     padding: EdgeInsets.only(
                      //       left: getHorizontalSize(8),
                      //     ),
                      //     child: Text(
                      //       '+',
                      //       style: TextStyle(
                      //         color: ColorConstant.orange200,
                      //         fontSize: getFontSize(
                      //           20,
                      //         ),
                      //         fontFamily: 'Cormorant',
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //     ),
                      //   ),
                      //   prefixConstraints:
                      //       BoxConstraints(minWidth: 0, minHeight: 0),
                      //   alignment: Alignment.center,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty)
                      //       return 'Обязательное поле';
                      //     if (!controller.isValidBy && !controller.isValidRu) {
                      //       return 'Введён неверный формат номера телефона';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      TitleTextFormField(
                        textEditingController: controller.emailController,
                        validator: (value) {
                          if (value == null ||
                              (!isValidEmail(value, isRequired: true))) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        titleString: "lbl_email".tr,
                        hintString: "msg_example_gmail_com".tr,
                      ),
                      TitleTextFormField(
                        textEditingController: controller.weburlController,
                        titleString: "msg15".tr,
                        hintString: "msg_https".tr,
                        keyboardType: TextInputType.url,
                        validator: (val) {
                          if (!isFilled(val)) {
                            return 'Поле обязательно';
                          }

                          if (!val!.isURL) {
                            return 'Необходима ссылка на соц.сеть';
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                        width: 345,
                        text: "Написать нам на почту".tr,
                        margin: getMargin(
                          left: 15,
                          top: 20,
                          right: 15,
                        ),
                        onTap: controller.writeEmail,
                        variant: ButtonVariant.OutlineGray900,
                        fontStyle:
                            ButtonFontStyle.CormorantRomanMedium24Gray900,
                      ),
                      CustomButton(
                        width: 345,
                        text: "Сохранить".tr,
                        margin: getMargin(
                          left: 15,
                          top: 20,
                          right: 15,
                        ),
                        onTap: () => controller.saveProfile(),
                      ),
                      SizedBox(
                        height: getVerticalSize(20),
                      ),
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

  onTapImgArrowleft() {
    Get.back();
  }
}
