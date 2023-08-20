import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:get_storage/get_storage.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../backend/backend.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../core/utils/referals_controller.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../domain/auth/auth_util.dart';
import '../../../domain/google_auth/google_auth_helper.dart';
import '../../../domain/ok_auth/ok_auth_helper.dart';
import '../../../domain/vk_auth/vk_auth_helper.dart';
import '../../../domain/yandex_auth/yandex_auth_data.dart';
import '../../../domain/yandex_auth/yandex_auth_helper.dart';

class RegistrationController extends GetxController {
  TextEditingController emailOneController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordOneController = TextEditingController();

  WebViewController? webViewController;

  bool maskChosen = false;

  String phoneNumber = '';

  final RegExp regExpRu = RegExp(
      r'^(\+7|7)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$');
  final RegExp regExpBe = RegExp(
      r'^(\+375|375)?[\s\-]?\(29|25|44|33\)?[\s\-]?(\d{3})(\d{2})?[\s\-]?(\d{2})$');

  bool isValidRu = false, isValidBy = false;

  onPhoneChanged(String value) {
    phoneNumber = value;
    validateNumber();
  }

  validateNumber() async {
    printInfo(info: phoneNumber);
    // debugger();
    if (phoneNumber.length == 11) {
      isValidRu = await PhoneNumberUtil.isValidPhoneNumber(
              phoneNumber: phoneNumber, isoCode: 'Ru') ??
          false;
      printInfo(info: isValidRu.toString());
    } else if (phoneNumber.length == 12) {
      isValidBy = await PhoneNumberUtil.isValidPhoneNumber(
              phoneNumber: phoneNumber, isoCode: 'BY') ??
          false;
      printInfo(info: isValidBy.toString());
    } else {
      if (isValidBy) isValidBy = false;
      if (isValidRu) isValidRu = false;
    }
    update();
  }

  String? yandexDoc;

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> googleSignIn() async {
    try {
      GoogleAuthHelper googleAuthHelper = GoogleAuthHelper();
      User? account = await googleAuthHelper.googleSignInProcess();
      if (account != null && !(await userExists(account.uid))) {
        // printInfo(info: account!.email);
        Get.offAndToNamed(
          AppRoutes.dataFormScreen,
          arguments: [
            {
              'displayName': account.displayName,
              'photoUrl': account.photoURL,
              'phoneNumber': account.phoneNumber,
            },
          ],
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

            externalAuth(
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

  Future<void> vkSignIn() async {
    // debugger();
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
        // printInfo(info: url);
        if (url.contains(OKAuthHelper.scheme)) {
          okTokenData = OKTokenData.fromStringUrl(url);

          // debugger();
          if (okTokenData != null && okTokenData!.error == null) {
            Map<String, dynamic>? okUser =
                await okAuthHelper.getCurrentUser(okTokenData!);

            if (okUser != null &&
                okUser.isNotEmpty &&
                okUser['uid'] != null &&
                okUser['error_code'] == null)
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

  Future<bool> userExists(String uid) async {
    final userRecord = UsersRecord.collection.doc(uid);
    final userExists = await userRecord.get().then((u) => u.exists);
    if (userExists) {
      Get.snackbar('Ошибка', 'Пользователь с такой почтой уже существует');

      return true;
    } else
      return false;
  }

  externalAuth({
    required String clientId,
    required String uid,
    String? email,
    String? displayName,
    required Map<String, dynamic> userData,
  }) async {
    showOverlay(asyncFunction: () async {
      try {
        String? jwtToken = await ApiClient().getJwt("$clientId$uid");
        if (jwtToken != null) {
          User? currentUser = await signInWithJwtToken(
            Get.context!,
            jwtToken,
          );
          if (currentUser != null) {
            if (!(await userExists(currentUser.uid))) {
              if (displayName != null && displayName.isNotEmpty)
                await currentUser.updateDisplayName(displayName);
              if (email != null && email.isNotEmpty)
                await currentUser.updateEmail(email);

              await maybeCreateUser(currentUser);

              String? referalLink = GetStorage().read(kReferalLink);

              await ReferralsController().validateLink(
                referalLink == null ? null : Uri.parse(referalLink),
              );

              Get.offAllNamed(
                AppRoutes.dataFormScreen,
                arguments: [
                  userData,
                ],
              );
            }
          } else {
            final auth = FirebaseAuth.instance;
            if (auth.currentUser != null) {
              await auth.signOut();
            }
            printInfo(info: "Didn't work");
          }
        }
      } catch (e) {
        printInfo(info: e.toString());
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

  regularSignUp() async {
    showOverlay(asyncFunction: () async {
      User? currentUser = await signInOrCreateAccount(
        Get.context!,
        () async {
          return await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailOneController.value.text,
            password: passwordOneController.value.text,
          );
        },
        'email',
      );

      if (currentUser != null) {
        final userRecord = UsersRecord.collection.doc(currentUser.uid);
        final userExists = await userRecord.get().then((u) => u.exists);
        if (userExists && currentUser.emailVerified) {
          Get.snackbar('Ошибка', 'Пользователь с такой почтой уже существует');
          FirebaseAuth.instance.signOut();
          return;
        } else if (!userExists) {
          await currentUser.updateEmail(emailOneController.value.text);
          await currentUser.updatePassword(passwordOneController.value.text);
        }

        if (!currentUser.emailVerified) {
          await sendVerificationEmail(); // send verification email
          Get.offNamed(
            AppRoutes.authorizationScreen,
          );
          Get.snackbar(
            'Email верификация',
            'Пожалуйста, проверьте свою почту и подтвердите свой аккаунт',
            duration: Duration(seconds: 5),
          );
          FirebaseAuth.instance.signOut();
          return;
        }
        Get.toNamed(AppRoutes.dataFormScreen);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    emailOneController.dispose();
    mobileNoController.dispose();
    passwordController.dispose();
    passwordOneController.dispose();
  }
}
