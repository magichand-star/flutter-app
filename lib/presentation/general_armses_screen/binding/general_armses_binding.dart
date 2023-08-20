import '../controller/general_armses_controller.dart';
import 'package:get/get.dart';

class GeneralArmsesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GeneralarmsesController());
  }
}
