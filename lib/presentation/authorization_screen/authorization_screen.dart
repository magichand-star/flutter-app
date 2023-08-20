import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'controller/authorization_controller.dart';

class AuthorizationScreen extends GetWidget<AuthorizationController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AuthorizationController>(builder: (controller) {
        if (controller.webViewController != null) {
          return WebViewWidget(
            controller: controller.webViewController!,
          );
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstant.deepOrange50,
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 15,
                      top: 107,
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
                      top: 7,
                      right: 15,
                    ),
                    child: Text(
                      "lbl9".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoiretOneRegular32,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      left: 15,
                      top: 15,
                      right: 15,
                    ),
                    child: Text(
                      "lbl_email".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtCormorantRomanRegular20,
                    ),
                  ),
                ),
                CustomTextFormField(
                  width: 345,
                  focusNode: FocusNode(),
                  controller: controller.emailController,
                  hintText: "msg_example_gmail_com".tr,
                  validator: (value) {
                    if (value == null ||
                        (!isValidEmail(value, isRequired: true))) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  margin: getMargin(
                    left: 15,
                    top: 4,
                    right: 15,
                  ),
                  alignment: Alignment.center,
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
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            // if (value == null ||
                            //     (!isValidPassword(value, isRequired: true))) {
                            //   return "Please enter valid password";
                            // }
                            if (value == null || value.isEmpty) {
                              return 'Обязательное поле!';
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
                      await controller.regularSignIn();
                    }
                  },
                  width: 345,
                  text: "lbl2".tr,
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
                      top: 21,
                      right: 15,
                      bottom: 5,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl11".tr,
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
                            text: "lbl12".tr,
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
                                    AppRoutes.registrationScreen,
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
          ),
        );
      }),
    );
  }
}
