import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_type_project/app/routes/app_pages.dart';

class StartupController extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, _checkAuthentication);
  }

  void _checkAuthentication() {
    final isLoggedIn = storage.read('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN_PAGE);
    }
  }
}
