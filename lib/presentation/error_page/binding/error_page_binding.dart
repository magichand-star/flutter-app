import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/presentation/error_page/controller/error_page_controller.dart';

class ErrorPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ErrorPageController(),
    );
  }
}
