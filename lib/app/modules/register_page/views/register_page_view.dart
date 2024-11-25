import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/register_page/controllers/register_page_controller.dart';
import 'package:task_type_project/app/widgets/login_reg_widget.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1D1D1D),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile image with option to select
              GestureDetector(
                onTap: () {
                  _showImagePickerOptions(context);
                },
                child: Obx(() {
                  return CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: controller.profileImagePath.value.isNotEmpty
                          ? Image.file(
                              File(controller.profileImagePath.value),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              controller.defaultProfileImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),

              // Register text title
              LoginRegWidget.loginRegTxt("R e g i s t e r"),
              SizedBox(height: 40),

              // User name field
              LoginRegWidget.loginRegEmailFormfield(
                controller: controller.nameController,
                labelText: "User name",
                hintText: "Enter your name",
              ),
              SizedBox(height: 20),

              // Email field
              LoginRegWidget.loginRegEmailFormfield(
                controller: controller.emailController,
                labelText: "Email",
                hintText: "Enter your email",
              ),
              SizedBox(height: 20),

              // Password field
              LoginRegWidget.loginRegPassFormfield(
                controller: controller.passwordController,
                labelText: "Password",
                hintText: "Create your password",
                obscureTextNotifier: ValueNotifier(false),
              ),
              SizedBox(height: 20),

              // Register button
              LoginRegWidget.loginRegButton("Register", () {
                controller.register();
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Show image picker options (Gallery or Camera)
  void _showImagePickerOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a Photo"),
              onTap: () {
                Get.back();
                controller.pickImageFromCamera();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from Gallery"),
              onTap: () {
                Get.back();
                controller.pickImageFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text("Cancel"),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
