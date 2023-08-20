import 'package:get/get.dart';

import '../controller/chats_controller.dart';

class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatsController());
  }
}
