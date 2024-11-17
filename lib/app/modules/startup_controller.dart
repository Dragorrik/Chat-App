import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_type_project/app/routes/app_pages.dart';

class StartupController extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    // Simulate loading delay if needed (e.g., for API calls or heavy logic)
    await Future.delayed(Duration(seconds: 1));

    final isLoggedIn = storage.read('isLoggedIn') ?? false;

    // Navigate to the appropriate page
    if (isLoggedIn) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN_PAGE);
    }
  }
}
