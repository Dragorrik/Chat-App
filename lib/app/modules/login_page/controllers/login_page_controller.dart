import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class LoginPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = GetStorage();

  final obscurePassword = ValueNotifier<bool>(true); // Define here

  @override
  void onClose() {
    // emailController.dispose(); // Dispose email controller
    // passwordController.dispose(); // Dispose password controller
    // obscurePassword.dispose(); // Dispose ValueNotifier
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    // emailController.text = "gg@gmail.com";
    // passwordController.text = "123456";
  }

  Future<User?> login() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final user = userCredential.user;
      if (user != null) {
        // Ensure user exists in Firestore
        final docRef = _firestore.collection('users').doc(user.uid);
        final doc = await docRef.get();

        if (!doc.exists) {
          await docRef.set({
            'uid': user.uid,
            'email': user.email,
          });
        }
        storage.write(
            'userEmail', emailController.text); // Save email when logging in
        storage.write('isLoggedIn', true); // Save login status
        //Get.offAllNamed('/home');
      }
      return user;
    } catch (e) {
      Get.snackbar("Login failed", e.toString());
    }
    return null;
  }

  signOut() async {
    await _auth.signOut();
    Get.toNamed('/login');
  }
}
