import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  //final LoginPageController controller = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.login,
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/register'),
              child: Text("Create an Account"),
            ),
          ],
        ),
      ),
    );
  }
}
