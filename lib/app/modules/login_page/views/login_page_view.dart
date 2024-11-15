import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/widgets/login_reg_widget.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          LoginRegWidget.loginRegBg(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Login text title
                  LoginRegWidget.loginRegTxt("Login"),
                  SizedBox(height: 40),

                  // Username / Email field
                  LoginRegWidget.loginRegFormfield(
                      controller: controller.emailController,
                      labelText: "Email",
                      hintText: "Enter your email"),
                  SizedBox(height: 20),

                  // Password field
                  LoginRegWidget.loginRegFormfield(
                      controller: controller.passwordController,
                      labelText: "Email",
                      hintText: "Enter your email",
                      obscureText: true),
                  SizedBox(height: 20),

                  // "Create an Account" and "Sign In" row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Create an Account button
                      TextButton(
                        onPressed: () => Get.toNamed('/register'),
                        child: Text(
                          "Create an Account",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),

                      // Sign In button
                      LoginRegWidget.loginRegElevatedButton("Sign in", () {
                        controller.login();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
