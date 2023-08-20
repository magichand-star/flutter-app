import '../controller/association_profile_controller.dart';
import 'package:get/get.dart';

class AssociationProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssociationProfileController());
  }
}
