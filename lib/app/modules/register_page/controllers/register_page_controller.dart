import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final occupationController = TextEditingController();
  final phoneNoController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final obscurePassword =
      ValueNotifier<bool>(true); // For password visibility toggle

  // For storing the picked profile image index
  final RxInt profileImageIndex = 6.obs;

  // Default profile image asset
  final int defaultProfileImageIndex =
      6; // Add this image in your assets folder

  @override
  void onClose() {
    resetRegistrationData();
    super.onClose();
  }

  void resetRegistrationData() {
    profileImageIndex.value =
        defaultProfileImageIndex; // Clear the selected image path
    nameController.clear(); // Clear the name input if needed
    emailController.clear(); // Clear the email input if needed
    passwordController.clear(); // Clear the password input if needed
  }

  Future<User?> register() async {
    try {
      // Create a new user in Firebase Authentication
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final user = userCredential.user;

      if (user != null) {
        // Determine the profile image path
        final imageIndex = profileImageIndex.value;

        // Save the user data in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'occupation': occupationController.text.trim(),
          'phoneNo': phoneNoController.text.trim(),
          'userName': nameController.text.trim(),
          'profileImageIndex': imageIndex,
        });

        Get.snackbar("Registration Successful",
            "Enjoy your chat, ${nameController.text.trim()}.",
            colorText: Colors.white);
        Get.offAllNamed('/home');
        return user;
      }
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString(),
          colorText: Colors.white);
      print("Error during registration: $e");
    }
    return null;
  }
}
