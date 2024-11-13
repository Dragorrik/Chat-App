import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/register_page/controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  //final RegisterPageController controller = Get.put(RegisterPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
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
              onPressed: controller.register,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
