import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../backend/backend.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../domain/auth/auth_util.dart';
import '../../../domain/google_auth/google_auth_helper.dart';
import '../../../domain/ok_auth/ok_auth_helper.dart';
import '../../../domain/vk_auth/vk_auth_helper.dart';
import '../../../domain/yandex_auth/yandex_auth_data.dart';
import '../../../domain/yandex_auth/yandex_auth_helper.dart';
import '../models/authorization_model.dart';

class AuthorizationController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<AuthorizationModel> authorizationModelObj = AuthorizationModel().obs;

  WebViewController? webViewController;

  Future<void> googleSignIn() async {
    try {
      GoogleAuthHelper googleAuthHelper = GoogleAuthHelper();
      User? account = await googleAuthHelper.googleSignInProcess();
      if (account != null) {
        // printInfo(info: account!.email);
        Get.offAndToNamed(
          AppRoutes.homeScreen,
          // arguments: [
          //   {
          //     'displayName': account.displayName,
          //     'photoUrl': account.photoURL,
          //     'phoneNumber': account.phoneNumber,
          //   },
          // ],
        );
      }
    } catch (error) {
      printError(info: error.toString());
    }
  }

  Future<void> yandexSignIn() async {
    final yandexAuthHelper = YandexAuthHelper();

    webViewController = yandexAuthHelper.webViewController(
      onPageFinished: (String url) async {
        // printInfo(info: url);
        YandexTokenData? yandexTokenData;
        if (url.contains(YandexAuthHelper.scheme)) {
          yandexTokenData = YandexTokenData.fromStringUrl(url);

          printInfo(info: yandexTokenData.toString());

          if (yandexTokenData != null &&
              yandexTokenData.error == null &&
              yandexTokenData.accessToken != null) {
            YandexAuthData yandexAuthData =
                await yandexAuthHelper.getCurrentUser(yandexTokenData);
            printInfo(
              info: yandexAuthData.toString(),
            );

            await externalAuth(
              email:
                  yandexAuthData.defaultEmail ?? yandexAuthData.emails?.first,
              displayName: yandexAuthData.displayName,
              clientId: yandexAuthData.clientId!,
              uid: yandexAuthData.id!,
              userData: yandexAuthData.toUserData(),
            );
          }
        }
      },
      onNavigationRequest: (NavigationRequest request) async {
        if (request.url.contains(YandexAuthHelper.scheme)) {
          webViewController = null;
          update();
        }
        return NavigationDecision.navigate;
      },
    );
    update();
  }

  overlayWrapper({required Future<dynamic> Function() asyncFunction}) async {
    await Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: ColorConstant.orangeSolid,
          ),
        ),
      ),
      opacityColor: ColorConstant.deepOrange50,
    );
  }

  Future<void> vkSignIn() async {
    final vkAuthHelper = VKAuthHelper();
    await vkAuthHelper.init();
    VKUserProfile? profile = await vkAuthHelper.login();
    if (profile != null) {
      Map<String, dynamic> userData = {
        'displayName': profile.firstName,
        'firstName': profile.firstName,
        'lastName': profile.lastName,
        // 'birthday':
        //     okUser['birthdaySet'] ? DateTime.parse(okUser['birthday']!) : null,
        'photoUrl': profile.photo200,
      };
      externalAuth(
        clientId: VKAuthHelper.clientId,
        uid: profile.userId.toString(),
        userData: userData,
        email: await VKAuthHelper.vk.getUserEmail(),
      );
    }
  }

  Future<void> okSignIn() async {
    final okAuthHelper = OKAuthHelper();
    OKTokenData? okTokenData;
    webViewController = okAuthHelper.webViewController(
      onPageFinished: (String url) async {
        if (url.contains(OKAuthHelper.scheme)) {
          okTokenData = OKTokenData.fromStringUrl(url);
          if (okTokenData != null && okTokenData!.error == null) {
            Map<String, dynamic>? okUser =
                await okAuthHelper.getCurrentUser(okTokenData!);

            if (okUser != null &&
                okUser.isNotEmpty &&
                okUser['uid'] != null &&
                okUser['error_code'] != null) {
              await externalAuth(
                clientId: OKAuthHelper.clientId,
                uid: okUser['uid'],
                userData: {
                  'displayName': okUser['name'],
                  'firstName': okUser['first_name'],
                  'lastName': okUser['last_name'],
                  'birthday': okUser['birthdaySet']
                      ? DateTime.parse(okUser['birthday']!)
                      : null,
                  'phoneNumber':
                      (okUser['hasPhone'] ?? false) ? okUser['mobile'] : null,
                  'photoUrl': okUser['pic_1'],
                },
              );
            } else if (okUser != null && okUser['error_code'] != null) {
              Get.toNamed(
                AppRoutes.errorPage,
                arguments: [
                  okUser['error_msg'],
                ],
              );
            }
          }
        }
      },
      onNavigationRequest: (NavigationRequest request) async {
        if (request.url.contains(OKAuthHelper.scheme)) {
          webViewController = null;
          update();
        }
        return NavigationDecision.navigate;
      },
    );
    update();
  }

  externalAuth({
    required String clientId,
    required String uid,
    String? email,
    String? displayName,
    required Map<String, dynamic> userData,
  }) {
    showOverlay(asyncFunction: () async {
      try {
        String? jwtToken = await ApiClient().getJwt("$clientId$uid");
        if (jwtToken != null) {
          User? currentUser = await signInWithJwtToken(
            Get.context!,
            jwtToken,
          );

          // final userRecord = UsersRecord.collection.doc(currentUser?.uid);
          // final userExists = await userRecord.get().then((u) => u.exists);

          if (currentUser != null) {
            if (displayName != null && displayName.isNotEmpty)
              await currentUser.updateDisplayName(displayName);
            if (email != null && email.isNotEmpty)
              await currentUser.updateEmail(email);

            await maybeCreateUser(
                currentUser); // Get.toNamed(AppRoutes.profileScreen);
            // Get.toNamed(
            //   AppRoutes.dataProcessingScreen,
            //   // arguments: [
            //   //   userData,
            //   // ],
            // );
            Get.offAllNamed(
              AppRoutes.homeScreen,
              arguments: [
                userData,
              ],
            );
          } else {
            printInfo(info: "Didn't work");
          }
        }
      } catch (e) {
        printError(info: e.toString());
        Get.toNamed(AppRoutes.errorPage);
      }
    });
  }

  sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  regularSignIn() async {
    // debugger();
    showOverlay(asyncFunction: () async {
      User? currentUser = await signInOrCreateAccount(Get.context!, () async {
        return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text,
        );
      }, 'email');

      if (currentUser != null) {
        // debugger();
        if (!currentUser.emailVerified) {
          // await sendVerificationEmail();
          Get.snackbar(
            'Email верификация',
            'Пожалуйста, проверьте свою почту и подтвердите свой аккаунт',
            duration: Duration(seconds: 5),
          );
          FirebaseAuth.instance.signOut();
          return;
        }
        printInfo(info: currentUser.uid);
        maybeCreateUser(currentUser);
        await moveToNext();
      }
    });
  }

  moveToNext() async {
    UsersRecord? userRecord = await initCurrentUserDocument();
    if (userRecord != null) {
      if (userRecord.fatherNationality != null &&
          userRecord.fatherNationality!.isEmpty) {
        Get.offAndToNamed(AppRoutes.dataFormScreen);
        return;
      }
      if (userRecord.generatedEmblems != null &&
          userRecord.generatedEmblems!.isEmpty) {
        Get.offAndToNamed(AppRoutes.dataProcessingScreen);
        return;
      }
    } else {
      Get.snackbar(
        'Ошибка',
        'Что-то пошло не так',
        duration: Duration(seconds: 5),
      );
    }
    Get.offAndToNamed(AppRoutes.homeScreen);
    return;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
