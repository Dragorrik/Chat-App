import 'package:get/get.dart';

import '../controllers/get_started_screen_controller.dart';

class GetStartedScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetStartedScreenController>(
      () => GetStartedScreenController(),
    );
  }
}
