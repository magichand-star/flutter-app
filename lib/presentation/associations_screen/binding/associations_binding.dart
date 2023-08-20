import '../controller/associations_controller.dart';
import 'package:get/get.dart';

class AssociationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssociationsController());
  }
}
