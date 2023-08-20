import '../controller/friend_search_controller.dart';
import 'package:get/get.dart';

class FriendSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FriendSearchController>(
      FriendSearchController(),
      // permanent: true,
    );
  }
}
