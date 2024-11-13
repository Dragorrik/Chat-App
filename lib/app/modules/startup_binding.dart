import 'package:get/get.dart';
import 'package:task_type_project/app/modules/startup_controller.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartupController>(() => StartupController());
  }
}
