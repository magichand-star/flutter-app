import 'package:monarchium/presentation/edit_profile_screen/controller/edit_profile_controller.dart';

import 'package:get/get.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
