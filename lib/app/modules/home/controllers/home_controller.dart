import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
  }

  void _loadUserName() {
    final email = storage.read('userEmail') ?? '';
    userName.value = email.split('@').first; // Get name part of the email
  }
}
