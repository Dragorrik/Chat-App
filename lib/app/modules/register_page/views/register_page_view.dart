import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/register_page/controllers/register_page_controller.dart';
import 'package:task_type_project/app/widgets/login_reg_widget.dart';
import 'package:task_type_project/constants/avatars.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1D1D1D),
      body: Container(
        padding: EdgeInsets.all(20),
        //height: Get.height * 0.7,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile image with option to select
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/avatar-page');
                  },
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Obx(
                        () => Image.asset(
                          avatars[controller.profileImageIndex.value],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
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

                // Occupation field
                LoginRegWidget.loginRegEmailFormfield(
                  controller: controller.occupationController,
                  labelText: "Occupation",
                  hintText: "What's your occupation?",
                ),
                SizedBox(height: 20),

                // Phone no field
                LoginRegWidget.loginRegEmailFormfield(
                  controller: controller.phoneNoController,
                  labelText: "Phone number",
                  hintText: "Write down your phone number",
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
          ],
        ),
      ),
    );
  }
}
