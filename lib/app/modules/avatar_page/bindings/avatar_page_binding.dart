import 'package:get/get.dart';

import '../controllers/avatar_page_controller.dart';

class AvatarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvatarPageController>(
      () => AvatarPageController(),
    );
  }
}
