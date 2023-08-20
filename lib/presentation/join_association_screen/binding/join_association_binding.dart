import '../controller/join_association_controller.dart';
import 'package:get/get.dart';

class JoinAssociationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JoinassociationController());
  }
}
