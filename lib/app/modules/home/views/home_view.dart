import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/widgets/drawer_widget.dart';
import 'package:task_type_project/constants/avatars.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1D1D1D),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      drawer: ProfileDrawer(),
      body: Obx(
        () {
          if (controller.userList.isEmpty) {
            return Center(
              child: Text(
                "No users available.",
                style: TextStyle(color: Colors.deepPurple, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.userList.length,
            itemBuilder: (context, index) {
              final user = controller.userList[index];

              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                      child: Image.asset(
                    avatars[user['profileImageIndex']],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
                ),
                title: Text(
                  user['userName'] ?? "Unknown User",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  user['email'] ?? "No Email",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  Get.toNamed('/chat', arguments: {
                    'uid': user['uid'],
                    'userName': user['userName'],
                    'email': user['email'],
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
