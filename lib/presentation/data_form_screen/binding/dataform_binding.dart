import '../controller/data_form_controller.dart';
import 'package:get/get.dart';

class DataformBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataFormController());
  }
}
