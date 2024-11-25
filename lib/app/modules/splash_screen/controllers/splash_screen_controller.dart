import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 5), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offNamed('/get-started-screen'); // Navigate to Login Page
        } else {
          Get.offNamed('/home'); // Navigate to Home Page
        }
      });
    });
  }
}
