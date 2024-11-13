import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.snackbar("Registration Successful", "Please log in to continue.");
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Registration Error", e.toString());
    }
  }
}
