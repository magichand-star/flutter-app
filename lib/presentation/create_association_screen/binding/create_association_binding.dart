import '../controller/create_association_controller.dart';
import 'package:get/get.dart';

class CreateAssociationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateAssociationController());
  }
}
