import '../controller/emblem_generation_controller.dart';
import 'package:get/get.dart';

class EmblemGenerationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmblemGenerationController());
  }
}
