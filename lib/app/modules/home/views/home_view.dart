import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/widgets/drawer_widget.dart';
import 'package:task_type_project/constants/avatars.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 219, 219),
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
                  style:
                      TextStyle(color: const Color(0XFF1D1D1D), fontSize: 18),
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
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF1D1D1D),
                    ),
                  ),
                  subtitle: Text(
                    user['email'] ?? "No Email",
                    style: TextStyle(color: Colors.black87),
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
      ),
    );
  }
}
