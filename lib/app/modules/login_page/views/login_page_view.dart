import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/widgets/login_reg_widget.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 219, 219),
      body: Center(
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

              // Password field
              Text("Password",
                  style: TextStyle(
                    color: const Color(0XFF1D1D1D),
                    fontWeight: FontWeight.bold,
                  )),
              LoginRegWidget.loginRegPassFormfield(
                  controller: controller.passwordController,
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
    );
  }
}
