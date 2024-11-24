import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_type_project/app/modules/home/controllers/home_controller.dart';
import 'package:task_type_project/app/modules/user_data/user.dart';

class RegisterPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final obscurePassword = ValueNotifier<bool>(true); // Define here

  // For storing the picked profile image path
  final RxString profileImagePath = ''.obs;

  // Default profile image asset
  final String defaultProfileImage =
      "assets/images/default_profile.jpg"; // Add this image in your assets folder

  // Image picker instance
  final ImagePicker _imagePicker = ImagePicker();

  //Hive box declaration
  late Box userBox;

  @override
  void onInit() {
    super.onInit();
    // Open Hive box and load profile image path
    userBox = Hive.box('userBox');
    profileImagePath.value = userBox.get('avatarPath', defaultValue: '');
  }

  // Save avatar path to Hive
  void _saveAvatarToHive(String path) {
    userBox.put('avatarPath', path);
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await _saveImageLocally(pickedFile);
    }
  }

  // Capture image from camera
  Future<void> pickImageFromCamera() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await _saveImageLocally(pickedFile);
    }
  }

  // Save the selected image locally
  Future<void> _saveImageLocally(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDir.path}/${file.name}";
    final savedFile = await File(file.path).copy(filePath);
    // Update the reactive variable and save to Hive
    profileImagePath.value = savedFile.path;
    _saveAvatarToHive(savedFile.path);
  }

  @override
  void onClose() {
    // emailController.dispose(); // Dispose email controller
    // passwordController.dispose(); // Dispose password controller
    // obscurePassword.dispose(); // Dispose ValueNotifier
    resetRegistrationData();
    super.onClose();
  }

  void resetRegistrationData() {
    clearProfileImagePath(); // Clear the selected image path
    //nameController.clear(); // Clear the name input if needed
    // Add any other resets as required
  }

  void clearProfileImagePath() {
    userBox.delete('avatarPath');
    profileImagePath.value = ''; // Reset the reactive variable
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
        final imagePath = profileImagePath.value.isNotEmpty
            ? profileImagePath.value
            : defaultProfileImage;

        // Save the user data in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'userName': nameController.text.trim(),
        });

        // Save user data locally in Hive
        userBox.add(UserData(
          id: user.uid,
          name: nameController.text.trim(),
          profileImagePath: imagePath,
          lastMessage: "Hello! I'm new here.",
        ));

        // Update the HomeController with the new user's data
        final homeController = Get.isRegistered<HomeController>()
            ? Get.find<HomeController>()
            : Get.put(HomeController());
        await homeController.saveProfileImage(user.uid, imagePath);
        homeController.fetchUsers();

        Get.snackbar("Registration Successful", "Enjoy your chat.");
        return user;
      }
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString());
      print("Error during registration: $e");
    }
    return null;
  }
}
