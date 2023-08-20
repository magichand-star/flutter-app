import '../controller/authorization_controller.dart';
import 'package:get/get.dart';

class AuthorizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthorizationController());
  }
}
