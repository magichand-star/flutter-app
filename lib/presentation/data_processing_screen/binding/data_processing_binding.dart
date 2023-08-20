import '../controller/data_processing_controller.dart';
import 'package:get/get.dart';

class DataprocessingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataProcessingController());
  }
}
