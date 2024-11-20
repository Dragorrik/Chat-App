import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final obscurePassword = ValueNotifier<bool>(true); // Define here

  @override
  void onClose() {
    // emailController.dispose(); // Dispose email controller
    // passwordController.dispose(); // Dispose password controller
    // obscurePassword.dispose(); // Dispose ValueNotifier
    super.onClose();
  }

  Future<User?> register() async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final user = userCredential.user;
      if (user != null) {
        // Save user details to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
        });
      }
      Get.snackbar("Registration Successful", "Please log in to continue.");
      Get.offAllNamed('/login');
      return user;
    } catch (e) {
      Get.snackbar("Registration failed", e.toString());
    }
    return null;
  }
}
