import 'dart:ui';
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
          // Gradient background with blur
          Stack(
            children: [
              LoginRegWidget.loginRegBg(), // Your existing background
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10, sigmaY: 10), // Adjust the blur intensity
                  child: Container(
                    color: Colors.black.withOpacity(
                        0.3), // Optional: add a semi-transparent overlay
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Login text title
                  LoginRegWidget.loginRegTxt("L o g i n"),
                  SizedBox(height: 40),

                  // Username / Email field
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
                      hintText: "Enter your password",
                      obscureTextNotifier: controller.obscurePassword),
                  SizedBox(height: 20),

                  // "Create an Account" and "Sign In" row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Create an Account button
                      LoginRegWidget.createAccountTxt(),

                      // Sign In button
                      LoginRegWidget.loginRegButton("Sign in", () {
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
