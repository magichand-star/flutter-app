// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/presentation/general_armses_screen/models/generalarmses_model.dart';
import 'package:monarchium/presentation/profile_screen/controller/profile_controller.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:share_plus/share_plus.dart';

class GeneralarmsesController extends GetxController {
  TextEditingController inputiconleftController = TextEditingController();

  Rx<GeneralarmsesModel> generalarmsesModelObj = GeneralarmsesModel().obs;

  generateLink() async {
    ProfileController profileController = Get.find<ProfileController>();
    await profileController.shareEmblem();
  }

  goToFriendsSearch() {
    Get.toNamed(
      AppRoutes.searchScreen,
      arguments: [
        {'from': 'generalArmses'}
      ],
    );
  }

  // shareTheLink(ShortDynamicLink unguessableDynamicLink) async {
  //   await Share.share(
  //     unguessableDynamicLink.shortUrl.toString(),
  //   );
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    inputiconleftController.dispose();
  }
}
