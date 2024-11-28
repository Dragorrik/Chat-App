import 'package:get/get.dart';
import 'package:task_type_project/app/routes/app_pages.dart';

class AvatarPageController extends GetxController {
  RxBool isSelected = false.obs;

  RxString selectedAvatar = ''.obs;

  void setSelectedAvatar(String avatar) {
    selectedAvatar.value = avatar;
  }

  void finalizeSelection() {
    Get.offNamed(Routes.REGISTER_PAGE);
    print('Avatar selected: ${selectedAvatar.value}');
  }
}
