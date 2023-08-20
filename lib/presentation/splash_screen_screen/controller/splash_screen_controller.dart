// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:get_storage/get_storage.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monarchium/backend/backend.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/core/utils/rating_controller.dart';
import 'package:monarchium/core/utils/referals_controller.dart';
import 'package:monarchium/core/utils/user_activity.dart';
import 'package:monarchium/domain/auth/auth_util.dart';
import 'package:monarchium/domain/auth/firebase_user_provider.dart';

class SplashscreenController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    Future.delayed(const Duration(milliseconds: 3000), () {
      monarchiumFirebaseUserStream()
          .listen((MonarchiumFirebaseUser? user) async {
        // debugger();
        if (user?.user != null) {
          await UserActivity().init();
          await RatingController().initRating();
          FirebaseDynamicLinks.instance.onLink.listen(
            (dynamicLinkData) {
              ReferralsController().validateLink(dynamicLinkData.link);
              GetStorage().write(kReferalLink, dynamicLinkData.link.toString());
            },
          ).onError(
            (error) {
              // Handle errors
            },
          );
          UsersRecord? currentUser = await initCurrentUserDocument();
          // TODO: Delete the two codes below later
          // Get.offAndToNamed(AppRoutes.dataProcessingScreen);
          // return;

          if (currentUser != null) {
            if (currentUser.fatherNationality != null &&
                currentUser.fatherNationality!.isEmpty) {
              Get.offAndToNamed(AppRoutes.dataFormScreen);
              return;
            }
            if (currentUser.generatedEmblems != null &&
                currentUser.generatedEmblems!.isEmpty) {
              Get.offAndToNamed(AppRoutes.dataProcessingScreen);
              return;
            }
            Get.offAndToNamed(AppRoutes.homeScreen);
            return;
          }
          Get.offAndToNamed(AppRoutes.onboardingScreen);
          return;
        } else {
          Get.offAndToNamed(AppRoutes.onboardingScreen);
          return;
        }
      });
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
