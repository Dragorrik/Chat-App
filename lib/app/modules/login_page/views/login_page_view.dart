import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.teal[200]!,
                  Colors.teal[600]!,
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Login text title
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),

                  // Username / Email field
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      labelText: "Username",
                      hintText: "Enter User ID or Email",
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Password field
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      labelText: "Password",
                      hintText: "Enter Password",
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
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
                      ElevatedButton(
                        onPressed: controller.login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 12),
                          backgroundColor: Colors.teal[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
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
