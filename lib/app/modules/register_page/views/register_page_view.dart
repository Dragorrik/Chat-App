import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/register_page/controllers/register_page_controller.dart';
import 'package:task_type_project/app/widgets/login_reg_widget.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  //final ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);

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
                  // Register text title
                  LoginRegWidget.loginRegTxt("Register"),
                  SizedBox(height: 40),

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
        ],
      ),
    );
  }
}
