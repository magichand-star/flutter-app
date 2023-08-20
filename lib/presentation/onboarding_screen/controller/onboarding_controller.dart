import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/presentation/onboarding_screen/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  Rx<OnboardingModel> onboardingModelObj = OnboardingModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  goToLogin() {
    Get.toNamed(AppRoutes.authorizationScreen);
  }

  goToRegister() {
    Get.toNamed(AppRoutes.registrationScreen);
  }
}
