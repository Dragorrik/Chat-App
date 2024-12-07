import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/register_page/controllers/register_page_controller.dart';
import 'package:task_type_project/app/widgets/login_reg_widget.dart';
import 'package:task_type_project/constants/avatars.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 219, 219),
      body: Container(
        padding: EdgeInsets.all(20),
        //height: Get.height * 0.7,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Register text title
                LoginRegWidget.loginRegTxt("R e g i s t e r"),
                SizedBox(height: 30),
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
                SizedBox(height: 10),
                Center(
                  child: Text("Choose your avatar",
                      style: TextStyle(
                        color: const Color(0XFF1D1D1D),
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: 30),
                // User name field
                Text("User name",
                    style: TextStyle(
                      color: const Color(0XFF1D1D1D),
                      fontWeight: FontWeight.bold,
                    )),
                LoginRegWidget.loginRegEmailFormfield(
                  controller: controller.nameController,
                  hintText: "Enter your name",
                ),
                SizedBox(height: 20),

                // Email field
                Text("Email",
                    style: TextStyle(
                      color: const Color(0XFF1D1D1D),
                      fontWeight: FontWeight.bold,
                    )),
                LoginRegWidget.loginRegEmailFormfield(
                  controller: controller.emailController,
                  hintText: "Enter your email",
                ),
                SizedBox(height: 20),

                // Occupation field
                Text("Occupation",
                    style: TextStyle(
                      color: const Color(0XFF1D1D1D),
                      fontWeight: FontWeight.bold,
                    )),
                LoginRegWidget.loginRegEmailFormfield(
                  controller: controller.occupationController,
                  hintText: "What's your occupation?",
                ),
                SizedBox(height: 20),

                // Phone no field
                Text("Phone number",
                    style: TextStyle(
                      color: const Color(0XFF1D1D1D),
                      fontWeight: FontWeight.bold,
                    )),
                LoginRegWidget.loginRegEmailFormfield(
                  controller: controller.phoneNoController,
                  hintText: "Write down your phone number",
                ),
                SizedBox(height: 20),

                // Password field
                Text("Password",
                    style: TextStyle(
                      color: const Color(0XFF1D1D1D),
                      fontWeight: FontWeight.bold,
                    )),
                LoginRegWidget.loginRegPassFormfield(
                  controller: controller.passwordController,
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
