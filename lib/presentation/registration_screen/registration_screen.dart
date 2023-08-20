import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/registration_controller.dart';

class RegistrationScreen extends GetWidget<RegistrationController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.deepOrange50,
        body: GetBuilder<RegistrationController>(builder: (controller) {
          // if (controller.yandexUrl == null)
          if (controller.webViewController != null) {
            return WebViewWidget(
              controller: controller.webViewController!,
            );
          }
          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getVerticalSize(50),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 15,
                      top: 36,
                      right: 15,
                    ),
                    child: CommonImageView(
                      imagePath: ImageConstant.imgEasterncrownheraldry,
                      height: getVerticalSize(
                        59.00,
                      ),
                      width: getHorizontalSize(
                        104.00,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 15,
                      top: 8,
                      right: 15,
                    ),
                    child: Text(
                      "lbl4".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoiretOneRegular32,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 15,
                    top: 14,
                    right: 15,
                  ),
                  child: Text(
                    "lbl_email".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtCormorantRomanRegular20,
                  ),
                ),
                CustomTextFormField(
                  width: 345,
                  focusNode: FocusNode(),
                  controller: controller.emailOneController,
                  hintText: "msg_example_gmail_com".tr,
                  margin: getMargin(
                    left: 15,
                    top: 5,
                    right: 15,
                  ),
                  alignment: Alignment.center,
                  validator: (value) {
                    if (value == null ||
                        (!isValidEmail(value, isRequired: true))) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                ),
                // Padding(
                //   padding: getPadding(
                //     left: 15,
                //     top: 6,
                //     right: 15,
                //   ),
                //   child: Text(
                //     "lbl5".tr,
                //     overflow: TextOverflow.ellipsis,
                //     textAlign: TextAlign.left,
                //     style: AppStyle.txtCormorantRomanRegular20,
                //   ),
                // ),
                // CustomTextFormField(
                //   onChanged: controller.onPhoneChanged,
                //   maxLength: 12,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //   ],
                //   keyboardType: TextInputType.phone,
                //   width: 345,
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
                //   prefixConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                //   alignment: Alignment.center,
                //   focusNode: FocusNode(),
                //   controller: controller.mobileNoController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty)
                //       return 'Обязательное поле';
                //     if (!controller.isValidBy && !controller.isValidRu) {
                //       return 'Введён неверный формат номера телефона';
                //     }
                //     return null;
                //   },
                //   hintText: "lbl_71234567890".tr,
                //   margin: getMargin(
                //     left: 15,
                //     top: 3,
                //     right: 15,
                //   ),
                // ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    margin: getMargin(
                      left: 15,
                      top: 7,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(
                            right: 10,
                          ),
                          child: Text(
                            "lbl6".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtCormorantRomanRegular20,
                          ),
                        ),
                        CustomTextFormField(
                          width: 345,
                          focusNode: FocusNode(),
                          controller: controller.passwordController,
                          hintText: "lbl7".tr,
                          margin: getMargin(
                            top: 2,
                          ),
                          validator: (value) {
                            if (value == null ||
                                (!isValidPassword(value, isRequired: true))) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                          isObscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    margin: getMargin(
                      left: 15,
                      top: 7,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(
                            right: 10,
                          ),
                          child: Text(
                            "msg5".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtCormorantRomanRegular20,
                          ),
                        ),
                        CustomTextFormField(
                          width: 345,
                          focusNode: FocusNode(),
                          controller: controller.passwordOneController,
                          hintText: "lbl7".tr,
                          margin: getMargin(
                            top: 2,
                          ),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null ||
                                value !=
                                    controller.passwordController.value.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          isObscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await controller.regularSignUp();
                    }
                  },
                  width: 345,
                  text: "msg6".tr,
                  margin: getMargin(
                    left: 15,
                    top: 20,
                    right: 15,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 15,
                      top: 12,
                      right: 15,
                    ),
                    child: Text(
                      "msg7".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtCormorantRomanRegular20,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: controller.googleSignIn,
                        child: CommonImageView(
                          svgPath: ImageConstant.imgGoogle,
                        ),
                      ),
                      SizedBox(
                        width: getHorizontalSize(15),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: controller.vkSignIn,
                        child: CommonImageView(
                          svgPath: ImageConstant.imgVk,
                        ),
                      ),
                      SizedBox(
                        width: getHorizontalSize(15),
                      ),
                      InkWell(
                        onTap: controller.yandexSignIn,
                        borderRadius: BorderRadius.circular(40),
                        child: CommonImageView(
                          svgPath: ImageConstant.imgYandex,
                        ),
                      ),
                      SizedBox(
                        width: getHorizontalSize(15),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: InkWell(
                          onTap: controller.okSignIn,
                          borderRadius: BorderRadius.circular(40),
                          child: CommonImageView(
                            svgPath: ImageConstant.imgOk,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: getMargin(
                      left: 15,
                      top: 22,
                      right: 15,
                      bottom: 5,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "msg9".tr,
                            style: TextStyle(
                              color: ColorConstant.brown80,
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Cormorant',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "lbl8".tr,
                            style: TextStyle(
                              color: ColorConstant.brown80,
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Cormorant',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: "lbl2".tr,
                            style: TextStyle(
                              color: ColorConstant.lime900,
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Cormorant',
                              fontWeight: FontWeight.w400,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.offNamed(
                                    AppRoutes.authorizationScreen,
                                  ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          );
          // else
          //   return WebViewWidget(
          //     controller: controller.webViewController!,
          //   );
        }),
      ),
    );
  }
}
